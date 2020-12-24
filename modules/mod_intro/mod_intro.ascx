<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_intro.ascx.cs" Inherits="modules_mod_intro_mod_intro" %>
<%@ Import Namespace="System.Data" %>

<%
    DataTable dsSlide = clsDatabase.getDataTable("select * from tbl_banner where FK_LangID = " + lang.getLangID() + " and C_Active = 1 and FK_CategoryID=3 order by C_Rank desc");
    string sssss = "";
     %>
     <%if(dsSlide.Rows.Count>0) {%>
<div class="slider-default bannerslider">
    <div class="hrv-banner-container">
        <div class="hrvslider">
            <ul class="slides">
            <%for (int i = 0; i < dsSlide.Rows.Count; i++)
              {
                  
               %>
               <%if ((i + 1) % 3 == 1)
                 { %>
                <li><a href="<%= clsConfig.GetHostUrl() %>/<%=dsSlide.Rows[i]["C_Url"].ToString() %>" class="hrv-url">
                    <img class="img-responsive" src="<%= clsConfig.GetHostUrl() %>/<%=dsSlide.Rows[i]["C_Img"].ToString() %>"
                        alt="" />
                </a>
                    <div id="hrv-banner-caption1" class="hrv-caption hrv-banner-caption">
                        <div class="container">
                            <div class="hrv-caption-inner">
                                <div class="hrv-banner-content slider-1">
                                    <h2 class="hrv-title1">
                                        <%= Regex.Replace(clsInput.decodeStr(dsSlide.Rows[i]["C_Des"].ToString()), @"<[^>]+>|&nbsp;", "").Trim()%></h2>
                                    <h3 class="hrv-title2">
                                        <%=dsSlide.Rows[i]["C_Name"].ToString() %></h3>
                                    <a href="<%= clsConfig.GetHostUrl() %>/<%=dsSlide.Rows[i]["C_Url"].ToString() %>" class="hrv-url">Xem ngay</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <%} %>
                <%if ((i + 1) % 3 == 2)
                  { %>
                <li><a href="<%= clsConfig.GetHostUrl() %>/<%=dsSlide.Rows[i]["C_Url"].ToString() %>" class="hrv-url">
                    <img class="img-responsive" src="<%= clsConfig.GetHostUrl() %>/<%=dsSlide.Rows[i]["C_Img"].ToString() %>"
                        alt="" />
                </a>
                    <div id="hrv-banner-caption2" class="hrv-caption hrv-banner-caption">
                        <div class="container">
                            <div class="hrv-caption-inner">
                                <div class="hrv-banner-content slider-2">
                                    <h2 class="hrv-title1">
                                        <%= Regex.Replace(clsInput.decodeStr(dsSlide.Rows[i]["C_Des"].ToString()), @"<[^>]+>|&nbsp;", "").Trim()%></h2>
                                    <h3 class="hrv-title2">
                                        <%=dsSlide.Rows[i]["C_Name"].ToString() %></h3>
                                    <a href="<%= clsConfig.GetHostUrl() %>/<%=dsSlide.Rows[i]["C_Url"].ToString() %>" class="hrv-url">Xem ngay</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <%} %>
                <%if ((i + 1) % 3 == 0)
                  { %>
                <li><a href="<%= clsConfig.GetHostUrl() %>/<%=dsSlide.Rows[i]["C_Url"].ToString() %>" class="hrv-url">
                    <img class="img-responsive" src="<%= clsConfig.GetHostUrl() %>/<%=dsSlide.Rows[i]["C_Img"].ToString() %>"
                        alt="" />
                </a>
                    <div id="hrv-banner-caption3" class="hrv-caption hrv-banner-caption">
                        <div class="container">
                            <div class="hrv-caption-inner">
                                <div class="hrv-banner-content slider-3">
                                    <h2 class="hrv-title1">
                                        <%= Regex.Replace(clsInput.decodeStr(dsSlide.Rows[i]["C_Des"].ToString()), @"<[^>]+>|&nbsp;", "").Trim()%></h2>
                                    <h3 class="hrv-title2">
                                        <%=dsSlide.Rows[i]["C_Name"].ToString() %></h3>
                                    <a href="<%= clsConfig.GetHostUrl() %>/<%=dsSlide.Rows[i]["C_Url"].ToString() %>" class="hrv-url">Xem ngay</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <%} %>

                <%} %>
            </ul>
        </div>
    </div>
</div>
<%} %>
