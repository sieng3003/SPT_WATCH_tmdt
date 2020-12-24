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

public partial class admincp_modules_mod_news_mod_add_edit_news : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        CKFinder.FileBrowser _FileBrowser1 = new CKFinder.FileBrowser();
        _FileBrowser1.BasePath = "../ckfinder/";
        _FileBrowser1.SetupCKEditor(CKEditor_TrichDan);
        CKFinder.FileBrowser _FileBrowser2 = new CKFinder.FileBrowser();
        _FileBrowser2.BasePath = "../ckfinder/";
        _FileBrowser2.SetupCKEditor(CKEditor_ChiTiet);
        //==============================================
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
        DataTable dt = clsDatabase.getDataTable("select * from tbl_news where PK_NewsID = " + intID);
        string strName = "";
        string strDes = "";
        string strContent = "";
        int intCheckHot = 0;
        
        int intCategoryID = 0;
        string strImg = "";
        string strFile = "";

        if (dt.Rows.Count > 0)
        {
            strName = clsInput.decodeStr(dt.Rows[0]["C_Name"].ToString());
            strDes = clsInput.decodeStr(dt.Rows[0]["C_Des"].ToString());
            strContent = clsInput.decodeStr(dt.Rows[0]["C_Content"].ToString());
            intCheckHot = Convert.ToInt16(dt.Rows[0]["C_Hot"]);
            
            intCategoryID = Convert.ToInt16(dt.Rows[0]["FK_CategoryID"]);
            strImg = dt.Rows[0]["C_Img"].ToString();
            strFile = dt.Rows[0]["C_Attach"].ToString();
            //Kiem tra viec xoa anh
            string strAct = clsInput.getStringInput("act", 0);
            if (strAct == "delImg")
            {
                clsDatabase.ExecuteQuery("update tbl_news set C_Img='' where PK_NewsID = " + intID);
                if (clsFile.fileExists("../" + dt.Rows[0]["C_Img"].ToString()))
                    clsFile.fileDelete("../" + dt.Rows[0]["C_Img"].ToString());
                Response.Redirect("Default.aspx?page=add_edit_news&mod=news&do=edit&id="+intID);
            }
            if (strAct == "delAttach")
            {
                clsDatabase.ExecuteQuery("update tbl_news set C_Attach='' where PK_NewsID = " + intID);
                if (clsFile.fileExists("../" + dt.Rows[0]["C_Attach"].ToString()))
                    clsFile.fileDelete("../" + dt.Rows[0]["C_Attach"].ToString());
                Response.Redirect("Default.aspx?page=add_edit_news&mod=news&do=edit&id=" + intID);
            }
        }
        //===============================================================
        if (strImg != "")
        {
            PnImg.Visible = true;
            LblImg.Text = "<img src=../" + strImg + " width='150'>";
        }
        if (strFile != "")
        {
            PnAttach.Visible = true;
            LblAttach.Text = strFile;
        }
        //===============================================================
        FCKeditor1.BasePath = clsConfig.getFckPath();
        //setup lang
        FCKeditor1.Config["AutoDetectLanguage"] = "false";
        FCKeditor1.Config["DefaultLanguage"] = "vi";
        FCKeditor1.Width = 900;
        FCKeditor1.Height = 150;
        //setup thame
        FCKeditor1.Config["SkinPath"] = clsConfig.getFckPath() + "editor/skins/office2003/";
        //===============================================================
        //===============================================================
        FCKeditor2.BasePath = clsConfig.getFckPath();
        //setup lang
        FCKeditor2.Config["AutoDetectLanguage"] = "false";
        FCKeditor2.Config["DefaultLanguage"] = "vi";
        FCKeditor2.Width = 900;
        FCKeditor2.Height = 350;
        //setup thame
        FCKeditor2.Config["SkinPath"] = clsConfig.getFckPath() + "editor/skins/office2003/";
        //===============================================================
        if (Page.IsPostBack)
            return;

        //Dropdown
        DataTable dtCategory = clsDatabase.getDataTable("select * from tbl_category_news where FK_LangID = " + lang.getLangID() + " and  FK_ParentID = 0 AND FK_LangID = " + lang.getLangID() + " order by C_Rank desc");
        DrdCategory.Items.Clear();        
        int intSelected = 0;

        for (int i = 0; i < dtCategory.Rows.Count; i++)
        {
            DrdCategory.Items.Add(new ListItem(dtCategory.Rows[i]["C_Name"].ToString(), dtCategory.Rows[i]["PK_CategoryID"].ToString()));
            DataTable dtCategorySub = clsDatabase.getDataTable("select * from tbl_category_news where FK_ParentID = " + dtCategory.Rows[i]["PK_CategoryID"].ToString() + " AND FK_LangID = " + lang.getLangID() + " order by C_Rank desc");
            if (Convert.ToInt16(dtCategory.Rows[i]["PK_CategoryID"]) == intCategoryID)
            {
                DrdCategory.SelectedIndex = intSelected;
            }
            intSelected++;
            if (dtCategorySub.Rows.Count > 0)
            {
                for (int j = 0; j < dtCategorySub.Rows.Count; j++)
                {
                    DrdCategory.Items.Add(new ListItem(Server.HtmlDecode("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;") + dtCategorySub.Rows[j]["C_Name"].ToString(), dtCategorySub.Rows[j]["PK_CategoryID"].ToString()));

                    if (Convert.ToInt16(dtCategorySub.Rows[j]["PK_CategoryID"]) == intCategoryID)
                    {                        
                        DrdCategory.SelectedIndex = intSelected;
                    }                     
                    intSelected++;
                }
            }           
        }

        // Set the startup editor value.
        txtName.Text = strName;
        FCKeditor1.Value = strDes;
        FCKeditor2.Value = strContent;
        CKEditor_TrichDan.Text = strDes;
        CKEditor_ChiTiet.Text = strContent;
        if (intCheckHot == 1)
        {
            ChkHot.Checked = true;
        }
       
       
        //==========================================
    }

    private void add_news()
    {

        string strName = "";
        string strDes = "";
        string strContent = "";
        int intCheckHot = 0;        

        //===============================================================
        FCKeditor1.BasePath = clsConfig.getFckPath();
        //setup lang
        FCKeditor1.Config["AutoDetectLanguage"] = "false";
        FCKeditor1.Config["DefaultLanguage"] = "vi";
        FCKeditor1.Width = 900;
        FCKeditor1.Height = 150;
        //setup thame
        FCKeditor1.Config["SkinPath"] = clsConfig.getFckPath() + "editor/skins/office2003/";
        //===============================================================
        //===============================================================
        FCKeditor2.BasePath = clsConfig.getFckPath();
        //setup lang
        FCKeditor2.Config["AutoDetectLanguage"] = "false";
        FCKeditor2.Config["DefaultLanguage"] = "vi";
        FCKeditor2.Width = 900;
        FCKeditor2.Height = 350;
        //setup thame
        FCKeditor2.Config["SkinPath"] = clsConfig.getFckPath() + "editor/skins/office2003/";
        //===============================================================
        if (Page.IsPostBack)
            return;

        //Dropdown
        DataTable dtCategory = clsDatabase.getDataTable("select * from tbl_category_news where  FK_LangID = " + lang.getLangID() + " and FK_ParentID = 0 order by C_Rank desc");
        DrdCategory.Items.Clear();
        //DrdCategory.Items.Add(new ListItem("", "0"));
        int intSelected = 0;
        // Response.Write();
        for (int i = 0; i < dtCategory.Rows.Count; i++)
        {

            DrdCategory.Items.Add(new ListItem(dtCategory.Rows[i]["C_Name"].ToString(), dtCategory.Rows[i]["PK_CategoryID"].ToString()));
            DataTable dtCategorySub = clsDatabase.getDataTable("select * from tbl_category_news where FK_ParentID = " + dtCategory.Rows[i]["PK_CategoryID"].ToString() + " AND FK_LangID = " + lang.getLangID() + " order by C_Rank desc");

            if (dtCategorySub.Rows.Count > 0)
            {
                for (int j = 0; j < dtCategorySub.Rows.Count; j++)
                {
                    DrdCategory.Items.Add(new ListItem(Server.HtmlDecode("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;") + dtCategorySub.Rows[j]["C_Name"].ToString(), dtCategorySub.Rows[j]["PK_CategoryID"].ToString()));
                    
                }
            }
        }

        // Set the startup editor value.
        txtName.Text = strName;
        FCKeditor1.Value = strDes;
        FCKeditor2.Value = strContent; 
        //==========================================
    }

    protected void BtnSubmit_ServerClick(object sender, EventArgs e)
    {
        //Khoi tao cac gia tri
        string strCreate = clsDate.GetStrTime("mmddyyyy");
        string strName = clsInput.encodeStr(txtName.Text);
        string strDes = clsInput.encodeStr(FCKeditor1.Value);
        string strContent = clsInput.encodeStr(FCKeditor2.Value);
        strDes = clsInput.encodeStr(CKEditor_TrichDan.Text);
        strContent = clsInput.encodeStr(CKEditor_ChiTiet.Text);
        int intCategoryID = Convert.ToInt32(DrdCategory.SelectedValue.ToString());
        string strImageURL = "";
        string strFile = "";
        int intCheckHot = 0;
        
        int intCheckTieudiem = 0;
        if (ChkHot.Checked == true)
            intCheckHot = 1;

        int intCat = clsInput.getNumericInput("cat", 0);
        string strKey = clsInput.getStringInput("key", 0);

        string strS = "";
        if (intCat > 0 || strKey != "")
            strS += "&do=search";
        if (intCat > 0)
            strS += "&cat=" + intCat;
        if (strKey != "")
            strS += "&key=" + strKey;

        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strName == "")
            clsErr.setErr("Tiêu đề", "Bạn hãy nhập vào tiêu đề");
        if (strContent == "")
            clsErr.setErr("Nội dung", "Bạn hãy nhập vào nội dung chi tiết");
        if (uploadFile.PostedFile.ContentLength > 0)
        {
            if (clsFile.checkImagesUploadSize(uploadFile) == false)
                clsErr.setErr("Dung lượng ảnh", "Ảnh có dung lượng quá lớn, bạn chỉ được phép upload ảnh <=1Mb");
            if (clsFile.checkImagesUploadType(uploadFile) == false)
                clsErr.setErr("Định dạng ảnh", "Bạn chỉ được phép upload ảnh có định dạng .gif, .jpg, .png");
        }
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
            //try
            {
                strImageURL = clsFile.saveImages(uploadFile, "news");
                strFile = clsFile.saveImages(uploadAttach, "news");
                string strSql = "insert into tbl_news(C_Name, C_Des, C_Content, C_Hot, FK_LangID, C_Author, C_Create, FK_CategoryID, C_Active, C_Img,C_Attach) values (N'" + strName + "',N'" + strDes + "',N'" + strContent + "'," + intCheckHot.ToString() + "," + lang.getLangID() + ",'" + this.Session["C_UserName"].ToString() + "','" + strCreate + "'," + intCategoryID.ToString() + ",1,'" + strImageURL + "','" + strFile + "')";
                clsDatabase.ExecuteQuery(strSql);
                int intInsertRecord = clsDatabase.getInsertID("tbl_news", "PK_NewsID");
                clsDatabase.ExecuteQuery("update tbl_news set C_Rank = " + intInsertRecord + " where PK_NewsID = " + intInsertRecord);
                Response.Redirect("Default.aspx?page=news&mod=news" + strS);
            }
            /*catch 
            {
                clsErr.setErr("Error", "Bạn hãy kiểm tra lại thông tin (Định dạng ảnh, file, các ký tự đặc biệt ...)");
                //Ket xuat loi
                if (clsErr.checkErr())
                {
                    block_error.Text = clsErr.displayErr();
                }
            }*/
        }

        //===============================================
    }
    
    protected void BtnEdit_ServerClick(object sender, EventArgs e)
    {
        //Khoi tao cac gia tri
        string strCreate = clsDate.GetStrTime("mmddyyyy");
        string strName = clsInput.encodeStr(txtName.Text);
        string strDes = clsInput.encodeStr(FCKeditor1.Value);
        string strContent = clsInput.encodeStr(FCKeditor2.Value);
        strDes = clsInput.encodeStr(CKEditor_TrichDan.Text);
        strContent = clsInput.encodeStr(CKEditor_ChiTiet.Text);
        string strFile = "";
        int intCategoryID = Convert.ToInt32(DrdCategory.SelectedValue.ToString());
        int intCheckHot = 0;
        
        if (ChkHot.Checked == true)
            intCheckHot = 1;

        int intCat = clsInput.getNumericInput("cat", 0);
        string strKey = clsInput.getStringInput("key", 0);

        string strS = "";
        if (intCat > 0 || strKey != "")
            strS += "&do=search";
        if (intCat > 0)
            strS += "&cat=" + intCat;
        if (strKey != "")
            strS += "&key=" + strKey;
        
        //====================================================
        //Get Url
        int intId = clsInput.getNumericInput("id", 0);
        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strName == "")
            clsErr.setErr("Tiêu đề", "Bạn hãy nhập vào tiêu đề");
        if (strContent == "")
            clsErr.setErr("Nội dung", "Bạn hãy nhập vào nội dung chi tiết");
        if (uploadFile.PostedFile.ContentLength > 0)
        {
            if (clsFile.checkImagesUploadSize(uploadFile) == false)
                clsErr.setErr("Dung lượng ảnh", "Ảnh có dung lượng quá lớn, bạn chỉ được phép upload ảnh <=1Mb");
            if (clsFile.checkImagesUploadType(uploadFile) == false)
                clsErr.setErr("Định dạng ảnh", "Bạn chỉ được phép upload ảnh có định dạng .gif, .jpg, .png");
        }
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
                string strImageURL = clsFile.saveImages(uploadFile, "news");
                strFile = clsFile.saveImages(uploadAttach, "news");
                string strSqlUpload = "";
                if (strImageURL != "")
                    strSqlUpload += ", C_Img = '" + strImageURL + "'";
                if(strFile != "")
                    strSqlUpload += ", C_Attach = '" + strFile + "'";
                //string strSql = "update tbl_news set C_Name = N'" + strName + "', C_Des = N'" + strDes + "', C_Content = N'" + strContent + "',C_Hot = " + intCheckHot + ",FK_CategoryID = " + intCategoryID + " where PK_NewsID=" + intId;
                //if(strImageURL != "")
                string strSql = "update tbl_news set C_Name = N'" + strName + "', C_Des = N'" + strDes + "', C_Content = N'" + strContent + "',C_Hot = " + intCheckHot + ",FK_CategoryID = " + intCategoryID + strSqlUpload + " where PK_NewsID=" + intId;                                
                clsDatabase.ExecuteQuery(strSql);

                Response.Redirect("Default.aspx?page=news&mod=news" + strS);
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
