<%@ Page Language="C#" AutoEventWireup="true" CodeFile="hoantatdonhang.aspx.cs" Inherits="hoantatdonhang" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    DataTable dtInfo = clsDatabase.getDataTable("select TOP 1 * from tbl_siteinfo where FK_LangID = " + lang.getLangID());
     %>
    <link rel="shortcut icon" href="//theme.hstatic.net/1000177652/1000229231/14/favicon.png?v=90"
        type="image/png" />
    <title><%=clsInput.decodeStr(dtInfo.Rows[0]["C_Title"].ToString())%></title>
    <meta charset="utf-8" />
    <meta name="description" content="" />
    <link href='//hstatic.net/0/0/global/checkouts.css?v=1.1' rel='stylesheet' type='text/css'
        media='all' />
    <link href='//theme.hstatic.net/1000177652/1000229231/14/check_out.css?v=90' rel='stylesheet'
        type='text/css' media='all' />
    <script src='//hstatic.net/0/0/global/jquery.min.js' type='text/javascript'></script>
    <script src='//hstatic.net/0/0/global/jquery.validate.js' type='text/javascript'></script>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=2, user-scalable=no">
    <script type="text/javascript">
        var toggleShowOrderSummary = false;
        $(document).ready(function () {
            var currentUrl = '';



            if ($('#reloadValue').val().length == 0) {
                $('#reloadValue').val(currentUrl);
                $('body').show();
            }
            else {
                window.location = $('#reloadValue').val();
                $('#reloadValue').val('');
            }

            $('body')
							.on('click', '.order-summary-toggle', function () {
							    toggleShowOrderSummary = !toggleShowOrderSummary;

							    if (toggleShowOrderSummary) {
							        $('.order-summary-toggle')
										.removeClass('order-summary-toggle-hide')
										.addClass('order-summary-toggle-show');

							        $('.sidebar:not(".sidebar-second") .sidebar-content .order-summary')
										.removeClass('order-summary-is-collapsed')
										.addClass('order-summary-is-expanded');

							        $('.sidebar.sidebar-second .sidebar-content .order-summary')
										.removeClass('order-summary-is-expanded')
										.addClass('order-summary-is-collapsed');
							    } else {
							        $('.order-summary-toggle')
										.removeClass('order-summary-toggle-show')
										.addClass('order-summary-toggle-hide');

							        $('.sidebar:not(".sidebar-second") .sidebar-content .order-summary')
										.removeClass('order-summary-is-expanded')
										.addClass('order-summary-is-collapsed');

							        $('.sidebar.sidebar-second .sidebar-content .order-summary')
										.removeClass('order-summary-is-collapsed')
										.addClass('order-summary-is-expanded');
							    }
							});
        });
    </script>
    <script>
//<![CDATA[
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
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
document, 'script', '//connect.facebook.net/en_US/fbevents.js');
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
        (function () { function asyncLoad() { var urls = ["//hstatic.net/652/1000177652/20/2017/4-10/noname.jsss"]; for (var i = 0; i < urls.length; i++) { var s = document.createElement('script'); s.type = 'text/javascript'; s.async = true; s.src = urls[i]; var x = document.getElementsByTagName('script')[0]; x.parentNode.insertBefore(s, x); } } window.attachEvent ? window.attachEvent('onload', asyncLoad) : window.addEventListener('load', asyncLoad, false); })();
//]]>
    </script>
    <script type='text/javascript'>
