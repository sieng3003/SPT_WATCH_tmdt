<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_home.ascx.cs" Inherits="modules_mod_home_mod_home" %>
<%@ Import Namespace="System.Data" %>
<%
    int intTabId = 0;
    intTabId = clsInput.getNumericInput("catid", 0);

    DataTable dsSanPhamNoiBat = clsDatabase.getDataTable("select TOP 8 * from tbl_product where FK_LangID = " + lang.getLangID() + " and C_Img!='' and C_Hot=1 and C_Active = 1  order by C_Rank desc");
    DataTable dsSanPhamMoi = clsDatabase.getDataTable("select TOP 8 * from tbl_product where FK_LangID = " + lang.getLangID() + " and C_Img!='' and C_Hot!=1 and C_Active = 1  order by C_Rank desc");
    DataTable dsBannerCenter = clsDatabase.getDataTable("select * from tbl_banner where FK_LangID = " + lang.getLangID() + " and C_Active = 1 and FK_CategoryID=2 order by C_Rank desc");
    DataTable dsBannerFooter = clsDatabase.getDataTable("select * from tbl_banner where FK_LangID = " + lang.getLangID() + " and C_Active = 1 and FK_CategoryID=1 order by C_Rank desc");
    string urlBannerCenter = "";
    if (dsBannerCenter.Rows.Count > 0) urlBannerCenter = dsBannerCenter.Rows[0]["C_Img"].ToString();
