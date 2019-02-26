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
using System.Data.SqlClient;

public partial class mod_top : System.Web.UI.UserControl
{
    //static string menu;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Action"] == "Logout")
        {
            this.Session["login"] = null;
            this.Session["C_UserName"] = null;
            this.Session["C_Permission"] = null;


            HttpCookie aCookie;
            string cookieName;
            int limit = Request.Cookies.Count;
            for (int i = 0; i < limit; i++)
            {
                cookieName = Request.Cookies[i].Name;
               
                aCookie = new HttpCookie(cookieName);
                aCookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(aCookie);
               
            }

        }
        
       
        //------------------
        if (Convert.ToInt32(Request.QueryString["lang"]) == 2)
        {
            this.Session["lang"] = 2;
            this.Session["language"] = "english.xml";                
        }
        //Response.Write(this.Session["lang"].ToString());
        if (Convert.ToInt32(Request.QueryString["lang"]) == 1)
        {
            this.Session["lang"] = 1;
            this.Session["language"] = "vietnamese.xml";
        }
       
    }
    
    
    
}
