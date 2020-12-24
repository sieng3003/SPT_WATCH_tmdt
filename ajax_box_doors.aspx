<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ajax_box_doors.aspx.cs" Inherits="ajax_box_doors" %>
<%@Import Namespace = "System.Data" %>
<%
    int intCatID = clsInput.getNumericInput("catid", 0);
    string strCatName = "";
 %>
<div class="listitem" id="showPlace">
            <ul>
            <%
                DataTable dtListdoors = clsDatabase.getDataTable("select TOP 24 tbl_category_news.C_Name as CatName, tbl_doors.* from tbl_doors inner join tbl_category_news on tbl_doors.FK_CategoryID = tbl_category_news.PK_CategoryID where tbl_category_news.FK_LangID = " + lang.getLangID() + " and (FK_ParentID = 35 or FK_ParentID = 37 ) and FK_CategoryID = " + intCatID + " order by tbl_category_news.C_Rank desc");
                for (int iListdoors = 0; iListdoors < dtListdoors.Rows.Count; iListdoors++ )
                {
                    strCatName = dtListdoors.Rows[iListdoors]["CatName"].ToString();
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
            <div style="text-align:right; padding-right:20px;"><b><a href="<%= clsConfig.GetHostUrl() %>/doors/3/<%= intCatID %>/<%= clsFunction.RemoveUnicode(strCatName) %>.aspx"><%= lang.setLangValue("View all", "Xem tất cả")%></a></b></div>
          </div>