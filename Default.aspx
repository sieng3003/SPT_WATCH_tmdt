<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeFile="Default.aspx.cs"
    Inherits="_Default" %>

<%@ Import Namespace="System.Data" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    DataTable dtInfo = clsDatabase.getDataTable("select TOP 1 * from tbl_siteinfo where FK_LangID = " + lang.getLangID());
     %>
    <base href="<%= clsConfig.GetHostUrl() %>/oxywatch" />
    <link rel="shortcut icon" href="<%= clsConfig.GetHostUrl() %>/theme.hstatic.net/1000177652/1000229231/14/favicon.png?v=90"
        type="image/png" />
    <meta charset="utf-8" />
    <title><%=clsInput.decodeStr(dtInfo.Rows[0]["C_Title"].ToString())%> </title>
    <link rel="canonical" href="#" />
    <meta name="robots" content="index,follow" />
    <meta name="revisit-after" content="1 day" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="HandheldFriendly" content="true">
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=2.0, user-scalable=0'
        name='viewport' />
    <link rel="dns-prefetch" href="#">
    <link rel="dns-prefetch" href="<%= clsConfig.GetHostUrl() %>/hstatic.net">
    <script>
//<![CDATA[
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', './www.google-analytics.com/analytics.js', 'ga');
        ga('create', 'UA-97086989-1', 'auto');
        try {

        } catch (e) { };
        ga('send', 'pageview');

//]]>
    </script>
    <script>
//<![CDATA[
        !function (f, b, e, v, n, t, s) {
            if (f.fbq) return; n = f.fbq = function () {
                n.callMethod ?
n.callMethod.apply(n, arguments) : n.queue.push(arguments)
            }; if (!f._fbq) f._fbq = n;
            n.push = n; n.loaded = !0; n.version = '2.0'; n.queue = []; t = b.createElement(e); t.async = !0;
            t.src = v; s = b.getElementsByTagName(e)[0]; s.parentNode.insertBefore(t, s)
        } (window,
document, 'script', './connect.facebook.net/en_US/fbevents.js');
        // Insert Your Facebook Pixel ID below. 
        fbq('init', '905600829489553');
        fbq('track', 'PageView');
//]]>
    </script>
    <noscript>
        <img height='1' width='1' style='display: none' src='' /></noscript>
    <script type='text/javascript'>
//<![CDATA[
        if ((typeof Haravan) === 'undefined') {
            Haravan = {};
        }
        Haravan.culture = 'vi-VN';
        Haravan.shop = 'happylive.myharavan.com';
        Haravan.theme = { "name": "Theme mặc định", "id": 1000229231, "role": "main" };
        Haravan.domain = 'happylive.vn';
//]]>
    </script>
    <script>
//<![CDATA[
        (function () { function asyncLoad() { var urls = ["./hstatic.net/652/1000177652/20/2017/4-10/noname.js"]; for (var i = 0; i < urls.length; i++) { var s = document.createElement('script'); s.type = 'text/javascript'; s.async = true; s.src = urls[i]; var x = document.getElementsByTagName('script')[0]; x.parentNode.insertBefore(s, x); } } window.attachEvent ? window.attachEvent('onload', asyncLoad) : window.addEventListener('load', asyncLoad, false); })();
//]]>
    </script>
    <script src="<%= clsConfig.GetHostUrl() %>/hstatic.net/0/0/global/design/js/jquery.min.1.11.0.js"></script>

    <script src="<%= clsConfig.GetHostUrl() %>/hstatic.net/0/0/global/design/js/bootstrap.min.js"></script>
   

    <script src='<%= clsConfig.GetHostUrl() %>/hstatic.net/0/0/global/option_selection.js'
        type='text/javascript'></script>
    <script src='<%= clsConfig.GetHostUrl() %>/hstatic.net/0/0/global/api.jquery.js'
        type='text/javascript'></script>
    <script>
        var formatMoney = '{{amount}}₫';
    </script>
    <script src='<%= clsConfig.GetHostUrl() %>/theme.hstatic.net/1000177652/1000229231/14/default_script.min.js?v=90'
        type='text/javascript'></script>
    <link href='<%= clsConfig.GetHostUrl() %>/theme.hstatic.net/1000177652/1000229231/14/default_style.min.css?v=90'
        rel='stylesheet' type='text/css' media='all' />
    <!--[if lt IE 9]>
