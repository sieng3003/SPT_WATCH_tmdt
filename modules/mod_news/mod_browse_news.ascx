<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_browse_news.ascx.cs"
    Inherits="modules_news_browse_news" %>
<%@ Import Namespace="System.Data" %>
<%
    int intTabId = clsInput.getNumericInput("tabid", 0);
    int intCatID = clsInput.getNumericInput("catid", 0);
    string strCatName = "";
    string strSearch1 = " and PK_CategoryID = "+intCatID;
    if (intCatID != 0) strSearch1 = "";
    DataTable dtCategoryName = clsDatabase.getDataTable("select C_Name from tbl_category_news where FK_LangID = " + lang.getLangID() + strSearch1);
    if (dtCategoryName.Rows.Count > 0)
    {
        strCatName = dtCategoryName.Rows[0]["C_Name"].ToString();
        //Response.Write(dtCategoryName.Rows[0]["C_Name"].ToString());
    }
    //------------------------------	

    int intCurPage = 0;
    int intStartRecord = 0;
    int intPageSize = 10;
    //------------------------------ 
    string strSearch2 = " and tbl_news.FK_CategoryID ="+intCatID;

    //-------------------------------		    		    
    intCurPage = clsPaging.getCurPage();
    intStartRecord = clsPaging.getStartRecord(intCurPage, intPageSize);
    //------------------------------ 		    
    string strSqlCount = "select count(*) from tbl_news  where FK_LangID = " + lang.getLangID() + "  and tbl_news.C_Active = 1 "+strSearch2 ;
    int intTotalPage = clsPaging.getTotalPage(strSqlCount, intPageSize);
    //string strParamPage = "page=" + Request.QueryString["page"] + "&mod=" + Request.QueryString["mod"] + "&key=" + strKey + "&catid=" + clsInput.getNumericInput("catid", 0);
    //========================================
    DataTable dtNews = clsDatabase.getDataTable("select tbl_news.* from tbl_news where FK_LangID = " + lang.getLangID() + "   and tbl_news.C_Active = 1 " + strSearch2 + " order by tbl_news.C_Rank desc", intStartRecord, intPageSize);

%>

