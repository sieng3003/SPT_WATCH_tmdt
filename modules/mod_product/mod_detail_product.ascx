<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_detail_product.ascx.cs"
    Inherits="modules_mod_granite_mod_detail_granite" %>
<%@ Import Namespace="System.Data" %>
<%
    int intCatID = 3;
    int intTabId = 0;
    intTabId = clsInput.getNumericInput("catid", 0);
    DataTable dsSanPhamKhac = null;
    if (dsSanPham.Rows.Count > 0)
    {

        dsSanPhamKhac = clsDatabase.getDataTable("Select top 4 * from tbl_product where FK_CategoryID=" + dsSanPham.Rows[0]["FK_CategoryID"].ToString() + " and C_Active = 1  order by C_Rank desc");

    }
    DataTable dsMenuProduct = clsDatabase.getDataTable("Select * from tbl_category_news where FK_ParentID=69 order by C_Rank desc");                      
%>
<div class="row">
    <div id="product" class="content-pages" data-sticky_parent="">
        <div class="wrapper-sticky" style="display: block; height: 581px; width: 25%; margin: auto;
            position: relative; float: left; left: auto; right: auto; top: auto; bottom: auto;
            vertical-align: top;">
            <div class="col-md-3 col-sm-12 col-xs-12  leftsidebar-col" data-sticky_column=""
                style="width: 293px; bottom: auto; right: auto; position: absolute; top: 733px;
                left: 0px;">
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
        </div>
        <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12" data-sticky_column="">
            <div id="wrapper-detail" class="product-page">
                <div class="row">
                    <%if (dsSanPham.Rows.Count > 0)
                      {
                          int intTyLe = 0;
                          if (decimal.Parse(dsSanPham.Rows[0]["C_GiaCu"].ToString()) != 0)
                          {
                              decimal dcmTyLe = decimal.Parse(dsSanPham.Rows[0]["C_GiaMoi"].ToString()) / decimal.Parse(dsSanPham.Rows[0]["C_GiaCu"].ToString());
                              intTyLe = decimal.ToInt32(100 * (1 - dcmTyLe));
                          }
                          DataTable dsAnhSlideSP = clsDatabase.getDataTable("Select * from tbl_product_image where FK_ProductID=" + dsSanPham.Rows[0]["PK_ProductID"].ToString() + " and C_Active = 1  order by C_Rank desc");
                          string aaaaaa = "";
                    %>
                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                        <div id="surround">
                            <div class="product-sale">
                                <span>
                                    <label class="sale-lb">
                                        -</label>
                                    <%=intTyLe %>% </span>
                            </div>
                            <a class="slide-prev slide-nav" href="javascript:"><i class="fa fa-arrow-circle-o-left fa-2">
                            </i></a><a class="slide-next slide-nav" href="javascript:"><i class="fa fa-arrow-circle-o-right fa-2">
                            </i></a>
                            <img class="product-image-feature" src="<%= clsConfig.GetHostUrl() %>/<%= dsSanPham.Rows[0]["C_Img"].ToString() %>"
                                alt="<%= dsSanPham.Rows[0]["C_Name"].ToString().ToUpper() %>" />
                            <div id="sliderproduct" class="">
                                <ul class="slides">
                                    <li class="product-thumb active"><a href="javascript:" data-image="<%= clsConfig.GetHostUrl() %>/<%= dsSanPham.Rows[0]["C_Img"].ToString() %>"
                                        data-zoom-image="<%= clsConfig.GetHostUrl() %>/<%= dsSanPham.Rows[0]["C_Img"].ToString() %>"
                                        src="<%= clsConfig.GetHostUrl() %>/<%= dsSanPham.Rows[0]["C_Img"].ToString() %>"
                                        class="zoomGalleryActive">
                                        <img alt="<%= dsSanPham.Rows[0]["C_Name"].ToString().ToUpper() %>" data-image="<%= clsConfig.GetHostUrl() %>/<%= dsSanPham.Rows[0]["C_Img"].ToString() %>"
                                            src="<%= clsConfig.GetHostUrl() %>/<%= dsSanPham.Rows[0]["C_Img"].ToString() %>">
                                    </a></li>
                                    <li class="product-thumb active"><a href="javascript:" data-image="<%= clsConfig.GetHostUrl() %>/<%= dsSanPham.Rows[0]["C_Img2"].ToString() %>"
                                        data-zoom-image="<%= clsConfig.GetHostUrl() %>/<%= dsSanPham.Rows[0]["C_Img2"].ToString() %>"
                                        src="<%= clsConfig.GetHostUrl() %>/<%= dsSanPham.Rows[0]["C_Img2"].ToString() %>"
                                        class="zoomGalleryActive">
                                        <img alt="<%= dsSanPham.Rows[0]["C_Name"].ToString().ToUpper() %>" data-image="<%= clsConfig.GetHostUrl() %>/<%= dsSanPham.Rows[0]["C_Img2"].ToString() %>"
                                            src="<%= clsConfig.GetHostUrl() %>/<%= dsSanPham.Rows[0]["C_Img2"].ToString() %>">
                                    </a></li>
                                    <%if (dsAnhSlideSP.Rows.Count > 0)
                                          foreach (DataRow itemAnhSlideSP in dsAnhSlideSP.Rows)
                                          {
                                    %>
                                    <li class="product-thumb active"><a href="javascript:" data-image="<%= clsConfig.GetHostUrl() %>/<%= itemAnhSlideSP["C_Img"].ToString() %>"
                                        data-zoom-image="<%= clsConfig.GetHostUrl() %>/<%= itemAnhSlideSP["C_Img"].ToString() %>"
                                        src="<%= clsConfig.GetHostUrl() %>/<%= itemAnhSlideSP["C_Img"].ToString() %>"
                                        class="zoomGalleryActive">
                                        <img alt="<%= itemAnhSlideSP["C_Name"].ToString().ToUpper() %>" data-image="<%= clsConfig.GetHostUrl() %>/<%= itemAnhSlideSP["C_Img"].ToString() %>"
                                            src="<%= clsConfig.GetHostUrl() %>/<%= itemAnhSlideSP["C_Img"].ToString() %>">
                                    </a></li>
                                    <%}
                                    %>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                        <div class="product-title">
                            <h1>
                                <%= dsSanPham.Rows[0]["C_Name"].ToString() %></h1>
                            <span id="pro_sku"></span>
                        </div>
                        <div class="product-price" id="price-preview">
                            <span>
                                <%=decimal.Parse(dsSanPham.Rows[0]["C_GiaMoi"].ToString()).ToString("#,##")%>₫</span>
                            <del>
                                <%=decimal.Parse(dsSanPham.Rows[0]["C_GiaCu"].ToString()).ToString("#,##")%>₫</del>
                        </div>
                        <%--action="<%= clsConfig.GetHostUrl() %>/detail-product/2/345/Lan-can-ngoai-troi-tay-vin-Inox.aspx"--%>
                        <form id="add-item-form" action="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= dsSanPham.Rows[0]["PK_ProductID"].ToString() %>/addcart/0/<%= clsFunction.RemoveUnicode(dsSanPham.Rows[0]["C_Name"].ToString()) %>.aspx"
                        method="post" class="variants clearfix">
                        <div class="select clearfix" style="display: none">
                            <select id="product-select" name="id123" style="display: none">
                                <option value="1012006173">Default Title - 800,000₫</option>
                            </select>
                        </div>
                        <div class="select-wrapper ">
                            <label>
                                Số lượng</label>
                            <input id="quantity" name="quantity" min="1" value="1" class="tc item-quantity" type="number">
                        </div>
                        <div class="row">
                            <div class="col-lg-6 col-md-12 col-sm-6 col-xs-12">
                                <button id="add-to-cart1" class=" btn-detail btn-color-add btn-min-width btn-mgt addtocart-modal"
                                    name="add">
                                    Thêm vào giỏ
                                </button>
                            </div>
                            <div class="col-lg-6 col-md-12 col-sm-6 col-xs-12">
                                <button id="buy-now1" class=" btn-detail btn-color-buy btn-min-width btn-mgt">
                                    Mua ngay
                                </button>
                            </div>
                        </div>
                        </form>
                        <div class="pt20">
                            <!-- Begin tags -->
                            <div class="tag-wrapper" style="display: none">
                                <label>
                                    Tags:
                                </label>
                                <ul class="tags">
                                    <li class="active"><a href="/collections/all/phu-kien-nam">phụ kiện nam</a> </li>
                                    <li class="active"><a href="/collections/all/thoi-trang-nam">thời trang nam</a>
                                    </li>
                                    <li class="active"><a href="/collections/all/dong-ho-co">đồng hồ cơ</a> </li>
                                    <li class="active"><a href="/collections/all/dong-ho">đồng hồ</a> </li>
                                    <li class="active"><a href="/collections/all/tevise">tevise</a> </li>
                                </ul>
                            </div>
                            <!-- End tags -->
                        </div>
                        <div class="pt20">
                            <!-- Begin social icons -->
                            <div class="addthis_toolbox addthis_default_style ">
                                <div class="info-socials-article clearfix">
                                    <div class="box-like-socials-article">
                                        <div class="fb-send" data-href="/products/dong-ho-nam-tevise-1952-chay-co-cuc-chat">
                                        </div>
                                    </div>
                                    <div class="box-like-socials-article">
                                        <div class="fb-like" data-href="/products/dong-ho-nam-tevise-1952-chay-co-cuc-chat"
                                            data-layout="button_count" data-action="like">
                                        </div>
                                    </div>
                                    <div class="box-like-socials-article">
                                        <div class="fb-share-button" data-href="/products/dong-ho-nam-tevise-1952-chay-co-cuc-chat"
                                            data-layout="button_count">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- End social icons -->
                        </div>
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin-top: 20px;">
                        <div role="tabpanel" class="product-comment">
                            <!-- Nav tabs -->
                            <ul class="nav visible-lg visible-md" role="tablist">
                                <li role="presentation" class="active"><a data-spy="scroll" data-target="#mota" href="#mota"
                                    aria-controls="mota" role="tab">Mô tả sản phẩm</a></li>
                                <%--<li role="presentation"><a data-spy="scroll" href="#binhluan" aria-controls="binhluan"
                                    role="tab">Bình luận</a> </li>--%>
                                <li role="presentation"><a data-spy="scroll" href="#like" aria-controls="like" role="tab">
                                    Sản phẩm khác</a> </li>
                            </ul>
                            <!-- Tab panes -->
                            <div id="mota">
                                <div class="title-bl visible-xs visible-sm">
                                    <h2>
                                        Mô tả</h2>
                                </div>
                                <div class="product-description-wrapper">
                                    <%=clsInput.decodeStr(dsSanPham.Rows[0]["C_Des"].ToString())%>
                                </div>
                            </div>
                            <div id="binhluan">
                                <div class="title-bl" style="display: none">
                                    <h2>
                                        Bình luận</h2>
                                </div>
                                <div class="product-comment-fb">
                                    <div id="fb-root">
                                    </div>
                                    <div class="fb-comments" data-href="http://happylive.vn/products/dong-ho-nam-tevise-1952-chay-co-cuc-chat"
                                        data-numposts="5" width="100%" data-colorscheme="light">
                                    </div>
                                    <!-- script comment fb -->
                                    <script type="text/javascript">                                        (function (d, s, id) {
                                            var js, fjs = d.getElementsByTagName(s)[0];
                                            if (d.getElementById(id)) return;
                                            js = d.createElement(s); js.id = id;
                                            js.src = "./connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.0";
                                            fjs.parentNode.insertBefore(js, fjs);
                                        } (document, 'script', 'facebook-jssdk'));
								</script>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%} %>
                </div>
            </div>
            <%if (dsSanPhamKhac != null && dsSanPhamKhac.Rows.Count > 0)
              {
                  
            %>
            <div class="col-md-12 col-sm-12 col-xs-12  list-like">
                <div id="like">
                    <div class="title-like">
                        <h2>
                            Sản phẩm khác</h2>
                    </div>
                    <div class="row product-list ">
                        <div class="content-product-list">
                            <%foreach (DataRow itemSanPhamKhac in dsSanPhamKhac.Rows)
                              {
                                  int intTyLe = 0;
                                  if (decimal.Parse(dsSanPham.Rows[0]["C_GiaCu"].ToString()) != 0)
                                  {
                                      decimal dcmTyLe = decimal.Parse(dsSanPham.Rows[0]["C_GiaMoi"].ToString()) / decimal.Parse(dsSanPham.Rows[0]["C_GiaCu"].ToString());
                                      intTyLe = decimal.ToInt32(100 * (1 - dcmTyLe));
                                  }

                                  string aaaaaa = "";
                            %>
                            <div class="col-md-3 col-sm-6 col-xs-12 pro-loop">
                                <div class="product-block product-resize fixheight" style="height: 291px;">
                                    <div class="product-img image-resize view view-third" style="height: 188px;">
                                        <div class="product-sale">
                                            <span>
                                                <label class="sale-lb">
                                                    -
                                                </label>
                                                <%=intTyLe%>%</span>
                                        </div>
                                        <a href="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= itemSanPhamKhac["PK_ProductID"].ToString() %>/act/0/<%= clsFunction.RemoveUnicode(itemSanPhamKhac["C_Name"].ToString()) %>.aspx"
                                            title="<%=itemSanPhamKhac["C_Name"].ToString() %>">
                                            <img class="first-image  has-img" alt="<%=itemSanPhamKhac["C_Name"].ToString() %>"
                                                src="<%= clsConfig.GetHostUrl() %>/<%=itemSanPhamKhac["C_Img"].ToString() %>" />
                                            <img class="second-image" src="<%= clsConfig.GetHostUrl() %>/<%=itemSanPhamKhac["C_Img2"].ToString() %>"
                                                alt="<%=itemSanPhamKhac["C_Name"].ToString() %>" />
                                        </a>
                                        <div class="actionss">
                                            <div class="btn-cart-products">
                                                <a href="<%= clsConfig.GetHostUrl() %>/cart/addcart/<%= itemSanPhamKhac["PK_ProductID"].ToString() %>/<%= clsFunction.RemoveUnicode("cart") %>.aspx">
                                                    <i class="fa fa-shopping-bag" aria-hidden="true"></i></a>
                                            </div>
                                            <div class="view-details">
                                                <a href="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= itemSanPhamKhac["PK_ProductID"].ToString() %>/act/0/<%= clsFunction.RemoveUnicode(itemSanPhamKhac["C_Name"].ToString()) %>.aspx"
                                                    class="view-detail"><span><i class="fa fa-eye"></i></span></a>
                                            </div>
                                            <%--<div class="btn-quickview-products">
                                                <a href="javascript:void(0);" class="quickview" data-handle="/products/dong-ho-nam-skmei-kim-xanh-duong">
                                                    <i class="fa fa-eye"></i></a>
                                            </div>--%>
                                        </div>
                                    </div>
                                    <div class="product-detail clearfix">
                                        <!-- sử dụng pull-left -->
                                        <h3 class="pro-name">
                                            <a href="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= itemSanPhamKhac["PK_ProductID"].ToString() %>/act/0/<%= clsFunction.RemoveUnicode(itemSanPhamKhac["C_Name"].ToString()) %>.aspx"
                                                title="<%=itemSanPhamKhac["C_Name"].ToString() %>">
                                                <%=itemSanPhamKhac["C_Name"].ToString() %>
                                            </a>
                                        </h3>
                                        <div class="pro-prices">
                                            <p class="pro-price">
                                                <%=decimal.Parse(itemSanPhamKhac["C_GiaMoi"].ToString()).ToString("#,##")%>₫</p>
                                            <p class="pro-price-del text-left">
                                                <del class="compare-price">
                                                    <%=decimal.Parse(itemSanPhamKhac["C_GiaCu"].ToString()).ToString("#,##")%>₫</del></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%} %>
                        </div>
                    </div>
                    <script>
                        var add_to_wishlist = function () {
                            if (typeof (Storage) !== "undefined") {
                                if (localStorage.recently_viewed) {

                                    if (localStorage.recently_viewed.indexOf('1st-birthday-princess-basic-party-kit-18-guests') == -1)
                                        localStorage.recently_viewed = '1st-birthday-princess-basic-party-kit-18-guests_' + localStorage.recently_viewed;

                                } else
                                    localStorage.recently_viewed = '1st-birthday-princess-basic-party-kit-18-guests';
                            }
                            else {
                                console.log('Your Browser does not support storage!');
                            }
                        }
				</script>
                </div>
            </div>
            <%} %>
        </div>
    </div>
    <script>
        $(".product-thumb img").click(function () {
            $(".product-thumb").removeClass('active');
            $(this).parents('li').addClass('active');
            $(".product-image-feature").attr("src", $(this).attr("data-image"));
            $(".product-image-feature").attr("data-zoom-image", $(this).attr("data-zoom-image"));
        });

        $(".product-thumb").first().addClass('active');