%>
<script>
    /* QUICK VIEW JS */
    jQuery(document).ready(function () {
        var callBack = function (variant, selector) {
            if (variant) {
                item = $('.wrapper-quickview');
                if (variant != null && variant.featured_image != null) {
                    item.find(".product-thumb a[data-image='" + Haravan.resizeImage(variant.featured_image.src, 'large') + "']").click();
                }
                item.find('.quickview-price').find('span').html(Haravan.formatMoney(variant.price, "{{amount}}₫"));

                if (variant.compare_at_price > variant.price)
                    item.find('.quickview-price').find('del').html(Haravan.formatMoney(variant.compare_at_price, "{{amount}}₫"));
                else
                    item.find('.quickview-price').find('del').html('');
                if (variant.available) {
                    item.find('.btn-addcart').css('display', 'block');
                    item.find('.btn-soldout').css('display', 'none');
                }
                else {
                    item.find('.btn-addcart').css('display', 'none');
                    item.find('.btn-soldout').css('display', 'block');
                }
            }
            else {
                item.find('.btn-addcart').css('display', 'none');
                item.find('.btn-soldout').css('display', 'block');
            }
        }
        var quickview_html_variants = $('.quickview-variants').html();
        var quickview_image_zoom = $('.quickview-image').html();
        var quickViewProduct = function (purl) {
            if ($(window).width() < 680) {
                window.location = purl;
                return false;
            }
            item = $('.wrapper-quickview');
            $.ajax({
                url: purl + '.js',
                async: false,
                success: function (product) {
                    $.each(product.options, function (i, v) {
                        product.options[i] = v.name;
                    })
                    item.find('.quickview-title').attr('title', product.title).attr('href', product.url).find('h4').html(product.title);
                    item.find('.quickview-variants').html(quickview_html_variants);
                    $('.quickview-image').html(quickview_image_zoom);
                    $.each(product.variants, function (i, v) {
                        item.find('#quickview-select').append("<option value='" + v.id + "'>" + v.title + ' - ' + v.price + "</option>");
                    })
                    if (product.variants.length == 1 && product.variants[0].title.indexOf('Default') != -1)
                        $('#quickview-select').hide();
                    else
                        $('#quickview-select').show();
                    if (product.variants.length == 1 && product.variants[0].title.indexOf('Default') != -1) {
                        callBack(product.variants[0], null);
                    }
                    else {
                        new Haravan.OptionSelectors("quickview-select", { product: product, onVariantSelected: callBack });
                        if (product.options.length == 1 && product.options[0].indexOf('Tiêu đề') == -1)
                            item.find('.selector-wrapper:eq(0)').prepend('<label>' + product.options[0] + '</label>');
                        $('.p-option-wrapper select:not(#p-select)').each(function () {
                            $(this).wrap('<span class="custom-dropdown custom-dropdown--white"></span>');
                            $(this).addClass("custom-dropdown__select custom-dropdown__select--white");
                        });
                        callBack(product.variants[0], null);
                    }
                    if (product.images.length == 0) {
                        item.find('.quickview-image').find('img').attr('alt', product.title).attr('src', './hstatic.net/0/0/global/design/theme-default/no-image.png');
                    }
                    else {
                        $('.quickview-slider').remove();
                        $('#quickview-sliderproduct').append("<div class='quickview-slider' class='flexslider'>");
                        $('.quickview-slider').append("<ul class='owl-carousel'>");
                        $.each(product.images, function (i, v) {
                            elem = $('<li class="product-thumb">').append('<a href="javascript:void(0);" data-image=""><img /></a>');
                            elem.find('a').attr('data-image', Haravan.resizeImage(v, 'large'));
                            elem.find('img').attr('src', Haravan.resizeImage(v, 'small'));
                            item.find('.owl-carousel').append(elem);
                        });
                        item.find('.quickview-image img').attr('alt', product.title).attr('src', Haravan.resizeImage(product.featured_image, 'large'));

                        $('.quickview-slider img').imagesLoaded(function () {
                            var owl = $('.owl-carousel');
                            owl.owlCarousel({
                                items: 3,
                                navigation: true,
                                navigationText: ['owl-prev', 'owl-next']
                            });
                            $('.quickview-slider .owl-carousel .owl-item').first().children('.product-thumb').addClass('active');
                        });

                    }

                }
            });
            return false;
        }
        //final width --> this is the quick view image slider width
        //maxQuickWidth --> this is the max-width of the quick-view panel
        var sliderFinalWidth = 500,
			maxQuickWidth = 900;

        //open the quick view panel
        jQuery(document).on("click", ".quickview", function (event) {
            alert(123);
            var selectedImage = $(this).parents('.product-block').find('.product-img img'),
				slectedImageUrl = selectedImage.attr('src');
            quickViewProduct($(this).attr('data-handle'));

            animateQuickView(selectedImage, sliderFinalWidth, maxQuickWidth, 'open');

            //update the visible slider image in the quick view panel
            //you don't need to implement/use the updateQuickView if retrieving the quick view data with ajax

        });

        $('.wrapper-quickview').on('click', '.product-thumb a', function () {
            item = $('.wrapper-quickview');
            item.find('.quickview-image img').attr('src', $(this).attr('data-image'));
            item.find('.product-thumb').removeClass('active');
            $(this).parents('li').addClass('active');
            return false;
        });
        //close the quick view panel

        $(document).on('click', '.quickview-close, .quickviewOverlay', function (e) {
            $(".wrapper-quickview").fadeOut(500);

            $('.jsQuickview').fadeOut(500);
        });


        //center quick-view on window resize
        $(window).on('resize', function () {
            if ($('.wrapper-quickview').hasClass('is-visible')) {
                window.requestAnimationFrame(resizeQuickView);
            }
        });

        function animateQuickView(image, finalWidth, maxQuickWidth, animationType) {

            $('.wrapper-quickview').fadeIn(500);
            $('.jsQuickview').fadeIn(500);
        }

        $(document).on("click", ".btn-addcart", function (event) {
            event.preventDefault();
            variant_id_quickview = $('#quickview-select').val();
            quantity_quickview = $('#quantity-quickview').val();
            var params = {
                type: 'POST',
                url: '/cart/add.js',
                async: true,
                data: 'quantity=' + quantity_quickview + '&id=' + variant_id_quickview,
                dataType: 'json',
                success: function (line_item) {
                    window.location = '/cart';
                },
                error: function (XMLHttpRequest, textStatus) {
                    alert('Sản phẩm bạn vừa mua đã vượt quá tồn kho');
                }
            };
            jQuery.ajax(params);
        });


    });