<script src="./hstatic.net/0/0/global/design/theme-default/html5shiv.js"></script>
<![endif]-->
    <script src="<%= clsConfig.GetHostUrl() %>/hstatic.net/0/0/global/design/theme-default/jquery-migrate-1.2.0.min.js"></script>
    <script src='<%= clsConfig.GetHostUrl() %>/hstatic.net/0/0/global/design/theme-default/jquery.touchSwipe.min.js'
        type='text/javascript'></script>
    <script data-target=".product-resize" data-parent=".products-resize" data-img-box=".image-resize"
        src="<%= clsConfig.GetHostUrl() %>/hstatic.net/0/0/global/design/js/fixheightproductv2.js"></script>
    <script src="<%= clsConfig.GetHostUrl() %>/hstatic.net/0/0/global/design/js/haravan.plugin.1.0.js"></script>
    <script src='<%= clsConfig.GetHostUrl() %>/hstatic.net/0/0/global/design/theme-default/jquery.flexslider.js'
        type='text/javascript'></script>
    <link href='<%= clsConfig.GetHostUrl() %>/hstatic.net/0/0/global/design/theme-default/flexslider.css'
        rel='stylesheet' type='text/css' media='all' />
    <script src='<%= clsConfig.GetHostUrl() %>/theme.hstatic.net/1000177652/1000229231/14/scripts.js?v=90'
        type='text/javascript'></script>
    <link rel="stylesheet" type="text/css" href="<%= clsConfig.GetHostUrl() %>/hstatic.net/0/0/global/design/member/fonts-master/roboto.css">
    <meta property="og:type" content="website" />
    <meta property="og:title" content="OxyWatch" />
    <meta property="og:image" content="http://theme.hstatic.net/1000177652/1000229231/14/share_fb_home.png?v=90" />
    <meta property="og:image" content="https://theme.hstatic.net/1000177652/1000229231/14/share_fb_home.png?v=90" />
    <meta property="og:url" content="#" />
    <meta property="og:site_name" content="Happylive" />
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="<%= clsConfig.GetHostUrl() %>/hstatic.net/0/0/global/design/css/bootstrap.3.3.1.css">
    
    <!-- Latest compiled and minified JavaScript -->
    <link href='<%= clsConfig.GetHostUrl() %>/hstatic.net/0/0/global/design/plugins/font-awesome/4.6.3/css/font-awesome.min.css'
        rel='stylesheet' type='text/css' media='all' />
    <link href='<%= clsConfig.GetHostUrl() %>/theme.hstatic.net/1000177652/1000229231/14/styles.css?v=90'
        rel='stylesheet' type='text/css' media='all' />
</head>
<body>
<form runat="server">
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
    
%>

    <nav id="menu-mobile" class="hidden" style="z-index:5000">
    <%if(dsMenu.Rows.Count>0 ){%>
	<ul>
			<%
        foreach (DataRow itemMenu in dsMenu.Rows)
                      {
                          DataTable dsSubMenu = clsDatabase.getDataTable("select * from tbl_category_news where FK_LangID = " + lang.getLangID() + " and C_MenuNgang=1 and FK_ParentID=" + itemMenu["PK_CategoryID"].ToString() + " and C_Active = 1  order by C_Rank desc");
                          string strStyle = "";
                          if (itemMenu["PK_CategoryID"].ToString().Equals(intTabId.ToString())) strStyle = " current";  
           %>
			<li class="has-children">
				<a class="<%=strStyle %>"  href="<%= clsConfig.GetHostUrl() %>/<%=itemMenu["C_Url"].ToString() %>"><%=itemMenu["C_Name"].ToString() %></a>



                    <%if (dsSubMenu.Rows.Count > 0)
                      {%>
					    <ul class="child count-nav-6">
                        <%
                          foreach (DataRow itemSubMenu in dsSubMenu.Rows)
                          {
                         %>
						    <li><a href="<%= clsConfig.GetHostUrl() %>/<%=itemSubMenu["C_Url"].ToString() %>"><%=itemSubMenu["C_Name"].ToString() %></a></li>
						    <%} %>
					    </ul>
                    <%} %>

			</li>
			<%} %>




	</ul>
    <%} %>