</script>
    <script>
        $(document).ready(function () {
            $('#add-to-cart').click(function (e) {
                e.preventDefault();
                $(this).addClass('clicked_buy');
                add_item_show_modalCart($('#product-select').val());
            });
            $('#buy-now').click(function (e) {
                e.preventDefault();
                $.ajax({
                    type: 'POST',
                    async: false,
                    url: '/cart/add.js',
                    async: false,
                    data: $('form#add-item-form').serialize(),
                    success: function (line) {
                        window.location = "/checkout";
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert('Sản phẩm bạn vừa mua đã vượt quá tồn kho');
                    }
                });
            });
        });
</script>
    <script>
        $(document).ready(function () {
            $('a[data-spy=scroll]').click(function () {
                event.preventDefault();
                $('body').animate({ scrollTop: ($($(this).attr('href')).offset().top - 20) + 'px' }, 500);
            })
        });

        /**
        function deleteCart(variant_id){
        var params = {
        type: 'POST',
        url: '/cart/change.js',
        data: 'quantity=0&id=' + variant_id,
        dataType: 'json',
        success: function(cart) {
        if ((typeof callback) === 'function') {
        callback(cart);
        } else {

        getCartAjax();
        }
        },
        error: function(XMLHttpRequest, textStatus) {
        Haravan.onError(XMLHttpRequest, textStatus);
        }
        };
        jQuery.ajax(params);
        }
        **/
        // The following piece of code can be ignored.
        $(function () {
            $(window).resize(function () {
                $('#info').text("Page width: " + $(this).width());
            });
            $(window).trigger('resize');
        });


        var selectCallback = function (variant, selector) {
            if (variant && variant.available) {
                if (variant.featured_image != null) {
                    $(".product-thumb").removeClass('active');
                    $(".product-thumb img[data-image='" + Haravan.resizeImage(variant.featured_image.src, 'master') + "']").click().parents('li').addClass('active');
                }
                if (variant.sku != null) {
                    jQuery('#pro_sku').html('SKU: ' + variant.sku);
                }
                jQuery('#add-to-cart').removeAttr('disabled').removeClass('disabled').html("Thêm vào giỏ"); ;
                jQuery('#buy-now').removeAttr('disabled').removeClass('disabled').html("Mua ngay").show();

                if (variant.price < variant.compare_at_price) {
                    jQuery('#price-preview').html("<span>" + Haravan.formatMoney(variant.price, "{{amount}}₫") + "</span><del>" + Haravan.formatMoney(variant.compare_at_price, "{{amount}}₫") + "</del>");
                    var pro_sold = variant.price;
                    var pro_comp = variant.compare_at_price / 100;
                    var sale = 100 - (pro_sold / pro_comp);
                    var kq_sale = Math.round(sale);
                    jQuery('#surround .product-sale span').html("<label class='sale-lb'>- </label> " + kq_sale + '%');
                } else {
                    jQuery('#price-preview').html("<span>" + Haravan.formatMoney(variant.price, "{{amount}}₫" + "</span>"));
                }

            } else {
                jQuery('#add-to-cart').addClass('disabled').attr('disabled', 'disabled').html("Hết hàng");
                jQuery('#buy-now').addClass('disabled').attr('disabled', 'disabled').html("Hết hàng").hide();
                var message = variant ? "Hết hàng" : "Không có hàng";
                jQuery('#price-preview').html("<span>" + message + "</span>");
            }
        };

        jQuery(document).ready(function ($) {



        });
			</script>
    <script>
