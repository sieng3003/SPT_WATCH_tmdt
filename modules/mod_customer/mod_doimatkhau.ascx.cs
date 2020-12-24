using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class modules_mod_customer_mod_doimatkhau : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strCheckButtonClick = clsInput.getStringInput("tenDangNhap", 0);
        if (strCheckButtonClick != null)
        {
            #region changepass
            //Khoi tao cac gia tri
            string strCustomerName = "";
            string strCustomerPass = "";
            string strReCustomerPass = "";
            string strFullName = "";
            string strAddress = "";
            string strEmail = "";
            int intSex = 0;
            string strBirth = "";
            string strPhone = "";
            string strDes = "";
            //====================================================

            string action = clsInput.getStringInput("action", 0);

            //==============================

            strCustomerName = clsInput.getStringInput("tenDangNhap", 0);
            strEmail = clsInput.getStringInput("email", 0);
            strCustomerPass = clsInput.getStringInput("matKhau", 0);
            strReCustomerPass = clsInput.getStringInput("reMatKhau", 0);




            //====================================================
            //Kiem tra loi
            //An thuoc tinh thong bao loi
            block_error.Text = "";
            if (strCustomerName == "")
                clsErr.setErr("Tên truy nhập", "Bạn hãy nhập vào tên đăng nhập");
            if (strCustomerPass == "")
                clsErr.setErr("Mật khẩu", "Bạn hãy nhập vào mật khẩu");
            if (strCustomerPass != strReCustomerPass)
                clsErr.setErr("Mật khẩu", "Mật khẩu và mật khẩu gõ lại không trùng nhau");
            if (strEmail == "")
                clsErr.setErr("Email", "Bạn hãy nhập vào Email");
            //Check exist
            DataTable dtCheckExist = clsDatabase.getDataTable("select * from tbl_customer where C_CustomerName = N'" + strCustomerName + "' and C_Email=N'" + strEmail + "'");
            if (dtCheckExist.Rows.Count <= 0)
            {
                clsErr.setErr("Account", "Tên đăng nhập hoặc email không đúng, vui lòng nhập lại");
            }
            //Ket xuat loi
            if (clsErr.checkErr())
            {
                string strError = clsErr.displayErr().Replace("<img border=\"0\" src=\"images/icons/warning.gif\" align=\"bottom\">", "");
                block_error.Text = strError;
            }
            else
            {
                if (dtCheckExist.Rows.Count > 0)
                {
                    string strSql = "";
                    //strCustomerPass = clsFunction.fnEncrypt(strCustomerPass);

                    //strSql = "update tbl_customer set C_CustomerPass = N'" + strCustomerPass + "' where PK_CustomerID=" + dtCheckExist.Rows[0]["PK_CustomerID"].ToString();
                    if (strCustomerPass != "")
                    {
                        strCustomerPass = clsFunction.fnEncrypt(strCustomerPass);
                        strSql = "update tbl_customer set C_CustomerPass = N'" + strCustomerPass + "' where PK_CustomerID=" + dtCheckExist.Rows[0]["PK_CustomerID"].ToString();
                    }
                    clsDatabase.ExecuteQuery(strSql);
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "redirect",
                    "alert('Đổi mật khẩu thành công!'); window.location='" +
                    clsConfig.GetHostUrl() + "/login/add/1/login.aspx';", true);
                    //Response.Redirect(clsConfig.GetHostUrl() + "/login/add/1/login.aspx");
                }
                else
                {

                }
            }
            #endregion
        }
    }
    protected void btnLogin_onserverclick(object sender, EventArgs e)
    {
        //Khoi tao cac gia tri
        string strCustomerName = "";
        string strCustomerPass = "";
        string strReCustomerPass = "";
        string strFullName = "";
        string strAddress = "";
        string strEmail = "";
        int intSex = 0;
        string strBirth = "";
        string strPhone = "";
        string strDes = "";
        //====================================================

        string action = clsInput.getStringInput("action", 0);

        //==============================
        if (Request.Form["txtTenDangNhap"] != null)
        {
            strCustomerName = Request.Form["txtTenDangNhap"].ToString().Trim();
        }
        if (Request.Form["txtEmail"] != null)
        {
            strEmail = Request.Form["txtEmail"].ToString().Trim();
        }
        if (Request.Form["txtMatKhau"] != null)
        {
            strCustomerPass = Request.Form["txtMatKhau"].ToString().Trim();
        }
        if (Request.Form["txtReMatKhau"] != null)
        {
            strReCustomerPass = Request.Form["txtReMatKhau"].ToString().Trim();
        }
        
        
        
        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strCustomerName == "")
            clsErr.setErr("Tên truy nhập", "Bạn hãy nhập vào tên đăng nhập");
        if (strCustomerPass == "")
            clsErr.setErr("Mật khẩu", "Bạn hãy nhập vào mật khẩu");
        if (strCustomerPass != strReCustomerPass)
            clsErr.setErr("Mật khẩu", "Mật khẩu và mật khẩu gõ lại không trùng nhau");
        if (strEmail == "")
            clsErr.setErr("Email", "Bạn hãy nhập vào Email");
        //Check exist
        DataTable dtCheckExist = clsDatabase.getDataTable("select * from tbl_customer where C_CustomerName = N'" + strCustomerName + "' and C_Email=N'"+strEmail+"'");
        if (dtCheckExist.Rows.Count <= 0)
        {
            clsErr.setErr("Account", "Tên đăng nhập và email không đúng, vui lòng nhập lại");
        }
        
        

        //Ket xuat loi
        if (clsErr.checkErr())
        {
            string strError = clsErr.displayErr().Replace("<img border=\"0\" src=\"images/icons/warning.gif\" align=\"bottom\">", "");
            block_error.Text = strError;
        }
        else
        {
            if (dtCheckExist.Rows.Count > 0)
            {
                string strSql = "";
                //strCustomerPass = clsFunction.fnEncrypt(strCustomerPass);

                //strSql = "update tbl_customer set C_CustomerPass = N'" + strCustomerPass + "' where PK_CustomerID=" + dtCheckExist.Rows[0]["PK_CustomerID"].ToString();
                if (strCustomerPass != "")
                {
                    strCustomerPass = clsFunction.fnEncrypt(strCustomerPass);
                    strSql = "update tbl_customer set C_CustomerPass = N'" + strCustomerPass + "' where PK_CustomerID=" + dtCheckExist.Rows[0]["PK_CustomerID"].ToString();
                }
                clsDatabase.ExecuteQuery(strSql);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "redirect",
                "alert('Đổi mật khẩu thành công!'); window.location='" +
                clsConfig.GetHostUrl() + "/login/add/1/login.aspx';", true);
                //Response.Redirect(clsConfig.GetHostUrl() + "/login/add/1/login.aspx");
            }
            else
            {
 
            }
        }
    }
}