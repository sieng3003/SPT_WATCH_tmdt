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
/// Summary description for clsSwap
/// </summary>
public class clsSwap
{
	public clsSwap()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public static int getCurrentRank(string strTableName, string strTableIdName, int intTableId)
    {
        string strSql = "select top 1 C_Rank from " + strTableName + " where " + strTableIdName + " = " + intTableId;
        DataTable dt;
        dt = clsDatabase.getDataTable(strSql);
        
        return (int)dt.Rows[0][0];
    }
    public static int getParentID(string strTableName, string strTableIdName, int intTableId)
    {
        string strSql = "select top 1 ParentID from " + strTableName + " where " + strTableIdName + " = " + intTableId;
        DataTable dt;
        dt = clsDatabase.getDataTable(strSql);
        return (int)dt.Rows[0]["ParentID"];
    }

    public static int getNextRank(string strTableName, string strTableIdName, int intRank, string strWhere)
    {
        string strSql = "";
        if(strWhere != "")
            strSql = "select top 1 C_Rank from " + strTableName + " where C_Rank > " + intRank + " and " + strWhere + " order by C_Rank asc";
        else
            strSql = "select top 1 C_Rank from " + strTableName + " where C_Rank > " + intRank + " order by C_Rank asc";
        DataTable dt;
        dt = clsDatabase.getDataTable(strSql);
        //HttpContext.Current.Response.Write(ds.Tables[strTableName].Rows[0]["Rank"].ToString());
        return (int)dt.Rows[0][0];
    }

    public static int getPreRank(string strTableName, string strTableIdName, int intRank, string strWhere)
    {  
        string strSql = "";
        if(strWhere != "")
            strSql = "select top 1 C_Rank from " + strTableName + " where C_Rank < " + intRank + " and " + strWhere + " order by C_Rank desc";
        else
            strSql = "select top 1 C_Rank from " + strTableName + " where C_Rank < " + intRank + " order by C_Rank desc";
        DataTable dt;
        dt = clsDatabase.getDataTable(strSql);
        //HttpContext.Current.Response.Write(ds.Tables[strTableName].Rows[0]["Rank"].ToString());
        return (int)dt.Rows[0][0];
    }



    public static void swapUpRecord(string strTableName, string strTableIdName, int intTableId, string strWhere)
    {
        int intCurrentRank = getCurrentRank(strTableName, strTableIdName, intTableId);
        int intNextRank = getNextRank(strTableName, strTableIdName, intCurrentRank, strWhere);
        //-----------------------------------
        //Lay Id cua ban ghi tiep theo
        //open connection
       

        string strSql = "select TOP 1 " + strTableIdName + " from " + strTableName + " where C_Rank = " + intNextRank;
        DataTable dt;
        dt = clsDatabase.getDataTable(strSql);
        //-----------------------------------
        
        int intIdCurrentRecord = intTableId;
        int intIdNextRecord = (int)dt.Rows[0][strTableIdName];
        //HttpContext.Current.Response.Write(intIdCurrentRecord.ToString());

        string strSqlUp = "update " + strTableName + " set C_Rank=" + intNextRank + " where " + strTableIdName + " =" + intIdCurrentRecord;
        string strSqlUpNext = "update " + strTableName + " set C_Rank=" + intCurrentRank + " where " + strTableIdName + " =" + intIdNextRecord;

        clsDatabase.ExecuteQuery(strSqlUp);
        clsDatabase.ExecuteQuery(strSqlUpNext);
         
        //HttpContext.Current.Response.Write(strSqlUp);
        //return (int)ds.Tables[strTableName].Rows[0][strTableIdName];
    }

    public static void swapDownRecord(string strTableName, string strTableIdName, int intTableId, string strWhere)
    {
        int intCurrentRank = getCurrentRank(strTableName, strTableIdName, intTableId);
        int intPreRank = getPreRank(strTableName, strTableIdName, intCurrentRank, strWhere);
        //-----------------------------------
        //Lay Id cua ban ghi truoc do
       
        string strSql = "select TOP 1 " + strTableIdName + " from " + strTableName + " where C_Rank = " + intPreRank;
        DataTable dt;
        dt = clsDatabase.getDataTable(strSql);
        //-----------------------------------
        int intIdCurrentRecord = intTableId;
        int intIdPreRecord = (int)dt.Rows[0][strTableIdName];
        //HttpContext.Current.Response.Write(intIdCurrentRecord + "/" + intIdNextRecord);

        string strSqlDown = "update " + strTableName + " set C_Rank=" + intPreRank + " where " + strTableIdName + " =" + intIdCurrentRecord;
        string strSqlDownPre = "update " + strTableName + " set C_Rank=" + intCurrentRank + " where " + strTableIdName + " =" + intIdPreRecord;
        
        clsDatabase.ExecuteQuery(strSqlDown);
        clsDatabase.ExecuteQuery(strSqlDownPre);
    }

    //dung cho table don le
    public static int getMaxRankRecord(string strTableName, string strWhere)
    {
        string strSql = "";
        if(strWhere !="")
            strSql = "select top 1 max(C_Rank) as C_Rank from " + strTableName + " where " + strWhere;
        else
            strSql = "select top 1 max(C_Rank) as C_Rank from " + strTableName;
        DataTable dt;
        dt = clsDatabase.getDataTable(strSql);
        return (int)dt.Rows[0][0];
    }
    //Dung cho cac table join voi nhau
    public static int getMaxRankRecord(string strSqlJoin, string strTableName, string strWhere)
    {
        string strSql = "";
        if (strWhere != "")
            strSql = "select top 1 max(" + strTableName + ".C_Rank) as C_Rank from " + strSqlJoin + " where " + strWhere;
        else
            strSql = "select top 1 max(" + strTableName + "C_Rank) as C_Rank from " + strSqlJoin;
        DataTable dt;
        dt = clsDatabase.getDataTable(strSql);
        return (int)dt.Rows[0][0];
    }
    public static int getMinRankRecord(string strTableName, string strWhere)
    {
        string strSql = "";
        if(strWhere !="")
            strSql = "select top 1 min(C_Rank) as C_Rank from " + strTableName + " where " + strWhere;
        else
            strSql = "select top 1 min(C_Rank) as C_Rank from " + strTableName;
        DataTable dt;
        dt = clsDatabase.getDataTable(strSql);
        return (int)dt.Rows[0][0];
    }
    public static int getMinRankRecord(string strSqlJoin, string strTableName, string strWhere)
    {
        string strSql = "";
        if (strWhere != "")
            strSql = "select top 1 min(" + strTableName + ".C_Rank) as C_Rank from " + strSqlJoin + " where " + strWhere;
        else
            strSql = "select top 1 min(" + strTableName + ".C_Rank) as C_Rank from " + strSqlJoin;
        DataTable dt;
        dt = clsDatabase.getDataTable(strSql);
        return (int)dt.Rows[0][0];
    }
}
