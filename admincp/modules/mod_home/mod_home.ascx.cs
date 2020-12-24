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

public partial class admincp_modules_mod_home_mod_home : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToBoolean(this.Session["login"]) == false || this.Session["C_UserName"].ToString() == null)
        {
            this.Response.Redirect("Login.aspx");
            ;
        }
    }
}
