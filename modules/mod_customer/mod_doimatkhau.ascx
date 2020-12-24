<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_doimatkhau.ascx.cs"
    Inherits="modules_mod_customer_mod_doimatkhau" %>
<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 custom-create" id="layout-page">
        <span class="header-contact header-page clearfix">
            <h1>
                Đổi mật khẩu</h1>
        </span>
        <div id="customer-login">
            <div id="login" class="userbox">
                <div class="accounttype">
                    <h2 class="title">
                    </h2>
                </div>
                <%--<form accept-charset='UTF-8' action='/account/login' id='customer_login' method='post'>--%>
                <asp:Label ID="block_error" runat="server"></asp:Label>
                <br />
                <input name='form_type' type='hidden' value='customer_login'>
                <input name='utf8' type='hidden' value='✓'>
                <div class="clearfix large_form">
                    <label for="customer_name" class="icon-field">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                    </label>
                    <input required type="text" value="" name="txtTenDangNhap" id="txtTenDangNhap" placeholder="Tên đăng nhập"
                        class="text" />
                </div>
                <div class="clearfix large_form">
                    <label for="customer_email" class="icon-field">
                        <i class="icon-login icon-envelope "></i>
                    </label>
                    <input required value="" name="txtEmail" id="txtEmail" placeholder="Email"
                        class="text" type="email">
                </div>
                <div class="clearfix large_form">
                    <label for="customer_password" class="icon-field">
                        <i class="icon-login icon-shield"></i>
                    </label>
                    <input required type="password" value="" name="txtMatKhau" id="txtMatKhau"
                        placeholder="Mật khẩu" class="text" size="16" />
                </div>
                <div class="clearfix large_form">
                    <label for="customer_re_password" class="icon-field">
                        <i class="icon-login icon-shield"></i>
                    </label>
                    <input required type="password" value="" name="txtReMatKhau" id="txtReMatKhau"
                        placeholder="Nhập lại mật khẩu" class="text" size="16" />
                </div>
                <div class="action_bottom">
                    <%--<input class="btn btn-signin" type="submit" value="Cập nhật" runat="server" id="btnLogin"
                        onserverclick="btnLogin_onserverclick" />--%>
                        <input class="btn btn-signin" type="button" value="Cập nhật"  id="btnLogin" onclick="changepass()" />
                </div>
                
                <%--</form>--%>
            </div>
            <div id="recover-password" style="display: none;" class="userbox">
                <div class="accounttype">
                    <h2>
                        Phục hồi mật khẩu</h2>
                </div>
                <%--<form accept-charset='UTF-8' action='/account/recover' method='post'>--%>
                <input name='form_type' type='hidden' value='recover_customer_password'>
                <input name='utf8' type='hidden' value='✓'>
                <label for="email" class="icon-field">
                    <i class="icon-login icon-envelope "></i>
                </label>
                <input type="email" value="" size="30" name="email" placeholder="Email" id="recover-email"
                    class="text" />
                <div class="action_bottom">
                    <input class="btn" type="submit" value="Gửi" />
                </div>
                <div class="req_pass">
                    <a href="#" onclick="hideRecoverPasswordForm();return false;">Hủy</a>
                </div>
                <%--</form>--%>
            </div>
        </div>
    </div>
    <script type="text/javascript">

        function changepass() {
            var txtTenDangNhap = document.getElementById('txtTenDangNhap').value;
            var txtMatKhau = document.getElementById('txtMatKhau').value;
            var txtReMatKhau = document.getElementById('txtReMatKhau').value;
            var txtEmail = document.getElementById('txtEmail').value;
            if (!txtTenDangNhap.trim() || !txtMatKhau.trim() || !txtReMatKhau.trim() || !txtEmail.trim()) {
                alert("Bạn vui lòng nhập đầy đủ thông tin");
            }
            else
                location.href = '<%=clsConfig.GetHostUrl() %>' + '/changepass/edit/1/login.aspx?tenDangNhap=' + txtTenDangNhap + "&matKhau=" + txtMatKhau + "&reMatKhau=" + txtReMatKhau + '&email=' + txtEmail;

        }
        function showRecoverPasswordForm() {
            document.getElementById('recover-password').style.display = 'block';
            document.getElementById('login').style.display = 'none';
        }

        function hideRecoverPasswordForm() {
            document.getElementById('recover-password').style.display = 'none';
            document.getElementById('login').style.display = 'block';
        }

        if (window.location.hash == '#recover') { showRecoverPasswordForm() }
    </script>
</div>
