<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_search.ascx.cs" Inherits="modules_mod_search_mod_search" %>
<%@ Import Namespace="System.Data" %>
<%
    int intTabId = 4;
    int intCurPage = 0;
    int intStartRecord = 0;
    int intPageSize = 8;
    int intTotalPage = 0;
    int counter = 0;
    string key = clsInput.getStringInput("key", 0);
    if (key.Equals("-")) key = "";
    //-------------------------------		    		    
    intCurPage = clsPaging.getCurPage();
    intStartRecord = clsPaging.getStartRecord(intCurPage, intPageSize);
    //------------------------------ 		    
    
    
    DataTable dsSanPham = null;
    if (!String.IsNullOrEmpty(key))
    {
        string strSqlCount = "select count(*) from tbl_product  where FK_LangID = " + lang.getLangID() + "  and C_Active = 1 and C_Name like N'%" + key + "%'";
        DataTable dtCount = clsDatabase.getDataTable(strSqlCount);
        if (dtCount.Rows.Count > 0) counter = int.Parse(dtCount.Rows[0][0].ToString());
        intTotalPage = clsPaging.getTotalPage(strSqlCount, intPageSize);
        //
        dsSanPham = clsDatabase.getDataTable("Select * from tbl_product where FK_LangID = " + lang.getLangID() + " and C_Active = 1 and C_Name like N'%" + key + "%' order by C_Rank desc", intStartRecord, intPageSize);
    }
%>
<div class="col-md-12 col-xs-12 col-sm-12" id="layout-page">
    <span class="header-search header-page clearfix">
        <h1>
            Tìm kiếm</h1>
    </span>
    <div class="content-page" id="search">
        <div class="col-md-12  col-xs-12 col-sm-12">
            <span class="subtext">Kết quả tìm kiếm cho <strong>
                <%=key %></strong>.Tìm được <strong><%=counter %></strong> sản phẩm. </span>
                <br /><br />
        </div>
    </div>
    <div class="results content-page content-product-list product-list">
        <!-- Begin results -->
        <%if (dsSanPham != null && dsSanPham.Rows.Count > 0)
          {
              for (int i = 0; i < dsSanPham.Rows.Count; i++)
              {
                  int intTyLe = 0;
                  if (decimal.Parse(dsSanPham.Rows[i]["C_GiaCu"].ToString()) != 0)
                  {
                      decimal dcmTyLe = decimal.Parse(dsSanPham.Rows[i]["C_GiaMoi"].ToString()) / decimal.Parse(dsSanPham.Rows[i]["C_GiaCu"].ToString());
                      intTyLe = decimal.ToInt32(100 * (1 - dcmTyLe));
                  }
                  
        %>
        <div class="col-md-3 col-sm-6 col-xs-6 pro-loop">
            <div class="product-block product-resize">
                <div class="product-img image-resize view view-third">
                    <a href="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= dsSanPham.Rows[i]["PK_ProductID"].ToString() %>/act/0/<%= clsFunction.RemoveUnicode(dsSanPham.Rows[i]["C_Name"].ToString()) %>.aspx"
                        title="">
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
                            title="">
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
        <%}
          } %>
    </div>
    <!-- End results -->
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
                                          
                                          
                                          //==================
                                          str = str + "<a class='page-node' href='" + clsConfig.GetHostUrl() + "/search-p_" + iPage.ToString() + "/" + intTabId + "/" + "0" + "/" + clsFunction.RemoveUnicode("tim-kiem") + ".aspx?key=" +key + "'>" + iPage.ToString() + "</a>";
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
    <!-- /#search -->
    <style>
        div#search
        {
            float: left;
            width: 100%;
            outline: none;
        }
        .search-field
        {
            width: 100% !important;
        }
        input#go
        {
            width: 34px !important;
            height: 34px !important;
            float: right !important;
            background: url(//hstatic.net/0/0/global/design/theme-default/icon-search.png) #e63535 center no-repeat;
            margin: 0px !important;
            font-size: 0px;
            position: relative !important;
            top: 0px !important;
            border-radius: 0;
        }
        #search .search_box
        {
            width: calc(100% - 34px) !important;
            float: left;
            outline: none;
            padding: 0px 0px 0px 10px;
        }
    </style>
</div>
