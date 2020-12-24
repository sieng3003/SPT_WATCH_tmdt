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
using System.Collections;

/// <summary>
/// Summary description for clsDatabase
/// </summary>
public class clsDatabase
{
    //public static SqlConnection Conn;
    //public static string strConn;
	public clsDatabase()
	{
		//
		// TODO: Add constructor logic here
		//
        /*
        if (Conn != null)
        {
            if (Conn.State != ConnectionState.Closed)
                Conn.Close();
        }
        
        if (Conn != null)
        {
            if (Conn.State != ConnectionState.Closed)
                clsFunction.teststr("O");
        }*/
       
    }
    ~clsDatabase()
    {
        //
        // TODO: Add constructor logic here
        //        
       // if (Conn != null)
        //    Conn = null;
    }
    public SqlConnection cnopen()
    {
        SqlConnection Conn;
        Conn = new SqlConnection();
        try
        {
            //Conn.ConnectionString = HttpContext.Current.Application["source"].ToString();
            Conn.ConnectionString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            if (Conn.State != ConnectionState.Closed) Conn.Close();
            Conn.Open();
        }
        catch (Exception ex)
        {
            HttpContext.Current.Response.Write("Không thể kết nối csdl");
        }
        return Conn;
    }
    public static SqlConnection cnopenstatic()
    {
        SqlConnection Conn;
        Conn = new SqlConnection();
        try
        {
            //Conn.ConnectionString = HttpContext.Current.Application["source"].ToString();
            Conn.ConnectionString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            if (Conn.State != ConnectionState.Closed) Conn.Close();
            Conn.Open();
        }
        catch (Exception ex)
        {
            HttpContext.Current.Response.Write("Không thể kết nối csdl");
        }
        return Conn;
    }
    public static void cnclose()
    {
        SqlConnection Conn;
        Conn = new SqlConnection();
        if (Conn != null)
        {
            if (Conn.State != ConnectionState.Closed)
                Conn.Close();
        }
         
    }
    public static void ExecuteQuery(string sqlCmd)
    {
        //open connection
        SqlConnection Conn;
        Conn = new SqlConnection();
        Conn = cnopenstatic();

        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = sqlCmd;
        cmd.Connection = Conn;
                
        cmd.ExecuteNonQuery();
       // HttpContext.Current.Response.Write(sqlCmd);
        Conn.Close();
        Conn = null;
    }
    
    
    public static int getInsertID(string strTableName, string strTableIdName)
    {
        int intInsertRecord = 0;
        string strSql = "select TOP 1 " + strTableIdName + " from " + strTableName + " order by " + strTableIdName + " desc";
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count > 0)
        {
            intInsertRecord = Convert.ToInt32(dt.Rows[0][strTableIdName]);
        }        
        return intInsertRecord;
    }
    
    public SqlDataReader getInfoDetail(string strSql)
    {
        //open connection
        SqlConnection Conn;
        Conn = new SqlConnection();
        Conn = cnopen();

        SqlCommand cmd = new SqlCommand(strSql, Conn);
        SqlDataReader dr = cmd.ExecuteReader();
     //   Conn.Close();
        return dr;
    }
    //=======================================================
    public static DataTable getDataTable(string strSql, int intStartRecord, int intPageSize)
    {
        SqlConnection Conn = new SqlConnection();
        Conn = cnopenstatic();
        //===========================================       
        SqlDataAdapter da = new SqlDataAdapter(strSql, Conn);
        DataTable dt = new DataTable();
        da.Fill(intStartRecord, intPageSize, dt);
        Conn.Close();
        Conn = null;
        return dt;
    }
    //=======================================================
    public static DataTable getDataTable(string strSql)
    {
        SqlConnection Conn = new SqlConnection();
        Conn = cnopenstatic();
        //===========================================        
        SqlDataAdapter da = new SqlDataAdapter(strSql, Conn);
        DataTable dt = new DataTable();
        da.Fill(dt);
        Conn.Close();
        Conn = null;
        return dt;
    }
    public static string getStringFieldDataTable(string strFieldName, string strTableName, string strWhere)
    {
        string strSql = "select " + strFieldName + " from " + strTableName + " " + strWhere;
        
        SqlConnection Conn = new SqlConnection();
        Conn = cnopenstatic();
        //===========================================        
        SqlDataAdapter da = new SqlDataAdapter(strSql, Conn);
        DataTable dt = new DataTable();
        da.Fill(dt);
        Conn.Close();
        Conn = null;
        if (dt.Rows.Count > 0)
            return dt.Rows[0][strFieldName].ToString();
        return "0";
        
    }
}
