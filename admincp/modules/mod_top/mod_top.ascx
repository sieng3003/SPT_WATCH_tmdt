<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_top.ascx.cs" Inherits="mod_top" %>
<%@Import Namespace = "System.Data" %>

<table border="0" cellpadding="0" cellspacing="0" width="1000">
<tbody><tr>
	<td class="WhiteText" height="80" valign="top" width="560" align="left">
		<!--<img src="images/logo.gif" title="Quay về trang chủ" border="0" align="left">--></td>

	<td class="DarkText" align="right">
	
	Xin chào <b><%= this.Session["C_FullName"].ToString() %></b>&nbsp;! &nbsp; |&nbsp; <a href="Default.aspx?Action=Logout" class="DarkText"> Logout </a>
	|&nbsp; 
		<br />

		<%--<%
            if (Convert.ToInt16(lang.getLangID()) == 1)
            {
		 %>
		Bạn đang ở ngôn ngữ <b>Tiếng Việt</b>, chuyển sang ngôn ngữ [ <img src="images/Lang_ENG.gif" /> <a href="default.aspx?lang=2" class="WhiteText"><b>English </a></b> ] 
		<% 
            } 
		    else
            {
		        %>
		Bạn đang ở ngôn ngữ <b>Tiếng Anh</b>, chuyển sang ngôn ngữ [ <img src="images/Lang_VIE.gif" /> <a href="default.aspx?lang=1" class="WhiteText"><b>Tiếng Việt </b></a>]
		<% } %>--%>

		</td>
		
</tr>
</tbody></table>
<table cellpadding="0" cellspacing="0" border="0" width="100%" background="images/bluefireback.gif">
    <tr>
        <td height="31">

<table cellpadding="0" cellspacing="0" border="0" style="margin-top:-1px;" width="100%">
    <tr>
        <td class="WhiteText" >
<%
    string strSql = "select DISTINCT tbl_menu.PK_MenuID as PK_MenuID, tbl_menu.C_Rank , tbl_menu.C_Name as C_Name, tbl_menu.C_Icon as C_Icon, tbl_menu.C_Url as C_Url, tbl_menu.FK_ParentID as FK_ParentID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID where tbl_user.PK_UserID = " + this.Session["PK_UserID"] + " and tbl_menu.FK_ParentID = 0  and tbl_menu.FK_LangID = " + lang.getLangID() + " order by tbl_menu.C_Rank desc ";
    DataTable dt = clsDatabase.getDataTable(strSql);
 %>		    
      		            

      
<script type="text/javascript" language="JavaScript1.2" src="menu_js/stmenu.js"></script>


<script type="text/javascript" language="JavaScript1.2">
stm_bm(["menu45ba",730,"","blank.gif",0,"","",0,0,250,0,500,1,0,0,"","",0,0,1,2,"default","hand",""],this);
stm_bp("p0",[0,4,0,0,3,4,21,9,100,"",-2,"",-2,50,0,0,"#999999","transparent","menu_js/bluefireback.gif",1,0,0,"#A9CFDB #93C0CE #155E8C"]);
<%
for(int i=0;i<dt.Rows.Count; i++)
{
 %> 
    stm_ai("p0i0",[0,"<%= dt.Rows[i]["C_Name"] %>  ","","",-1,-1,0,"<%= clsConfig.getGlobalUrlPath() + dt.Rows[i]["C_Url"] %>","_self","","","images/ThemeOffice/<%= dt.Rows[i]["C_Icon"].ToString() %>","images/ThemeOffice/<%= dt.Rows[i]["C_Icon"].ToString() %>",16,16,0,"","",0,0,0,0,1,"#00CCFF",1,"#B5BED6",1,"","",3,0,0,0,"#FFFFF7","#000000","#FFFFFF","#FFFF00","8pt Verdana","8pt Verdana",0,0]);
    stm_bpx("p1","p0",[1,4,5,5,3,5,16,0,100,"stEffect(\"slip\")",-2,"stEffect(\"slip\")",-2,100,2,3,"#999999","#f0f0f0","",0]);
    //Duyet vao cac danh muc con
     <%
     //check Supper admin
        string strSqlSub = "select tbl_menu.C_Name as C_Name, tbl_menu.C_Icon as C_Icon, tbl_menu.C_Url as C_Url, tbl_menu.FK_ParentID as FK_ParentID from ((tbl_menu inner join tbl_permission on tbl_menu.PK_MenuID = tbl_permission.FK_MenuID) inner join tbl_groupmember on tbl_permission.FK_GroupMemberID = tbl_groupmember.PK_GroupMemberID) inner join tbl_user_groupmember on tbl_groupmember.PK_GroupMemberID = tbl_user_groupmember.FK_GroupMemberID inner join tbl_user on tbl_user_groupmember.FK_UserID = tbl_user.PK_UserID  where tbl_user.PK_UserID = " + this.Session["PK_UserID"] + " and tbl_menu.FK_ParentID = "+ dt.Rows[i]["PK_MenuID"] +"  and tbl_menu.FK_LangID = "+ lang.getLangID() +"  order by tbl_menu.C_Rank desc ";
        if(clsConfig.isSupperAdmin())
            strSqlSub = "select * from tbl_menu where FK_ParentID = " + dt.Rows[i]["PK_MenuID"] + " and FK_LangID = " + lang.getLangID() + "  order by tbl_menu.C_Rank desc ";
        DataTable dtSub = clsDatabase.getDataTable(strSqlSub);
        for(int j=0;j<dtSub.Rows.Count; j++)
        { 
      %>            
            stm_aix("p1i0","p0i0",[0,"<%= dtSub.Rows[j]["C_Name"].ToString() %>","","",-1,-1,0,"<%= clsConfig.getGlobalUrlPath() + dtSub.Rows[j]["C_Url"].ToString() %>","_self","","","images/ThemeOffice/<%= dtSub.Rows[j]["C_Icon"].ToString() %>","images/ThemeOffice/<%= dtSub.Rows[j]["C_Icon"].ToString() %>",16,16,0,"","",0,0,0,0,1,"#00CCFF",1,"#FFFFFF",0,"","",3,0,0,0,"","#003366","#000000","#000000","8pt Verdana","8pt Verdana"]);
            //stm_ep();
    <% 
        } 
     %>
    stm_ep();
<%
}
 %> 
    stm_em();
</script>
      		            
      		            
                 </td>	
                    
	        </tr>
        </table>   		                  		                  		                  		            	    	            
	    </td>	    
	</tr>
</table>



