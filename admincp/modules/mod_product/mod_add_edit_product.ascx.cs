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

public partial class admincp_modules_mod_product_mod_add_edit_product : System.Web.UI.UserControl
{
    string urlFileDinhKem = "";
    public string attackFile = "";
    public DataTable dsAttackFile = null;
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

        DataTable dt = clsDatabase.getDataTable("select * from tbl_product where PK_ProductID = " + intID);
        string strName = "";
        decimal dcmGiaMoi = 0;
        decimal dcmGiaCu = 0;
        int intCategoryID = 0;
        int intCheckHot = 0;
        string strImg1 = "";
        string strImg2 = "";
        string strDes = "";

        if (dt.Rows.Count > 0)
        {
            strName = clsInput.decodeStr(dt.Rows[0]["C_Name"].ToString());
            dcmGiaMoi = decimal.Parse(dt.Rows[0]["C_GiaMoi"].ToString());
            dcmGiaCu = decimal.Parse(dt.Rows[0]["C_GiaCu"].ToString());
            strDes = clsInput.decodeStr(dt.Rows[0]["C_Des"].ToString());
            intCheckHot = Convert.ToInt16(dt.Rows[0]["C_Hot"]);
            strImg1 = dt.Rows[0]["C_Img"].ToString();
            strImg2 = dt.Rows[0]["C_Img2"].ToString();
            intCategoryID = Convert.ToInt16(dt.Rows[0]["FK_CategoryID"]);
            //Kiem tra viec xoa anh
            string strAct = clsInput.getStringInput("act", 0);
            if (strAct == "delImg1")
            {
                clsDatabase.ExecuteQuery("update tbl_product set C_Img='' where PK_ProductID = " + intID);
                if (clsFile.fileExists("../" + dt.Rows[0]["C_Img"].ToString()))
                    clsFile.fileDelete("../" + dt.Rows[0]["C_Img"].ToString());
                Response.Redirect("Default.aspx?page=add_edit_product&mod=product&do=edit&id=" + intID);
            }
            if (strAct == "delImg2")
            {
                clsDatabase.ExecuteQuery("update tbl_product set C_Img2='' where PK_ProductID = " + intID);
                if (clsFile.fileExists("../" + dt.Rows[0]["C_Img2"].ToString()))
                    clsFile.fileDelete("../" + dt.Rows[0]["C_Img2"].ToString());
                Response.Redirect("Default.aspx?page=add_edit_product&mod=product&do=edit&id=" + intID);
            }
            //============================================
            dsAttackFile = clsDatabase.getDataTable("select * from tbl_product_image where FK_ProductID=" + intID.ToString() +" and FK_LangID = " + lang.getLangID() + " order by C_Rank desc");
            if (dsAttackFile.Rows.Count > 0)
            {
                foreach (DataRow item in dsAttackFile.Rows)
                {
                    string fileName = item["C_Img"].ToString().Split('/')[item["C_Img"].ToString().Split('/').Length - 1];
                    //Ten file hien thi
                    string extension = System.IO.Path.GetExtension(fileName);
                    int index = fileName.IndexOf(extension);
                    string cleanPath = (index < 0)
                        ? fileName
                        : fileName.Remove(index, extension.Length);
                    string[] stringSeparators = new string[] { "_" };
                    cleanPath = cleanPath.Split(stringSeparators, StringSplitOptions.None)[0];
                    fileName = cleanPath + extension;
                    //////////////////////////////////
                    attackFile += "<div style=\"margin-bottom:5px\" id=\"fileDinhKem_" + item["PK_ProductImageID"].ToString() + "\" runat=\"server\" visible=\"true\">"
                    + "<img src=\'../" + item["C_Img"].ToString() + "\' width=\"150px\">" 
                    + "<img title=\"\" src=\"images/b_drop1.png\" style=\"border-width: 0px;margin-bottom:5px\" onclick=\"xoaFile(" + item["PK_ProductImageID"].ToString() + ");\">"
                    + "</div>";
                }
            }
        }


