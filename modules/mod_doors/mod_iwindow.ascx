<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_iwindow.ascx.cs" Inherits="modules_mod_doors_mod_iwindow" %>
<%@Import Namespace = "System.Data" %>
<script language="javascript">
function search_list_doors(PK_doorsID)
{		
    //alert(PK_doorsID);
	key_search_List_doors('<%= clsConfig.GetHostUrl() %>/ajax_box_doors.aspx?catid='+PK_doorsID);	
	return false;
}

</script>
<script src="<%= clsConfig.GetHostUrl() %>/js/ShowAjax.js"></script>
<div class="">
        <div class="blockright">
          <div class="tabright"> <span><%= lang.setLangValue("Plastic Doors, Doors", "Cửa nhựa, cửa cuốn")%></span> </div>
          <div class="submenu_right"> 
          <%
            DataTable dtdoors = clsDatabase.getDataTable("select * from tbl_category_news where C_MenuNgang = 1 and FK_LangID = " + lang.getLangID() + " and (FK_ParentID = 35 or FK_ParentID = 37 ) order by C_Rank desc");
            for(int idoors = 0; idoors < dtdoors.Rows.Count; idoors++)
            {
             %>
   	    <a onmouseover="search_list_doors(<%= dtdoors.Rows[idoors]["PK_CategoryID"].ToString() %>);" href="<%= clsConfig.GetHostUrl() %>/doors/3/<%= dtdoors.Rows[idoors]["PK_CategoryID"].ToString() %>/<%= clsFunction.RemoveUnicode(dtdoors.Rows[idoors]["C_Name"].ToString()) %>.aspx"><%= dtdoors.Rows[idoors]["C_Name"].ToString() %></a> | 
   	        <% } %>
          
          </div>
          <div class="listitem" id="showPlacedoors">
            <ul>
            <%
                DataTable dtListdoors = clsDatabase.getDataTable("select Top 24 * from tbl_doors inner join tbl_category_news on tbl_doors.FK_CategoryID = tbl_category_news.PK_CategoryID where tbl_category_news.FK_LangID = " + lang.getLangID() + " and (FK_ParentID = 35 or FK_ParentID = 37 ) order by tbl_category_news.C_Rank desc");
                for (int iListdoors = 0; iListdoors < dtListdoors.Rows.Count; iListdoors++ )
                {
             %>
             <% if (dtListdoors.Rows[iListdoors]["C_Img"].ToString() != "")
                {
                    if (clsFile.fileExists("~/" + dtListdoors.Rows[iListdoors]["C_Img"].ToString()))
                {
             %>
              <li>
                              <a href="<%= clsConfig.GetHostUrl() %>/detail-doors/7/<%= dtListdoors.Rows[iListdoors]["PK_doorsID"].ToString() %>/<%= clsFunction.RemoveUnicode(dtListdoors.Rows[iListdoors]["C_Name"].ToString()) %>.aspx"><img src="<%= clsConfig.GetHostUrl() %>/<%= dtListdoors.Rows[iListdoors]["C_Img"].ToString() %>" width="150" height="90" />
                            <%= dtListdoors.Rows[iListdoors]["C_Name"].ToString()%></a><br /><%= dtListdoors.Rows[iListdoors]["C_Intro"].ToString() %></li>
                            
              <% } } %>
              <% } %>
            </ul>
            <div style="clear:both"></div>
          </div>
          <!-- end item-->
        </div>
        <!-- end blockright-->
        
      </div>