$(document).ready(function(){
	if($(".slides .product-thumb").length>4){
		$('#sliderproduct').flexslider({
			animation: "slide",
			controlNav: false,
			animationLoop: false,
			slideshow: false,
			itemWidth:95,
			itemMargin: 10,
		});
	}
	if($(window).width() > 960){
		jQuery(".product-image-feature").elevateZoom({
			gallery:'sliderproduct',
			scrollZoom : true
		});
	} else {

	}
	jQuery('.slide-next').click(function(){
		if($(".product-thumb.active").prev().length>0){
			$(".product-thumb.active").prev().find('img').click();
		}
		else{
			$(".product-thumb:last img").click();
		}
	});
	jQuery('.slide-prev').click(function(){
		if($(".product-thumb.active").next().length>0){
			$(".product-thumb.active").next().find('img').click();
		}
		else{
			$(".product-thumb:first img").click();
		}
	});
});
</script>
</div>
<!--Scroll to Top-->
<asp:Panel ID="Panel_MyCart" runat="server" Visible="false">
    <%
        decimal dcmTongTien = 0;
        if (cart != null && cart.Rows.Count > 0)
        {
            int tongSoSP = 0;
            string dsCartID = "";
            foreach (DataRow item in cart.Rows)
            {
                tongSoSP += int.Parse(item["C_SoLuong"].ToString());
                dsCartID += item["PK_ProductID"].ToString() + ",";
                //==============
                if (!item["C_Price"].ToString().Trim().Equals(""))
                {
                    dcmTongTien += decimal.Parse(item["C_Price"].ToString().Trim()) * decimal.Parse(item["C_SoLuong"].ToString());
                }
            }
            if (dsCartID.Length > 0)
            {
                dsCartID = dsCartID.Remove(dsCartID.Length - 1);
            }
    %>
    <div id="myCart" class="modal fade bs-example-modal-lg in" tabindex="-1" role="dialog"
        aria-labelledby="myLargeModalLabel" aria-hidden="false" style="display: block;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <a href="javascript:void(0));" onclick="closeCart()">
                        <h4 class="modal-title" id="exampleModalLabel">
                            Bạn có
                            <%=tongSoSP%>
                            sản phẩm trong giỏ hàng.</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span class="hrv-close-modal"></span>
                        </button>
                    </a>
                </div>
                <form action="<%= clsConfig.GetHostUrl() %>/checkout.aspx" method="post" id="cartform"
                style="display: block;">
                <div class="modal-body">
                    <table style="width: 100%;" id="cart-table">
                        <tbody>
                            <tr>
                                <th>
                                </th>
                                <th>
                                    Tên sản phẩm
                                </th>
                                <th>
                                    Số lượng
                                </th>
                                <th>
                                    Giá tiền
                                </th>
                                <th>
                                </th>
                            </tr>
                            <tr class="line-item original">
                                <td class="item-image">
                                </td>
                                <td class="item-title">
                                    <a></a>
                                </td>
                                <td class="item-quantity">
                                </td>
                                <td class="item-price">
                                </td>
                                <td class="item-delete text-center">
                                </td>
                            </tr>
                            <%foreach (DataRow itemCart in cart.Rows)
                              {%>
                            <tr class="line-item">
                                <td class="item-image">
                                    <img src="<%= clsConfig.GetHostUrl() %>/<%=itemCart["C_Img"].ToString() %>">
                                </td>
                                <td class="item-title">
                                    <a href="/products/dong-ho-nam-tevise-1952-chay-co-cuc-chat">
                                        <%=itemCart["C_Name"].ToString() %><br>
                                        <span></span></a>
                                </td>
                                <td class="item-quantity">
                                    <input id="quantity_<%=itemCart["PK_ProductID"].ToString() %>" name="quantity_<%=itemCart["PK_ProductID"].ToString() %>"
                                        min="1" type="number" value="<%=itemCart["C_SoLuong"].ToString() %>" class="" />
                                </td>
                                <td class="item-price">
                                    <%=!itemCart["C_Price"].ToString().Trim().Equals("") ? decimal.Parse(itemCart["C_Price"].ToString()).ToString("#,##") :""%>₫
                                </td>
                                <td class="item-delete text-center">
                                    <a href="javascript:void(0));" onclick="deletecart('<%=dsSanPham.Rows[0]["PK_ProductID"].ToString() %>','<%=itemCart["PK_ProductID"].ToString() %>')">
                                        <i class="fa fa-times"></i></a>
                                </td>
                            </tr>
                            <%} %>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="modal-note">
                                <textarea placeholder="Viết ghi chú" id="note" name="note" rows="5"></textarea>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="total-price-modal">
                                Tổng cộng : <span class="item-total">
                                    <%if (dcmTongTien > 0)
                                      {%>
                                    <%=decimal.Parse(dcmTongTien.ToString()).ToString("#,##")%>₫
                                    <%} %>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div class="col-lg-6">
                            <div class="comeback">
                                <a href="<%= clsConfig.GetHostUrl() %>"><i class="fa fa-caret-left mr10"></i>Tiếp tục
                                    mua hàng </a>
                            </div>
                        </div>
                        <div class="col-lg-6 text-right">
                            <div class="buttons btn-modal-cart">
                                <button type="submit" class="button-default" id="checkout" name="checkout" onclick="dathang()">
                                    Đặt hàng <i class="fa fa-caret-right"></i>
                                </button>
                            </div>
                            <div class="buttons btn-modal-cart">
                                <button type="submit" class="button-default" id="update-cart-modal" name="" onclick="updatecart('<%=dsSanPham.Rows[0]["PK_ProductID"].ToString() %>','<%=dsCartID %>')">
                                    <i class="fa fa-caret-left"></i>Cập nhật
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                </form>
            </div>
        </div>
    </div>
    <%} %>
