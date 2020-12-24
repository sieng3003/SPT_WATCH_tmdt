<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_cart.ascx.cs" Inherits="modules_mod_cart_mod_cart" %>
<%@ Import Namespace="System.Data" %>



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
%>
<div class="row">
    <div id="cart" class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
        <!-- Begin empty cart -->
        <div class="row">
            <div id="layout-page" class="col-md-12 col-sm-12 col-xs-12">
                <span class="header-page clearfix">
                    <h1>
                        Giỏ hàng</h1>
                </span>
                <%--<form action="/cart" method="post" id="123">--%>
                <%if (cart != null && cart.Rows.Count > 0)
                  {
                %>
                <table>
                    <thead>
                        <tr>
                            <th class="image">
                                &nbsp;
                            </th>
                            <th class="item">
                                Tên sản phẩm
                            </th>
                            <th class="qty">
                                Số lượng
                            </th>
                            <th class="price">
                                Giá tiền
                            </th>
                            <th class="remove">
                                &nbsp;
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                    foreach (DataRow itemCart in cart.Rows)
                    {
                       %>
                        <tr>
                            <td class="image">
                                <div class="product_image">
                                    <a href="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= itemCart["PK_ProductID"].ToString() %>/act/0/<%= clsFunction.RemoveUnicode(itemCart["C_Name"].ToString()) %>.aspx">
                                        <img src="<%= clsConfig.GetHostUrl() %>/<%=itemCart["C_Img"].ToString() %>"
                                            alt="<%=itemCart["C_Name"].ToString() %>" />
                                    </a>
                                </div>
                            </td>
                            <td class="item">
                                <a href="<%= clsConfig.GetHostUrl() %>/detail-product/<%= intTabId %>/<%= itemCart["PK_ProductID"].ToString() %>/act/0/<%= clsFunction.RemoveUnicode(itemCart["C_Name"].ToString()) %>.aspx"><strong><%=itemCart["C_Name"].ToString()%></strong> </a>
                            </td>
                            <td class="qty">
                                <input type="number" size="4" id="quantity_<%= itemCart["PK_ProductID"].ToString() %>" name="updates[]" min="1" id="updates_1012030836" value="<%=itemCart["C_SoLuong"].ToString()%>"
                                    onfocus="this.select();" class="tc item-quantity" />
                            </td>
                            <td class="price">
                                <%=!itemCart["C_Price"].ToString().Trim().Equals("") ? decimal.Parse(itemCart["C_Price"].ToString()).ToString("#,##") :""%>₫
                            </td>
                            <td class="remove">
                                <a href="javascript:void(0));" onclick="deletecart('<%=itemCart["PK_ProductID"].ToString() %>')" class="cart">Xóa</a>
                            </td>
                        </tr>
                        <%} %>
                        <tr class="summary">
                            <td class="image">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td class="text-center">
                                <b>Tổng cộng:</b>
                            </td>
                            <td class="price">
                                <span class="total"><strong><%if (dcmTongTien > 0)
                  {%> <%=decimal.Parse(dcmTongTien.ToString()).ToString("#,##")%>₫ <%} %></strong> </span>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </tbody>
                </table>
                <%}
                  else
                  {
                    %>
                    
                    <p class="text-center">
				Không có sản phẩm nào trong giỏ hàng!</p>

                    <%} %>
                <div class="row">
                    <div class="col-md-6 col-sm-6 col-xs-12 inner-left inner-right">
                        <div class="checkout-buttons clearfix">
                            <label for="note">
                                Ghi chú
                            </label>
                            <textarea id="note" name="note" rows="8" cols="50"></textarea>
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12 cart-buttons inner-right inner-left">
                        <div class="buttons clearfix">
                            <button type="button" id="" class="button-default" style="float:right;margin-left:10px" name="" value="" onclick="checkout()">
                                Thanh toán</button>
                            <button type="button" id="update-cart" class="button-default" name="update" value="" onclick="updatecart('<%=dsCartID %>')">
                                Cập nhật</button>
                        </div>
                    </div>
                    <div class="col-md-12 col-sm-12  col-xs-12 continue-shop">
                        <a href="<%= clsConfig.GetHostUrl() %>"><i class="fa fa-reply"></i>Tiếp tục mua hàng</a>
                    </div>
                </div>
                <%--</form>--%>
            </div>
        </div>
        <!-- End cart -->
    </div>
</div>
<script type="text/javascript">
    function updatecart(field) {
       
        var dsCartID = field.split(',');
        var key = '';
        for (i = 0; i < dsCartID.length; i++) {

            var soLuong = document.getElementById('quantity_' + dsCartID[i]).value;
            key += dsCartID[i] + ',' + soLuong + '_';


        }
        if (key.length > 0) key = key.substring(0, key.length - 1);
       
        location.href = '<%= clsConfig.GetHostUrl() %>/cart/editcart/' + key + '/cart.aspx';
    }
    function deletecart(field) {
        location.href = '<%= clsConfig.GetHostUrl() %>/cart/deletecart/' + field + '/cart.aspx';
    }
    function checkout() {
        
        
        location.href = '<%= clsConfig.GetHostUrl() %>/checkout.aspx';
    }
</script>