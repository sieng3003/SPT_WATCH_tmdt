using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class admincp_modules_mod_granit_mod_add_edit_granit : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strDo = clsInput.getStringInput("do", 0);
        int intId = clsInput.getNumericInput("id", 0);


        


        if (strDo == "edit" && intId > 0)
        {
            PnAdd.Visible = false;
            PnEdit.Visible = true;
            if (!Page.IsPostBack)
                edit_news(intId);
        }
        else if (strDo == "add")
        {
            PnAdd.Visible = true;
            PnEdit.Visible = false;
            if (!Page.IsPostBack)
                add_news();
        }
        else
        {
            //Hien thi thong bao loi, khong thay tac vu yeu cau
            //==================================================
            //Display Msg
            clsConfig.redirectUrl("Default.aspx?page=category_news&mod=news");
            //==================================================
        }

    }


    private void edit_news(int intID)
    {

        DataTable dt = clsDatabase.getDataTable("select * from tbl_granit where PK_GranitID = " + intID);
        string strName = "";
        int intCategoryID = 0;
        string strImg = "";
        string strDes = "";

        if (dt.Rows.Count > 0)
        {
            strName = clsInput.decodeStr(dt.Rows[0]["C_Name"].ToString());
            strDes = clsInput.decodeStr(dt.Rows[0]["C_Des"].ToString());
            strImg = dt.Rows[0]["C_Img"].ToString();
            intCategoryID = Convert.ToInt16(dt.Rows[0]["FK_CategoryID"]);
            //Kiem tra viec xoa anh
            string strAct = clsInput.getStringInput("act", 0);
            if (strAct == "delImg")
            {
                clsDatabase.ExecuteQuery("update tbl_granit set C_Img='' where PK_GranitID = " + intID);
                if (clsFile.fileExists("../" + dt.Rows[0]["C_Img"].ToString()))
                    clsFile.fileDelete("../" + dt.Rows[0]["C_Img"].ToString());
                Response.Redirect("Default.aspx?page=add_edit_granit&mod=granit&do=edit&id=" + intID);
            }
        }


        //===============================================================
        if (strImg != "")
        {
            PnImg.Visible = true;
            LblImg.Text = "<img src=../" + strImg + " width='150'>";
        }



        //Dropdown
        DataTable dtCategory = clsDatabase.getDataTable("select * from tbl_category_news where FK_LangID = " + lang.getLangID() + " and (FK_ParentID = 13 or FK_ParentID = 21) order by C_Rank desc");
        DrdCategory.Items.Clear();
        int intSelected = 0;

        for (int i = 0; i < dtCategory.Rows.Count; i++)
        {
            DrdCategory.Items.Add(new ListItem(dtCategory.Rows[i]["C_Name"].ToString(), dtCategory.Rows[i]["PK_CategoryID"].ToString()));
            if (Convert.ToInt16(dtCategory.Rows[i]["PK_CategoryID"]) == intCategoryID)
            {
                DrdCategory.SelectedIndex = intSelected;
            }
            intSelected++;

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


        //==========================================
    }

    private void add_news()
    {

        string strName = "";



        if (Page.IsPostBack)
            return;

        //Dropdown
        DataTable dtCategory = clsDatabase.getDataTable("select * from tbl_category_news where FK_LangID = " + lang.getLangID() + " and (FK_ParentID = 13 or FK_ParentID = 21) order by C_Rank desc");
        DrdCategory.Items.Clear();

        for (int i = 0; i < dtCategory.Rows.Count; i++)
        {

            DrdCategory.Items.Add(new ListItem(dtCategory.Rows[i]["C_Name"].ToString(), dtCategory.Rows[i]["PK_CategoryID"].ToString()));


        }

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
        int intCategoryID = Convert.ToInt32(DrdCategory.Text.ToString());
        string strImageURL = "";
        string strDes = clsInput.encodeStr(FCKeditor1.Value);

        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strName == "")
            clsErr.setErr("Tiêu đề", "Bạn hãy nhập vào tiêu đề");
        if (uploadFile.PostedFile.ContentLength > 0)
        {
            if (clsFile.checkImagesUploadSize(uploadFile) == false)
                clsErr.setErr("Dung lượng ảnh", "Ảnh có dung lượng quá lớn, bạn chỉ được phép upload ảnh <=1Mb");
            if (clsFile.checkImagesUploadType(uploadFile) == false)
                clsErr.setErr("Định dạng ảnh", "Bạn chỉ được phép upload ảnh có định dạng .gif, .jpg, .png");
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

                strImageURL = clsFile.saveImages(uploadFile, "granit");
                string strSql = "insert into tbl_granit(C_Name,C_Des, C_Img, FK_CategoryID, FK_LangID, C_Active) values (N'" + strName + "',N'" + strDes + "',N'" + strImageURL + "'," + intCategoryID + "," + lang.getLangID() + ",1)";

                clsDatabase.ExecuteQuery(strSql);
                int intInsertRecord = clsDatabase.getInsertID("tbl_granit", "PK_GranitID");
                clsDatabase.ExecuteQuery("update tbl_granit set C_Rank = " + intInsertRecord + " where PK_GranitID = " + intInsertRecord);
                Response.Redirect("Default.aspx?page=granit&mod=granit");
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
        int intCategoryID = Convert.ToInt32(DrdCategory.Text.ToString());
        string strDes = clsInput.encodeStr(FCKeditor1.Value);
        //====================================================
        //Get Url
        int intId = clsInput.getNumericInput("id", 0);
        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strName == "")
            clsErr.setErr("Tiêu đề", "Bạn hãy nhập vào tiêu đề");
        if (uploadFile.PostedFile.ContentLength > 0)
        {
            if (clsFile.checkImagesUploadSize(uploadFile) == false)
                clsErr.setErr("Dung lượng ảnh", "Ảnh có dung lượng quá lớn, bạn chỉ được phép upload ảnh <=1Mb");
            if (clsFile.checkImagesUploadType(uploadFile) == false)
                clsErr.setErr("Định dạng ảnh", "Bạn chỉ được phép upload ảnh có định dạng .gif, .jpg, .png");
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
                string strImageURL = clsFile.saveImages(uploadFile, "granit");
                string strSql = "update tbl_granit set C_Name = N'" + strName + "', C_Des = N'" + strDes + "',FK_CategoryID = " + intCategoryID + " where PK_GranitID=" + intId;
                if (strImageURL != "")
                    strSql = "update tbl_granit set C_Name = N'" + strName + "', C_Des = N'" + strDes + "', C_Img = N'" + strImageURL + "',FK_CategoryID = " + intCategoryID + " where PK_GranitID=" + intId;
                clsDatabase.ExecuteQuery(strSql);
                Response.Redirect("Default.aspx?page=granit&mod=granit");
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
