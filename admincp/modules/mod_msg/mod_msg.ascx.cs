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

public partial class admincp_modules_mod_msg_mod_msg : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strUrl,strReport;
        strUrl = Request.QueryString["url"];
        Response.Write(strUrl);
        if (strUrl == "")
            strUrl = "Default.aspx";
        //lblUrl.Text = "<meta http-equiv='Refresh' content='5; URL="+ strUrl +"'>";
        lblUrlNext.Text = "<b><a href=\"" + strUrl + "\"><font color=\"#FF0000\">Tiếp tục</font></a></b>";
    }
}
