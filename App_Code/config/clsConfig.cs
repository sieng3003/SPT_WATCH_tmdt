using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for clsConfig
/// </summary>
public class clsConfig
{
    public static int intAdminPermission = 2;
	public clsConfig()
	{
		//
		// TODO: Add constructor logic here
		//
        //intAdminPermission = 2;
	}
    public static string getMapKey()
    {
        string strKey = "ABQIAAAAHjY1Ci-roYEgP5sSlWjL8hTWzwxno2iK3JTNzEEPo5RTa6T4WRSnTtMart-D-cxd89qYpGTx6XIsNA"; //vietcode.vn
        //string strKey = "ABQIAAAAHjY1Ci-roYEgP5sSlWjL8hQOIlhKokvLQQ6uBwaWZwYHikY3-RRco0lFKHKkwekxva__luPwcwevYA"; //demo2.ninebit.vn
        return strKey;
    }
    public static void Xacnhandangnhap()
    {
        try
        {
            if (Convert.ToBoolean(HttpContext.Current.Session["login"]) == false || HttpContext.Current.Session["C_UserName"].ToString() == null)
            {
                HttpContext.Current.Response.Redirect("Login.aspx");
            }
        }
        catch
        {
            HttpContext.Current.Response.Redirect("Login.aspx");
        }
    }
    public static bool KiemtraThanhviendangnhap()
    {
        try
        {
            if (Convert.ToBoolean(HttpContext.Current.Session["Front_login"]) == false || HttpContext.Current.Session["Front_UserName"].ToString() == null)
            {
                return false;
            }
            return true;
        }
        catch
        {
            return false;
        }
    }
    public static void ChungthucThanhviendangnhap()
    {
        try
        {
            if (Convert.ToBoolean(HttpContext.Current.Session["Front_login"]) == false || HttpContext.Current.Session["Front_UserName"].ToString() == null)
            {
                //HttpContext.Current.Response.Redirect("~/thanh-vien/dang-nhap/tab.aspx");
                //neu ko phai la nguoi viet tin nay, xac dinh xem co phai admin ko
                if (Convert.ToBoolean(HttpContext.Current.Session["login"]) == false || HttpContext.Current.Session["C_UserName"].ToString() == null)
                    HttpContext.Current.Response.Redirect(clsConfig.GetHostUrl() + "/hotdeals/6/alert.aspx");
            }
        }
        catch
        {
            HttpContext.Current.Response.Redirect(clsConfig.GetHostUrl() + "/hotdeals/6/alert.aspx");
        }
    }
    public static bool ChungthucNguoidangtin(int intID)
    {
        try
        {           
            if (HttpContext.Current.Session["Front_UserID"] != null)
            {
                DataTable dtCheck = clsDatabase.getDataTable("select TOP 1 PK_TindangID from tbl_hotdeals where PK_TindangID = " + intID.ToString() + " and FK_UserID = " + HttpContext.Current.Session["Front_UserID"].ToString());
                if (dtCheck.Rows.Count > 0)
                    return true;
            }
            return false;
        }
        catch
        {
            HttpContext.Current.Response.Redirect(clsConfig.GetHostUrl() + "/hotdeals/5/alert.aspx");
            return false;
        }
    }
    public static bool isSupperAdmin()
    {
        try
        {
            if (Convert.ToInt32(HttpContext.Current.Session["C_Permission"]) == 2)
                return true;
            return false;
        }
        catch
        {
            return false;
        }
    }
    public static string getGlobalUrlPath()
    {
        
        string strUrl = HttpContext.Current.Request.Url.ToString();
        string strRealUrl = "";
        string[] separator = new string[] { "admincp" };
        string[] strSplitArr = strUrl.Split(separator, StringSplitOptions.RemoveEmptyEntries);
        strRealUrl = strSplitArr[0].ToString() + "admincp/";
        //Response.Write(strRealUrl.ToString());
        return strRealUrl;
    }

    public static string GetHostUrl()
    {
        //return "http://" + HttpContext.Current.Request.ServerVariables["HTTP_HOST"] + "/oxywatch";
        return "http://" + HttpContext.Current.Request.ServerVariables["HTTP_HOST"];
    }


    public static string getFckPath()
    {
        //string strPath = "/code/admincp/";
        //path server: string strPath = "/admincp/";
        string strPath = clsConfig.getGlobalUrlPath();
        return strPath;
    }
    public static void redirectUrl(string strPagename)
    {
        HttpContext.Current.Response.Redirect(clsConfig.getGlobalUrlPath() + "Default.aspx?page=msg&mod=msg&url=" + strPagename);
    }
    public static string getCurrentUrl()
    {
        string strType = clsInput.getStringInput("type",0);
        string strParType = "";
        if (strType != "")
            strParType = "&type="+strType;
        string strParentUrl = "Default.aspx?page=" + clsInput.getStringInput("page", 0) + "&mod=" + clsInput.getStringInput("mod", 0) + strParType;
        //=================================================
        string strPage = clsInput.getStringInput("p", 0);        
        if (strPage != null)
            strParentUrl += "&p=" + strPage;
        //=================================================
        return strParentUrl;
    }
    public static string getCurrentUrl(string strListParam)
    {
        string strParentUrl = "Default.aspx?page=" + clsInput.getStringInput("page", 0) + "&mod=" + clsInput.getStringInput("mod", 0) + strListParam;
        //=================================================        
        return strParentUrl;
    }
}
