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

public partial class admincp_modules_mod_nhaxuong_mod_add_edit_nhaxuong : System.Web.UI.UserControl
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
            clsConfig.redirectUrl("Default.aspx?page=category_nhaxuong&mod=nhaxuong");
            //==================================================
        }

    }


    private void edit_news(int intID)
    {
        DataTable dt = clsDatabase.getDataTable("select * from tbl_nhaxuong where PK_NhaxuongID = " + intID);
        string strName = "";
        string strDes = "";
        string strContent = "";
        int intCheckHot = 0;
        int intCheckSupperHot = 0;
        int intCategoryID = 0;
        string strImg = "";
        string strFile = "";

        if (dt.Rows.Count > 0)
        {
            strName = clsInput.decodeStr(dt.Rows[0]["C_Name"].ToString());
            strDes = clsInput.decodeStr(dt.Rows[0]["C_Des"].ToString());
            strContent = clsInput.decodeStr(dt.Rows[0]["C_Content"].ToString());
            intCheckHot = Convert.ToInt16(dt.Rows[0]["C_Hot"]);
            intCheckSupperHot = Convert.ToInt16(dt.Rows[0]["C_SupperHot"]);
            intCategoryID = Convert.ToInt16(dt.Rows[0]["FK_CategoryID"]);
            strImg = dt.Rows[0]["C_Img"].ToString();
            strFile = dt.Rows[0]["C_Attach"].ToString();
            //Kiem tra viec xoa anh
            string strAct = clsInput.getStringInput("act", 0);
            if (strAct == "delImg")
            {
                clsDatabase.ExecuteQuery("update tbl_nhaxuong set C_Img='' where PK_NhaxuongID = " + intID);
                if (clsFile.fileExists("../" + dt.Rows[0]["C_Img"].ToString()))
                    clsFile.fileDelete("../" + dt.Rows[0]["C_Img"].ToString());
                Response.Redirect("Default.aspx?page=add_edit_nhaxuong&mod=nhaxuong&do=edit&id=" + intID);
            }
            if (strAct == "delAttach")
            {
                clsDatabase.ExecuteQuery("update tbl_nhaxuong set C_Attach='' where PK_NhaxuongID = " + intID);
                if (clsFile.fileExists("../" + dt.Rows[0]["C_Attach"].ToString()))
                    clsFile.fileDelete("../" + dt.Rows[0]["C_Attach"].ToString());
                Response.Redirect("Default.aspx?page=add_edit_nhaxuong&mod=nhaxuong&do=edit&id=" + intID);
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
        DataTable dtCategory = clsDatabase.getDataTable("select * from tbl_category_nhaxuong where FK_LangID = "+lang.getLangID()+" AND FK_LangID = " + lang.getLangID() + " order by C_Rank desc");
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

        // Set the startup editor value.
        txtName.Text = strName;
        FCKeditor1.Value = strDes;
        FCKeditor2.Value = strContent;
        if (intCheckHot == 1)
        {
            ChkHot.Checked = true;
        }
        if (intCheckSupperHot == 1)
        {
            ChkSupperHot.Checked = true;
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
        DataTable dtCategory = clsDatabase.getDataTable("select * from tbl_category_nhaxuong where FK_LangID = " + lang.getLangID() + "  order by C_Rank desc");
        DrdCategory.Items.Clear();
        //DrdCategory.Items.Add(new ListItem("", "0"));
        int intSelected = 0;
        // Response.Write();
        for (int i = 0; i < dtCategory.Rows.Count; i++)
        {

            DrdCategory.Items.Add(new ListItem(dtCategory.Rows[i]["C_Name"].ToString(), dtCategory.Rows[i]["PK_CategoryID"].ToString()));
            


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
        int intCategoryID = Convert.ToInt32(DrdCategory.SelectedValue.ToString());
        string strImageURL = "";
        string strFile = "";
        int intCheckHot = 0;
        int intCheckSupperHot = 0;
        int intCheckTieudiem = 0;
        if (ChkHot.Checked == true)
            intCheckHot = 1;
        if (ChkSupperHot.Checked == true)
            intCheckSupperHot = 1;

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
                strImageURL = clsFile.saveImages(uploadFile, "news");
                strFile = clsFile.saveImages(uploadAttach, "news");
                string strSql = "insert into tbl_nhaxuong(C_Name, C_Des, C_Content, C_Hot,C_SupperHot, FK_LangID, C_Author, C_Create, FK_CategoryID, C_Active, C_Img,C_Attach) values (N'" + strName + "',N'" + strDes + "',N'" + strContent + "'," + intCheckHot.ToString() + "," + intCheckSupperHot.ToString() + "," + lang.getLangID() + ",'" + this.Session["C_UserName"].ToString() + "','" + strCreate + "'," + intCategoryID.ToString() + ",1,'" + strImageURL + "','" + strFile + "')";
                clsDatabase.ExecuteQuery(strSql);
                int intInsertRecord = clsDatabase.getInsertID("tbl_nhaxuong", "PK_NhaxuongID");
                clsDatabase.ExecuteQuery("update tbl_nhaxuong set C_Rank = " + intInsertRecord + " where PK_NhaxuongID = " + intInsertRecord);
                Response.Redirect("Default.aspx?page=nhaxuong&mod=nhaxuong");
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
        string strCreate = clsDate.GetStrTime("mmddyyyy");
        string strName = clsInput.encodeStr(txtName.Text);
        string strDes = clsInput.encodeStr(FCKeditor1.Value);
        string strContent = clsInput.encodeStr(FCKeditor2.Value);
        string strFile = "";
        int intCategoryID = Convert.ToInt32(DrdCategory.SelectedValue.ToString());
        int intCheckHot = 0;
        int intCheckSupperHot = 0;
        if (ChkHot.Checked == true)
            intCheckHot = 1;
        if (ChkSupperHot.Checked == true)
            intCheckSupperHot = 1;
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
                if (strFile != "")
                    strSqlUpload += ", C_Attach = '" + strFile + "'";
                //string strSql = "update tbl_nhaxuong set C_Name = N'" + strName + "', C_Des = N'" + strDes + "', C_Content = N'" + strContent + "',C_Hot = " + intCheckHot + ",FK_CategoryID = " + intCategoryID + " where PK_NhaxuongID=" + intId;
                //if(strImageURL != "")
                string strSql = "update tbl_nhaxuong set C_Name = N'" + strName + "', C_Des = N'" + strDes + "', C_Content = N'" + strContent + "',C_Hot = " + intCheckHot + ",C_SupperHot = " + intCheckSupperHot + ",FK_CategoryID = " + intCategoryID + strSqlUpload + " where PK_NhaxuongID=" + intId;
                clsDatabase.ExecuteQuery(strSql);

                Response.Redirect("Default.aspx?page=nhaxuong&mod=nhaxuong");
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