        //===============================================================
        if (strImg1 != "")
        {
            PnImg1.Visible = true;
            LblImg1.Text = "<img src='../" + strImg1 + "' width='150'>";
        }
        if (strImg2 != "")
        {
            PnImg2.Visible = true;
            LblImg2.Text = "<img src='../" + strImg2 + "' width='150'>";
        }


        //Dropdown
        //DataTable dtCategory = clsDatabase.getDataTable("select * from tbl_category_news where FK_LangID = " + lang.getLangID() + " and (FK_ParentID = 12 ) order by C_Rank desc");
        DataTable dtCategory = clsDatabase.getDataTable("select * from tbl_category_news where FK_ParentID = 0 AND FK_LangID = " + lang.getLangID() + " AND PK_CategoryID <> " + intID + " order by C_Rank desc");
        DrdCategory.Items.Clear();
        int intSelected = 0;

        for (int i = 0; i < dtCategory.Rows.Count; i++)
        {
            //DrdCategory.Items.Add(new ListItem(dtCategory.Rows[i]["C_Name"].ToString(), dtCategory.Rows[i]["PK_CategoryID"].ToString()));
            //if (Convert.ToInt16(dtCategory.Rows[i]["PK_CategoryID"]) == intCategoryID)
            //{
            //    DrdCategory.SelectedIndex = intSelected;
            //}
            //intSelected++;
            //==============
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
        DrdCategory.SelectedValue = intCategoryID.ToString();
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
        if (intCheckHot == 1)
        {
            ChkHot.Checked = true;
        }
        txtGiaMoi.Text = dcmGiaMoi.ToString();
        txtGiaCu.Text = dcmGiaCu.ToString();
        FCKeditor1.Value = strDes;
        CKEditor_ThongTin.Text = strDes;

        //==========================================
    }