</asp:Panel>
<script type="text/javascript">
    function updatecart(idSanPham, field) {

        var dsCartID = field.split(',');
        var key = '';
        for (i = 0; i < dsCartID.length; i++) {

            var soLuong = document.getElementById('quantity_' + dsCartID[i]).value;
            key += dsCartID[i] + ',' + soLuong + '_';


        }
        if (key.length > 0) key = key.substring(0, key.length - 1);

        location.href = '<%= clsConfig.GetHostUrl() %>/detail-product/2/' + idSanPham + '/editcart/' + key + '/<%= clsFunction.RemoveUnicode(dsSanPham.Rows[0]["C_Name"].ToString()) %>.aspx';
    }
    function deletecart(idSanPham, field) {
        location.href = '<%= clsConfig.GetHostUrl() %>/detail-product/2/' + idSanPham + '/deletecart/' + field + '/<%= clsFunction.RemoveUnicode(dsSanPham.Rows[0]["C_Name"].ToString()) %>.aspx';
    }
    function closeCart() {

        var x = document.getElementById('myCart');
        if (x.style.display === 'none') {
            x.style.display = 'block';
        } else {
            x.style.display = 'none';
        }
    }
    function dathang() {
        location.href = '<%= clsConfig.GetHostUrl() %>/checkout.aspx';
    }
</script>