</nav>
    <div id="page">
        <div id="quick-view-modal" class="wrapper-quickview" style="display: none;">
            <div class="quickviewOverlay">
            </div>
            <div class="jsQuickview">
                <div class="modal-header clearfix" style="width: 100%">
                    <a href="/products/dong-ho-nam-skmei-kim-xanh-duong" class="quickview-title text-left"
                        title="ĐỒNG HỒ NAM SKMEI KIM XANH DƯƠNG">
                        <h4 class="p-title modal-title">
                            ĐỒNG HỒ NAM SKMEI KIM XANH DƯƠNG</h4>
                    </a>
                    <div class="quickview-close">
                        <a href="javascript:void(0);"><i class="fa fa-times"></i></a>
                    </div>
                </div>
                <div class="col-md-5">
                    <div class="quickview-image image-zoom">
                        <img class="p-product-image-feature" src="./product.hstatic.net/1000177652/product/1_e0ed7c0240734782a8268793dce0b9b8_large.jpg"
                            alt="ĐỒNG HỒ NAM SKMEI KIM XANH DƯƠNG">
                    </div>
                    <div id="quickview-sliderproduct">
                        <div class="quickview-slider">
                            <ul class="owl-carousel owl-theme" style="display: block; opacity: 1;">
                                <div class="owl-wrapper-outer">
                                    <div class="owl-wrapper" style="width: 600px; left: 0px; display: block;">
                                        <div class="owl-item" style="width: 100px;">
                                            <li class="product-thumb active"><a href="javascript:void(0);" data-image="./product.hstatic.net/1000177652/product/1_e0ed7c0240734782a8268793dce0b9b8_large.jpg">
                                                <img src="./product.hstatic.net/1000177652/product/1_e0ed7c0240734782a8268793dce0b9b8_small.jpg"></a></li></div>
                                        <div class="owl-item" style="width: 100px;">
                                            <li class="product-thumb"><a href="javascript:void(0);" data-image="./product.hstatic.net/1000177652/product/2_85fc5908867e488da92b768cb240477d_large.jpg">
                                                <img src="./product.hstatic.net/1000177652/product/2_85fc5908867e488da92b768cb240477d_small.jpg"></a></li></div>
                                        <div class="owl-item" style="width: 100px;">
                                            <li class="product-thumb"><a href="javascript:void(0);" data-image="./product.hstatic.net/1000177652/product/3_30be00d496bb474aa0e9324311dd02f0_large.jpg">
                                                <img src="./product.hstatic.net/1000177652/product/3_30be00d496bb474aa0e9324311dd02f0_small.jpg"></a></li></div>
                                    </div>
                                </div>
                                <div class="owl-controls clickable" style="display: none;">
                                    <div class="owl-pagination">
                                        <div class="owl-page active">
                                            <span class=""></span>
                                        </div>
                                    </div>
                                    <div class="owl-buttons">
                                        <div class="owl-prev">
                                            owl-prev</div>
                                        <div class="owl-next">
                                            owl-next</div>
                                    </div>
                                </div>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-md-7">
                    <form id="form-quickview" method="post" action="/cart/add">
                    <div class="quickview-information">
                        <div class="form-input">
                            <div class="quickview-price product-price">
                                <span>499,000₫</span><del>700,000₫</del>
                            </div>
                        </div>
                        <div class="quickview-variants variant-style clearfix">
                            <select name="id" class="" id="quickview-select" style="display: none;">
                                <option value="1012030836">Default Title - 49900000</option>
                            </select>
                        </div>
                        <div class="quickview-description">
                        </div>
                        <div class="form-input ">
                            <label>
                                Số lượng</label>
                            <input id="quantity-quickview" name="quantity" type="number" min="1" value="1">
                        </div>
                        <div class="form-input" style="width: 100%">
                            <button type="submit" class="btn-detail  btn-color-add btn-min-width btn-mgt btn-addcart"
                                style="display: block;">
                                Thêm vào giỏ</button>
                            <button disabled="" class="btn-detail addtocart btn-color-add btn-min-width btn-mgt btn-soldout"
                                style="display: none;">
                                Hết hàng</button>
                            <div class="qv-readmore">
                                <span>hoặc </span><a class="read-more p-url" href="" role="button">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
        </div>
        <%--QUICK VIEW JS--%>
        <section id="page_content" class="">
				<div id="pageContainer" class="clearfix">
					
					<asp:PlaceHolder ID="inc_header" runat="server"></asp:PlaceHolder>
                    <br />
					<asp:PlaceHolder ID="inc_submenu" runat="server"></asp:PlaceHolder>

