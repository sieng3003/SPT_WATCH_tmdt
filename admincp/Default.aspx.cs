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

public partial class adminSongda_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //========================
        clsConfig.Xacnhandangnhap();
        //========================
        inc_top.Controls.Add(LoadControl("modules/mod_top/mod_top.ascx"));
        string strMod = Request.QueryString["mod"];
        string strPage = Request.QueryString["page"];
        string loadPage = "modules/mod_" + strMod + "/mod_" + strPage + ".ascx";
        if (clsFile.fileExists(loadPage))
            inc_content.Controls.Add(LoadControl(loadPage));
        else
            inc_content.Controls.Add(LoadControl("modules/mod_home/mod_home.ascx"));

    }
    
}
