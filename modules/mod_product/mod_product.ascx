<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_product.ascx.cs" Inherits="modules_mod_product_mod_product" %>
<%@ Import Namespace="System.Data" %>
<%
    int intTabId = 4;
    int intParentID = 0;
    if (lang.getLangID() == 2)
        intParentID = 20;
    else
        intParentID = 12;
    string strCatName = "";
    int intCatID = clsInput.getNumericInput("catid", 0);
    int intHot = clsInput.getNumericInput("hot", 0);
    string strListCategoryID = "0,";
    if (intCatID != 0)
    {
        DataTable dtListCategoryID = clsDatabase.getDataTable("Select PK_CategoryID from tbl_category_news where (PK_CategoryID=" + intCatID + " or PK_CategoryID in (Select PK_CategoryID from tbl_category_news where FK_ParentID=" + intCatID + ")) ");
        if (dtListCategoryID.Rows.Count > 0)
            foreach (DataRow itemCategoryID in dtListCategoryID.Rows)
            {
                strListCategoryID += itemCategoryID["PK_CategoryID"].ToString() + ",";
            }
        strListCategoryID += "0";
        DataTable dtCatName = clsDatabase.getDataTable("select C_Name from tbl_category_news where FK_LangID = " + lang.getLangID() + " and PK_CategoryID =" + intCatID);
        if (dtCatName.Rows.Count > 0)
        {
            strCatName = dtCatName.Rows[0]["C_Name"].ToString();
        }
    }

    string strSort = clsInput.getStringInput("sort_by", 0);
    //------------------------------	

    int intCurPage = 0;
    int intStartRecord = 0;
    int intPageSize = 12;
    //------------------------------ 
    string strSearchByCategoryID = "";
    if (intCatID != 0) strSearchByCategoryID = " and (tbl_product.FK_CategoryID in(" + strListCategoryID + ")) ";
    string strSearch = "";

    if (intHot == 1)
        strSearch += " and tbl_product.C_Hot=1 ";
    string strQuerySort = "";
    if (strSort == null) strQuerySort = " order by tbl_product.C_Name asc ";
    else
    {
        if (strSort.Equals("manual"))
        {
            strSearch += " and tbl_product.C_Hot=1 ";
            strQuerySort = " order by tbl_product.C_Rank desc ";
        }
        if (strSort.Equals("price-ascending")) strQuerySort = " order by tbl_product.C_GiaMoi asc ";
        if (strSort.Equals("price-descending")) strQuerySort = " order by tbl_product.C_GiaMoi desc ";
        if (strSort.Equals("title-ascending")) strQuerySort = " order by tbl_product.C_Name asc ";
        //title-ascending
        if (strSort.Equals("title-descending")) strQuerySort = " order by tbl_product.C_Name desc ";

        if (strSort.Equals("created-ascending")) strQuerySort = " order by tbl_product.PK_ProductID asc ";
        if (strSort.Equals("created-descending")) strQuerySort = " order by tbl_product.PK_ProductID desc ";

    }
    //==================
    string strAddQueryString = "";

    if (intHot == 1)
    {

        strAddQueryString = "&hot=1";

    }
    //==================
    //-------------------------------		    		    
    intCurPage = clsPaging.getCurPage();
    intStartRecord = clsPaging.getStartRecord(intCurPage, intPageSize);
    //------------------------------ 		    
    string strSqlCount = "select count(*) from tbl_product  where FK_LangID = " + lang.getLangID() + "  and tbl_product.C_Active = 1 " + strSearchByCategoryID + strSearch;
    DataTable dtCount = clsDatabase.getDataTable(strSqlCount);
    int counter = 0;
    if (dtCount.Rows.Count > 0) counter = int.Parse(dtCount.Rows[0][0].ToString());
    int intTotalPage = clsPaging.getTotalPage(strSqlCount, intPageSize);
    //string strParamPage = "page=" + Request.QueryString["page"] + "&mod=" + Request.QueryString["mod"] + "&key=" + strKey + "&catid=" + clsInput.getNumericInput("catid", 0);

    //========================================
    DataTable dsSanPham = clsDatabase.getDataTable("select tbl_product.* from tbl_product where FK_LangID = " + lang.getLangID() + "   and tbl_product.C_Active = 1 " + strSearchByCategoryID + strSearch + strQuerySort, intStartRecord, intPageSize);
    string sss = "";
    DataTable dsMenuProduct = clsDatabase.getDataTable("Select * from tbl_category_news where FK_ParentID=69 order by C_Rank desc");
