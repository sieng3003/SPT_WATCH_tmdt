<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_header.ascx.cs" Inherits="modules_mod_top_mod_header" %>
<%@ Import Namespace="System.Data" %>
<%
    int intTabId = 0;
    intTabId = clsInput.getNumericInput("tabid", 0);
    DataTable cart = null;
    if (Session["cart"] != null) cart = Session["cart"] as DataTable;
    int tongSoSP = 0;

    if (cart != null && cart.Rows.Count > 0)
    {
        foreach (DataRow item in cart.Rows)
        {
            tongSoSP += int.Parse(item["C_SoLuong"].ToString());

        }
    }
    DataTable dsMenu = clsDatabase.getDataTable("select * from tbl_category_news where FK_LangID = " + lang.getLangID() + " and C_MenuNgang=1 and FK_ParentID=0 and C_Active = 1  order by C_Rank desc");
    string sssss = "";

    DataTable dtInfo = clsDatabase.getDataTable("select * from tbl_siteinfo where FK_LangID = " + lang.getLangID());
    string strCustomerLogin = "0";
    if (this.Session["customerlogin"] != null) strCustomerLogin = "1";                 
		
%>
<header class="header bkg visible-lg">
	<div class="container clearfix">
		<div class="row">
			<div class="col-lg-5 col-md-5 col-sm-12 col-xs-12 logo">
				<div class="row">
					<div class="col-lg-12 col-md-12 col-sm-7 col-xs-7">
						<!-- LOGO -->
						<h1>
							<a href="<%= clsConfig.GetHostUrl() %>">
								<img src="<%= clsConfig.GetHostUrl() %>/<%=dtInfo.Rows[0]["C_Logo"].ToString() %>" alt="" class="img-responsive logoimg"/>
							</a>
						</h1>
						<h1 style="display:none">
							<a href="/"><%=clsInput.decodeStr(dtInfo.Rows[0]["C_Title"].ToString())%></a>
						</h1>
					</div>
					<div class="hidden-lg hidden-md col-sm-5 col-xs-5 mobile-icons" >
						<div>
							<a href="<%= clsConfig.GetHostUrl() %>/cart/0/1/<%= clsFunction.RemoveUnicode("cart") %>.aspx" title="Xem giỏ hàng" class="mobile-cart"><span><%=tongSoSP %></span></a>
							<a href="#" id="mobile-toggle"><i class="fa fa-bars"></i></a>
						</div>
					</div>
				</div>
			</div>	
			<div class="col-lg-7 hidden-md hidden-sm hidden-xs">
				<aside class="top-info">
					<div class="cart-info hidden-xs">
	<a class="cart-link" href="<%= clsConfig.GetHostUrl() %>/cart/0/1/<%= clsFunction.RemoveUnicode("cart") %>.aspx">			
		<span class="icon-cart">																
		</span>
		<div class="cart-number">
			<%=tongSoSP %>
		</div>
	</a>
	<div class="cart-view clearfix" style="display: none;">
		<table id="clone-item-cart" class="table-clone-cart">
			<tr class="item_2 hidden">
				<td class="img"><a href="" title=""><img src="" alt="" /></a></td>
				<td>
					<a class="pro-title-view" href="" title=""></a>
					<span class="variant"></span>	
					<span class="pro-quantity-view"></span>
					<span class="pro-price-view"></span>
					<span class="remove_link remove-cart">					
					</span>				
				</td>
			</tr>   
		</table>
		<table id="cart-view">
			
			
			<%
                decimal dcmTongTien = 0;
                if (cart != null && cart.Rows.Count > 0)
                {
                    foreach (DataRow itemCart in cart.Rows)
                    {

                        if (!itemCart["C_Price"].ToString().Trim().Equals(""))
                        {
                            dcmTongTien += decimal.Parse(itemCart["C_Price"].ToString().Trim()) * decimal.Parse(itemCart["C_SoLuong"].ToString());
                        }
             %>
        <tr>
				<td class="img">
					<a href="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= itemCart["PK_ProductID"].ToString() %>/act/0/<%= clsFunction.RemoveUnicode(itemCart["C_Name"].ToString()) %>.aspx">
						<img src="<%= clsConfig.GetHostUrl() %>/<%=itemCart["C_Img"].ToString() %>" alt="<%=itemCart["C_Name"].ToString() %>" />
					</a>
				</td>
				<td>
					<a class="pro-title-view" href="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= itemCart["PK_ProductID"].ToString() %>/act/0/<%= clsFunction.RemoveUnicode(itemCart["C_Name"].ToString()) %>.aspx" title="<%=itemCart["C_Name"].ToString() %>"><%=itemCart["C_Name"].ToString()%></a>
					<span class="variant">
					</span>	
					<span class="pro-quantity-view"><%=itemCart["C_SoLuong"].ToString()%></span>
					<span class="pro-price-view"><%=!itemCart["C_Price"].ToString().Trim().Equals("") ? decimal.Parse(itemCart["C_Price"].ToString()).ToString("#,##") :""%>₫</span>
					<%--<span class="remove_link remove-cart">
						<a href='javascript:void(0);' onclick='deleteCart(1012030836)' ><i class='fa fa-times'></i></a>
					</span>	--%>			
				</td>
			</tr>
     <%}
                }
                else
                {%>
			
			<tr>
				<td class="img">
					Hiện chưa có sản phẩm
				</td>
				
			</tr>
			
			<%} %>
		</table>
		<span class="line"></span>
		<table class="table-total">
			<tr>
				<td class="text-left">TỔNG TIỀN:</td>
				<td class="text-right" id="total-view-cart">
                <%if (dcmTongTien > 0)
                  {%> <%=decimal.Parse(dcmTongTien.ToString()).ToString("#,##")%>₫ <%} %></td>
			</tr>
			<tr>
				<td><a href="<%= clsConfig.GetHostUrl() %>/cart/0/1/<%= clsFunction.RemoveUnicode("cart") %>.aspx" class="linktocart">Xem giỏ hàng</a></td>
				<td><a href="<%= clsConfig.GetHostUrl() %>/checkout.aspx" class="linktocheckout">Thanh toán</a></td>
			</tr>
		</table>
	</div>
	