//<![CDATA[
        Haravan.checkout = '{"created_at":"2017-07-26T02:19:30.549Z","currency":"VND","customer_id":1004253741,"email":"guest+1223343434@haravan.com","location_id":null,"order_id":1012405262,"requires_shipping":true,"reservation_time":null,"source_name":"web","source_identifier":null,"source_url":null,"taxes_included":false,"tax_exempt":false,"tax_lines":null,"token":"03869eec042d4e35b05d54909a3bf9a7","updated_at":"0001-01-01T00:00:00","payment_due":null,"payment_url":null,"reservation_time_left":0,"subtotal_price":4697000.0,"total_price":4697000.0,"total_tax":0.0,"line_items":[{"id":0,"key":"0","product_id":1004862902,"variant_id":1012030836,"sku":"DHN68","vendor":"Happylive","title":"ĐỒNG HỒ NAM SKMEI KIM XANH DƯƠNG - Default Title","variant_title":"Default Title","taxable":false,"requires_shipping":true,"price":499000.0,"compare_at_price":700000.0,"line_price":1497000.0,"quantity":3,"grams":0.0},{"id":0,"key":"0","product_id":1004853557,"variant_id":1012006173,"sku":"DHN04","vendor":"Happylive","title":"ĐỒNG HỒ NAM TEVISE 1952 CHẠY CƠ CỰC CHẤT - Default Title","variant_title":"Default Title","taxable":false,"requires_shipping":true,"price":800000.0,"compare_at_price":1200000.0,"line_price":800000.0,"quantity":1,"grams":0.0},{"id":0,"key":"0","product_id":1004853513,"variant_id":1012006066,"sku":"DHN01-1","vendor":"Happylive","title":"ĐỒNG HỒ NAM TEVISE CHẠY CƠ MẶT CHẠM RỘNG CỰC SANG. - Viền trắng","variant_title":"Viền trắng","taxable":false,"requires_shipping":true,"price":1200000.0,"compare_at_price":1800000.0,"line_price":2400000.0,"quantity":2,"grams":0.0}],"shipping_rate":{"id":0,"barcode":null,"title":"Giao hàng tận nơi","price":0.0,"handle":"giao-hang-tan-noi-0"},"shipping_address":{"name":"1223343434 ","full_name":null,"first_name":null,"last_name":"1223343434","company":null,"address1":"-","address2":null,"zip":"70000","country":"Vietnam","province":"Hồ Chí Minh","country_id":241,"province_id":50,"district_id":469,"ward_id":null,"phone":"1223343434","province_code":"HC","country_code":"VN"},"billing_address":{"name":"1223343434 ","full_name":"1223343434","first_name":null,"last_name":"1223343434","company":null,"address1":"-","address2":null,"zip":"70000","country":"Vietnam","province":"Hồ Chí Minh","country_id":241,"province_id":50,"district_id":null,"phone":"1223343434","billing_is_shipping":false,"note":null,"customeradd":0,"province_code":"HC","country_code":"VN"},"discount":{"amount":0.0,"code":null}}';
