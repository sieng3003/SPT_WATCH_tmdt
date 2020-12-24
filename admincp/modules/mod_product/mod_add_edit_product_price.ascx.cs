using System;
using System.Collections.Generic;
//using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class admincp_modules_mod_product_mod_add_edit_product_price : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //===============================================================
        CKFinder.FileBrowser _FileBrowser1 = new CKFinder.FileBrowser();
        _FileBrowser1.BasePath = "../ckfinder/";
        _FileBrowser1.SetupCKEditor(CKEditor_Mota);
        //===============================================================
        string strDo = clsInput.getStringInput("do", 0);
        int intId = clsInput.getNumericInput("id", 0);
        if (strDo == "edit" && intId > 0)
        {
            PnAdd.Visible = false;
            PnEdit.Visible = true;
            if (!Page.IsPostBack)
                edit_product_price(intId);
        }
        else if (strDo == "add")
        {
            PnAdd.Visible = true;
            PnEdit.Visible = false;
            if (!Page.IsPostBack)
                add_product_price();
        }
        else
        {
            //Hien thi thong bao loi, khong thay tac vu yeu cau
            //==================================================
            //Display Msg
            clsConfig.redirectUrl("Default.aspx?page=product_price&mod=product");
            //==================================================
        }

    }


    private void edit_product_price(int intID)
    {

        DataTable dt = clsDatabase.getDataTable("select * from tbl_product_price where PK_ProductPriceID = " + intID);
        string strName = "";
       
        string strFile = "";
        string strDes = "";

        if (dt.Rows.Count > 0)
        {
            strName = clsInput.decodeStr(dt.Rows[0]["C_Name"].ToString());
            strDes = clsInput.decodeStr(dt.Rows[0]["C_Des"].ToString());
            strFile = dt.Rows[0]["C_Attach"].ToString();
           
            //Kiem tra viec xoa anh
            string strAct = clsInput.getStringInput("act", 0);
            if (strAct == "delAttach")
            {
                clsDatabase.ExecuteQuery("update tbl_product_price set C_Attach='' where PK_ProductPriceID = " + intID);
                if (clsFile.fileExists("../" + dt.Rows[0]["C_Attach"].ToString()))
                    clsFile.fileDelete("../" + dt.Rows[0]["C_Attach"].ToString());
                Response.Redirect("Default.aspx?page=add_edit_product_price&mod=product&do=edit&id=" + intID);
            }
        }


        //===============================================================
        if (strFile != "")
        {
            PnAttach.Visible = true;
            LblAttach.Text = strFile;
        }



       

        if (Page.IsPostBack)
            return;



        //===============================================================
        FCKeditor1.BasePath = clsConfig.getFckPath();
        //setup lang
        FCKeditor1.Config["AutoDetectLanguage"] = "false";
        FCKeditor1.Config["DefaultLanguage"] = "vi";
        FCKeditor1.Width = 900;
        FCKeditor1.Height = 250;
        //setup thame
        FCKeditor1.Config["SkinPath"] = clsConfig.getFckPath() + "editor/skins/office2003/";
        //===============================================================


        // Set the startup editor value.
        txtName.Text = strName;
        FCKeditor1.Value = strDes;
        CKEditor_Mota.Text = strDes;

        //==========================================
    }

    private void add_product_price()
    {

        string strName = "";



        if (Page.IsPostBack)
            return;

        
        //===============================================================
        FCKeditor1.BasePath = clsConfig.getFckPath();
        //setup lang
        FCKeditor1.Config["AutoDetectLanguage"] = "false";
        FCKeditor1.Config["DefaultLanguage"] = "vi";
        FCKeditor1.Width = 900;
        FCKeditor1.Height = 250;
        //setup thame
        FCKeditor1.Config["SkinPath"] = clsConfig.getFckPath() + "editor/skins/office2003/";
        //===============================================================

        // Set the startup editor value.
        txtName.Text = strName;

        //==========================================
    }

    protected void BtnSubmit_ServerClick(object sender, EventArgs e)
    {
        //Khoi tao cac gia tri        
        string strName = clsInput.encodeStr(txtName.Text);
        
        
        string strDes = clsInput.encodeStr(FCKeditor1.Value);
        strDes = clsInput.encodeStr(CKEditor_Mota.Text);
        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strName == "")
            clsErr.setErr("Tiêu đề", "Bạn hãy nhập vào tiêu đề");
        if (uploadAttach.PostedFile.ContentLength > 0)
        {
            if (clsFile.checkFileUploadType(uploadAttach) == false)
                clsErr.setErr("Định dạng file", "Bạn không được phép upload file có định dạng .avi, .mpg, .wma, .wmv, .flv");
        }

        //Ket xuat loi
        if (clsErr.checkErr())
        {
            block_error.Text = clsErr.displayErr();
        }
        else
        {
            try
            {

                string strFile = clsFile.saveImages(uploadAttach, "product");
                string strSql = "insert into tbl_product_price(C_Name,C_Des, C_Attach, FK_LangID, C_Active) values (N'" + strName + "',N'" + strDes + "',N'" + strFile + "',"  + lang.getLangID() + ",1)";

                clsDatabase.ExecuteQuery(strSql);
                int intInsertRecord = clsDatabase.getInsertID("tbl_product_price", "PK_ProductPriceID");
                clsDatabase.ExecuteQuery("update tbl_product_price set C_Rank = " + intInsertRecord + " where PK_ProductPriceID = " + intInsertRecord);
                Response.Redirect("Default.aspx?page=product_price&mod=product");
            }
            catch
            {
                clsErr.setErr("Error", "Bạn hãy kiểm tra lại thông tin (Định dạng ảnh, file, các ký tự đặc biệt ...)");
                //Ket xuat loi
                if (clsErr.checkErr())
                {
                    block_error.Text = clsErr.displayErr();
                }
            }
        }

        //===============================================
    }

    protected void BtnEdit_ServerClick(object sender, EventArgs e)
    {

        //Khoi tao cac gia tri        
        string strName = clsInput.encodeStr(txtName.Text);
        
        string strDes = clsInput.encodeStr(FCKeditor1.Value);
        strDes = clsInput.encodeStr(CKEditor_Mota.Text);
        //====================================================
        //Get Url
        int intId = clsInput.getNumericInput("id", 0);
        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strName == "")
            clsErr.setErr("Tiêu đề", "Bạn hãy nhập vào tiêu đề");
        if (uploadAttach.PostedFile.ContentLength > 0)
        {
            if (clsFile.checkFileUploadType(uploadAttach) == false)
                clsErr.setErr("Định dạng file", "Bạn không được phép upload file có định dạng .avi, .mpg, .wma, .wmv, .flv");
        }


        //Ket xuat loi
        if (clsErr.checkErr())
        {
            block_error.Text = clsErr.displayErr();
        }
        else
        {
            try
            {
                string strFile = clsFile.saveImages(uploadAttach, "product");
                string strSqlUpload = "";
                if (strFile != "")
                    strSqlUpload += ", C_Attach = N'" + strFile + "'";
                string  strSql = "update tbl_product_price set C_Name = N'" + strName + "', C_Des = N'" + strDes + "'" + strSqlUpload+" where PK_ProductPriceID=" + intId;
                clsDatabase.ExecuteQuery(strSql);
                Response.Redirect("Default.aspx?page=product_price&mod=product");
            }
            catch
            {
                clsErr.setErr("Error", "Bạn hãy kiểm tra lại thông tin (Định dạng ảnh, file, các ký tự đặc biệt ...)");
                //Ket xuat loi
                if (clsErr.checkErr())
                {
                    block_error.Text = clsErr.displayErr();
                }
            }
        }

        //===============================================
    }

}