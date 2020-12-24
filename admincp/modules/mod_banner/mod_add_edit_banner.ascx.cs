using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class admincp_modules_mod_banner_mod_add_edit_banner : System.Web.UI.UserControl
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

        DataTable dt = clsDatabase.getDataTable("select * from tbl_banner where PK_bannerID = " + intID);
        string strName = "";
        int intCategoryID = 0;
        string strImg = "";
        string strDes = "";
        string strUrl = "";
        if (dt.Rows.Count > 0)
        {
            strName = clsInput.decodeStr(dt.Rows[0]["C_Name"].ToString());
            strDes = clsInput.decodeStr(dt.Rows[0]["C_Des"].ToString());
            strUrl = clsInput.decodeStr(dt.Rows[0]["C_Url"].ToString());
            strImg = dt.Rows[0]["C_Img"].ToString();
            intCategoryID = Convert.ToInt16(dt.Rows[0]["FK_CategoryID"]);
            //Kiem tra viec xoa anh
            string strAct = clsInput.getStringInput("act", 0);
            if (strAct == "delImg")
            {
                clsDatabase.ExecuteQuery("update tbl_banner set C_Img='' where PK_bannerID = " + intID);
                if (clsFile.fileExists("../" + dt.Rows[0]["C_Img"].ToString()))
                    clsFile.fileDelete("../" + dt.Rows[0]["C_Img"].ToString());
                Response.Redirect("Default.aspx?page=add_edit_banner&mod=banner&do=edit&id=" + intID);
            }
        }


        //===============================================================
        //Dropdown
        DataTable dtCategory = clsDatabase.getDataTable("select * from tbl_category_banner where FK_LangID=" + lang.getLangID() + "  order by C_Rank desc");
        DrdCategory.Items.Clear();
        //DrdCategory.Items.Add(new ListItem("", "0"));
        int intSelected = 0;
        // Response.Write();

        for (int i = 0; i < dtCategory.Rows.Count; i++)
        {
            //if (Convert.ToInt16(dtCategory.Rows[i]["PK_CategoryID"]) == intID)
            //    ;
            //else
                DrdCategory.Items.Add(new ListItem(dtCategory.Rows[i]["C_Name"].ToString(), dtCategory.Rows[i]["PK_CategoryID"].ToString()));
            if (Convert.ToInt16(dtCategory.Rows[i]["PK_CategoryID"]) == intCategoryID)
            {
                DrdCategory.SelectedIndex = intSelected + 1;
            }
            intSelected++;
        }


        if (strImg != "")
        {
            PnImg.Visible = true;
            LblImg.Text = "<img src=../" + strImg + " width='150'>";
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
        txtUrl.Text = strUrl;
        FCKeditor1.Value = strDes;
        CKEditor_ThongTin.Text = strDes;
        DrdCategory.SelectedValue = intCategoryID.ToString();

        //==========================================
    }

    private void add_news()
    {

        string strName = "";



        if (Page.IsPostBack)
            return;



        //===============================================================
        //Dropdown
        DataTable dtCategory = clsDatabase.getDataTable("select * from tbl_category_banner where FK_LangID=" + lang.getLangID() + "  order by C_Rank desc");
        DrdCategory.Items.Clear();
        for (int i = 0; i < dtCategory.Rows.Count; i++)
        {
            DrdCategory.Items.Add(new ListItem(dtCategory.Rows[i]["C_Name"].ToString(), dtCategory.Rows[i]["PK_CategoryID"].ToString()));
        }

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
        string strUrl = clsInput.encodeStr(txtUrl.Text);
        string strImageURL = "";
        string strDes = clsInput.encodeStr(FCKeditor1.Value);
        strDes = clsInput.encodeStr(CKEditor_ThongTin.Text);
        int intCategoryID = Convert.ToInt16(DrdCategory.SelectedValue);
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

                strImageURL = clsFile.saveImages(uploadFile, "banner");
                string strSql = "insert into tbl_banner(C_Name,C_Des, C_Img, FK_LangID, C_Active,FK_CategoryID,C_Url) values (N'" + strName + "',N'" + strDes + "',N'" + strImageURL + "'," + lang.getLangID() + ",1," + intCategoryID + ",N'" + strUrl + "'" + ")";

                clsDatabase.ExecuteQuery(strSql);
                int intInsertRecord = clsDatabase.getInsertID("tbl_banner", "PK_bannerID");
                clsDatabase.ExecuteQuery("update tbl_banner set C_Rank = " + intInsertRecord + " where PK_bannerID = " + intInsertRecord);
                Response.Redirect("Default.aspx?page=banner&mod=banner");
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
        string strUrl = clsInput.encodeStr(txtUrl.Text);
        string strDes = clsInput.encodeStr(FCKeditor1.Value);
        strDes = clsInput.encodeStr(CKEditor_ThongTin.Text);
        int intCategoryID = Convert.ToInt16(DrdCategory.SelectedValue);
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
                string strImageURL = clsFile.saveImages(uploadFile, "banner");
                string strSql = "update tbl_banner set C_Name = N'" + strName + "', C_Des = N'" + strDes + "',FK_CategoryID=" + intCategoryID + ",C_Url=N'" + strUrl + "' " + " where PK_bannerID=" + intId;
                if (strImageURL != "")
                    strSql = "update tbl_banner set C_Name = N'" + strName + "', C_Des = N'" + strDes + "', C_Img = N'" + strImageURL + "'" + " where PK_bannerID=" + intId;
                clsDatabase.ExecuteQuery(strSql);
                Response.Redirect("Default.aspx?page=banner&mod=banner");
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