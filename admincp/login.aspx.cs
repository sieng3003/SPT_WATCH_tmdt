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

public partial class admincp_login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LblError.Visible = true;
        if (Request.Cookies["isLog"] != null)
        {
            this.Session["C_UserName"] = Request.Cookies["isLog"]["C_UserName"];
            this.Session["C_FullName"] = Request.Cookies["isLog"]["C_FullName"];
            this.Session["PK_UserID"] = Request.Cookies["isLog"]["PK_UserID"];
            this.Session["login"] = true;
            //this.Session["language"] = "1";
            //Response.Write(this.Session["C_UserName"]);
            Response.Redirect("Default.aspx");
        }
        
    }
    protected void Dangnhap_Click(object sender, EventArgs e)
    {
        LblError.Text = "Đăng nhập không thành công, hãy thực hiện lại!";
        LblError.Visible = false;

        //string strPassWord = clsFunction.fnEncrypt(txt_password.Text);

        if (TxtUsername.Text != "" && TxtPassword.Text != "")
        {
            string Username = TxtUsername.Text.Replace("'", "''");
            string Password = clsFunction.fnEncrypt(TxtPassword.Text);
            string sql = "select * from tbl_user where C_UserName='" + Username + "'and C_UserPass='" + Password + "' and C_Active = 1";

            DataTable dt = clsDatabase.getDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                this.Session["C_UserName"] = dt.Rows[0]["C_UserName"].ToString();
                this.Session["C_Permission"] = Convert.ToInt16(dt.Rows[0]["C_Permission"]);
                this.Session["C_FullName"] = dt.Rows[0]["C_FullName"].ToString();
                this.Session["login"] = true;
                this.Session["PK_UserID"] = Convert.ToInt32(dt.Rows[0]["PK_UserID"]);


                Response.Cookies["isLog"]["C_UserName"] = dt.Rows[0]["C_UserName"].ToString();
                Response.Cookies["isLog"]["C_FullName"] = dt.Rows[0]["C_FullName"].ToString();
                Response.Cookies["isLog"]["PK_UserID"] = dt.Rows[0]["PK_UserID"].ToString();


                Response.Cookies["isLog"]["log"] = "true";
                Response.Cookies["isLog"]["lastVisit"] = DateTime.Now.ToString();
                Response.Cookies["isLog"].Expires = DateTime.Now.AddMinutes(30);
                

                Response.Redirect("Default.aspx" );
            }
            else
                LblError.Visible = true;
        }
        else
            LblError.Visible = true;
    }
}
