using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class admincp_modules_mod_banner_mod_add_edit_category_banner : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //===============================================================
        CKFinder.FileBrowser _FileBrowser1 = new CKFinder.FileBrowser();
        _FileBrowser1.BasePath = "../ckfinder/";
        _FileBrowser1.SetupCKEditor(CKEditor_ThongTin);
        //===============================================================
        string strDo = clsInput.getStringInput("do", 0);
        int intId = clsInput.getNumericInput("id", 0);

        if (strDo == "edit" && intId > 0)
        {
            PnAdd.Visible = false;
            PnEdit.Visible = true;
            if (!Page.IsPostBack)
                edit_category_banner(intId);
        }
        else if (strDo == "add")
        {
            PnAdd.Visible = true;
            PnEdit.Visible = false;
            if (!Page.IsPostBack)
                add_category_banner();
        }
        else
        {
            //Hien thi thong bao loi, khong thay tac vu yeu cau
            //==================================================
            //Display Msg
            clsConfig.redirectUrl("Default.aspx?page=category_banner&mod=banner");
            //==================================================
        }

    }


    private void edit_category_banner(int intID)
    {
        DataTable dt = clsDatabase.getDataTable("select * from tbl_category_banner where PK_CategoryID = " + intID);
        string strName = "";
        string strDes = "";
        int intCheckUrl = 0;
        string strUrl = "";
        int intParentID = 0;

        int intCheckMenuNgang = 0;
        string strImg = "";
        string strFile = "";
        if (dt.Rows.Count > 0)
        {
            strName = clsInput.decodeStr(dt.Rows[0]["C_Name"].ToString());
            strDes = clsInput.decodeStr(dt.Rows[0]["C_Des"].ToString());

        }

        //===============================================================
        FCKeditor2.BasePath = clsConfig.getFckPath();
        //setup lang
        FCKeditor2.Config["AutoDetectLanguage"] = "false";
        FCKeditor2.Config["DefaultLanguage"] = "vi";
        FCKeditor2.Width = 900;
        FCKeditor2.Height = 250;
        //setup thame
        FCKeditor2.Config["SkinPath"] = clsConfig.getFckPath() + "editor/skins/office2003/";
        //===============================================================
        if (Page.IsPostBack)
            return;



        // Set the startup editor value.
        txtName.Text = strName;
        FCKeditor2.Value = strDes;
        CKEditor_ThongTin.Text = strDes;
        //==========================================
    }

    private void add_category_banner()
    {

        string strName = "";
        string strDes = "";
        int intCheckUrl = 0;
        string strUrl = "";

        int intCheckMenuNgang = 0;

        //===============================================================
        FCKeditor2.BasePath = clsConfig.getFckPath();
        //setup lang
        FCKeditor2.Config["AutoDetectLanguage"] = "false";
        FCKeditor2.Config["DefaultLanguage"] = "vi";
        FCKeditor2.Width = 900;
        FCKeditor2.Height = 250;
        //setup thame
        FCKeditor2.Config["SkinPath"] = clsConfig.getFckPath() + "editor/skins/office2003/";
        //===============================================================
        if (Page.IsPostBack)
            return;


        // Set the startup editor value.
        txtName.Text = strName;
        FCKeditor2.Value = strDes;
        CKEditor_ThongTin.Text = strDes;
        //==========================================
    }

    protected void BtnSubmit_ServerClick(object sender, EventArgs e)
    {
        //Khoi tao cac gia tri
        string strName = clsInput.encodeStr(txtName.Text);
        string strDes = clsInput.encodeStr(FCKeditor2.Value);
        strDes = clsInput.encodeStr(CKEditor_ThongTin.Text);

        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strName == "")
            clsErr.setErr("Tiêu đề", "Bạn hãy nhập vào tiêu đề");



        //Ket xuat loi
        if (clsErr.checkErr())
        {
            block_error.Text = clsErr.displayErr();
        }
        else
        {
            try
            {



                string strSql = "insert into tbl_category_banner(FK_LangID, C_Name, C_Des, C_Active) values (" + lang.getLangID() + ",N'" + strName + "',N'" + strDes + "'," + "1)";
                clsDatabase.ExecuteQuery(strSql);
                int intInsertRecord = clsDatabase.getInsertID("tbl_category_banner", "PK_CategoryID");
                clsDatabase.ExecuteQuery("update tbl_category_banner set C_Rank = " + intInsertRecord + " where PK_CategoryID = " + intInsertRecord);
                Response.Redirect("Default.aspx?page=category_banner&mod=banner");
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
        string strDes = clsInput.encodeStr(FCKeditor2.Value);
        strDes = clsInput.encodeStr(CKEditor_ThongTin.Text);
        //====================================================
        //Get Url
        int intId = clsInput.getNumericInput("id", 0);
        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strName == "")
            clsErr.setErr("Tiêu đề", "Bạn hãy nhập vào tiêu đề");


        //Ket xuat loi
        if (clsErr.checkErr())
        {
            block_error.Text = clsErr.displayErr();
        }
        else
        {
            try
            {

                string strSql = "update tbl_category_banner set C_Name = N'" + strName + "', C_Des = N'" + strDes + "'" + " where PK_CategoryID=" + intId;
                clsDatabase.ExecuteQuery(strSql);
                Response.Redirect("Default.aspx?page=category_banner&mod=banner");
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