<div class="row">
    <div id="blog" class="page-content main-content content-pages" data-sticky_parent>
        <!-- Begin content -->
        <div class="blog-content col-md-12 col-sm-12 col-xs-12">
            <div class="row">
                <div class="col-md-3  col-sm-12 col-xs-12 leftsidebar-col" data-sticky_column>
                    <!-- Begin sidebar blog -->
                    <div class="sidebar ">
                        <div class="group_sidebar">
                            <div class="list-group navbar-inner ">
                                <div>
                                    <h3 class="sb-title">
                                        Danh mục blog</h3>
                                </div>
                                <ul class="nav navs sidebar menu" id="menu-blog">
                                    <li class="item  "><a href="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/0/danh-sach-san-pham.aspx"><span>Tất cả các sản phẩm</span>
                                    </a></li>
                                    <li class="item  first"><a href="<%= clsConfig.GetHostUrl() %>/product/13/13/danh-sach-san-pham.aspx"><span>Đồng hồ nam</span>
                                    </a></li>
                                    <li class="item  "><a href="<%= clsConfig.GetHostUrl() %>/product/12/12/danh-sach-san-pham.aspx"><span>Đồng hồ nữ</span> </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <!-- End: Danh mục tin tức -->
                        <!--Begin: Bài viết mới nhất-->
                        <%if(dtNews.Rows.Count>0) 
                          {%>
                        <div class=" group_sidebar">
                            <h3 class="sb-title">
                                Bài viết mới nhất
                            </h3>
                            <%foreach (DataRow itemTinMoi in dtNews.Rows)
                              {
                                  //string sssss = DateTime.Parse(itemTinMoi["C_Create"].ToString()).ToString("dd/MM/yyyy");
                                  %>
                                <div class="article seller-item">
                                    <div class="sellers-img">
                                        <a href="<%= clsConfig.GetHostUrl() %>/detail-news/<%= intTabId %>/<%= itemTinMoi["PK_NewsID"].ToString() %>/<%= clsFunction.RemoveUnicode(itemTinMoi["C_Name"].ToString()) %>.aspx" class="products-block-image content_img clearfix">
                                            <img src="<%= clsConfig.GetHostUrl() %>/<%=itemTinMoi["C_Img"].ToString() %>"
                                                alt="<%=itemTinMoi["C_Name"].ToString() %>" /></a>
                                    </div>
                                    <div class="post-content has-sellers-img ">
                                        <a href="<%= clsConfig.GetHostUrl() %>/detail-news/<%= intTabId %>/<%= itemTinMoi["PK_NewsID"].ToString() %>/<%= clsFunction.RemoveUnicode(itemTinMoi["C_Name"].ToString()) %>.aspx"><%=itemTinMoi["C_Name"].ToString() %></a><span
                                            class="date"> <i class="fa fa-calendar-o"></i><%=DateTime.Parse(itemTinMoi["C_Create"].ToString()).ToString("dd/MM/yyyy")%></span>
                                    </div>
                                </div>
                            <%} %>
                        </div>
                        <%} %>
                        <!--End: Bài viết mới nhất-->
                    </div>
                    <!-- End sidebar blog -->
                </div>



                <%if (dtNews.Rows.Count > 0)
                  {%>
                <div class="col-md-9 col-sm-12 col-xs-12 " id="blog-container" data-sticky_column >
                    <div class="row">
                        <div class="articles clearfix" id="layout-page">
                            <div class="col-md-12  col-sm-12 col-xs-12">
                                <h1>
                                    Tin tức</h1>
                            </div>
                            <!-- Begin: Nội dung blog -->
                            <%foreach (DataRow itemTinMoi in dtNews.Rows)
                              {
                                  //string sssss = DateTime.Parse(itemTinMoi["C_Create"].ToString()).ToString("dd/MM/yyyy");
                                  %>
                            <div class="news-content">
                                <div class="col-md-5 col-xs-12 col-sm-12 img-article">
                                    <div class="art-img">
                                        <img src="<%= clsConfig.GetHostUrl() %>/<%=itemTinMoi["C_Img"].ToString() %>"
                                            alt="">
                                    </div>
                                </div>
                                <div class=" col-md-7 col-sm-12  col-xs-12">
                                    <!-- Begin: Nội dung bài viết -->
                                    <h2 class="title-article">
                                        <a href="<%= clsConfig.GetHostUrl() %>/detail-news/<%= intTabId %>/<%= itemTinMoi["PK_NewsID"].ToString() %>/<%= clsFunction.RemoveUnicode(itemTinMoi["C_Name"].ToString()) %>.aspx">
                                        <%=itemTinMoi["C_Name"].ToString() %></a></h2>
                                    <div class="body-content">
                                        <ul class="info-more">
                                            <li><i class="fa fa-calendar-o"></i>
                                                <time pubdate datetime=""><%=DateTime.Parse(itemTinMoi["C_Create"].ToString()).ToString("dd/MM/yyyy")%></time>
                                            </li>
                                            <li><i class="fa fa-file-text-o"></i><a href="#">Tin tức </a></li>
                                        </ul>
                                        <p>
                                            <%=clsInput.decodeStr(itemTinMoi["C_Des"].ToString())%>
                                            </p>
                                    </div>
                                    <!-- End: Nội dung bài viết -->
                                    <a class="readmore btn-rb clear-fix" href="<%= clsConfig.GetHostUrl() %>/detail-news/<%= intTabId %>/<%= itemTinMoi["PK_NewsID"].ToString() %>/<%= clsFunction.RemoveUnicode(itemTinMoi["C_Name"].ToString()) %>.aspx" role="button">
                                        Xem tiếp <span class="fa fa-angle-double-right"></span></a>
                                </div>
                            </div>
                            <%} %>
                            
                           
                            
                            <!-- End: Nội dung blog -->
                        </div>
                        <div class="col-md-12">
                            <!-- Begin: Phân trang blog -->
                            <div id="pagination" class="">
                            <%
                              string str = "";
                              //int Pagesize = 10;
                              //int intTotalPage = getPage(strTableName, intPagesize, strWhere);
                              if (intTotalPage <= 1)
                              {
                                  str = "";
                              }
                              else
                              {
                                  int intGetP = clsInput.getNumericInput("p", 0);
                                  //--------------------------------------------

                                  //str += "<a href='#'>Trang trước</a>";
                                  //--------------------------------------------    
                                  int intNowPage = intGetP;
                                  if (intNowPage == 0)
                                      intNowPage = 1;
                                  int intPerRecord = 100;
                                  int intPrePage = intNowPage - intPerRecord;
                                  if (intPrePage <= 0)
                                      intPrePage = 1;
                                  int intNexPage = intNowPage + intPerRecord;
                                  if (intNexPage > intTotalPage)
                                      intNexPage = intTotalPage;
                                  //===
                                  str = "<div class='col-lg-8 col-md-8 col-sm-6 col-xs-12 text-center'>";
                                  //===
                                  for (int iPage = intPrePage; iPage <= intNexPage; iPage++)
                                  //for (int iPage = intNexPage; iPage >=intPrePage; iPage--)
                                  {
                                      //Drd1.Items.Add(i.ToString());
                                      if (intCurPage == iPage)
                                          str = str + "<span class='page-node current'><a href='#'>" + iPage.ToString() + "</a></span>";
                                      else
                                      {
                                          
                                          //==================
                                          str = str + "<a class='page-node' href='" + clsConfig.GetHostUrl() + "/category-p_" + iPage.ToString() + "/" + intTabId + "/" + intCatID + "/" + clsFunction.RemoveUnicode(strCatName) + ".aspx" + "'>" + iPage.ToString() + "</a>";
                                      }
                                  }
                                  str += "</div>";
                                  //--------------------------------------------

                                  //str = str + "<a href='#'>Trang sau</a>";
                                  //--------------------------------------------
                              }

                              Response.Write(str);
                                %>
                            </div>
                            <!-- End: Phân trang blog -->
                        </div>
                    </div>
                </div>
                <%} %>

            </div>
        </div>
        <!-- End content -->
    </div>
</div>
