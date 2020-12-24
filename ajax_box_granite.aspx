<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ajax_box_granite.aspx.cs" Inherits="ajax_box_granite" %>
<%@Import Namespace = "System.Data" %>
<%
    int intCatID = clsInput.getNumericInput("catid", 0);
    string strCatName = "";
 %>
<div class="listitem" id="showPlace">
            <ul>
            <%
                DataTable dtListGranite = clsDatabase.getDataTable("select TOP 12 tbl_category_news.C_Name as CatName, tbl_granit.* from tbl_granit inner join tbl_category_news on tbl_granit.FK_CategoryID = tbl_category_news.PK_CategoryID where tbl_category_news.FK_LangID = " + lang.getLangID() + " and (FK_ParentID = 13 or FK_ParentID = 21 ) and FK_CategoryID = " + intCatID + " order by tbl_category_news.C_Rank desc");
                for (int iListGranite = 0; iListGranite < dtListGranite.Rows.Count; iListGranite++ )
                {
                    strCatName = dtListGranite.Rows[iListGranite]["CatName"].ToString();
             %>
             <% if (dtListGranite.Rows[iListGranite]["C_Img"].ToString() != "")
                {
                    if (clsFile.fileExists("~/" + dtListGranite.Rows[iListGranite]["C_Img"].ToString()))
                {
             %>
              <li>
                              <a href="<%= clsConfig.GetHostUrl() %>/detail-granite/3/<%= dtListGranite.Rows[iListGranite]["PK_GranitID"].ToString() %>/<%= clsFunction.RemoveUnicode(dtListGranite.Rows[iListGranite]["C_Name"].ToString()) %>.aspx"><img src="<%= clsConfig.GetHostUrl() %>/<%= dtListGranite.Rows[iListGranite]["C_Img"].ToString() %>" width="150" height="90" />
                            <%= dtListGranite.Rows[iListGranite]["C_Name"].ToString()%></a>
                            <a href="#" class="btn-buy">Mua ngay</a>
                            </li>
              <% } } %>
              <% } %>
            </ul>
            <div style="clear:both"></div>
            <div style="text-align:right; padding-right:20px;"><b><a href="<%= clsConfig.GetHostUrl() %>/Granite/3/<%= intCatID %>/<%= clsFunction.RemoveUnicode(strCatName) %>.aspx"><%= lang.setLangValue("View all", "Xem tất cả")%></a></b></div>
          </div>