</div>

					<div class="navholder">
						<nav id="subnav">
							<ul>
								<li>
									<a href="#"><i class="fa fa-phone" aria-hidden="true"></i> <%=dtInfo.Rows[0]["DienThoai"].ToString()%></a>
								</li>
                                <%if (!strCustomerLogin.Equals("1"))
                                  {%>
								<li><a class="reg" href="<%= clsConfig.GetHostUrl() %>/register/add/1/dang-ky.aspx" title="Đăng ký">ĐĂNG KÝ</a></li>
								<li><a class="log" href="<%= clsConfig.GetHostUrl() %>/login/add/1/login.aspx" title="Đăng nhập">Đăng nhập</a></li>
                                <%}
                                  else
                                  { %>
                                 <li><a class="reg" href="<%= clsConfig.GetHostUrl() %>/register/edit/<%=this.Session["PK_CustomerID"].ToString() %>/dang-ky.aspx" title="Thông tin tài khoản"><%=this.Session["C_CustomerName"]%></a></li>
								 <li><a class="log" href="<%= clsConfig.GetHostUrl() %>/login/logout/1/login.aspx" title="Đăng xuất">Đăng xuất</a></li>
                                  <%} %>
							</ul>
						</nav>
						<div class="header_line"><p><%--Miễn phí vận chuyển<span class="mar-l5"> ĐƠN HÀNG TRÊN 500K TP HÀ NỘI</span>--%></p></div>
					</div>
				</aside>
			</div>	
		</div>
	</div>
</header>
<nav class="navbar-main navbar navbar-default cl-pri">
	<!-- MENU MAIN -->
