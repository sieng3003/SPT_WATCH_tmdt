using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Mail;
using System.Web.Security;
using System.Security.Cryptography;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Globalization;

/// <summary>
/// Summary description for clsFunction
/// </summary>
public class clsFunction
{
    public static string FormatForXML(object input)
    {
        string data = input.ToString();      // cast the input to a string

        // replace those characters disallowed in XML documents
        data = data.Replace("&", "&amp;");
        data = data.Replace("\"", "&quot;");
        data = data.Replace("'", "&apos;");
        data = data.Replace("<", "&lt;");
        data = data.Replace(">", "&gt;");

        return data;
    }
    public static string RemoveUnicode(string s)
    {
        string stFormD = s.Normalize(NormalizationForm.FormD);
        StringBuilder sb = new StringBuilder();

        for (int ich = 0; ich < stFormD.Length; ich++)
        {
            UnicodeCategory uc = CharUnicodeInfo.GetUnicodeCategory(stFormD[ich]);
            if (uc != UnicodeCategory.NonSpacingMark)
            {
                sb.Append(stFormD[ich]);
            }
        }
        string strResult = sb.ToString().Normalize(NormalizationForm.FormC);
        strResult = strResult.Trim();
        strResult = strResult.Replace("\"", "");
        strResult = strResult.Replace("/", "");
        strResult = strResult.Replace(":", "");
        strResult = strResult.Replace("$", "");
        strResult = strResult.Replace("#", "");
        strResult = strResult.Replace("<", "");
        strResult = strResult.Replace(">", "");
        strResult = strResult.Replace("@", "");
        strResult = strResult.Replace("!", "");
        strResult = strResult.Replace("%", "");
        strResult = strResult.Replace("^", "");
        strResult = strResult.Replace("&", "");
        strResult = strResult.Replace("*", "");
        strResult = strResult.Replace("(", "");
        strResult = strResult.Replace(")", "");
        strResult = strResult.Replace("|", "");
        strResult = strResult.Replace(",", "");
        strResult = strResult.Replace(".", "");
        strResult = strResult.Replace("?", "");
        strResult = strResult.Replace(" ","-");
        return (strResult);
    }

    static public bool checkSubMenu(int intMenuID)
    {
        DataTable dt = clsDatabase.getDataTable("select * from tbl_menu where C_Active = 1 and FK_LangID = " + lang.getLangID() + " and FK_ParentID = " + intMenuID);
        if (dt.Rows.Count > 0)
            return true;
        return false;
    }
    static public bool checkGroupPermissionRecord(int intGroupMemberID, int intMenuID)
    {
        string strSql = "select FK_GroupMemberID, FK_MenuID from tbl_Permission where FK_GroupMemberID =" + intGroupMemberID.ToString();
        DataTable dt = clsDatabase.getDataTable(strSql);
        string strListMenu = "0,0";
        bool flag = false;
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (Convert.ToInt32(dt.Rows[i]["FK_MenuID"]) == intMenuID)
                {
                    flag = true;
                    return flag;
                }
            }               
        }
        return flag;
    }
    static public bool checkUserPermissionRecord(int intGroupMemberID, int intUserID)
    {
        //string strSql = "select FK_GroupMemberID from tbl_User where PK_UserID =" + intUserID.ToString();
        string strSql = "select FK_GroupMemberID from tbl_user_groupmember where FK_UserID =" + intUserID.ToString();
        DataTable dt = clsDatabase.getDataTable(strSql);
        bool flag = false;
        //if (dt.Rows.Count > 0)
        for (int i = 0; i < dt.Rows.Count; i++ )
        {
            if (dt.Rows[i]["FK_GroupMemberID"].ToString() == intGroupMemberID.ToString())
            {
                flag = true;
                return flag;
            }
        }
        return flag;
    }

   public static string fnEncrypt(string password)
    {
        byte[] textBytes = System.Text.Encoding.Default.GetBytes(password);
        try
        {
            System.Security.Cryptography.MD5CryptoServiceProvider cryptHandler;
            cryptHandler = new System.Security.Cryptography.MD5CryptoServiceProvider();
            byte[] hash = cryptHandler.ComputeHash(textBytes);
            string ret = "";
            foreach (byte a in hash)
            {
                if (a < 16)
                    ret += "0" + a.ToString("x");
                else
                    ret += a.ToString("x");
            }
            return ret;
        }
        catch
        {
            throw;
        }
    }



    public static string SendMail(string SenderName, string SenderEmail, string RecieverEmail, string MailTitle, string MailContent)
    {
        try
        {
            MailMessage mail = new MailMessage();

            mail.BodyEncoding = System.Text.Encoding.UTF8;
            mail.BodyFormat = MailFormat.Html;

            mail.To = RecieverEmail;

            mail.From = SenderEmail;

            mail.Subject = MailTitle;

            mail.Body = MailContent;

            //SmtpMail.SmtpServer = ConfigurationSettings.AppSettings["SMTP"];
            SmtpMail.SmtpServer = "210.245.86.14";

            SmtpMail.Send(mail);
            return "0";
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
    }
    public static string SendMail(string SenderName, string SenderEmail, string RecieverEmail, string MailTitle, string MailContent, string sSmtpServer)
    {
        try
        {
            MailMessage mail = new MailMessage();

            mail.BodyEncoding = System.Text.Encoding.UTF8;
            mail.BodyFormat = MailFormat.Html;

            mail.To = RecieverEmail;

            mail.From = SenderEmail;

            mail.Subject = MailTitle;

            mail.Body = MailContent;

            SmtpMail.SmtpServer = sSmtpServer;

            SmtpMail.Send(mail);
            return "0";
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
    }        
}