%>
<div class="row">
    <div id="collection" class="content-pages collection-page" data-sticky_parent>
        <!-- Begin collection info -->
        <!-- Content-->
        <div class="col-lg-12 visible-sm visible-xs">
            <div class="visible-sm visible-xs">
                <h1 class="title-sm">
                    <%=strCatName%>(<%=counter %>
                    sp)
                </h1>
            </div>
            <div class="filter-by-wrapper">
                <div class="filter-by">
                    <div class="sort-filter-option navbar-inactive" id="navbar-inner">
                        <div class="filterBtn txtLeft btn-navbar-collection">
                            <span class="list-coll"><i class="fa fa-server" aria-hidden="true"></i>Danh mục
                            </span>
                        </div>
                    </div>
                    <div class="sort-filter-option js-promoteTooltip">
                        <div class="filterBtn txtLeft showOverlay">
                            <i class="fa fa-sort-alpha-asc" aria-hidden="true"></i><span class="custom-dropdown1 custom-dropdown--white1">
                                <select class="custom-dropdown__select1 custom-dropdown__select--white1" id="sortOption1">
                                    <option value="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/<%=intCatID %>/danh-sach-san-pham.aspx?sort_by=manual<%=strAddQueryString %>"
                                        <%if(strSort !=null && strSort.Equals("manual")) {%> selected="selected" <%} %>>
                                        Sản phẩm nổi bật</option>
                                    <option value="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/<%=intCatID %>/danh-sach-san-pham.aspx?sort_by=price-ascending<%=strAddQueryString %>"
                                        <%if(strSort !=null && strSort.Equals("price-ascending")) {%> selected="selected"
                                        <%} %>>Giá: Tăng dần</option>
                                    <option value="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/<%=intCatID %>/danh-sach-san-pham.aspx?sort_by=price-descending<%=strAddQueryString %>"
                                        <%if(strSort !=null && strSort.Equals("price-descending")) {%> selected="selected"
                                        <%} %>>Giá: Giảm dần</option>
                                    <option value="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/<%=intCatID %>/danh-sach-san-pham.aspx?sort_by=title-ascending<%=strAddQueryString %>"
                                        <%if(strSort ==null || strSort.Equals("title-ascending")) {%> selected="selected"
                                        <%} %>>Tên: A-Z</option>
                                    <option value="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/<%=intCatID %>/danh-sach-san-pham.aspx?sort_by=title-descending<%=strAddQueryString %>"
                                        <%if(strSort !=null && strSort.Equals("title-descending")) {%> selected="selected"
                                        <%} %>>Tên: Z-A</option>
                                    <option value="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/<%=intCatID %>/danh-sach-san-pham.aspx?sort_by=created-ascending<%=strAddQueryString %>"
                                        <%if(strSort !=null && strSort.Equals("created-ascending")) {%> selected="selected"
                                        <%} %>>Cũ nhất</option>
                                    <option value="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/<%=intCatID %>/danh-sach-san-pham.aspx?sort_by=created-descending<%=strAddQueryString %>"
                                        <%if(strSort !=null && strSort.Equals("created-descending")) {%> selected="selected"
                                        <%} %>>Mới nhất</option>
                                </select>
                            </span>
                            <%--<select class="custom-dropdown__select1" id="sortOption1">
                                               
                                                <option value="<%= clsConfig.GetHostUrl() %>/product/3/43/danh-sach-san-pham.aspx?sort_by=manual" <%if(strSort !=null && strSort.Equals("manual")) {%> selected="selected" <%} %> >Sản phẩm nổi bật</option>
                                                <option value="<%= clsConfig.GetHostUrl() %>/product/3/43/danh-sach-san-pham.aspx?sort_by=price-ascending" <%if(strSort !=null && strSort.Equals("price-ascending")) {%> selected="selected" <%} %> >Giá: Tăng dần</option>
                                                <option value="<%= clsConfig.GetHostUrl() %>/product/3/43/danh-sach-san-pham.aspx?sort_by=price-descending" <%if(strSort !=null && strSort.Equals("price-descending")) {%> selected="selected" <%} %> >Giá: Giảm dần</option>
                                                <option value="<%= clsConfig.GetHostUrl() %>/product/3/43/danh-sach-san-pham.aspx?sort_by=title-ascending" <%if(strSort ==null || strSort.Equals("title-ascending")) {%> selected="selected" <%} %> >Tên: A-Z</option>
                                                <option value="<%= clsConfig.GetHostUrl() %>/product/3/43/danh-sach-san-pham.aspx?sort_by=title-descending" <%if(strSort !=null && strSort.Equals("title-descending")) {%> selected="selected" <%} %> >Tên: Z-A</option>
                                                <option value="<%= clsConfig.GetHostUrl() %>/product/3/43/danh-sach-san-pham.aspx?sort_by=created-ascending" <%if(strSort !=null && strSort.Equals("created-ascending")) {%> selected="selected" <%} %> >Cũ nhất</option>
                                                <option value="<%= clsConfig.GetHostUrl() %>/product/3/43/danh-sach-san-pham.aspx?sort_by=created-descending" <%if(strSort !=null && strSort.Equals("created-descending")) {%> selected="selected" <%} %> >Mới nhất</option>
                                                
                                            </select>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class=" col-md-3 col-sm-12 col-xs-12 leftsidebar-col" data-sticky_column>
            <div class="group_sidebar">
                <div class="list-group navbar-inner ">
                    <div class="mega-left-title btn-navbar title-hidden-sm">
                        <h3 class="sb-title">
                            Danh mục
                        </h3>
                    </div>
                    <%if (dsMenuProduct.Rows.Count > 0)
                      {%>
                    <ul class="nav navs sidebar menu" id='cssmenu'>
                    <%foreach (DataRow itemMenuProduct in dsMenuProduct.Rows)
                      {
                          
                       %>
                       <li class="item  "><a href="<%= clsConfig.GetHostUrl() %>/<%=itemMenuProduct["C_Url"].ToString() %>">
                            <span><%=itemMenuProduct["C_Name"].ToString() %></span> </a></li>

                        <%--<li class="item  first"><a href="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/<%=intCatID %>/danh-sach-san-pham.aspx?sort_by=title-ascending">
                            <span>Sản phẩm khuyến mãi</span> </a></li>
                        <li class="item  "><a href="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/<%=intCatID %>/danh-sach-san-pham.aspx?sort_by=manual&hot=1">
                            <span>Sản phẩm nổi bật</span> </a></li>
                        <li class="item  last"><a href="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/0/danh-sach-san-pham.aspx?sort_by=title-ascending">
                            <span>Tất cả sản phẩm</span> </a></li>--%>

                            <%} %>
                    </ul>
                    <%} %>
                </div>
                <!-- Banner quảng cáo -->
                <div class="list-group_l banner-left hidden-sm hidden-xs">
                    <a href="#">
                        <img src="<%= clsConfig.GetHostUrl() %>/theme.hstatic.net/1000177652/1000229231/14/left_image_ad.jpg?v=90">
                    </a>
                </div>
            </div>
            <script>

                $(document).ready(function () {
                    //$('ul li:has(ul)').addClass('hassub');
                    $('#cssmenu ul ul li:odd').addClass('odd');
                    $('#cssmenu ul ul li:even').addClass('even');
                    $('#cssmenu > ul > li > a').click(function () {
                        $('#cssmenu li').removeClass('active');
                        $(this).closest('li').addClass('active');
                        var checkElement = $(this).nextS();
                        if ((checkElement.is('ul')) && (checkElement.is(':visible'))) {
                            $(this).closest('li').removeClass('active');
                            checkElement.slideUp('normal');
                        }
                        if ((checkElement.is('ul')) && (!checkElement.is(':visible'))) {
                            $('#cssmenu ul ul:visible').slideUp('normal');
                            checkElement.slideDown('normal');
                        }
                        if ($(this).closest('li').find('ul').children().length == 0) {
                            return true;
                        } else {
                            return false;
                        }
                    });

                    $('.drop-down').click(function (e) {
                        if ($(this).parents('li').hasClass('has-sub')) {
                            e.preventDefault();
                            if ($(this).hasClass('open-nav')) {
                                $(this).removeClass('open-nav');
                                $(this).parents('li').children('ul.lve2').slideUp('normal').removeClass('in');
                            } else {
                                $(this).addClass('open-nav');
                                $(this).parents('li').children('ul.lve2').slideDown('normal').addClass('in');
                            }
                        } else {

                        }
                    });

                });

                $("#list-group-l ul.navs li.active").parents('ul.children').addClass("in");
            </script>
        </div>
        <div class="content-col col-md-9 col-sm-12 col-xs-12" data-sticky_column>
            <div class="row">
                <div class="main-content">
                    <div class="col-md-12 hidden-sm hidden-xs">
                        <div class="sort-collection">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <h1>
                                        <%=strCatName%>(<%=counter %>
                                        sp)
                                    </h1>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <div class="browse-tags1">
                                        <span>Sắp xếp theo:</span> <span class="custom-dropdown1">
                                            <select class="custom-dropdown__select1" id="sortOption">
                                                <option value="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/<%=intCatID %>/danh-sach-san-pham.aspx?sort_by=manual<%=strAddQueryString %>"
                                                    <%if(strSort !=null && strSort.Equals("manual")) {%> selected="selected" <%} %>>
                                                    Sản phẩm nổi bật</option>
                                                <option value="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/<%=intCatID %>/danh-sach-san-pham.aspx?sort_by=price-ascending<%=strAddQueryString %>"
                                                    <%if(strSort !=null && strSort.Equals("price-ascending")) {%> selected="selected"
                                                    <%} %>>Giá: Tăng dần</option>
                                                <option value="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/<%=intCatID %>/danh-sach-san-pham.aspx?sort_by=price-descending<%=strAddQueryString %>"
                                                    <%if(strSort !=null && strSort.Equals("price-descending")) {%> selected="selected"
                                                    <%} %>>Giá: Giảm dần</option>
                                                <option value="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/<%=intCatID %>/danh-sach-san-pham.aspx?sort_by=title-ascending<%=strAddQueryString %>"
                                                    <%if(strSort ==null || strSort.Equals("title-ascending")) {%> selected="selected"
                                                    <%} %>>Tên: A-Z</option>
                                                <option value="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/<%=intCatID %>/danh-sach-san-pham.aspx?sort_by=title-descending<%=strAddQueryString %>"
                                                    <%if(strSort !=null && strSort.Equals("title-descending")) {%> selected="selected"
                                                    <%} %>>Tên: Z-A</option>
                                                <option value="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/<%=intCatID %>/danh-sach-san-pham.aspx?sort_by=created-ascending<%=strAddQueryString %>"
                                                    <%if(strSort !=null && strSort.Equals("created-ascending")) {%> selected="selected"
                                                    <%} %>>Cũ nhất</option>
                                                <option value="<%= clsConfig.GetHostUrl() %>/product/<%=intTabId %>/<%=intCatID %>/danh-sach-san-pham.aspx?sort_by=created-descending<%=strAddQueryString %>"
                                                    <%if(strSort !=null && strSort.Equals("created-descending")) {%> selected="selected"
                                                    <%} %>>Mới nhất</option>
                                            </select>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%if (dsSanPham.Rows.Count > 0)
                      { %>
                    <div class="col-md-12 col-sm-12 col-xs-12 content-product-list">
                        <div class="row product-list">
                            <%for (int i = 0; i < dsSanPham.Rows.Count; i++)
                              {
                                  int intTyLe = 0;
                                  if (decimal.Parse(dsSanPham.Rows[i]["C_GiaCu"].ToString()) != 0)
                                  {
                                      decimal dcmTyLe = decimal.Parse(dsSanPham.Rows[i]["C_GiaMoi"].ToString()) / decimal.Parse(dsSanPham.Rows[i]["C_GiaCu"].ToString());
                                      intTyLe = decimal.ToInt32(100 * (1 - dcmTyLe));
                                  }
                            %>
                            <div class="col-md-4  col-sm-6 col-xs-12 pro-loop">
                                <div class="product-block product-resize">
                                    <div class="product-img image-resize view view-third">
                                        <div class="product-sale">
                                            <span>
                                                <label class="sale-lb">
                                                    -
                                                </label>
                                                <%=intTyLe %>%</span>
                                        </div>
                                        <a href="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= dsSanPham.Rows[i]["PK_ProductID"].ToString() %>/act/0/<%= clsFunction.RemoveUnicode(dsSanPham.Rows[i]["C_Name"].ToString()) %>.aspx"
                                            title="<%= dsSanPham.Rows[i]["C_Name"].ToString().ToUpper() %>">
                                            <img class="first-image  has-img" alt="" src="<%= clsConfig.GetHostUrl() %>/<%= dsSanPham.Rows[i]["C_Img"].ToString() %>" />
                                            <img class="second-image" src="<%= clsConfig.GetHostUrl() %>/<%= dsSanPham.Rows[i]["C_Img2"].ToString() %>"
                                                alt="" />
                                        </a>
                                        <div class="actionss">
                                            <div class="btn-cart-products">
                                                <a href="<%= clsConfig.GetHostUrl() %>/cart/addcart/<%= dsSanPham.Rows[i]["PK_ProductID"].ToString() %>/<%= clsFunction.RemoveUnicode("cart") %>.aspx">
                                                    <i class="fa fa-shopping-bag" aria-hidden="true"></i></a>
                                            </div>
                                            <div class="view-details">
                                                <a href="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= dsSanPham.Rows[i]["PK_ProductID"].ToString() %>/act/0/<%= clsFunction.RemoveUnicode(dsSanPham.Rows[i]["C_Name"].ToString()) %>.aspx"
                                                    class="view-detail"><span><i class="fa fa-eye"></i></span></a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="product-detail clearfix">
                                        <!-- sử dụng pull-left -->
                                        <h3 class="pro-name">
                                            <a href="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= dsSanPham.Rows[i]["PK_ProductID"].ToString() %>/act/0/<%= clsFunction.RemoveUnicode(dsSanPham.Rows[i]["C_Name"].ToString()) %>.aspx"
                                                title="<%= dsSanPham.Rows[i]["C_Name"].ToString().ToUpper() %>">
                                                <%= dsSanPham.Rows[i]["C_Name"].ToString() %>
                                            </a>
                                        </h3>
                                        <div class="pro-prices">
                                            <p class="pro-price">
                                                <%=decimal.Parse(dsSanPham.Rows[i]["C_GiaMoi"].ToString()).ToString("#,##")%>₫</p>
                                            <p class="pro-price-del text-left">
                                                <del class="compare-price">
                                                    <%=decimal.Parse(dsSanPham.Rows[i]["C_GiaCu"].ToString()).ToString("#,##")%>₫
                                                </del>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%} %>
                        </div>
                    </div>
                    <div class="col-md-12 col-sm-12 col-xs-12 ">
                        <div class="clearfix">
                            <div id="pagination" class="">
                                <div class="col-lg-2 col-md-2 col-sm-3 hidden-xs">
                                </div>
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
                                          string aaaaaaa = "";
                                          if (strSort != null) aaaaaaa = "?sort_by=" + strSort;
                                          if (intHot == 1)
                                          {
                                              if (!aaaaaaa.Equals(""))
                                                  aaaaaaa += "&hot=1";
                                              else aaaaaaa = "?hot=1";
                                          }
                                          //==================
                                          str = str + "<a class='page-node' href='" + clsConfig.GetHostUrl() + "/product-p_" + iPage.ToString() + "/" + intTabId + "/" + intCatID + "/" + clsFunction.RemoveUnicode(strCatName) + ".aspx" + aaaaaaa + "'>" + iPage.ToString() + "</a>";
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
                        </div>
                    </div>
                    <%} %>
                </div>
            </div>
        </div>
        <!-- End collection info -->
        <!-- Begin no products -->
        <!-- End no products -->
    </div>
    <script>
        Haravan.queryParams = {};
        if (location.search.length) {
            for (var aKeyValue, i = 0, aCouples = location.search.substr(1).split('&'); i < aCouples.length; i++) {
                aKeyValue = aCouples[i].split('=');
                if (aKeyValue.length > 1) {
                    Haravan.queryParams[decodeURIComponent(aKeyValue[0])] = decodeURIComponent(aKeyValue[1]);
                }
            }
        }
        var collFilters = jQuery('.coll-filter');
        collFilters.change(function () {
            var newTags = [];
            var newURL = '';
            delete Haravan.queryParams.page;
            collFilters.each(function () {
                if (jQuery(this).val()) {
                    newTags.push(jQuery(this).val());
                }
            });

            newURL = '/collections/' + 'dong-ho-nam-longbo';
            if (newTags.length) {
                newURL += '/' + newTags.join('+');
            }
            var search = jQuery.param(Haravan.queryParams);
            if (search.length) {
                newURL += '?' + search;
            }
            location.href = newURL;

        });
        jQuery('.sort-by')
		.val('title-ascending')
		.bind('change', function () {
		    Haravan.queryParams.sort_by = jQuery(this).val();
		    //alert(jQuery.param(Haravan.queryParams));
		    location.search = jQuery.param(Haravan.queryParams);
		});



        $(document).ready(function () {
            $('#sortOption').change(function () {
                location.href = $(this).val();
            });
        });

        $(document).ready(function () {
            $('#sortOption1').change(function () {
                location.href = $(this).val();
            });
        });

    </script>
</div>
