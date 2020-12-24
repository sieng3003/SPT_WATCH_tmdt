using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

/// <summary>
/// Summary description for clsPaging
/// </summary>
public class clsPaging
{
    public static SqlConnection Conn;
	public clsPaging()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    
    public static int getTotalPage(string strSql, int intPageSize)
    {
        int intTotalPage;
        int intTotalRecord = 0;
        
        DataTable dt;
        dt = clsDatabase.getDataTable(strSql);
        if(dt.Rows.Count > 0)
            intTotalRecord = Convert.ToInt32(dt.Rows[0][0]);
        intTotalPage = intTotalRecord / intPageSize;
        if (intTotalRecord % intPageSize > 0)
            intTotalPage += 1;
        if (intTotalRecord <= intPageSize)
            intTotalPage = 1;
        
        return intTotalPage;
    }

    public static int getCurPage()
    {
        int intCurPage = 0;
        if (System.Web.HttpContext.Current.Request.QueryString["p"] != null)
            intCurPage = Convert.ToInt32(System.Web.HttpContext.Current.Request.QueryString["p"].ToString());
        //System.Web.HttpContext.Current.Response.Write(intCurPage.ToString());
        if (intCurPage == 0)
            intCurPage = 1;
        //else
        //intCurPage = intCurPage - 1;
        //System.Web.HttpContext.Current.Response.Write(intCurPage.ToString());
        return intCurPage;
    }
    public static int getStartRecord(int intCurPage, int intPageSize)
    {
        int intStartRecord = 0;
        if (intCurPage == 0 || intCurPage == 1)
            intStartRecord = 0;
        else
            intStartRecord = (intCurPage - 1) * intPageSize;
        //System.Web.HttpContext.Current.Response.Write(intStartRecord.ToString());
        return intStartRecord;
    }

    public static string drawPage(int intPagesize, int intCurPage, int intTotalPage, string strPreParameters)
    {
        string str = "<b>Trang: </b>";
        //int Pagesize = 10;
        //int intTotalPage = getPage(strTableName, intPagesize, strWhere);
        if (intTotalPage <= 1)
        {
            str = "";
        }
        else
        {
            for (int i = 1; i <= intTotalPage; i++)
            {
                //Drd1.Items.Add(i.ToString());
                if (intCurPage == i)
                    str = str + "<font color='red'><b>" + i.ToString() + "</b></font> &nbsp;|&nbsp;&nbsp;";
                else
                {
                    if (strPreParameters != "")
                        str = str + "<a class='DarkText'  href='?" + strPreParameters + "&p=" + i.ToString() + "'>" + i.ToString() + "</a> | ";
                    else
                        str = str + "<a class='DarkText'  href='?p=" + i.ToString() + "'>" + i.ToString() + "</a> &nbsp;|&nbsp; &nbsp;";
                }
            }
        }
        //clsFunction.teststr(TotalPage.ToString());
        return str.ToString();
    }

    
}
