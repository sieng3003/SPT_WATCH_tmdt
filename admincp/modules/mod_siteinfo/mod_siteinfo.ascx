<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_siteinfo.ascx.cs"
    Inherits="admincp_modules_mod_siteinfo_mod_siteinfo" %>
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
                                        <span class="title">Quản trị thông tin hệ thống</span>
                                    </td>
                                </tr>
                            </table>
                            <table class="content">
                                <tr>
                                    <td>
                                        <table class="header" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <th>
                                                    Cấu hình hệ thống
                                                </th>
                                            </tr>
                                        </table>
                                        <table class="boder" cellspacing="1" cellpadding="1">
                                            <tr>
                                                <td>
                                                    <table width="100%">
                                                        <tr>
                                                            <td align="right" width="100%" valign="bottom">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table class="form">
                                                        <!-- BEGIN block_error -->
                                                        <tr>
                                                            <td>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="block_error" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <!-- END block_error -->
                                                        <tr>
                                                            <th>
                                                                Tiêu đề website :<span class="note">*</span>
                                                            </th>
                                                            <td>
                                                                <asp:TextBox runat="server" type="text" size="60" ID="txtTieuDe"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="display:none">
                                                            <th>
                                                                Thống kê lượt truy cập :<span class="note">*</span>
                                                            </th>
                                                            <td>
                                                                <asp:TextBox runat="server" type="text" NAME="VisitedCount" size="60" ID="TxtCounter"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="display:none">
                                                            <th>
                                                                Kinh doanh - Yahoo :
                                                            </th>
                                                            <td>
                                                                <asp:TextBox runat="server" type="text" size="60" ID="TxtYahoo1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="display:none">
                                                            <th>
                                                                Kinh doanh - Skype :
                                                            </th>
                                                            <td>
                                                                <asp:TextBox runat="server" type="text" size="60" ID="TxtSkype1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="display:none">
                                                            <th>
                                                                Hỗ trợ kỹ thuật - Yahoo :
                                                            </th>
                                                            <td>
                                                                <asp:TextBox runat="server" type="text" size="60" ID="TxtYahoo2"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="display:none">
                                                            <th>
                                                                Hỗ trợ kỹ thuật - Skype :
                                                            </th>
                                                            <td>
                                                                <asp:TextBox runat="server" type="text" size="60" ID="TxtSkype2"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Email nhận phản hồi :<span class="note">*</span>
                                                            </th>
                                                            <td>
                                                                <asp:TextBox runat="server" type="text" size="60" ID="TxtEmail"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th valign="top">
                                                                Thông tin liên hệ :
                                                            </th>
                                                            <td>
                                                                <FCKeditorV2:FCKeditor ID="FCKeditor1" runat="server">
                                                                </FCKeditorV2:FCKeditor>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Tiêu đề giới thiệu :
                                                            </th>
                                                            <td>
                                                                <asp:TextBox runat="server" type="text" size="60" ID="TxtTieudeGioithieu"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="display:none">
                                                            <th valign="top">
                                                                Giới thiệu ngắn :
                                                            </th>
                                                            <td>
                                                                <FCKeditorV2:FCKeditor ID="FCKeditor2" runat="server">
                                                                </FCKeditorV2:FCKeditor>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th valign="top">
                                                                Giới thiệu chi tiết :
                                                            </th>
                                                            <td>
                                                                <FCKeditorV2:FCKeditor ID="FCKeditor3" runat="server">
                                                                </FCKeditorV2:FCKeditor>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Tên doanh nghiệp :<span class="note">*</span>
                                                            </th>
                                                            <td>
                                                                <asp:TextBox runat="server" type="text" size="60" ID="txtCongty"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Địa chỉ :<span class="note">*</span>
                                                            </th>
                                                            <td>
                                                                <asp:TextBox runat="server" type="text" size="60" ID="txtDiachi"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Điện thoại :<span class="note">*</span>
                                                            </th>
                                                            <td>
                                                                <asp:TextBox runat="server" type="text" size="60" ID="txtDienthoai"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Mobile :<span class="note">*</span>
                                                            </th>
                                                            <td>
                                                                <asp:TextBox runat="server" type="text" size="60" ID="txtMobile"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Logo :<span class="note">*</span>
                                                            </th>
                                                            <td>
                                                                <input id="uploadFile" style="width: 291px; height: 22px" type="file" size="50" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Copyright :<span class="note"></span>
                                                            </th>
                                                            <td>
                                                                <asp:TextBox runat="server" type="text" size="60" ID="txtCopyright"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                            </th>
                                                            <td>
                                                                <asp:Panel ID="PnImg" runat="server" Visible="false">
                                                                    <asp:Label ID="LblImg" runat="server"></asp:Label>
                                                                    <img src="images/b_drop.png" />
                                                                    [ <a href="Default.aspx?page=siteinfo&mod=siteinfo&act=delImg">
                                                                        Xóa ảnh này </a>]
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <br>
                                                    <table class="page">
                                                        <tr>
                                                            <td>
                                                                <input type="submit" class="button" runat="server" id="BtnSubmit" value="Ghi lại"
                                                                    onserverclick="BtnSubmit_ServerClick">
                                                                <input type="reset" value="Nhập lại" class="button">
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
