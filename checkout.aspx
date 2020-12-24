<%@ Page Language="C#" AutoEventWireup="true" CodeFile="checkout.aspx.cs" Inherits="checkout" %>

<%@ Import Namespace="System.Data" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    DataTable dtInfo = clsDatabase.getDataTable("select TOP 1 * from tbl_siteinfo where FK_LangID = " + lang.getLangID());
     %>
    <link rel="shortcut icon" href="//theme.hstatic.net/1000177652/1000229231/14/favicon.png?v=90"
        type="image/png" />
    <title><%=clsInput.decodeStr(dtInfo.Rows[0]["C_Title"].ToString())%>  </title>
    <meta charset="utf-8" />
    <meta name="description" content="Happylive - Thanh to&#225;n đơn h&#224;ng" />
    <link href='//hstatic.net/0/0/global/checkouts.css?v=1.1' rel='stylesheet' type='text/css'
        media='all' />
    <link href='//theme.hstatic.net/1000177652/1000229231/14/check_out.css?v=90' rel='stylesheet'
        type='text/css' media='all' />
    <script src='//hstatic.net/0/0/global/jquery.min.js' type='text/javascript'></script>
    <script src='//hstatic.net/0/0/global/jquery.validate.js' type='text/javascript'></script>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=2, user-scalable=no">
    <script type="text/javascript">
        window.onpageshow = function (event) {
            if (event.persisted) {
                //var currentUrl = '';


                //currentUrl = 'http://happylive.vn/checkouts/03869eec042d4e35b05d54909a3bf9a7?step=1';


                //if (currentUrl)
                //window.location = currentUrl;
            }
        };



        var isInit = false;

        function funcFormOnSubmit(e) {

            if (!isInit) {
                isInit = true;

                $.fn.tagName = function () {
                    return this.prop("tagName").toLowerCase();
                };
            }

            if (typeof (e) == 'string') {
                var element = $(e);
                var formData = e;
            } else {
                var element = this;
                var formData = this;
                e.preventDefault();
            }

            $(element).find('button:submit').addClass('btn-loading');

            var formId = $(element).attr('id'), replaceElement = [], funcCallback;

            if (formId == undefined || formId == null || formId == '')
                return;



            if (formId == 'form_next_step') {
                formData = '.section-customer-information';
                replaceElement.push('.step-sections');
            }
            else if (
									formId == 'form_discount_add'
									|| formId == 'form_discount_remove'
									|| formId == 'form_update_location'

									) {
                replaceElement.push('#form_update_location');
                replaceElement.push('.inventory_location');
                replaceElement.push('.inventory_location_data');
                replaceElement.push('.order-summary-toggle-inner .order-summary-toggle-total-recap');
                replaceElement.push('.order-summary-sections');
            }





            if (!$(formData) || $(formData).length == 0) {
                window.location.reload();
                return false;
            }

            if ($(formData).tagName() != 'form')
                formData += ' :input';

            $.ajax({
                type: 'GET',
                url: window.location.origin + window.location.pathname + '?' + $(formData).serialize() + encodeURI('&form_name=' + formId),
                success: function (html) {

                    if ($(html).attr('id') == 'redirect-url') {
                        window.location = $(html).val();
                    } else {
                        if (replaceElement.length > 0) {
                            for (var i = 0; i < replaceElement.length; i++) {
                                var tempElement = replaceElement[i];
                                var newElement = $(html).find(tempElement);

                                if (newElement.length > 0) {
                                    if (tempElement == '.step-sections')
                                        $(tempElement).attr('step', $(newElement).attr('step'));

                                    var listTempElement = $(tempElement);

                                    for (var j = 0; j < newElement.length; j++)
                                        if (j < listTempElement.length)
                                            $(listTempElement[j]).html($(newElement[j]).html());
                                }
                            }
                        }

                        $('body').attr('src', $(html).attr('src'));
                        $(element).find('button:submit').removeClass('btn-loading');

                        if (($('body').find('.field-error') && $('body').find('.field-error').length > 0)
                                            || ($('body').find('.has-error') && $('body').find('.has-error').length > 0))
                            $("html, body").animate({ scrollTop: 0 }, "slow");

                        if (funcCallback)
                            funcCallback();
                    }
                }
            });

            return false;
        };
        function funcSetEvent() {
            var effectControlFieldClass = '.field input, .field select, .field textarea';

            $('body')
								.on('focus', effectControlFieldClass, function () {
								    funcFieldFocus($(this), true);
								})
								.on('blur', effectControlFieldClass, function () {
								    funcFieldFocus($(this), false);
								    funcFieldHasValue($(this), true);
								})
								.on('keyup input paste', effectControlFieldClass, function () {
								    funcFieldHasValue($(this), false);
								})
								.on('submit', 'form', funcFormOnSubmit);





            $('body')
										.on('change', '#form_update_location', function () {
										    $(this).submit();
										});



            $('body')
									.on('change', '#form_update_location select[name=customer_shipping_district]', function () {
									    $('.section-customer-information input:hidden[name=customer_shipping_district]').val($(this).val());
									})
									.on('change', '#form_update_location select[name=customer_shipping_ward]', function () {
									    $('.section-customer-information input:hidden[name=customer_shipping_ward]').val($(this).val());
									});



            $('body')
									.on('change', '#form_update_shipping_method input:radio', function () {
									    $('#form_update_shipping_method .content-box-row.content-box-row-secondary').addClass('hidden');

									    var id = $(this).attr('id');

									    if (id) {
									        var sub = $('body').find('.content-box-row.content-box-row-secondary[for=' + id + ']')

									        if (sub && sub.length > 0) {
									            $(sub).removeClass('hidden');
									        }
									    }
									});





        };
        function funcFieldFocus(fieldInputElement, isFocus) {
            if (fieldInputElement == undefined)
                return;

            var fieldElement = $(fieldInputElement).closest('.field');

            if (fieldElement == undefined)
                return;

            if (isFocus)
                $(fieldElement).addClass('field-active');
            else
                $(fieldElement).removeClass('field-active');
        };
        function funcFieldHasValue(fieldInputElement, isCheckRemove) {
            if (fieldInputElement == undefined)
                return;

            var fieldElement = $(fieldInputElement).closest('.field');

            if (fieldElement == undefined)
                return;

            if ($(fieldElement).find('.field-input-wrapper-select').length > 0) {
                var value = $(fieldInputElement).find(':selected').val();

                if (value == 'null')
                    value = undefined;
            } else {
                var value = $(fieldInputElement).val();
            }

            if (!isCheckRemove) {
                if (value != $(fieldInputElement).attr('value'))
                    $(fieldElement).removeClass('field-error');
            }

            var fieldInputBtnWrapperElement = $(fieldInputElement).closest('.field-input-btn-wrapper');

            if (value && value.trim() != '') {
                $(fieldElement).addClass('field-show-floating-label');
                $(fieldInputBtnWrapperElement).find('button:submit').removeClass('btn-disabled');
            }
            else if (isCheckRemove) {
                $(fieldElement).removeClass('field-show-floating-label');
                $(fieldInputBtnWrapperElement).find('button:submit').addClass('btn-disabled');
            }
            else {
                $(fieldInputBtnWrapperElement).find('button:submit').addClass('btn-disabled');
            }
        };
        function funcInit() {
            funcSetEvent();


        }
        $(document).ready(function () {
            funcInit();
        });
    </script>
    <script type="text/javascript">
        var toggleShowOrderSummary = false;
        $(document).ready(function () {
            var currentUrl = '';


            //currentUrl = 'http://happylive.vn/checkouts/03869eec042d4e35b05d54909a3bf9a7?step=1';


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
        <img height='1' width='1' style='display: none' src='https://www.facebook.com/tr?id=905600829489553&amp;ev=PageView&amp;noscript=1' /></noscript>
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
</head>
<body>
    <form id="form1" runat="server">
    <%
        int intTabId = 2;
        DataTable cart = null;
        if (Session["cart"] != null) cart = Session["cart"] as DataTable;
        int tongSoSP = 0;
        string dsCartID = "";
        decimal dcmTongTien = 0;
        if (cart != null && cart.Rows.Count > 0)
        {


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
        }
        DataTable dtInfo1 = clsDatabase.getDataTable("select TOP 1 * from tbl_siteinfo where FK_LangID = " + lang.getLangID());
    %>
    <input id="reloadValue" type="hidden" name="reloadValue" value="" />
    <div class="banner">
        <div class="wrap">
            <a href="#" class="logo">
                <h1 class="logo-text">
                    <%=clsInput.decodeStr(dtInfo1.Rows[0]["C_Title"].ToString())%> </h1>
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
                <div class="order-summary-toggle-total-recap" data-checkout-payment-due-target="349700000">
                    <span class="total-recap-final-price">
                        <%if (dcmTongTien > 0)
                          {%>
                        <%=decimal.Parse(dcmTongTien.ToString()).ToString("#,##")%>₫
                        <%} %></span>
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
                            <div class="order-summary-section order-summary-section-discount" data-order-summary-section="discount">
                                <form id="form_discount_add" accept-charset="UTF-8" method="post">
                                <input name="utf8" type="hidden" value="✓">
                                <div class="fieldset">
                                    <div class="field  ">
                                        <div class="field-input-btn-wrapper">
                                            <div class="field-input-wrapper">
                                                <label class="field-label" for="discount.code">
                                                    Mã giảm giá</label>
                                                <input placeholder="Mã giảm giá" class="field-input" data-discount-field="true" autocomplete="off"
                                                    autocapitalize="off" spellcheck="false" size="30" type="text" id="discount.code"
                                                    name="discount.code" value="" />
                                            </div>
                                            <button type="submit" class="field-input-btn btn btn-default btn-disabled">
                                                <span class="btn-content">Sử dụng</span> <i class="btn-spinner icon icon-button-spinner">
                                                </i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                </form>
                            </div>
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
                            <div class="order-summary-section order-summary-section-discount" data-order-summary-section="discount">
                                <form id="form_discount_add" accept-charset="UTF-8" method="post">
                                <input name="utf8" type="hidden" value="✓">
                                <div class="fieldset">
                                    <div class="field  ">
                                        <div class="field-input-btn-wrapper">
                                            <div class="field-input-wrapper">
                                                <label class="field-label" for="discount.code">
                                                    Mã giảm giá</label>
                                                <input placeholder="Mã giảm giá" class="field-input" data-discount-field="true" autocomplete="off"
                                                    autocapitalize="off" spellcheck="false" size="30" type="text" id="discount.code"
                                                    name="discount.code" value="" />
                                            </div>
                                            <button type="submit" class="field-input-btn btn btn-default btn-disabled">
                                                <span class="btn-content">Sử dụng</span> <i class="btn-spinner icon icon-button-spinner">
                                                </i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                </form>
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
                                                <span class="order-summary-emphasis" data-checkout-subtotal-price-target="349700000">
                                                    <%if (dcmTongTien > 0)
                                                      {%>
                                                    <%=decimal.Parse(dcmTongTien.ToString()).ToString("#,##")%>₫
                                                    <%} %>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr class="total-line total-line-shipping">
                                            <td class="total-line-name">
                                                Phí vận chuyển
                                            </td>
                                            <td class="total-line-price">
                                                <span class="order-summary-emphasis" data-checkout-total-shipping-target="0">Thanh toán
                                                    khi giao hàng</span>
                                            </td>
                                        </tr>
                                    </tbody>
                                    <tfoot class="total-line-table-footer">
                                        <tr class="total-line">
                                            <td class="total-line-name payment-due-label">
                                                <span class="payment-due-label-total">Tổng cộng</span>
                                            </td>
                                            <td class="total-line-name payment-due">
                                                <span class="payment-due-currency">VND</span> <span class="payment-due-price" data-checkout-payment-due-target="349700000">
                                                    <%if (dcmTongTien > 0)
                                                      {%>
                                                    <%=decimal.Parse(dcmTongTien.ToString()).ToString("#,##")%>₫
                                                    <%} %>
                                                </span>
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
                <%

                    string strCustomerLogin = "0";
                    if (this.Session["customerlogin"] != null) strCustomerLogin = "1";  
    
                %>
                <div class="main-header">
                    <a href="#" class="logo">
                        <h1 class="logo-text">
                            <%=clsInput.decodeStr(dtInfo1.Rows[0]["C_Title"].ToString())%> </h1>
                    </a>
                    <ul class="breadcrumb">
                        <li class="breadcrumb-item"><a href="<%= clsConfig.GetHostUrl() %>/cart/0/1/<%= clsFunction.RemoveUnicode("cart") %>.aspx">
                            Giỏ hàng</a> </li>
                        <li class="breadcrumb-item breadcrumb-item-current">Thông tin giao hàng </li>
                        <li class="breadcrumb-item "><a href="<%= clsConfig.GetHostUrl() %>/phuongthucthanhtoan.aspx"
                            class="breadcrumb-link">Phương thức thanh toán </a></li>
                    </ul>
                </div>
                <div class="main-content">
                    <div class="step">
                        <asp:Label ID="block_error" runat="server"></asp:Label>
                        <div class="step-sections " step="1">
                            <div class="section">
                                <div class="section-header">
                                    <h2 class="section-title">
                                        Thông tin giao hàng</h2>
                                </div>
                                <div class="section-content section-customer-information no-mb">
                                    <input name="utf8" type="hidden" value="✓">
                                    <div class="inventory_location_data">
                                        <input name="customer_shipping_district" type="hidden" value="5" />
                                        <input name="customer_shipping_ward" type="hidden" value="" />
                                    </div>
                                    <%if (!strCustomerLogin.Equals("1"))
                                      {%>
                                    <p class="section-content-text">
                                        Bạn đã có tài khoản? <a href="<%= clsConfig.GetHostUrl() %>/login/add/1/login.aspx">
                                            Đăng nhập</a>
                                    </p>
                                    <%} %>
                                    <div class="fieldset">
                                        <div class="field   field-show-floating-label">
                                            <div class="field-input-wrapper">
                                                <label class="field-label" for="billing_address_full_name">
                                                    Họ và tên</label>
                                                <input placeholder="Họ và tên" autocapitalize="off" spellcheck="false" class="field-input"
                                                    size="30" type="text" id="txtTenKhachHang" name="txtTenKhachHang" value="<%=this.Session["C_CustomerFullName"] != null ? this.Session["C_CustomerFullName"].ToString() : "" %>" />
                                                <asp:TextBox ID="txtTenKhachHang" CssClass="field-input" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="field  field-two-thirds  field-show-floating-label">
                                            <div class="field-input-wrapper">
                                                <label class="field-label" for="checkout_user_email">
                                                    Email</label>
                                                <input placeholder="Email" autocapitalize="off" spellcheck="false" class="field-input"
                                                    size="30" type="text" id="txtEmail" name="txtEmail" value="<%=this.Session["C_CustomerEmail"] != null ? this.Session["C_CustomerEmail"].ToString() : "" %>" />
                                                <asp:TextBox ID="txtEmail" CssClass="field-input" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="field field-required field-third  field-show-floating-label">
                                            <div class="field-input-wrapper">
                                                <label class="field-label" for="billing_address_phone">
                                                    Số điện thoại</label>
                                                <input placeholder="Số điện thoại" autocapitalize="off" spellcheck="false" class="field-input"
                                                    size="30" maxlength="11" type="text" id="txtDienThoai" name="txtDienThoai" value="<%=this.Session["C_CustomerPhone"] != null ? this.Session["C_CustomerPhone"].ToString() : "" %>" />
                                                <asp:TextBox ID="txtDienThoai" CssClass="field-input" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="field   field-show-floating-label">
                                            <div class="field-input-wrapper">
                                                <label class="field-label" for="billing_address_address1">
                                                    Địa chỉ</label>
                                                <input placeholder="Địa chỉ" autocapitalize="off" spellcheck="false" class="field-input"
                                                    size="30" type="text" id="txtDiaChi" name="txtDiaChi" value="<%=this.Session["C_CustomerAddress"] != null ? this.Session["C_CustomerAddress"].ToString() : "" %>" />
                                                <asp:TextBox ID="txtDiaChi" CssClass="field-input" runat="server"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="field field-show-floating-label">
                                            <div class="field-input-wrapper">
                                                <label class="field-label" for="billing_address_address2">
                                                    Ghi chú</label><br />
                                                <textarea placeholder="Ghi chú" rows="5" autocapitalize="off" spellcheck="false"
                                                    class="field-input" size="30" type="text" style="height: 100px" id="txtGhiChu"
                                                    name="txtGhiChu" value=""></textarea>
                                                <asp:TextBox ID="txtGhiChu" runat="server" TextMode="MultiLine" Height="100" CssClass="field-input"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="change_pick_location_or_shipping">
                                </div>
                            </div>
                            <div class="section" style="display: none">
                                <div>
                                    <h2 class="section-title">
                                        Thông tin giao hàng
                                    </h2>
                                    <asp:DropDownList ID="ddlHinhThucThanhToan" runat="server">
                                        <asp:ListItem Value="0">--Lựa chọn--</asp:ListItem>
                                        <asp:ListItem Value="1">Chuyển khoản qua ngân hàng</asp:ListItem>
                                        <asp:ListItem Value="2">Thanh toán khi giao hàng (COD)</asp:ListItem>
                                    </asp:DropDownList>
                                   <%-- <select id="ddlHinhThucThanhToan" runat="server">
                                                <option value="0">--Lựa chọn--</option>
						                        <option value="1">Chuyển khoản qua ngân hàng</option>
                                                <option value="2">Thanh toán khi giao hàng (COD)</option>
						            </select>--%>
                                </div>
                            </div>
                        </div>
                        <div class="step-footer">
                            <form id="form_next_step" accept-charset="UTF-8" method="post">
                                --%>

                            <input name="utf8" type="hidden" value="✓">
                            <button type="button" class="step-footer-continue-btn btn" onclick="hoantatdonhang()"
                                id="btnHoanTatDonHang">
                                <span class="btn-content">Hoàn tất đơn hàng</span> <i class="btn-spinner icon icon-button-spinner">
                                </i>
                            </button>
                            
                                
                            <script type="text/javascript">

                                function hoantatdonhang() {
                                    
                                    var txtTenKhachHang = document.getElementById('txtTenKhachHang').value;
                                    var txtEmail = document.getElementById('txtEmail').value;
                                    var txtDienThoai = document.getElementById('txtDienThoai').value;
                                    
                                    var txtDiaChi = document.getElementById('txtDiaChi').value;
                                    var txtGhiChu = document.getElementById('txtGhiChu').value;
                                    alert(txtTenKhachHang + "//" + txtEmail + "//" + txtDienThoai + "//" + txtDiaChi + "//" + txtGhiChu);
                                    
                                    if (!txtTenKhachHang.trim() || !txtEmail.trim() || !txtDienThoai.trim()) {
                                        alert("Bạn hãy điền đầy đủ: Tên, email, điện thoại");
                                    }
                                    else
                                    location.href  = '<%=clsConfig.GetHostUrl() %>'+'/checkout.aspx?do=add&tenKhachHang='+txtTenKhachHang+'&email='+txtEmail+'&dienThoai='+txtDienThoai+'&diaChi='+txtDiaChi+'&ghiChu='+txtGhiChu;
                                };
                                </script>
                            </form>
                            <a class="step-footer-previous-link" href="<%= clsConfig.GetHostUrl() %>/cart/0/1/<%= clsFunction.RemoveUnicode("cart") %>.aspx">
                                <svg class="previous-link-icon icon-chevron icon" xmlns="http://www.w3.org/2000/svg"
                                    width="6.7" height="11.3" viewbox="0 0 6.7 11.3"><path
    d="M6.7 1.1l-1-1.1-4.6 4.6-1.1 1.1 1.1 1 4.6 4.6 1-1-4.6-4.6z"></path></svg>
                                Giỏ hàng </a>
                        </div>
                    </div>
                </div>
                <div class="main-footer">
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
