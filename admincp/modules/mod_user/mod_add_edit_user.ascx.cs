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

public partial class admincp_modules_mod_user_mod_add_edit_user : System.Web.UI.UserControl
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
        //Server.Transfer("Default.aspx");
        if (strDo == "edit" && intId > 0)
        {
            //====================================
            //clsHtml.checkUpdatePermission(4);
            //====================================
            PnAdd.Visible = false;
            PnEdit.Visible = true;
            if (!Page.IsPostBack)
               edit_user(intId);
        }
        else if (strDo == "add")
        {
            //====================================
            //clsHtml.checkAddPermission(4);
            //====================================
            PnAdd.Visible = true;
            PnEdit.Visible = false;
            if (!Page.IsPostBack)
                add_user();
        }
        else
        {
            //Hien thi thong bao loi, khong thay tac vu yeu cau
            //==================================================
            //Display Msg
            clsConfig.redirectUrl("Default.aspx");
            //==================================================
        }
    }
    private void add_user()
    {
        string strUserName = "";
        string strUserPass = "";
        string strFullName = "";
        string strAdd = "";
        string strEmail = "";
        int intSex = 0;
        string strBirth = "";
        string strPhone = "";
        int intPermission = 0;
        string strDes = "";

        

        //===============================================================
        FCKeditor2.BasePath = clsConfig.getFckPath();
        //setup lang
        FCKeditor2.Config["AutoDetectLanguage"] = "false";
        FCKeditor2.Config["DefaultLanguage"] = "vi";
        FCKeditor2.Width = 750;
        FCKeditor2.Height = 250;
        //setup thame
        FCKeditor2.Config["SkinPath"] = clsConfig.getFckPath() + "editor/skins/office2003/";
        //===============================================================
        if (Page.IsPostBack)
            return;

        //==========================================
    }
    private void edit_user(int intID)
    {

        DataTable dt = clsDatabase.getDataTable("select * from tbl_user where PK_UserID = " + intID);
        string strUserName = "";
        string strUserPass = "";
        string strFullName = "";
        string strAdd = "";
        string strEmail = "";
        int intSex = 0;
        string strBirth = "";
        string strPhone = "";
        string strDes = "";
        if (dt.Rows.Count > 0)
        {
            strUserName = dt.Rows[0]["C_UserName"].ToString();
            strUserPass = dt.Rows[0]["C_UserPass"].ToString();
            strFullName = dt.Rows[0]["C_FullName"].ToString();
            strAdd = dt.Rows[0]["C_Add"].ToString();
            strEmail = dt.Rows[0]["C_Email"].ToString();
            intSex = Convert.ToInt16(dt.Rows[0]["C_Sex"]);
            strBirth = dt.Rows[0]["C_Birth"].ToString();
            strPhone = dt.Rows[0]["C_Phone"].ToString();
            strDes = clsInput.decodeStr(dt.Rows[0]["C_Des"].ToString());
            

           

        }

        //===============================================================
        FCKeditor2.BasePath = clsConfig.getFckPath();
        //setup lang
        FCKeditor2.Config["AutoDetectLanguage"] = "false";
        FCKeditor2.Config["DefaultLanguage"] = "vi";
        FCKeditor2.Width = 750;
        FCKeditor2.Height = 250;
        //setup thame
        FCKeditor2.Config["SkinPath"] = clsConfig.getFckPath() + "editor/skins/office2003/";
        //===============================================================
        if (Page.IsPostBack)
            return;

        

        // Set the startup editor value.
        txtUserName.Text = strUserName;
        txtUserName.Visible = false;
        lblUserName.Text = strUserName;
        txtUserPass.Text = "";
        txtFullName.Text = strFullName;
        txtEmail.Text = strEmail;
        if (intSex == 1)
            DrdSex.SelectedIndex = 0;
        else
            DrdSex.SelectedIndex = 1;
        
        txtBirth.Text = strBirth;
        txtAdd.Text = strAdd;

        FCKeditor2.Value = strDes;
        CKEditor_Mota.Text = strDes;
        //==========================================
    }
    protected void BtnSubmit_ServerClick(object sender, EventArgs e)
    {
        //====================================
      //  clsHtml.checkAddPermission(4);
        //====================================
        //Khoi tao cac gia tri
        string strUserName = clsInput.encodeStr(txtUserName.Text);
        string strUserPass = clsInput.encodeStr(txtUserPass.Text);
        string strReUserPass = clsInput.encodeStr(txtReUserPass.Text);
        string strFullName = clsInput.encodeStr(txtFullName.Text);
        string strAdd = clsInput.encodeStr(txtAdd.Text);
        string strEmail = clsInput.encodeStr(txtEmail.Text);
        int intSex = Convert.ToInt32(DrdSex.Value.ToString());
        string strBirth = clsInput.encodeStr(txtBirth.Text);
        string strPhone = clsInput.encodeStr(txtPhone.Text);
        
       
        string strDes = clsInput.encodeStr(FCKeditor2.Value);
        strDes = clsInput.encodeStr(CKEditor_Mota.Text);  
        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strUserName == "")
            clsErr.setErr("Tên truy nhập", "Bạn hãy nhập vào NickName");
        if (strUserPass == "")
            clsErr.setErr("Mật khẩu", "Bạn hãy nhập vào mật khẩu");
        if (strUserPass != strReUserPass)
            clsErr.setErr("Mật khẩu", "Mật khẩu và mật khẩu gõ lại không trùng nhau");
        if (strEmail == "")
            clsErr.setErr("Email", "Bạn hãy nhập vào Email");
        //Check exist
        DataTable dtCheckExist = clsDatabase.getDataTable("select * from tbl_user where C_UserName = N'" + strUserName+"'");
        if (dtCheckExist.Rows.Count > 0)
        {
            clsErr.setErr("Account", "Tên đăng nhập đã có trong hệ thống, vui lòng nhập tên khác");
        }
        //Ket xuat loi
        if (clsErr.checkErr())
        {
            block_error.Text = clsErr.displayErr();
        }
        else
        {
            strUserPass = clsFunction.fnEncrypt(strUserPass);
            //string strSql = "update tbl_user set C_UserName = N'" + strUserName + "', C_FullName = N'" + strFullName + "', C_Add = '" + strAdd + "',C_Email = '" + strEmail + "',C_Sex = " + intSex + ",C_Birth = '" + strBirth + "',C_Phone = '" + strPhone + "',C_Des = '" + strDes + "',C_Permission = " + intPermission + " where PK_UserID=" + intId;
            string strSql = "insert into tbl_user(C_UserName, C_UserPass,  FK_LangID, C_FullName, C_Email, C_Sex, C_Des, C_Birth, C_Add, C_Phone) values(N'" + strUserName + "','" + strUserPass + "'," + lang.getLangID() + ",N'" + strFullName + "',N'" + strEmail + "'," + intSex + ",N'" + strDes + "',N'" + strBirth + "',N'" + strAdd + "',N'" + strPhone + "')";
            clsDatabase.ExecuteQuery(strSql);
            int intInsertID = clsDatabase.getInsertID("tbl_user", "PK_UserID");
            clsDatabase.ExecuteQuery("update tbl_user set C_Rank = " + intInsertID + " where PK_UserID = " + intInsertID);
            Response.Redirect("Default.aspx?page=user&mod=user");
        }

        //===============================================
    }
    protected void BtnEdit_ServerClick(object sender, EventArgs e)
    {
        //====================================
       // clsHtml.checkUpdatePermission(4);
        //====================================
        //Khoi tao cac gia tri
        string strUserName = clsInput.encodeStr(txtUserName.Text);
        string strUserPass = clsInput.encodeStr(txtUserPass.Text);
        string strReUserPass = clsInput.encodeStr(txtReUserPass.Text);
        string strFullName = clsInput.encodeStr(txtFullName.Text);
        string strAdd = clsInput.encodeStr(txtAdd.Text);
        string strEmail = clsInput.encodeStr(txtEmail.Text);
        int intSex = Convert.ToInt32(DrdSex.Value.ToString());
        string strBirth = clsInput.encodeStr(txtBirth.Text);
        string strPhone = clsInput.encodeStr(txtPhone.Text);
        string strDes = clsInput.encodeStr(FCKeditor2.Value);
        strDes = clsInput.encodeStr(CKEditor_Mota.Text);  
                
        //====================================================
        //Get Url
        int intId = clsInput.getNumericInput("id", 0);
        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strUserName == "")
            clsErr.setErr("Tên truy nhập", "Bạn hãy nhập vào NickName");
        if (strUserPass != "")
        {
            if(strUserPass!=strReUserPass)
                clsErr.setErr("Mật khẩu", "Mật khẩu và mật khẩu gõ lại không trùng nhau");
        }
        if (strEmail == "")
            clsErr.setErr("Email", "Bạn hãy nhập vào Email");
        //Check exist
        //DataTable dtCheckExist = clsDatabase.getDataTable("select * from tbl_user where C_UserName = N'" + strUserName + "' and PK_UserID <> "+intId);
        //if (dtCheckExist.Rows.Count > 0)
        //{
        //    clsErr.setErr("Account", "Tên đăng nhập đã có trong hệ thống, vui lòng nhập tên khác");
        //}
        //Ket xuat loi
        if (clsErr.checkErr())
        {
            block_error.Text = clsErr.displayErr();
        }
        else
        {
            string strSql = "";
            strSql = "update tbl_user set C_UserName = N'" + strUserName + "', C_FullName = N'" + strFullName + "', C_Add = N'" + strAdd + "',C_Email = N'" + strEmail + "',C_Sex = " + intSex + ",C_Birth = N'" + strBirth + "',C_Phone = N'" + strPhone + "',C_Des = N'" + strDes + "' where PK_UserID=" + intId;
            if (strUserPass != "")
            {
                strUserPass = clsFunction.fnEncrypt(strUserPass);
                strSql = "update tbl_user set C_UserName = N'" + strUserName + "', C_UserPass = '" + strUserPass + "', C_FullName = N'" + strFullName + "', C_Add = N'" + strAdd + "',C_Email = N'" + strEmail + "',C_Sex = " + intSex + ",C_Birth = N'" + strBirth + "',C_Phone = N'" + strPhone + "',C_Des = N'" + strDes + "' where PK_UserID=" + intId;
            }
            clsDatabase.ExecuteQuery(strSql);
            Response.Redirect("Default.aspx?page=user&mod=user");
        }

        //===============================================
    }
}