<!-- Begin slider -->
<asp:PlaceHolder ID="inc_intro" runat="server"></asp:PlaceHolder>
<!-- End slider -->


<script>
jQuery(document).ready(function(){
	if ( $('.slides li').size() > 0 ) {
		$(".hrv-banner-container .slides").owlCarousel({
			singleItem: true,
			autoPlay : 5000,
			items : 1,
			itemsDesktop : [1199,1],
			itemsDesktopSmall : [980,1],
			itemsTablet: [768,1],
			itemsMobile : [479,1],
			slideSpeed : 500,
			paginationSpeed : 500,
			rewindSpeed : 500,
			addClassActive: true,
			navigation : true,
			stopOnHover : true,
			pagination : false,
			scrollPerPage:true,
			afterMove: nextslide,
			afterInit: nextslide,
		});
		function nextslide() {
			$(".hrv-banner-container .owl-item .hrv-banner-caption").css('display','none');
			$(".hrv-banner-container .owl-item .hrv-banner-caption").removeClass('hrv-caption')
			$(".hrv-banner-container .owl-item.active .hrv-banner-caption").css('display','block');

			var heading = $('.hrv-banner-container .owl-item.active .hrv-banner-caption').clone().removeClass();
			$('.hrv-banner-container .owl-item.active .hrv-banner-caption').remove();
			$('.hrv-banner-container .owl-item.active>li').append(heading);
			$('.hrv-banner-container .owl-item.active>li>div').addClass('hrv-banner-caption hrv-caption');
		}

	}
})