//]]>
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <%
    int intId = clsInput.getNumericInput("id", 0);
    DataTable dtCustommerCart = clsDatabase.getDataTable("Select * from tbl_customer_cart where PK_CustomerID=" + intId);
    int intTabId = 2;
    DataTable cart = null;
    cart = clsDatabase.getDataTable("Select * from tbl_product_cart where FK_CustomerCartID=" + dtCustommerCart.Rows[0]["PK_CustomerID"].ToString() +" order by C_Rank desc");
    int tongSoSP = 0;
    string dsCartID = "";
    decimal dcmTongTien = 0;
    if (cart != null && cart.Rows.Count > 0)
    {
        
        
        foreach (DataRow item in cart.Rows)
        {
            tongSoSP += int.Parse(item["C_SoLuong"].ToString());
            dsCartID += item["PK_ProductCartID"].ToString() + ",";
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
    }
    DataTable dtInfo1 = clsDatabase.getDataTable("select TOP 1 * from tbl_siteinfo where FK_LangID = " + lang.getLangID());
%>
    
    <input id="reloadValue" type="hidden" name="reloadValue" value="" />
    <div class="banner">
        <div class="wrap">
            <a href="#" class="logo">
                <h1 class="logo-text">
                    <%=clsInput.decodeStr(dtInfo1.Rows[0]["C_Title"].ToString())%></h1>
            </a>
        </div>
    </div>
    <button class="order-summary-toggle order-summary-toggle-hide">
        <div class="wrap">
            <div class="order-summary-toggle-inner">
                <div class="order-summary-toggle-icon-wrapper">
                    <svg width="20" height="19" xmlns="http://www.w3.org/2000/svg" class="order-summary-toggle-icon"><path d="M17.178 13.088H5.453c-.454 0-.91-.364-.91-.818L3.727 1.818H0V0h4.544c.455 0 .91.364.91.818l.09 1.272h13.45c.274 0 .547.09.73.364.18.182.27.454.18.727l-1.817 9.18c-.09.455-.455.728-.91.728zM6.27 11.27h10.09l1.454-7.362H5.634l.637 7.362zm.092 7.715c1.004 0 1.818-.813 1.818-1.817s-.814-1.818-1.818-1.818-1.818.814-1.818 1.818.814 1.817 1.818 1.817zm9.18 0c1.004 0 1.817-.813 1.817-1.817s-.814-1.818-1.818-1.818-1.818.814-1.818 1.818.814 1.817 1.818 1.817z"></path></svg>
                </div>
                <div class="order-summary-toggle-text order-summary-toggle-text-show">
                    <span>Hiển thị thông tin đơn hàng</span>
                    <svg width="11" height="6" xmlns="http://www.w3.org/2000/svg" class="order-summary-toggle-dropdown"
                        fill="#000"><path d="M.504 1.813l4.358 3.845.496.438.496-.438 4.642-4.096L9.504.438 4.862 4.534h.992L1.496.69.504 1.812z"></path></svg>
                </div>
                <div class="order-summary-toggle-text order-summary-toggle-text-hide">
                    <span>Ẩn thông tin đơn hàng</span>
                    <svg width="11" height="7" xmlns="http://www.w3.org/2000/svg" class="order-summary-toggle-dropdown"
                        fill="#000"><path d="M6.138.876L5.642.438l-.496.438L.504 4.972l.992 1.124L6.138 2l-.496.436 3.862 3.408.992-1.122L6.138.876z"></path></svg>
                </div>
                <div class="order-summary-toggle-total-recap" data-checkout-payment-due-target="469700000">
                    <span class="total-recap-final-price">
                    <%if (dcmTongTien > 0)
                          {%>
                        <%=decimal.Parse(dcmTongTien.ToString()).ToString("#,##")%>₫
                        <%} %>
                    </span>
                </div>
            </div>
        </div>
    </button>
    <div class="content content-second">
        <div class="wrap">
            <div class="sidebar sidebar-second">
                <div class="sidebar-content">
                    <div class="order-summary">
                        <div class="order-summary-sections">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="content">
        <div class="wrap">
            <div class="sidebar">
                <div class="sidebar-content">
                    <div class="order-summary order-summary-is-collapsed">
                        <h2 class="visually-hidden">
                            Thông tin đơn hàng</h2>
                        <div class="order-summary-sections">
                            <div class="order-summary-section order-summary-section-product-list" data-order-summary-section="line-items">
                                <table class="product-table">
                                    <thead>
                                        <tr>
                                            <th scope="col">
                                                <span class="visually-hidden">Hình ảnh</span>
                                            </th>
                                            <th scope="col">
                                                <span class="visually-hidden">Mô tả</span>
                                            </th>
                                            <th scope="col">
                                                <span class="visually-hidden">Số lượng</span>
                                            </th>
                                            <th scope="col">
                                                <span class="visually-hidden">Giá</span>
                                            </th>
                                        </tr>
                                    </thead>
                                    <%if (cart != null && cart.Rows.Count > 0)
                                      {%>
                                    <tbody>
                                        <%foreach (DataRow itemCart in cart.Rows)
                                          {
                                          
                                        %>
                                        <tr class="product" data-product-id="1004862902" data-variant-id="1012030836">
                                            <td class="product-image">
                                                <div class="product-thumbnail">
                                                    <div class="product-thumbnail-wrapper">
                                                        <img class="product-thumbnail-image" alt="<%=itemCart["C_Name"].ToString() %>" src="<%= clsConfig.GetHostUrl() %>/<%=itemCart["C_Img"].ToString() %>" />
                                                    </div>
                                                    <span class="product-thumbnail-quantity" aria-hidden="true">
                                                        <%=itemCart["C_SoLuong"].ToString() %></span>
                                                </div>
                                            </td>
                                            <td class="product-description">
                                                <span class="product-description-name order-summary-emphasis">
                                                    <%=itemCart["C_Name"].ToString() %></span>
                                            </td>
                                            <td class="product-quantity visually-hidden">
                                                <%=itemCart["C_SoLuong"].ToString() %>
                                            </td>
                                            <td class="product-price">
                                                <span class="order-summary-emphasis">
                                                    <%=!itemCart["C_Price"].ToString().Trim().Equals("") ? (decimal.Parse(itemCart["C_Price"].ToString()) * decimal.Parse(itemCart["C_SoLuong"].ToString())).ToString("#,##") : ""%>₫</span>
                                            </td>
                                        </tr>
                                        <%} %>
                                    </tbody>
                                    <%} %>
                                </table>
                            </div>
                            <div class="order-summary-section order-summary-section-total-lines" data-order-summary-section="payment-lines">
                                <table class="total-line-table">
                                    <thead>
                                        <tr>
                                            <th scope="col">
                                                <span class="visually-hidden">Mô tả</span>
                                            </th>
                                            <th scope="col">
                                                <span class="visually-hidden">Giá</span>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="total-line total-line-subtotal">
                                            <td class="total-line-name">
                                                Tạm tính
                                            </td>
                                            <td class="total-line-price">
                                                <span class="order-summary-emphasis" data-checkout-subtotal-price-target="469700000">
                                                    <%if (dcmTongTien > 0)
                          {%>
                        <%=decimal.Parse(dcmTongTien.ToString()).ToString("#,##")%>₫
                        <%} %></span>
                                            </td>
                                        </tr>
                                        <tr class="total-line total-line-shipping">
                                            <td class="total-line-name">
                                                Phí vận chuyển
                                            </td>
                                            <td class="total-line-price">
                                                <span class="order-summary-emphasis" data-checkout-total-shipping-target="0">Thanh toán khi giao hàng
                                                </span>
                                            </td>
                                        </tr>
                                    </tbody>
                                    <tfoot class="total-line-table-footer">
                                        <tr class="total-line">
                                            <td class="total-line-name payment-due-label">
                                                <span class="payment-due-label-total">Tổng cộng</span>
                                            </td>
                                            <td class="total-line-name payment-due">
                                                <span class="payment-due-currency">VND</span> <span class="payment-due-price" data-checkout-payment-due-target="469700000">
                                                    <%if (dcmTongTien > 0)
                          {%>
                        <%=decimal.Parse(dcmTongTien.ToString()).ToString("#,##")%>₫
                        <%} %> </span>
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="main">
                <div class="main-header">
                    <a href="#" class="logo">
                        <h1 class="logo-text">
                            <%=clsInput.decodeStr(dtInfo1.Rows[0]["C_Title"].ToString())%></h1>
                    </a>
                </div>
                <div class="main-content">
                    <div>
                        <div class="section">
                            <div class="section-header os-header">
                                <svg width="50" height="50" xmlns="http://www.w3.org/2000/svg" fill="none" stroke="#000"
                                    stroke-width="2" class="hanging-icon checkmark"><path class="checkmark_circle" d="M25 49c13.255 0 24-10.745 24-24S38.255 1 25 1 1 11.745 1 25s10.745 24 24 24z"></path><path class="checkmark_check" d="M15 24.51l7.307 7.308L35.125 19"></path></svg>
                                <div class="os-header-heading">
                                    <h2 class="os-header-title">
                                        Đặt hàng thành công
                                    </h2>
                                    <span class="os-order-number">Mã đơn hàng #<%=dtCustommerCart.Rows[0]["C_Code"].ToString()%> </span><span class="os-description">
                                        Cám ơn bạn đã mua hàng! </span>
                                </div>
                            </div>
                        </div>
                        <div class="thank-you-additional-content">
                            <!-- Google Code for Successful checkout Page -->
                            <script>
                                if (typeof ga != 'undefined') {
                                    ga('require', 'ecommerce');

                                    ga('ecommerce:addItem', {
                                        'id': '1004862902', // Transaction ID. Required.
                                        'name': 'ĐỒNG HỒ NAM SKMEI KIM XANH DƯƠNG', // Product name. Required.
                                        'sku': '', // SKU/code.
                                        'category': 'Đồng hồ nổi bật', // Category or variation.
                                        'price': '1497000', // Unit price.
                                        'quantity': '3' // Quantity.
                                    });

                                    ga('ecommerce:addItem', {
                                        'id': '1004853557', // Transaction ID. Required.
                                        'name': 'ĐỒNG HỒ NAM TEVISE 1952 CHẠY CƠ CỰC CHẤT', // Product name. Required.
                                        'sku': '', // SKU/code.
                                        'category': 'Đồng hồ nổi bật', // Category or variation.
                                        'price': '800000', // Unit price.
                                        'quantity': '1' // Quantity.
                                    });

                                    ga('ecommerce:addItem', {
                                        'id': '1004853513', // Transaction ID. Required.
                                        'name': 'ĐỒNG HỒ NAM TEVISE CHẠY CƠ MẶT CHẠM RỘNG CỰC SANG.', // Product name. Required.
                                        'sku': '', // SKU/code.
                                        'category': 'Đồng hồ nổi bật', // Category or variation.
                                        'price': '2400000', // Unit price.
                                        'quantity': '2' // Quantity.
                                    });


                                    ga('ecommerce:addTransaction', {
                                        'id': '#100012',
                                        'affiliation': '',
                                        'revenue': '4697000',
                                        'shipping': '',
                                        'tax': '',
                                        'currency': 'VND'  // local currency code.
                                    });
                                    ga('ecommerce:send');
                                }
                            </script>
                        </div>
                        <div class="section thank-you-checkout-info">
                            <div class="section-content">
                                <div class="content-box">
                                    <div class="content-box-row content-box-row-padding content-box-row-no-border">
                                        <h2>
                                            Thông tin đơn hàng</h2>
                                    </div>
                                    <div class="content-box-row content-box-row-padding">
                                        <div class="section-content">
                                            <div class="section-content-column">
                                                <h3>
                                                    Thông tin giao hàng</h3>
                                                <p>
                                                    Khách hàng: <%=dtCustommerCart.Rows[0]["C_CustomerName"].ToString()%>
                                                    <br />
                                                    Địa chỉ: <%=dtCustommerCart.Rows[0]["C_Address"].ToString()%>
                                                    
                                                    <br />
                                                    Điện thoại: <%=dtCustommerCart.Rows[0]["C_Phone"].ToString()%>
                                                    <br />
                                                    Email: <%=dtCustommerCart.Rows[0]["C_Email"].ToString()%>
                                                </p>
                                                <p>
                                                    <%=dtCustommerCart.Rows[0]["C_Des"].ToString()%>
                                                </p>
                                                <%--<h3>
                                                    Phương thức thanh toán</h3>
                                                <p>
                                                    <%=dtCustommerCart.Rows[0]["C_HinhThucThanhToan"].ToString()%>
                                                </p>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="step-footer">
                            <a href="<%=clsConfig.GetHostUrl() %>" class="step-footer-continue-btn btn"><span class="btn-content">
                                Tiếp tục mua hàng</span> </a>
                            <p class="step-footer-info">
                                <i class="icon icon-os-question"></i><span>Cần hỗ trợ? <a href="#">
                                    Liên hệ chúng tôi</a> </span>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="main-footer">
                </div>
            </div>
        </div>
    </div>

    </div>
    </form>
</body>
</html>