</script>
<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <!-- Content-->
        <div class="main-content">
            <!-- Sản phẩm trang chủ -->
            <div class="product-list clearfix">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <aside class="styled_header  use_icon ">
						<h2>What hot</h2>
											
						<h3>Sản phẩm bán chạy</h3>
						<span class="icon"><img src="./theme.hstatic.net/1000177652/1000229231/14/icon_featured.png?v=90" alt=""></span>
						
					</aside>
                    </div>
                </div>
                <%if (dsSanPhamNoiBat.Rows.Count > 0)
                  {%>
                <!--Product loop-->
                <div class="row content-product-list products-resize">
                    <%foreach (DataRow item in dsSanPhamNoiBat.Rows)
                      {
                          int intTyLe = 0;
                          if (decimal.Parse(item["C_GiaCu"].ToString()) != 0)
                          {
                              decimal dcmTyLe = decimal.Parse(item["C_GiaMoi"].ToString()) / decimal.Parse(item["C_GiaCu"].ToString());
                              intTyLe = decimal.ToInt32(100 * (1 - dcmTyLe));
                          }
                    %>
                    <div class="col-md-3 col-sm-6 col-xs-6 pro-loop">
                        <div class="product-block product-resize">
                            <div class="product-img image-resize view view-third">
                                <div class="product-sale">
                                    <span>
                                        <label class="sale-lb">
                                            -
                                        </label>
                                        <%=intTyLe%>%</span>
                                </div>
                                <a href="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= item["PK_ProductID"].ToString() %>/act/0/<%= clsFunction.RemoveUnicode(item["C_Name"].ToString()) %>.aspx"
                                    title="<%= item["C_Name"].ToString().ToUpper() %>">
                                    <img class="first-image  has-img" alt="" src="<%= clsConfig.GetHostUrl() %>/<%= item["C_Img"].ToString() %>" />
                                    <img class="second-image" src="<%= clsConfig.GetHostUrl() %>/<%= item["C_Img2"].ToString() %>"
                                        alt="" />
                                </a>
                                <div class="actionss">
                                    <div class="btn-cart-products">
                                        <a href="<%= clsConfig.GetHostUrl() %>/cart/addcart/<%= item["PK_ProductID"].ToString() %>/<%= clsFunction.RemoveUnicode("cart") %>.aspx">
                                            <i class="fa fa-shopping-bag" aria-hidden="true"></i></a>
                                    </div>
                                    <div class="view-details">
                                        <a href="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= item["PK_ProductID"].ToString() %>/act/0/<%= clsFunction.RemoveUnicode(item["C_Name"].ToString()) %>.aspx"
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
                                    <a href="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= item["PK_ProductID"].ToString() %>/act/0/<%= clsFunction.RemoveUnicode(item["C_Name"].ToString()) %>.aspx"
                                        title="<%= item["C_Name"].ToString().ToUpper() %>">
                                        <%= item["C_Name"].ToString()%>
                                    </a>
                                </h3>
                                <div class="pro-prices">
                                    <p class="pro-price">
                                        <%=decimal.Parse(item["C_GiaMoi"].ToString()).ToString("#,##")%>₫</p>
                                    <p class="pro-price-del text-left">
                                        <del class="compare-price">
                                            <%=decimal.Parse(item["C_GiaCu"].ToString()).ToString("#,##")%>₫</del></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%} %>
                </div>
                <%} %>
                <div class="row">
                    <div class="col-lg-12 col-sm-12 col-xs-12  pull-center center">
                        <a class="btn btn-readmore" href="<%= clsConfig.GetHostUrl() %>/product/3/0/<%= clsFunction.RemoveUnicode("danh sach san pham") %>.aspx?hot=1"
                            role="button">Xem thêm</a>
                    </div>
                </div>
            </div>
            <!--Product loop-->
            <%if (dsBannerCenter.Rows.Count > 0)
              {%>
            <div class="row">
                <div class="col-lg-12 col-sm-12 col-xs-12">
                    <div class="animation
            fade-in home-banner-1" style="background-image: url('<%=urlBannerCenter %>')">
                        <aside class="banner-home-1"> <div class="divcontent">
            <span class="ad_banner_1">
                <%= clsInput.decodeStr( dsBannerCenter.Rows[0]["C_Des"].ToString())%>
            </span> 
            <span class="ad_banner_desc" ><%=dsBannerCenter.Rows[0]["C_Name"].ToString()%></span> 
            </div> 
            <div class="divstyle"
            style="border-color:;"></div> </aside>
                    </div>
                </div>
            </div>
            <%} %>
            <div class="product-list clearfix ">
                <div class="row">
                    <div class="col-lg-12 col-sm-12 col-xs-12">
                        <aside class="styled_header  use_icon ">
						
											
						<h3>Sản phẩm mới</h3>
						<span class="icon"><img src="./theme.hstatic.net/1000177652/1000229231/14/icon_sale.png?v=90" alt="Newest trends"></span>
						
					</aside>
                    </div>
                </div>
                <%if (dsSanPhamMoi.Rows.Count > 0)
                  {%>
                <div class="row content-product-list products-resize">
                    <%foreach (DataRow itemSPMoi in dsSanPhamMoi.Rows)
                      {
                          int intTyLe = 0;
                          if (decimal.Parse(itemSPMoi["C_GiaCu"].ToString()) != 0)
                          {
                              decimal dcmTyLe = decimal.Parse(itemSPMoi["C_GiaMoi"].ToString()) / decimal.Parse(itemSPMoi["C_GiaCu"].ToString());
                              intTyLe = decimal.ToInt32(100 * (1 - dcmTyLe));
                          }
                    %>
                    <div class="col-md-3 col-sm-6 col-xs-6 pro-loop">
                        <div class="product-block product-resize">
                            <div class="product-img image-resize view view-third">
                                <div class="product-sale">
                                    <span>
                                        <label class="sale-lb">
                                            -
                                        </label>
                                        <%=intTyLe%>%</span>
                                </div>
                                <a href="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= itemSPMoi["PK_ProductID"].ToString() %>/act/0/<%= clsFunction.RemoveUnicode(itemSPMoi["C_Name"].ToString()) %>.aspx"
                                    title="<%= itemSPMoi["C_Name"].ToString().ToUpper() %>">
                                    <img class="first-image  has-img" alt="" src="<%= clsConfig.GetHostUrl() %>/<%= itemSPMoi["C_Img"].ToString() %>" />
                                    <img class="second-image" src="<%= clsConfig.GetHostUrl() %>/<%= itemSPMoi["C_Img2"].ToString() %>"
                                        alt="" />
                                </a>
                                <div class="actionss">
                                    <div class="btn-cart-products">
                                        <a href="<%= clsConfig.GetHostUrl() %>/cart/addcart/<%= itemSPMoi["PK_ProductID"].ToString() %>/<%= clsFunction.RemoveUnicode("cart") %>.aspx">
                                            <i class="fa fa-shopping-bag" aria-hidden="true"></i></a>
                                    </div>
                                    <div class="view-details">
                                        <a href="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= itemSPMoi["PK_ProductID"].ToString() %>/act/0/<%= clsFunction.RemoveUnicode(itemSPMoi["C_Name"].ToString()) %>.aspx"
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
                                    <a href="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= itemSPMoi["PK_ProductID"].ToString() %>/act/0/<%= clsFunction.RemoveUnicode(itemSPMoi["C_Name"].ToString()) %>.aspx"
                                        title="<%= itemSPMoi["C_Name"].ToString().ToUpper() %>">
                                        <%= itemSPMoi["C_Name"].ToString()%>
                                    </a>
                                </h3>
                                <div class="pro-prices">
                                    <p class="pro-price">
                                        <%=decimal.Parse(itemSPMoi["C_GiaMoi"].ToString()).ToString("#,##")%>₫</p>
                                    <p class="pro-price-del text-left">
                                        <del class="compare-price">
                                            <%=decimal.Parse(itemSPMoi["C_GiaCu"].ToString()).ToString("#,##")%>₫</del></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%} %>
                </div>
                <%} %>
                <div class="row">
                    <div class="col-lg-12 pull-center center ">
                        <a class="btn btn-readmore" href="<%= clsConfig.GetHostUrl() %>/product/3/0/<%= clsFunction.RemoveUnicode("danh-sach-san-pham") %>.aspx"
                            role="button">Xem thêm</a>
                    </div>
                </div>
            </div>


            <%if (dsBannerFooter.Rows.Count > 0)
              {%>
            <div class="banner-bottom">
                <div class="row">
                    

                    <%foreach (DataRow itemBannerFooter in dsBannerFooter.Rows)
                      {
                          
                       %>
                    <div class="col-xs-12 col-sm-6 home-category-item-2">
                        <div class="block-home-category">
                            <a href="<%= clsConfig.GetHostUrl() %>/<%=itemBannerFooter["C_Url"].ToString() %>">
                                <img class="b-lazy b-loaded" src="<%= clsConfig.GetHostUrl() %>/<%=itemBannerFooter["C_Img"].ToString() %>"
                                    alt="" />
                            </a>
                        </div>
                    </div>
                    <%} %>




                </div>
            </div>
            <%} %>




        </div>
        <!-- end Content-->
    </div>
</div>
