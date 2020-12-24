using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml;
using System.Globalization;

/// <summary>
/// Summary description for language
/// </summary>
public class language
{
	public language()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    // XML THEME FILE (TEST)
    private XmlDocument LoadTheme(string themefile)
    {
        XmlDocument doc = (XmlDocument)System.Web.HttpContext.Current.Cache[themefile];
        if (doc == null)
        {
            try
            {
                doc = new XmlDocument();
                doc.Load(System.Web.HttpContext.Current.Server.MapPath("/languages") + "\\" + themefile);
                System.Web.HttpContext.Current.Cache[themefile] = doc;
            }
            catch (Exception ex)
            {
                doc = new XmlDocument();
                doc.Load(System.Web.HttpContext.Current.Server.MapPath("/languages") + "\\" + "vietnamese.xml");
                System.Web.HttpContext.Current.Cache[themefile] = doc;
            }
        }
        return doc;
    }

    /// <summary>
    /// Get a value from the currently configured forum theme.
    /// </summary>
    /// <param name="page">Page to look under</param>
    /// <param name="tag">Theme item</param>
    /// <returns>Converted Theme information</returns>
    public string GetThemeContents(string page, string tag)
    {
        //return LoadTranslation();
        return GetThemeContents(page, tag, String.Format("[{0}.{1}]", page.ToUpper(), tag.ToUpper()));
    }

    /// <summary>
    /// Get a value from the currently configured forum theme.
    /// </summary>
    /// <param name="page">Page to look under</param>
    /// <param name="tag">Theme item</param>
    /// <param name="defaultValue">Value to return if the theme item doesn't exist</param>
    /// <param name="dontLogMissing">True if you don't want a log created if it doesn't exist</param>
    /// <returns>Converted Theme information or Default Value if it doesn't exist</returns>
    public string GetThemeContents(string page, string tag, string defaultValue)
    {
        XmlDocument doc;
        if (HttpContext.Current.Session["language"] == null) doc = LoadTheme("vietnamese.xml");
        else doc = LoadTheme(HttpContext.Current.Session["language"].ToString());

        string xPath = "//page[@name='" + page.ToUpper() + "']//Resource[@tag='" + tag.ToUpper() + "']";
        XmlNode sReturn = doc.DocumentElement.SelectSingleNode(xPath);
        if (sReturn == null) return defaultValue;
        //doc = null;
        return sReturn.InnerText;
    } 
}
