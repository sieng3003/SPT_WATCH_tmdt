<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ajax_box_product.aspx.cs" Inherits="ajax_box_product" %>
<%@Import Namespace = "System.Data" %>
<%
    int intCatID = clsInput.getNumericInput("catid", 0);
    string strCatName = "";
 %>
<div class="listitem" id="showPlace">
            <ul>
            <%
                DataTable dtListProduct = clsDatabase.getDataTable("select TOP 12 tbl_product.*, tbl_category_news.C_Name as CatName from tbl_product inner join tbl_category_news on tbl_product.FK_CategoryID = tbl_category_news.PK_CategoryID where tbl_category_news.FK_LangID = " + lang.getLangID() + " and (FK_ParentID = 12 or FK_ParentID = 20 ) and FK_CategoryID = " + intCatID + " order by tbl_category_news.C_Rank desc");
                for (int iListProduct = 0; iListProduct < dtListProduct.Rows.Count; iListProduct++ )
                {
                    strCatName = dtListProduct.Rows[iListProduct]["CatName"].ToString();
             %>
             <% if (dtListProduct.Rows[iListProduct]["C_Img"].ToString() != "")
                {
                    if (clsFile.fileExists("~/" + dtListProduct.Rows[iListProduct]["C_Img"].ToString()))
                {
             %>
              <li>
                              <a href="<%= clsConfig.GetHostUrl() %>/detail-product/3/<%= dtListProduct.Rows[iListProduct]["PK_productID"].ToString() %>/<%= clsFunction.RemoveUnicode(dtListProduct.Rows[iListProduct]["C_Name"].ToString()) %>.aspx"><img src="<%= clsConfig.GetHostUrl() %>/<%= dtListProduct.Rows[iListProduct]["C_Img"].ToString() %>" width="150" height="90" />
                            <%= dtListProduct.Rows[iListProduct]["C_Name"].ToString()%></a></li>
              <% } } %>
              <% } %>
            </ul>
            <div style="clear:both"></div>
            <div style="text-align:right; padding-right:20px;"><b><a href="<%= clsConfig.GetHostUrl() %>/product/4/<%= intCatID %>/<%= clsFunction.RemoveUnicode(strCatName) %>.aspx"><%= lang.setLangValue("View all", "Xem tất cả")%></a></b></div>
          </div>