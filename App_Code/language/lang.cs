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
/// Summary description for lang
/// </summary>
public class lang
{
	public lang()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static string getLanguage(string page, string tag)
    {        
        return (new language()).GetThemeContents(page, tag);
    }
    public static string getCondLanguage(string prefix)
    {
        if (prefix != "") prefix = prefix + ".";
        try
        {
            if (HttpContext.Current.Session["language"] == null)
            {
                return prefix + "lang = 'vietnamese.xml'";
            }
            else return prefix + "lang = '" + HttpContext.Current.Session["language"].ToString() + "'";
        }
        catch (Exception ex)
        {
            return prefix + "lang = 'vietnamese.xml'";
        }
    }
    public static int getLangID()
    {
        if (HttpContext.Current.Session["lang"] == null)
            return 1;
        else
            return Convert.ToInt32(HttpContext.Current.Session["lang"].ToString());
    }
    public static string setLangValue(string english, string vietnamese)
    {
        if (HttpContext.Current.Session["lang"] != null)
            if(Convert.ToInt32(HttpContext.Current.Session["lang"]) == 1)
                return vietnamese;
        if (HttpContext.Current.Session["lang"] == null)
            return vietnamese;
        else
            return english;
        return "";
    }
    public static string getValLanguage()
    {
        try
        {
            if (HttpContext.Current.Session["language"] == null)
            {
                return "vietnamese.xml";
            }
            else return HttpContext.Current.Session["language"].ToString();
        }
        catch (Exception ex)
        {
            return "vietnamese.xml";
        }
    }
    public static string getLangText()
    {
        if (HttpContext.Current.Session["language"] == null)
            return "vi";
        else
            return "en";
        return "vi";
    }
}
