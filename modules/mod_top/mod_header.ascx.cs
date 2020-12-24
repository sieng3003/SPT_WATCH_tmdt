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

public partial class modules_mod_top_mod_header : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {


        //------------------
        if (this.Session["lang"] == null)
            this.Session["lang"] = 2;
        //Response.Write(this.Session["lang"].ToString());
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
