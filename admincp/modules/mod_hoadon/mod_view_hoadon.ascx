<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_view_hoadon.ascx.cs"
    Inherits="admincp_modules_mod_hoadon_mod_view_hoadon" %>
<%@ Import Namespace="System.Data" %>
<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<script type="text/javascript">
    function clearForm() {
        document.forms[0].reset();
        return false;
    }

</script>
<table bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0" height="100%"
    width="100%">
    <tbody>
        <tr>
            <td class="DarkText" style="background-position: center top; background-repeat: repeat-x;
                background-attachment: scroll;" align="center" background="images/bg_silver.gif"
                valign="top">
                <table class="main" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <!-- Body -->
                            <table class="title" cellpadding="3" cellspacing="3">
                                <tr>
                                    <td width="5%">
                                        <img border="0" src="images/icons/laguage.gif" align="bottom" class="icon">
                                    </td>
                                    <td width="95%">
                                        <span class="title">Profile</span>
                                    </td>
                                </tr>
                            </table>
                            <table class="content">
                                <tr>
                                    <td>
                                        <table class="header" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <th>
                                                    Xem thông tin đơn hàng
                                                </th>
                                            </tr>
                                        </table>
                                        <table class="boder" cellspacing="1" cellpadding="1">
                                            <tr>
                                                <td>
                                                    <%
                                                        DataTable dt = clsDatabase.getDataTable("select * from tbl_customer_cart where PK_CustomerID = " + clsInput.getNumericInput("id", 0));
                                                        DataTable dsSanPham = clsDatabase.getDataTable("Select * from tbl_product_cart where FK_CustomerCartID=" + dt.Rows[0]["PK_CustomerID"].ToString() + " order by C_Rank desc");
                                                        if (dt.Rows.Count > 0)
                                                        {            
                                                    %>
                                                    <table class="form">
                                                        <tr>
                                                            <th>
                                                                Tên truy nhập :
                                                            </th>
                                                            <td>
                                                                <%= dt.Rows[0]["C_CustomerName"].ToString() %>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Email :
                                                            </th>
                                                            <td>
                                                                <%= dt.Rows[0]["C_Email"].ToString() %>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Ngày mua :
                                                            </th>
                                                            <td>
                                                                <%= DateTime.Parse(dt.Rows[0]["C_Create"].ToString()).ToString("dd/MM/yyyy")%>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Địa chỉ :
                                                            </th>
                                                            <td>
                                                                <%= dt.Rows[0]["C_Address"].ToString() %>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Điện thoại :
                                                            </th>
                                                            <td>
                                                                <%= dt.Rows[0]["C_Phone"].ToString() %>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Mã đơn :
                                                            </th>
                                                            <td>
                                                                <%= dt.Rows[0]["C_Code"].ToString() %>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th valign="top">
                                                                Ghi chú :
                                                            </th>
                                                            <td>
                                                                <%= clsInput.decodeStr(dt.Rows[0]["C_Des"].ToString()) %>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <% } %>
                                                    <table class="page" cellpadding="0" cellspacing="0" style="margin-left: 70px">
                                                        <tr>
                                                            <th style="text-align: left;">
                                                                Cần mua
                                                            </th>
                                                        </tr>
                                                    </table>
                                                    <%if (dsSanPham != null && dsSanPham.Rows.Count > 0)
                                                      {
                                                          
                                                          
                                                          %>
                                                    <table class="table" cellSpacing="1" cellPadding="1">
                                                        <tr>
                                                            <th width="40%">
                                                                Tên mặt hàng
                                                            </th>
                                                            <th width="30%">
                                                                Ảnh
                                                            </th>
                                                            <th width="5%">
                                                                Số lượng
                                                            </th>
                                                            <th width="10%">
                                                                Đơn giá
                                                            </th>
                                                            <th width="15%">
                                                                Thành tiền
                                                            </th>
                                                        </tr>
                                                        <%
                                                          decimal dcmTongTien = 0;
                                                            foreach (DataRow itemSanPham in dsSanPham.Rows)
                                                          {
                                                              

                                                              //==============
                                                              if (!itemSanPham["C_Price"].ToString().Trim().Equals(""))
                                                              {
                                                                  dcmTongTien += decimal.Parse(itemSanPham["C_Price"].ToString().Trim()) * decimal.Parse(itemSanPham["C_SoLuong"].ToString());
                                                              }
                                                              
                                                           %>
                                                        <tr>
                                                            <td style="text-align:center">
                                                                <%= itemSanPham["C_Name"].ToString()%>
                                                            </td>
                                                            <td style="text-align:center">
                                                                <img class="" style="width:100px" src="../<%= itemSanPham["C_Img"].ToString()%>" alt="<%= itemSanPham["C_Name"].ToString()%>" />
                                                            </td>
                                                            <td style="text-align:center">
                                                                <%= itemSanPham["C_SoLuong"].ToString()%>
                                                            </td>
                                                            <td style="text-align:center">
                                                                <%= itemSanPham["C_Price"].ToString()%>
                                                            </td>
                                                            <td style="text-align:center">
                                                                <%=!itemSanPham["C_Price"].ToString().Trim().Equals("") ? (decimal.Parse(itemSanPham["C_Price"].ToString()) * decimal.Parse(itemSanPham["C_SoLuong"].ToString())).ToString("#,##") : ""%>₫
                                                            </td>
                                                        </tr>
                                                        <%} %>
                                                        <tr>
                                                            <td style="text-align:center">
                                                                
                                                            </td>
                                                            <td style="text-align:center">
                                                                
                                                            </td>
                                                            <td style="text-align:center">
                                                                
                                                            </td>
                                                            <td style="text-align:center">
                                                                <strong>Tổng tiền</strong>
                                                            </td>
                                                            <td style="text-align:center">
                                                                <%if (dcmTongTien > 0)
                                                                  {%>
                                                                <%=decimal.Parse(dcmTongTien.ToString()).ToString("#,##")%>₫
                                                                <%} %>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <%} %>
                                                    <table class="page">
                                                        <tr>
                                                            <td>
                                                                <asp:Panel ID="PnEdit" runat="server">
                                                                    <input type="button" value="Quay lại" onclick="javascript:history.go(-1)" class="button">
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <!-- End body -->
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </tbody>
</table>
