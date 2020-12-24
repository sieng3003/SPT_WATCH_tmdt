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
/// Summary description for clsErr
/// </summary>
public class clsErr
{
    public static string strTableErr;
    public static string strRowErr;
    public static int intCountErr;
	public clsErr()
	{
		//
		// TODO: Add constructor logic here
		//
        strTableErr = "";
        strRowErr = "";
        intCountErr = 0;
	}
    static void closeClsErr()
    {
        //
        // TODO: Add constructor logic here
        //
        strTableErr = null;
        strRowErr = null;
        intCountErr = 0;
    }
    //Kiem tra su ton tai cua loi
    public static bool checkErr()
    {
        if(intCountErr>0)
            return true;
        return false;
    }
    public static void setErr(string strErrName, string strErrContent)
    {        
        intCountErr++;
        strRowErr += "<tr>";
        strRowErr += "<td width=\"25%\" style=\"text-align : left;\"><a href=\"#\" {focus}><i>" + strErrName + "</i></a></td>";
        strRowErr += "<td width=\"75%\" style=\"text-align : left;\">:<span class=\"note\">" + strErrContent + "</span></td>";
        strRowErr += "</tr>";
    }
    public static string displayErr()
    {
        strTableErr += "<fieldset>";
        strTableErr += "<legend>Error:</legend>";
        strTableErr += "<table bgcolor=\"#FFFBB3\" cellpadding=\"1\" cellspacing=\"1\">";
        strTableErr += "<tr>";
        strTableErr += "<td width=\"80\" align=\"center\" valign=\"middle\"><img border=\"0\" src=\"images/icons/warning.gif\" align=\"bottom\"></td>";
        strTableErr += "<td width=\"100%\" valign=\"top\" align=\"left\" >";
        strTableErr += "<table class=\"error\" cellpadding=\"1\" cellspacing=\"1\">";
        strTableErr += strRowErr;
        strTableErr += "</table>";
        strTableErr += "</td>";
        strTableErr += "</tr>";
        strTableErr += "</table>";
        strTableErr += "</fieldset>";
        string strDisplayErr = strTableErr;
        closeClsErr();
        return strDisplayErr;
    }
    public static void setFrontErr(string strErrName, string strErrContent)
    {
        intCountErr++;
        strRowErr += "<tr>";
        strRowErr += "<td width=\"25%\" style=\"text-align : left;\"  class=\"text s10 br p0\"><a href=\"#\" {focus}><i>" + strErrName + "</i></a></td>";
        strRowErr += "<td width=\"75%\" style=\"text-align : left;\" class=\"text s10 br p0\">:" + strErrContent + "</td>";
        strRowErr += "</tr>";
    }
    public static string displayFrontErr()
    {
        strTableErr += "<fieldset style='padding-bottom:10px;'>";
        strTableErr += "<legend>Error:</legend>";
        strTableErr += "<table bgcolor=\"#FFFBB3\" cellpadding=\"1\" cellspacing=\"1\">";
        strTableErr += "<tr>";
        strTableErr += "<td width=\"80\" align=\"center\" valign=\"middle\"></td>";
        strTableErr += "<td width=\"100%\" valign=\"top\" align=\"left\" >";
        strTableErr += "<table class=\"error\" cellpadding=\"1\" cellspacing=\"1\">";
        strTableErr += strRowErr;
        strTableErr += "</table>";
        strTableErr += "</td>";
        strTableErr += "</tr>";
        strTableErr += "</table>";
        strTableErr += "</fieldset>";
        string strDisplayErr = strTableErr;
        closeClsErr();
        return strDisplayErr;
    }
}
