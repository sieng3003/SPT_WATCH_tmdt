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

public partial class admincp_modules_mod_adv_mod_add_edit_adv_video : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strDo = clsInput.getStringInput("do", 0);
        int intId = clsInput.getNumericInput("id", 0);
        int intGetPage = clsInput.getNumericInput("getpage", 0);
        int intP = clsInput.getNumericInput("p", 0);
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
            clsConfig.redirectUrl("Default.aspx?page=adv&mod=adv&getpage=" + intGetPage);
            //==================================================
        }

    }


    private void edit_news(int intID)
    {

        DataTable dt = clsDatabase.getDataTable("select * from tbl_adv where PK_AdvID = " + intID);
        string strName = "";
        string strDes = "";
        string strVideo = "";
        int intCategoryID = 0;
        string strImg = "";
        int intPageID = 0;
        int intGetPage = clsInput.getNumericInput("getpage", 0);
        int intP = clsInput.getNumericInput("p", 0);
        string strParam = "";
        if (intGetPage > 0)
            strParam += "&getpage=" + intGetPage.ToString();
        if (intGetPage > 0)
            strParam += "&p=" + intP.ToString();

        if (dt.Rows.Count > 0)
        {
            strName = clsInput.decodeStr(dt.Rows[0]["C_Name"].ToString());
            strDes = clsInput.decodeStr(dt.Rows[0]["C_Des"].ToString());
            strVideo = clsInput.decodeStr(dt.Rows[0]["C_Video"].ToString());
            intCategoryID = Convert.ToInt16(dt.Rows[0]["C_Place"]);
            intPageID = Convert.ToInt16(dt.Rows[0]["C_Page"]);
            strImg = dt.Rows[0]["C_Img"].ToString();
            //Kiem tra viec xoa anh
            string strAct = clsInput.getStringInput("act", 0);
            if (strAct == "delImg")
            {
                clsDatabase.ExecuteQuery("update tbl_adv set C_Img='' where PK_AdvID = " + intID + strParam);
                if (clsFile.fileExists("../" + dt.Rows[0]["C_Img"].ToString()))
                    clsFile.fileDelete("../" + dt.Rows[0]["C_Img"].ToString());
                Response.Redirect("Default.aspx?page=add_edit_adv&mod=adv&do=edit&id=" + intID + strParam);
            }
        }
        //===============================================================
        if (strImg != "")
        {
            PnImg.Visible = true;
            LblImg.Text = "<img src=../" + strImg + " width='150'>";
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
        FCKeditor1.Value = strDes;
        FCKeditor2.Value = strVideo;
        if (intCategoryID == 1)
            DrdPlace.SelectedIndex = 0;
        if (intCategoryID == 2)
            DrdPlace.SelectedIndex = 1;
        if (intCategoryID == 3)
            DrdPlace.SelectedIndex = 2;

        if (intPageID == 1)
            DrdPage.SelectedIndex = 0;
        if (intPageID == 2)
            DrdPage.SelectedIndex = 1;
        if (intPageID == 3)
            DrdPage.SelectedIndex = 2;
        if (intPageID == 4)
            DrdPage.SelectedIndex = 3;
        if (intPageID == 5)
            DrdPage.SelectedIndex = 4;
        if (intPageID == 6)
            DrdPage.SelectedIndex = 5;

        
        if (intGetPage == 1)
            DrdPage.SelectedIndex = 0;
        if (intGetPage == 2)
            DrdPage.SelectedIndex = 1;
        if (intGetPage == 3)
            DrdPage.SelectedIndex = 2;
        if (intGetPage == 4)
            DrdPage.SelectedIndex = 3;
        if (intGetPage == 5)
            DrdPage.SelectedIndex = 4;
        if (intGetPage == 6)
            DrdPage.SelectedIndex = 5;
        if (intGetPage == 7)
            DrdPage.SelectedIndex = 6;

        //==========================================
    }

    private void add_news()
    {

        string strName = "";
        string strDes = "";

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
        FCKeditor1.Value = strDes;

        int intGetPage = clsInput.getNumericInput("getpage", 0);
        if (intGetPage == 1)
            DrdPage.SelectedIndex = 0;
        if (intGetPage == 2)
            DrdPage.SelectedIndex = 1;
        if (intGetPage == 3)
            DrdPage.SelectedIndex = 2;
        if (intGetPage == 4)
            DrdPage.SelectedIndex = 3;
        if (intGetPage == 5)
            DrdPage.SelectedIndex = 4;
        if (intGetPage == 6)
            DrdPage.SelectedIndex = 5;
        if (intGetPage == 7)
            DrdPage.SelectedIndex = 6;

        //==========================================
    }

    protected void BtnSubmit_ServerClick(object sender, EventArgs e)
    {
        int intGetPage = clsInput.getNumericInput("getpage", 0);
        int intP = clsInput.getNumericInput("p", 0);
        string strParam = "";
        if (intGetPage > 0)
            strParam += "&getpage=" + intGetPage.ToString();
        strParam += "&p=" + intP.ToString();
        //Khoi tao cac gia tri        
        string strName = clsInput.encodeStr(txtName.Text);
        string strDes = clsInput.encodeStr(FCKeditor1.Value);
        string strVideo = clsInput.encodeStr(FCKeditor2.Value);
        int intCategoryID = Convert.ToInt32(DrdPlace.Value.ToString());
        int intPageID = Convert.ToInt32(DrdPage.Value.ToString());
        string strImageURL = "";


        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strName == "")
            clsErr.setErr("Tiêu đề", "Bạn hãy nhập vào tiêu đề");
        if (strVideo == "")
            clsErr.setErr("Video", "Bạn hãy nhập vào nội dung video");
        //Ket xuat loi
        if (clsErr.checkErr())
        {
            block_error.Text = clsErr.displayErr();
        }
        else
        {
            try
            {
                
                string strSql = "insert into tbl_adv(C_Name, C_Des, C_Video, FK_LangID, C_Place, C_Page, C_Active, C_IsImages, C_IsFlash, C_IsVideo) values (N'" + strName + "',N'" + strDes + "','" + strVideo + "'," + lang.getLangID() + "," + intCategoryID + "," + intPageID + ",1,0,0,1)";

                clsDatabase.ExecuteQuery(strSql);
                int intInsertRecord = clsDatabase.getInsertID("tbl_adv", "PK_AdvID");
                clsDatabase.ExecuteQuery("update tbl_adv set C_Rank = " + intInsertRecord + " where PK_AdvID = " + intInsertRecord);
                Response.Redirect("Default.aspx?page=adv&mod=adv" + strParam);
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
        int intGetPage = clsInput.getNumericInput("getpage", 0);
        int intP = clsInput.getNumericInput("p", 0);
        string strParam = "";
        if (intGetPage > 0)
            strParam += "&getpage=" + intGetPage.ToString();
        strParam += "&p=" + intP.ToString();
        //Khoi tao cac gia tri        
        string strName = clsInput.encodeStr(txtName.Text);
        string strDes = clsInput.encodeStr(FCKeditor1.Value);
        string strVideo = clsInput.encodeStr(FCKeditor2.Value);
        int intCategoryID = Convert.ToInt32(DrdPlace.Value.ToString());
        int intPageID = Convert.ToInt32(DrdPage.Value.ToString());
        //====================================================
        //Get Url
        int intId = clsInput.getNumericInput("id", 0);
        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strName == "")
            clsErr.setErr("Tiêu đề", "Bạn hãy nhập vào tiêu đề");
        if (strVideo == "")
            clsErr.setErr("Video", "Bạn hãy nhập đường dẫn video");

        //Ket xuat loi
        if (clsErr.checkErr())
        {
            block_error.Text = clsErr.displayErr();
        }
        else
        {
            try
            {
                string strSql = "update tbl_adv set C_Name = N'" + strName + "', C_Des = N'" + strDes + "',C_Video = '" + strVideo + "',C_Place = " + intCategoryID + ",C_Page = " + intPageID + ",C_IsImages = 0, C_IsFlash = 0, C_IsVideo = 1" + " where PK_AdvID=" + intId;
                clsDatabase.ExecuteQuery(strSql);
                Response.Redirect("Default.aspx?page=adv&mod=adv" + strParam);
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
