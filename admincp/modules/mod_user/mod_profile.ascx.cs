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

public partial class admincp_modules_mod_user_mod_profile : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strDo = clsInput.getStringInput("do", 0);
        int intId = clsInput.getNumericInput("id", 0);
        //Server.Transfer("Default.aspx");
        PnEdit.Visible = true;
        if (!Page.IsPostBack)
            edit_user();
    }
    
    private void edit_user()
    {

        DataTable dt = clsDatabase.getDataTable("select * from tbl_user where C_UserName = '" + this.Session["C_UserName"].ToString() + "'");
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

        //==========================================
    }
    
    protected void BtnEdit_ServerClick(object sender, EventArgs e)
    {
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
       
        
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strUserName == "")
            clsErr.setErr("Tên truy nhập", "Bạn hãy nhập vào NickName");
        if (strUserPass != "")
        {
            if (strUserPass != strReUserPass)
                clsErr.setErr("Mật khẩu", "Mật khẩu và mật khẩu gõ lại không trùng nhau");
        }
        //Ket xuat loi
        if (clsErr.checkErr())
        {
            block_error.Text = clsErr.displayErr();
        }
        else
        {
            string strSql = "";
            strSql = "update tbl_user set C_UserName = N'" + strUserName + "', C_FullName = N'" + strFullName + "', C_Add = '" + strAdd + "',C_Email = '" + strEmail + "',C_Sex = " + intSex + ",C_Birth = '" + strBirth + "',C_Phone = '" + strPhone + "',C_Des = '" + strDes  + "' where C_UserName = '" + this.Session["C_UserName"].ToString()+"'";
            if (strUserPass != "")
            {
                strUserPass = clsFunction.fnEncrypt(strUserPass);
                strSql = "update tbl_user set C_UserName = N'" + strUserName + "', C_UserPass = '" + strUserPass + "', C_FullName = N'" + strFullName + "', C_Add = '" + strAdd + "',C_Email = '" + strEmail + "',C_Sex = " + intSex + ",C_Birth = '" + strBirth + "',C_Phone = '" + strPhone + "',C_Des = '" + strDes + "' where C_UserName = '" + this.Session["C_UserName"].ToString()+"'";
            }
            clsDatabase.ExecuteQuery(strSql);
            Response.Redirect("Default.aspx?page=profile&mod=user");
        }

        //===============================================
    }
}