    private void add_news()
    {

        string strName = "";



        if (Page.IsPostBack)
            return;

        //Dropdown
        //DataTable dtCategory = clsDatabase.getDataTable("select * from tbl_category_news where FK_LangID = " + lang.getLangID() + " and (FK_ParentID = 12 ) order by C_Rank desc");
        DataTable dtCategory = clsDatabase.getDataTable("select * from tbl_category_news where FK_ParentID = 0 and FK_LangID = " + lang.getLangID() + " order by C_Rank desc");
        DrdCategory.Items.Clear();

        for (int i = 0; i < dtCategory.Rows.Count; i++)
        {

            //DrdCategory.Items.Add(new ListItem(dtCategory.Rows[i]["C_Name"].ToString(), dtCategory.Rows[i]["PK_CategoryID"].ToString()));
            //==========
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
        decimal dcmGiaMoi = 0;
        decimal dcmGiaCu = 0;
        
        int intCategoryID = Convert.ToInt32(DrdCategory.Text.ToString());
        int intCheckHot = 0;
        if (ChkHot.Checked == true)
            intCheckHot = 1;
        string strImageURL1 = "";
        string strImageURL2 = "";
        string strDes = clsInput.encodeStr(FCKeditor1.Value);
        strDes = clsInput.encodeStr(CKEditor_ThongTin.Text);
        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strName == "")
            clsErr.setErr("Tiêu đề", "Bạn hãy nhập vào tiêu đề");
        decimal value;
        if (!String.IsNullOrEmpty(txtGiaMoi.Text))
        {
            if (!decimal.TryParse(txtGiaMoi.Text.Trim(), out value))
                clsErr.setErr("Kiểu dữ liệu", "Giá mới phải là số");
            else dcmGiaMoi = decimal.Parse(txtGiaMoi.Text.Trim());
        }
        if (!String.IsNullOrEmpty(txtGiaCu.Text))
        {
            if (!decimal.TryParse(txtGiaCu.Text.Trim(), out value))
                clsErr.setErr("Kiểu dữ liệu", "Giá cũ phải là số");
            else dcmGiaCu = decimal.Parse(txtGiaCu.Text.Trim());
        }
        if (uploadFile1.PostedFile.ContentLength == 0 || uploadFile2.PostedFile.ContentLength == 0)
        {
            clsErr.setErr("Check null", "Bạn cần chọn ảnh 1 và 2");
        }
        if (uploadFile1.PostedFile.ContentLength > 0)
        {
            if (clsFile.checkImagesUploadSize(uploadFile1) == false)
                clsErr.setErr("Dung lượng ảnh", "Ảnh có dung lượng quá lớn, bạn chỉ được phép upload ảnh <=1Mb");
            if (clsFile.checkImagesUploadType(uploadFile1) == false)
                clsErr.setErr("Định dạng ảnh", "Bạn chỉ được phép upload ảnh có định dạng .gif, .jpg, .png");
        }
        if (uploadFile2.PostedFile.ContentLength > 0)
        {
            if (clsFile.checkImagesUploadSize(uploadFile2) == false)
                clsErr.setErr("Dung lượng ảnh", "Ảnh có dung lượng quá lớn, bạn chỉ được phép upload ảnh <=1Mb");
            if (clsFile.checkImagesUploadType(uploadFile2) == false)
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
                
                strImageURL1 = clsFile.saveImages(uploadFile1, "product");
                strImageURL2 = clsFile.saveImages(uploadFile2, "product");
                string strSql = "insert into tbl_product(C_Name,C_Des, C_Img, C_Img2, FK_CategoryID, FK_LangID, C_Active,C_GiaMoi,C_GiaCu,C_Hot) values (N'" + strName + "',N'" + strDes + "',N'" + strImageURL1 + "',N'"+strImageURL2+"'," + intCategoryID + "," + lang.getLangID() + ",1,"+dcmGiaMoi+","+dcmGiaCu+","+intCheckHot+")";

                clsDatabase.ExecuteQuery(strSql);
                int intInsertRecord = clsDatabase.getInsertID("tbl_product", "PK_ProductID");
                clsDatabase.ExecuteQuery("update tbl_product set C_Rank = " + intInsertRecord + " where PK_ProductID = " + intInsertRecord);
                //Upload Anh slide
                urlFileDinhKem = clsFile.uploadFiles(Page.Request.Files.Count, Page.Request.Files, 2, "product");
                if (!urlFileDinhKem.Equals(""))
                {
                    string[] arrFileDinhKem = urlFileDinhKem.Split('#');
                    for (int i = 0; i < arrFileDinhKem.Length; i++)
                    {

                        strSql = "INSERT into tbl_product_image(FK_ProductID,C_Img,FK_LangID,C_Active,C_Rank) values (" + intInsertRecord + ",N'" + arrFileDinhKem[i] + "'," + lang.getLangID() + ",1," + i + 1 + ")";
                        clsDatabase.ExecuteQuery(strSql);
                    }
                }
                Response.Redirect("Default.aspx?page=product&mod=product");
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
        //====================
        string arrDeleteIDs = hdfDeleteFileId.Value;
        if (!arrDeleteIDs.Equals(""))
            arrDeleteIDs = arrDeleteIDs.Remove(arrDeleteIDs.Length - 1);
        //Khoi tao cac gia tri        
        string strName = clsInput.encodeStr(txtName.Text);
        decimal dcmGiaMoi = 0;
        decimal dcmGiaCu = 0;
        int intCheckHot = 0;
        if (ChkHot.Checked == true)
            intCheckHot = 1;
        int intCategoryID = Convert.ToInt32(DrdCategory.Text.ToString());
        string strDes = clsInput.encodeStr(FCKeditor1.Value);
        strDes = clsInput.encodeStr(CKEditor_ThongTin.Text);
        //====================================================
        //Get Url
        int intId = clsInput.getNumericInput("id", 0);
        DataTable dt = clsDatabase.getDataTable("select * from tbl_product where PK_ProductID = " + intId);
        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strName == "")
            clsErr.setErr("Tiêu đề", "Bạn hãy nhập vào tiêu đề");
        decimal value;
        if (!String.IsNullOrEmpty(txtGiaMoi.Text))
        {
            if (!decimal.TryParse(txtGiaMoi.Text.Trim(), out value))
                clsErr.setErr("Kiểu dữ liệu", "Giá mới phải là số");
            else dcmGiaMoi = decimal.Parse(txtGiaMoi.Text.Trim());
        }
        if (!String.IsNullOrEmpty(txtGiaCu.Text))
        {
            if (!decimal.TryParse(txtGiaCu.Text.Trim(), out value))
                clsErr.setErr("Kiểu dữ liệu", "Giá cũ phải là số");
            else dcmGiaCu = decimal.Parse(txtGiaCu.Text.Trim());
        }
        if (dt.Rows[0]["C_Img"].ToString().Equals("") || dt.Rows[0]["C_Img"].ToString().Equals(""))
        {
            if (uploadFile1.PostedFile.ContentLength == 0 || uploadFile2.PostedFile.ContentLength == 0)
            {
                clsErr.setErr("Check null", "Bạn cần chọn ảnh 1 và 2");
            }
        }
        if (uploadFile1.PostedFile.ContentLength > 0)
        {
            if (clsFile.checkImagesUploadSize(uploadFile1) == false)
                clsErr.setErr("Dung lượng ảnh", "Ảnh có dung lượng quá lớn, bạn chỉ được phép upload ảnh <=1Mb");
            if (clsFile.checkImagesUploadType(uploadFile1) == false)
                clsErr.setErr("Định dạng ảnh", "Bạn chỉ được phép upload ảnh có định dạng .gif, .jpg, .png");
        }
        if (uploadFile2.PostedFile.ContentLength > 0)
        {
            if (clsFile.checkImagesUploadSize(uploadFile2) == false)
                clsErr.setErr("Dung lượng ảnh", "Ảnh có dung lượng quá lớn, bạn chỉ được phép upload ảnh <=1Mb");
            if (clsFile.checkImagesUploadType(uploadFile2) == false)
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
                string strImageURL1 = clsFile.saveImages(uploadFile1, "product");
                string strImageURL2 = clsFile.saveImages(uploadFile2, "product");
                string strSql = "update tbl_product set C_Name = N'" + strName + "', C_Des = N'" + strDes + "',FK_CategoryID = " + intCategoryID +",C_GiaMoi="+dcmGiaMoi+",C_GiaCu="+dcmGiaCu+",C_Hot="+intCheckHot +" where PK_ProductID=" + intId;
                string addQueryString = "";
                if (strImageURL1 != "") addQueryString += " C_Img = N'" + strImageURL1 + "', ";
                if (strImageURL2 != "") addQueryString += " C_Img2 = N'" + strImageURL2 + "', ";
                strSql = "update tbl_product set C_Name = N'" + strName + "', C_Des = N'" + strDes + "', " + addQueryString + "FK_CategoryID = " + intCategoryID + ",C_GiaMoi=" + dcmGiaMoi + ",C_GiaCu=" + dcmGiaCu +",C_Hot="+intCheckHot + " where PK_ProductID=" + intId;
                clsDatabase.ExecuteQuery(strSql);
                //Upload Anh slide
                //Delete attackfile
                if (!arrDeleteIDs.Equals(""))
                {
                    foreach (string item in arrDeleteIDs.Split(';'))
                    {
                        clsDatabase.ExecuteQuery("Delete from tbl_product_image where PK_ProductImageID=" + item);
                    }

                }
                //Add attackFile
                urlFileDinhKem = clsFile.uploadFiles(Page.Request.Files.Count, Page.Request.Files, 2, "product");
                if (!urlFileDinhKem.Equals(""))
                {
                    string[] arrFileDinhKem = urlFileDinhKem.Split('#');
                    for (int i = 0; i < arrFileDinhKem.Length; i++)
                    {

                        strSql = "INSERT into tbl_product_image(FK_ProductID,C_Img,FK_LangID,C_Active,C_Rank) values (" + intId + ",N'" + arrFileDinhKem[i] + "'," + lang.getLangID() + ",1," + i + 1 + ")";
                        clsDatabase.ExecuteQuery(strSql);
                    }
                }
                //================
                Response.Redirect("Default.aspx?page=product&mod=product");
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