<div class="container nav-wrapper check_nav">
	<div class="row">
		<div class="navbar-header">	
			<div class="mobile-menu-icon-wrapper">
				<div class="menu-logo">
					
					<h1 class="logo logo-mobile">
						<a href="<%= clsConfig.GetHostUrl() %>">
							<img src="<%= clsConfig.GetHostUrl() %>/<%=dtInfo.Rows[0]["C_Logo"].ToString()%>" alt="SPTWatch" class="img-responsive logoimg"/>
						</a>
					</h1>	
					
					<div class="nav-login">
                    <%if (!strCustomerLogin.Equals("1"))
                      {%>
					<a href="<%= clsConfig.GetHostUrl() %>/login/add/1/login.aspx" class="cart " title="Tài khoản">
						<svg class="icon icon-user" viewBox="0 0 32 32">
							<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-user">
							</use>
						</svg>
					</a>
                    <%}
                      else
                      { %>
                      <a href="<%= clsConfig.GetHostUrl() %>/register/edit/<%=this.Session["PK_CustomerID"].ToString() %>/dang-ky.aspx" class="cart " title="Tài khoản">
						<svg class="icon icon-user" viewBox="0 0 32 32">
							<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#icon-user">
							</use>
						</svg>
					</a>
                      <%} %>
				</div>
					<div class="menu-btn click-menu-mobile "><a href="#menu-mobile" class="navbar-toggle">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span></a>
					</div>

					<div id="cart-targets" class="cart">
						<a href="<%= clsConfig.GetHostUrl() %>/cart/0/1/<%= clsFunction.RemoveUnicode("cart") %>.aspx" class="cart " title="Giỏ hàng">
							<span >		

								<svg class="shopping-cart">
									<use xmlns:xlink="./www.w3.org/1999/xlink" xlink:href="#icon-add-cart" />
								</svg>														
							</span>		
							<span id="cart-count" class="cart-number"><%=tongSoSP %></span>
						</a>
					</div>
				</div>
				<div class="search-bar-top">
					<div class="search-input-top">
						<%--<form  action="/search">--%>
							<input type="hidden" name="type" value="product" />
							<input type="text" id="txtSearch2" name="txtSearch2" placeholder="Tìm kiếm sản phẩm ..." />
							<button type="button" class="icon-search" onclick="search2()">
								<svg class="icon-search_white">
									<use xmlns:xlink="./www.w3.org/1999/xlink" xlink:href="#icon-search_white" />
								</svg>	
							</button>
						<%--</form>--%>
					</div>
				</div>
			</div>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav clearfix">
				
                <%if (dsMenu.Rows.Count > 0)
                      foreach (DataRow itemMenu in dsMenu.Rows)
                      {
                          DataTable dsSubMenu = clsDatabase.getDataTable("select * from tbl_category_news where FK_LangID = " + lang.getLangID() + " and C_MenuNgang=1 and FK_ParentID=" + itemMenu["PK_CategoryID"].ToString() + " and C_Active = 1  order by C_Rank desc");
                          //===================
                          string strStyle = "";
                          if (itemMenu["PK_CategoryID"].ToString().Equals(intTabId.ToString())) strStyle = " active ";
                          //===================
                          %>
				<li class="<%=strStyle %>">
					<a href="<%= clsConfig.GetHostUrl() %>/<%=itemMenu["C_Url"].ToString() %>" title="<%=itemMenu["C_Name"].ToString() %>">
						<span><%=itemMenu["C_Name"].ToString().ToUpper() %></span>
					</a>
                    <%if (dsSubMenu.Rows.Count > 0)
                      {%>
					<ul class="dropdown-menu" role="menu">
						<%
                          foreach (DataRow itemSubMenu in dsSubMenu.Rows)
                          {
                         %>
						<li>
							<a class="" href="<%= clsConfig.GetHostUrl() %>/<%=itemSubMenu["C_Url"].ToString() %>" title="<%=itemSubMenu["C_Name"].ToString() %>"><%=itemSubMenu["C_Name"].ToString()%></a>
							
						</li>
						<%} %>
						
						
					</ul>
                    <%} %>







				</li>
				<%
                      }%>
				
			</ul>
		</div>
		<div  class="hidden-xs pull-right right-menu">
			<ul class="nav navbar-nav pull-right">
				<li class="col-md-12">

					<div class="search-bar123">

						<div class="">
							<form  action="">
								<input type="hidden" name="type" value="product" />
								<input type="text" id="txtSearch1" name="txtSearch1" placeholder="Tìm kiếm..."  autocomplete="off" "/>
                                <img src="<%= clsConfig.GetHostUrl() %>/images/search_logo.JPG" style="margin-bottom:1px" onclick="search1()"/>
							</form>
                            

						</div>
					</div>
				</li>

			</ul>
		</div><!--/.nav-collapse -->
	</div>
</div><!-- End container  -->
<script>
    function search1() {
        var key = document.getElementById("txtSearch1").value;
        if (!key) {
            key = "-";
        }
        location.href = '<%= clsConfig.GetHostUrl() %>/search/0/'+key+'/tim-kiem.aspx';
    }
    function search2() {
        var key = document.getElementById("txtSearch2").value;
        if (!key) {
            key = "-";
        }
        location.href = '<%= clsConfig.GetHostUrl() %>/search/0/' + key + '/tim-kiem.aspx';
    }
    $(window).resize(function () {
        $('li.dropdown li.active').parents('.dropdown').addClass('active');
        if ($('.right-menu').width() + $('#navbar').width() > $('.check_nav.nav-wrapper').width() - 40) {
            $('.nav-wrapper').addClass('responsive-menu');
        }
        else {
            $('.nav-wrapper').removeClass('responsive-menu');
        }
    })

    $(document).on("click", ".mobile-menu-icon .dropdown-menu ,.drop-control .dropdown-menu, .drop-control .input-dropdown", function (e) {
        e.stopPropagation();
    });
</script>
<script>
    $(function () {
        $('nav#menu-mobile').mmenu();
    });
    $(document).ready(function () {
        flagg = true;
        if (flagg) {
            $('.click-menu-mobile a').click(function () {
                $('#menu-mobile').removeClass('hidden');
                flagg = false;
            })
        }
    })



</script>
</nav>