</script>

					

						
					</div>
					<section id="content" class="clearfix container">
						<asp:PlaceHolder ID="inc_content" runat="server"></asp:PlaceHolder>
					</section>

					<footer id="footer">
	                    <asp:PlaceHolder ID="inc_footer" runat="server"></asp:PlaceHolder>
                    </footer>

					<a href="#" class="scrollToTop show">
						<i class="fa fa-chevron-up"></i>
					</a>

					<!--Scroll to Top-->

					


					<svg xmlns="http://www.w3.org/2000/svg" class="hidden">	
	<symbol id="icon-add-cart">
		<svg xmlns="http://www.w3.org/2000/svg"   xmlns:xlink="http://www.w3.org/1999/xlink"  x="0px" y="0px"
				 viewBox="0 0 512 512" enable-background="new 0 0 512 512">
			<g >
				<g>
					<polygon points="447.992,336 181.555,336 69.539,80 0.008,80 0.008,48 90.477,48 202.492,304 447.992,304 		"/>
				</g>
				<path d="M287.992,416c0,26.5-21.5,48-48,48s-48-21.5-48-48s21.5-48,48-48S287.992,389.5,287.992,416z"/>
				<path d="M447.992,416c0,26.5-21.5,48-48,48s-48-21.5-48-48s21.5-48,48-48S447.992,389.5,447.992,416z"/>
				<g>
					<polygon points="499.18,144 511.992,112 160.008,112 172.805,144 		"/>
					<polygon points="211.195,240 223.992,272 447.992,272 460.805,240 		"/>
					<polygon points="486.398,176 185.602,176 198.398,208 473.586,208 		"/>
				</g>
			</g>
		</svg>
	</symbol>
	<symbol id="icon-list-switch">
		<svg  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
				 viewBox="0 0 194.828 194.828" style="enable-background:new 0 0 194.828 194.828;" xml:space="preserve">
			<g>
				<g>
					<g>
						<path d="M190.931,17.534H3.897C1.745,17.534,0,19.279,0,21.431v19.483c0,2.152,1.745,3.897,3.897,3.897h187.034
										 c2.152,0,3.897-1.745,3.897-3.897V21.431C194.828,19.279,193.083,17.534,190.931,17.534z M187.034,37.017H7.793v-11.69h179.241
										 V37.017z"/>
						<path d="M190.931,64.293H3.897C1.745,64.293,0,66.038,0,68.19v31.172c0,2.152,1.745,3.897,3.897,3.897h187.034
										 c2.152,0,3.897-1.745,3.897-3.897V68.19C194.828,66.038,193.083,64.293,190.931,64.293z M187.034,95.466H7.793v-23.38h179.241
										 V95.466z"/>
						<path d="M190.931,122.741H3.897c-2.152,0-3.897,1.745-3.897,3.897v46.759c0,2.152,1.745,3.897,3.897,3.897h187.034
										 c2.152,0,3.897-1.745,3.897-3.897v-46.759C194.828,124.486,193.083,122.741,190.931,122.741z M187.034,169.5H7.793v-38.966
										 h179.241V169.5z"/>
					</g>
				</g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
		</svg>

	</symbol>
	<symbol id="icon-sort-by">
		<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
				 viewBox="0 0 490 490" style="enable-background:new 0 0 490 490;" xml:space="preserve">
			<g>
				<polygon points="85.877,154.014 85.877,428.309 131.706,428.309 131.706,154.014 180.497,221.213 217.584,194.27 108.792,44.46 
												 0,194.27 37.087,221.213 	"/>
				<polygon points="404.13,335.988 404.13,61.691 358.301,61.691 358.301,335.99 309.503,268.787 272.416,295.73 381.216,445.54 
												 490,295.715 452.913,268.802 	"/>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
			<g>
			</g>
		</svg>
	</symbol>
	<symbol id="icon-search_white" viewBox="0 0 1024 1024">
		<path class="path1" d="M1014.176 968.256l-264.32-260.128c69.184-75.264 111.68-174.688 111.68-284.128 0-234.080-192.8-423.872-430.688-423.872s-430.72 189.792-430.72 423.872c0 234.112 192.864 423.872 430.72 423.872 102.752 0 197.088-35.552 271.072-94.688l265.376 261.12c12.928 12.736 33.952 12.736 46.88 0 12.96-12.672 12.96-33.376 0-46.048zM430.848 782.688c-201.312 0-364.48-160.64-364.48-358.688 0-198.080 163.168-358.656 364.48-358.656 201.28 0 364.448 160.576 364.448 358.656 0.032 198.048-163.168 358.688-364.448 358.688z"></path>
	</symbol>
	<symbol id="icon-user" viewBox="0 0 1024 1024">
		<title>user</title>
		<path class="path1" d="M622.826 702.736c-22.11-3.518-22.614-64.314-22.614-64.314s64.968-64.316 79.128-150.802c38.090 0 61.618-91.946 23.522-124.296 1.59-34.054 48.96-267.324-190.862-267.324s-192.45 233.27-190.864 267.324c-38.094 32.35-14.57 124.296 23.522 124.296 14.158 86.486 79.128 150.802 79.128 150.802s-0.504 60.796-22.614 64.314c-71.22 11.332-337.172 128.634-337.172 257.264h896c0-128.63-265.952-245.932-337.174-257.264z"></path>
	</symbol>
</svg>
    </div>

    </form>
    
</body>
</html>
