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
/// Summary description for clsHtml
/// </summary>
public class clsHtml
{
    public clsHtml()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    static public void checkAddPermission(int intMenuID)
    {
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + " and tbl_groupmember.C_Add = 1 and tbl_menu.FK_LangID = " + lang.getLangID() + " and tbl_Menu.PK_MenuID = " + intMenuID;
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count <= 0)
            HttpContext.Current.Response.Write("<script>alert('Bạn không được quyền sử dụng chức năng này');document.location = 'default.aspx'</script>");
    }
    static public void checkUpdatePermission(int intMenuID)
    {
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + " and tbl_groupmember.C_Edit = 1 and tbl_menu.FK_LangID = " + lang.getLangID() + " and tbl_Menu.PK_MenuID = " + intMenuID;
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count <= 0)
            HttpContext.Current.Response.Write("<script>alert('Bạn không được quyền sử dụng chức năng này');document.location = 'default.aspx'</script>");
    }
    static public void checkViewPermission(int intMenuID)
    {
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + " and tbl_groupmember.C_View = 1 and tbl_menu.FK_LangID = " + lang.getLangID() + " and tbl_Menu.PK_MenuID = " + intMenuID;
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count <= 0)
            HttpContext.Current.Response.Write("<script>alert('Bạn không được quyền sử dụng chức năng này');document.location = 'default.aspx'</script>");
    }
    static public void checkLockPermission(int intMenuID)
    {
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + " and tbl_groupmember.C_Lock = 1 and tbl_menu.FK_LangID = " + lang.getLangID() + " and tbl_Menu.PK_MenuID = " + intMenuID;
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count <= 0)
            HttpContext.Current.Response.Write("<script>alert('Bạn không được quyền sử dụng chức năng này');document.location = 'default.aspx'</script>");
    }
    static public void checkDelPermission(int intMenuID)
    {
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + " and tbl_groupmember.C_Del = 1 and tbl_menu.FK_LangID = " + lang.getLangID() + " and tbl_Menu.PK_MenuID = " + intMenuID;
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count <= 0)
            HttpContext.Current.Response.Write("<script>alert('Bạn không được quyền sử dụng chức năng này');document.location = 'default.aspx'</script>");
    }
    static public void checkProcessLockPermission(int intMenuID)
    {
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + " and tbl_groupmember.C_ProcessLock = 1 and tbl_menu.FK_LangID = " + lang.getLangID() + " and tbl_Menu.PK_MenuID = " + intMenuID;
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count <= 0)
            HttpContext.Current.Response.Write("<script>alert('Bạn không được quyền sử dụng chức năng này');document.location = 'default.aspx'</script>");
    }
    static public void checkProcessUnLockPermission(int intMenuID)
    {
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + " and tbl_groupmember.C_ProcessUnLock = 1 and tbl_menu.FK_LangID = " + lang.getLangID() + " and tbl_Menu.PK_MenuID = " + intMenuID;
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count <= 0)
            HttpContext.Current.Response.Write("<script>alert('Bạn không được quyền sử dụng chức năng này');document.location = 'default.aspx'</script>");
    }
    static public void checkProcessDelPermission(int intMenuID)
    {
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + " and tbl_groupmember.C_ProcessDel = 1 and tbl_menu.FK_LangID = " + lang.getLangID() + " and tbl_Menu.PK_MenuID = " + intMenuID;
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count <= 0)
            HttpContext.Current.Response.Write("<script>alert('Bạn không được quyền sử dụng chức năng này');document.location = 'default.aspx'</script>");
    }





    //type = 1: nomal; type = 2: permission
    static public string update(int intType, string strUrl)
    {
        string strDraw = "";
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + " and tbl_groupmember.C_Edit = 1 and tbl_menu.FK_LangID = " + lang.getLangID();
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count > 0)
            strDraw = "<a href=\"" + strUrl + "\"><img src=\"images/icons/update.png\" class=\"icon\" onmouseover=\"Tip('Nâng cấp/thay đổi thiết bị')\"></a>";
        else
            strDraw = "";
        return strDraw;
    }
    static public string add(int intType, string strUrl)
    {
        string strDraw = "";
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + " and tbl_groupmember.C_Add = 1 and tbl_menu.FK_LangID = " + lang.getLangID();
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count > 0)
            strDraw = "<a href=\"" + strUrl + "\"><img src=\"images/icons/add.gif\" class=\"icon\" onmouseover=\"Tip('Thêm bản ghi mới')\"></a>";
        else
            strDraw = "";
        return strDraw;
    }
    static public string addFlash(int intType, string strUrl)
    {
        string strDraw = "";
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + " and tbl_groupmember.C_Add = 1 and tbl_menu.FK_LangID = " + lang.getLangID();
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count > 0)
            strDraw = "<a href=\"" + strUrl + "\"><img src=\"images/icons/ListConfig.png\" class=\"icon\" onmouseover=\"Tip('Thêm bản ghi Flash mới')\"></a>";
        else
            strDraw = "";
        return strDraw;
    }
    static public string addVideo(int intType, string strUrl)
    {
        string strDraw = "";
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + " and tbl_groupmember.C_Add = 1 and tbl_menu.FK_LangID = " + lang.getLangID();
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count > 0)
            strDraw = "<a href=\"" + strUrl + "\"><img src=\"images/icons/install.png\" class=\"icon\" onmouseover=\"Tip('Thêm bản ghi Media mới')\"></a>";
        else
            strDraw = "";
        return strDraw;
    }
    static public string addImages(int intType, string strUrl)
    {
        string strDraw = "";
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + " and tbl_groupmember.C_Add = 1 and tbl_menu.FK_LangID = " + lang.getLangID();
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count > 0)
            strDraw = "<a href=\"" + strUrl + "\"><img src=\"images/icons/laguage1.gif\" class=\"icon\" onmouseover=\"Tip('Thêm bản ghi Images mới')\"></a>";
        else
            strDraw = "";
        return strDraw;
    }
    static public string edit(int intType, string strUrl)
    {
        string strDraw = "";
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + "  and tbl_groupmember.C_Edit = 1 and tbl_menu.FK_LangID = " + lang.getLangID();
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count > 0)
        {
            strDraw = "<a href='" + strUrl + "'>";
            strDraw = strDraw + "<img src='images/icons/edit.gif' onmouseover=\"Tip('Sửa bản ghi')\" border='0'>";
            strDraw = strDraw + "</a>";
        }
        else
            strDraw = "";
        return strDraw;
    }
    static public string del(int intType, string strUrl)
    {
        string strDraw = "";
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + "  and tbl_groupmember.C_Del = 1 and tbl_menu.FK_LangID = " + lang.getLangID();
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count > 0)
        {
            strDraw = "<a href='" + strUrl + "' onclick=\"return confirm('Bạn muốn xóa bản ghi này?');\">";
            strDraw = strDraw + "<img src=\"images/icons/delete.gif\" onmouseover=\"Tip('Xóa bản ghi')\" border=\"0\">";
            strDraw = strDraw + "</a>";
        }
        else
            strDraw = "";
        return strDraw;
    }
    static public string view(int intType, string strUrl)
    {
        
        string strDraw = "";
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + "  and tbl_groupmember.C_View = 1 and tbl_menu.FK_LangID = " + lang.getLangID();
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count > 0)
        {
            strDraw = "<a href='" + strUrl + "'>";
            strDraw = strDraw + "<img src=\"images/icons/detail.gif\" onmouseover=\"Tip('Xem thông bản ghi')\" border=\"0\">";
            strDraw = strDraw + "</a>";
        }
        else
            strDraw = "";
        return strDraw;
    }
    //intTypeActive = 0: Lock, intTypeActive = 1: UnLock
    static public string Lock(int intType, string strUrl)
    {
        string strDraw = "";
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + "  and tbl_groupmember.C_Lock = 1 and tbl_menu.FK_LangID = " + lang.getLangID();
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count > 0)
        {
            strDraw = "<a href='" + strUrl + "' onclick=\"return confirm('Bạn muốn khóa bản ghi này?');\">";
            strDraw = strDraw + "<img src=\"images/icons/unlock.gif\" onmouseover=\"Tip('Khóa bản ghi')\" border=\"0\">";
            strDraw = strDraw + "</a>";
        }
        else
            strDraw = "";
        return strDraw;
    }
    static public string UnLock(int intType, string strUrl)
    {
        string strDraw = "";
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + "  and tbl_groupmember.C_Lock = 1 and tbl_menu.FK_LangID = " + lang.getLangID();
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count > 0)
        {
            strDraw = "<a href='" + strUrl + "' onclick=\"return confirm('Bạn muốn mở khóa bản ghi này?');\">";
            strDraw = strDraw + "<img src=\"images/icons/lock.gif\" onmouseover=\"Tip('Mở Khóa bản ghi')\" border=\"0\">";
            strDraw = strDraw + "</a>";
        }
        else
            strDraw = "";
        return strDraw;
    }
    static public string process_lock(int intType)
    {
        string strDraw = "";
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + "  and tbl_groupmember.C_ProcessLock = 1 and tbl_menu.FK_LangID = " + lang.getLangID();
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count > 0)
        {
            strDraw = "<input name=\"inactive_all\" type=\"submit\" id=\"Submit1\" value='' class=\"inactive_button\" onmouseover=\"Tip('Khóa các bản ghi đã chọn lựa')\" onclick=\"return checkSubmitActiveInactiveForm(document.getElementById('activeForm'),'InActiveAll');\" />";
        }
        else
            strDraw = "";
        return strDraw;
    }
    static public string process_unlock(int intType)
    {
        string strDraw = "";
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + "  and tbl_groupmember.C_ProcessUnLock = 1 and tbl_menu.FK_LangID = " + lang.getLangID();
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count > 0)
        {
            strDraw = "<input name=\"active_all\" type=\"submit\" value=\"\" id=\"operation\" class=\"active_button\" onmouseover=\"Tip('Mở khóa các bản ghi đã chọn lựa')\"  onclick=\"return checkSubmitActiveInactiveForm(document.getElementById('activeForm'),'ActiveAll');\" />";
        }
        else
            strDraw = "";
        return strDraw;
    }
    static public string process_del(int intType)
    {
        string strDraw = "";
        //System Admin
        string strSql = "select tbl_menu.PK_MenuID as PK_MenuID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + HttpContext.Current.Session["PK_UserID"].ToString() + "  and tbl_groupmember.C_ProcessDel = 1 and tbl_menu.FK_LangID = " + lang.getLangID();
        DataTable dt = clsDatabase.getDataTable(strSql);
        if (dt.Rows.Count > 0)
        {
            strDraw = "<input name=\"delete_all\" type=\"submit\" id=\"Submit2\" value=\"\" class=\"delete_button\" onmouseover=\"Tip('Xóa các bản ghi đã chọn lựa')\"  onclick=\"return checkSubmitActiveInactiveForm(document.getElementById('activeForm'),'DeleteAll');\" />";
        }
        else
            strDraw = "";
        return strDraw;
    }
}
