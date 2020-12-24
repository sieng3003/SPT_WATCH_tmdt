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
/// Summary description for clsInput
/// </summary>
public class clsInput
{
	public clsInput()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    
    private static bool IsNumeric(string numberString)
    {
        char[] ca = numberString.ToCharArray();
        for (int i = 0; i < ca.Length; i++)
        {
            if (!char.IsNumber(ca[i]))
                return false;
        }
        return true;
    } 
    public static int getNumericInput(string strVar, int intType)
    {
        //intType = 0: QueryString; =1: Form
        int intVal = 0;
        string strBefore = "";
        //=====================================
        if (HttpContext.Current.Request.Form[strVar] != null)
            strBefore = HttpContext.Current.Request.Form[strVar];
        if (HttpContext.Current.Request.QueryString[strVar] != null)
            strBefore = HttpContext.Current.Request.QueryString[strVar];
        //=====================================
       
        if (IsNumeric(strBefore) == false)
        {
            intVal = 0;
        }
        else
        {
            bool isNum;
            if (HttpContext.Current.Request.Form[strVar] != null)
            {
                //intVal = Convert.ToInt16(HttpContext.Current.Request.Form[strVar]);
                isNum = int.TryParse(HttpContext.Current.Request.Form[strVar], out intVal);
                if (isNum)
                    return intVal;
            }
            if (intType == 0)
            {
                if (HttpContext.Current.Request.QueryString[strVar] != null)
                {
                    //intVal = Convert.ToInt16(HttpContext.Current.Request.QueryString[strVar]);
                    isNum = int.TryParse(HttpContext.Current.Request.QueryString[strVar],out intVal);
                    if (isNum)
                        return intVal;
                }
            }
        }
        return 0;
    }
    public static string getStringInput(string strVar, int intType)
    {
        //intType = 0: QueryString; =1: Form
        string str = null;
        if (HttpContext.Current.Request.Form[strVar]!=null)
            str = HttpContext.Current.Request.Form[strVar];
        if (intType == 0)
        {
            if (HttpContext.Current.Request.QueryString[strVar] != null)
                str = (string)HttpContext.Current.Request.QueryString[strVar];
        }
        return str;
    }
    public static string encodeStr(string strString)
    {
        strString = strString.Replace("'", "&#39;");
        strString = strString.Replace("<", "&lt;");
        strString = strString.Replace(">", "&gt;");
        strString = strString.Replace("\"", "&#34;");        
        strString = strString.Trim();
        return strString;
    }
    public static string decodeStr(string strString)
    {
        strString = strString.Replace("&#39;", "'");
        strString = strString.Replace("&lt;", "<");
        strString = strString.Replace("&gt;", ">");
        strString = strString.Replace("&#34;", "\"");        
        strString = strString.Trim();
        return strString;
    }


    public static string ConvertCurrency(double number)
    {
        double sodau = 0;
        double sosau = 0;
        if (number / 1000000000 >= 1)
        {
            sodau = Math.Round(number / 1000000000, 3);
            sosau = Math.Round(number / 1000000000, 3);
            return sodau.ToString() + " Tỷ";
        }
        if (number / 1000000 >= 1)
        {
            sodau = Math.Round(number / 1000000, 3);
            sosau = Math.Round(number / 100000, 3);
            return sodau.ToString() + " Triệu";
        }
        if (number / 100000 >= 1)
        {
            sodau = Math.Round(number / 100000, 3);
            sosau = Math.Round(number / 100000, 3);
            return sodau.ToString() + " Trăm nghìn";
        }
        if (number / 1000 >= 1)
        {
            sodau = Math.Round(number / 1000, 3);
            sosau = Math.Round(number / 1000, 3);
            return sodau.ToString() + " Nghìn";
        }
        if (number / 100 >= 1)
        {
            sodau = Math.Round(number / 100, 3);
            sosau = Math.Round(number / 100, 3);
            return sodau.ToString() + " Trăm đồng";
        }
        return "0";
    }
}
