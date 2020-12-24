<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_login.ascx.cs" Inherits="modules_mod_customer_mod_login" %>
<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 custom-create" id="layout-page">
        <span class="header-contact header-page clearfix">
            <h1>
                Đăng nhập</h1>
        </span>
        <div id="customer-login1">
            <div id="login1" class="userbox">
                <div class="accounttype">
                    <h2 class="title">
                    </h2>
                </div>
                <%--<form accept-charset='UTF-8' action='/account/login' id='customer_login' method='post'>--%>
                <asp:Label id="LblError" runat="server" CssClass="WindowText" Width="360px" Height="8px" ForeColor="Red"></asp:Label><br />

                <input name='form_type' type='hidden' value='customer_login'>
                <input name='utf8' type='hidden' value='✓'>
                <div class="clearfix large_form">
                    <label for="customer_name" class="icon-field">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                    </label>
                    <input required type="text" value="" name="txtCustomerName" id="txtCustomerName"
                        placeholder="Tên đăng nhập" class="text" />
                </div>
                <div class="clearfix large_form">
                    <label for="customer_password" class="icon-field">
                        <i class="icon-login icon-shield"></i>
                    </label>
                    <input required type="password" value="" name="txtCustomerPassword" id="txtCustomerPassword"
                        placeholder="Mật khẩu" class="text" size="16" />
                </div>
                <div class="action_bottom">
                    <%--<input class="btn btn-signin" type="submit" value="Đăng nhập" runat="server" id="btnLogin" onserverclick="btnLogin_onserverclick"/>--%>
                    <input class="btn btn-signin1" type="button" value="Đăng nhập"  id="btnLogin" name="btnLogin" onclick="login()"/>
                </div>
                <div class="req_pass">
                    <a href="<%= clsConfig.GetHostUrl() %>/changepass/edit/1/login.aspx">Quên mật khẩu?</a>
                    hoặc <a href="<%= clsConfig.GetHostUrl() %>/register/add/1/dang-ky.aspx" title="Đăng ký">Đăng ký</a>
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
        function login() {
            var txtCustomerName = document.getElementById("txtCustomerName").value;
            var txtCustomerPassword = document.getElementById("txtCustomerPassword").value;
            if (!txtCustomerName.trim() || !txtCustomerPassword.trim()) {
                alert("Bạn hãy nhập đầy đủ: Tên đăng nhập và mật khẩu");
            }
            else {
                location.href = '<%=clsConfig.GetHostUrl() %>/login/add/1/login.aspx?customerName=' + txtCustomerName + '&customerPassword=' + txtCustomerPassword;
            }
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
