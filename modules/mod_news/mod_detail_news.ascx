<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_detail_news.ascx.cs"
    Inherits="modules_mod_news_mod_detail_news" %>
<script language="javascript">

    function getW() {

        var theImg = document.getElementById('imgNewsDetail');

        //alert(theImg.width);
        return theImg.width;
        //alert('123');
    }

        
        
</script>
<%@ Import Namespace="System.Data" %>
<%
    int intTabId = clsInput.getNumericInput("tabid", 0);
    int intId = clsInput.getNumericInput("id", 0);
    int intCatId = 0;
     %>
<%
    DataTable dtName = clsDatabase.getDataTable("select tbl_category_news.C_Name as CatName, tbl_news.* from tbl_news inner join tbl_category_news on tbl_news.FK_CategoryID = tbl_category_news.PK_CategoryID where tbl_news.PK_NewsID = " + intId);
    if (dtName.Rows.Count > 0)
    {
        intCatId = Convert.ToInt32(dtName.Rows[0]["FK_CategoryID"].ToString());
%>
<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12 " id="layout-page">
        <span class="header-page clearfix">
            <h1>
                <%= dtName.Rows[0]["C_Name"].ToString() %></h1>
        </span>
        <div class="content-page">
             <%= clsInput.decodeStr(dtName.Rows[0]["C_Content"].ToString()) %>
        </div>
    </div>
</div>
<% } %>
