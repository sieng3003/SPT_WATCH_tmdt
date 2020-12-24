<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_dangky.ascx.cs" Inherits="modules_mod_customer_mod_dangky" %>
<%@ Import Namespace="System.Data" %>
<script type="text/javascript">
    function register() {
        
        var txtTenDangNhap = document.getElementById('txtTenDangNhap').value;
        
        var txtMatKhau = document.getElementById('txtMatKhau').value;
        var txtReMatKhau = document.getElementById('txtReMatKhau').value;
        var txtHoTen = document.getElementById('txtHoTen').value;
        var txtEmail = document.getElementById('txtEmail').value;

        var ddlGioiTinh = document.getElementById("ddlGioiTinh");
        var intSex = ddlGioiTinh.options[ddlGioiTinh.selectedIndex].value;
        var txtDiaChi = document.getElementById('txtDiaChi').value;
        var txtDienThoai = document.getElementById('txtDienThoai').value;

        //alert(txtTenDangNhap + "//" + txtMatKhau + "//" + txtReMatKhau + "//" + txtHoTen + "//" + txtEmail + "//" + intSex + "//" + txtDiaChi +"//"+ txtDienThoai);

        if (!txtTenDangNhap.trim() || !txtEmail.trim()) {
            alert("Bạn hãy điền đầy đủ: Tên đăng nhập, email");
        }
        else
        location.href = '<%=clsConfig.GetHostUrl() %>' + '/register/add/1/dang-ky.aspx?tenDangNhap=' + txtTenDangNhap +"&matKhau="+txtMatKhau+"&reMatKhau="+txtReMatKhau+"&hoTen="+txtHoTen+ '&email=' + txtEmail +"&gioiTinh="+intSex+ '&dienThoai=' + txtDienThoai + '&diaChi=' + txtDiaChi ;

    }
    function updateInfo(intID) {
        var txtTenDangNhap = document.getElementById('txtTenDangNhap').value;

        var txtMatKhau = document.getElementById('txtMatKhau').value;
        var txtReMatKhau = document.getElementById('txtReMatKhau').value;
        var txtHoTen = document.getElementById('txtHoTen').value;
        var txtEmail = document.getElementById('txtEmail').value;

        var ddlGioiTinh = document.getElementById("ddlGioiTinh");
        var intSex = ddlGioiTinh.options[ddlGioiTinh.selectedIndex].value;
        var txtDiaChi = document.getElementById('txtDiaChi').value;
        var txtDienThoai = document.getElementById('txtDienThoai').value;

        //alert(txtTenDangNhap + "//" + txtMatKhau + "//" + txtReMatKhau + "//" + txtHoTen + "//" + txtEmail + "//" + intSex + "//" + txtDiaChi +"//"+ txtDienThoai);

        if (!txtTenDangNhap.trim() || !txtEmail.trim() || !txtMatKhau.trim() || !txtReMatKhau.trim()) {
            alert("Bạn hãy điền đầy đủ: Tên đăng nhập, email, mật khẩu");
        }
        else
            location.href = '<%=clsConfig.GetHostUrl() %>' + '/register/edit/'+intID+'/dang-ky.aspx?tenDangNhap=' + txtTenDangNhap + "&matKhau=" + txtMatKhau + "&reMatKhau=" + txtReMatKhau + "&hoTen=" + txtHoTen + '&email=' + txtEmail + "&gioiTinh=" + intSex + '&dienThoai=' + txtDienThoai + '&diaChi=' + txtDiaChi;

    }
</script>
<%
    string action = clsInput.getStringInput("action", 0);
    int intId = clsInput.getNumericInput("key", 0);
    //Khoi tao cac gia tri
    string strCustomerName = "";
    string strCustomerPass = "";
    string strReCustomerPass = "";
    string strFullName = "";
    string strAddress = "";
    string strEmail = "";
    int intSex = 1;
    string strBirth = "";
    string strPhone = "";
    string strDes = "";
    //====================================================
    if (action.Equals("edit") && intId > 0)
    {
        DataTable dt = clsDatabase.getDataTable("select * from tbl_customer where PK_CustomerID = " + intId);
        if (dt.Rows.Count > 0)
        {
            strCustomerName = dt.Rows[0]["C_CustomerName"].ToString();
            strCustomerPass = dt.Rows[0]["C_CustomerPass"].ToString();
            strFullName = dt.Rows[0]["C_FullName"].ToString();
            strAddress = dt.Rows[0]["C_Address"].ToString();
            strEmail = dt.Rows[0]["C_Email"].ToString();
            intSex = Convert.ToInt16(dt.Rows[0]["C_Sex"]);
            strBirth = dt.Rows[0]["C_Birth"].ToString();
            strPhone = dt.Rows[0]["C_Phone"].ToString();
            strDes = clsInput.decodeStr(dt.Rows[0]["C_Des"].ToString());
        }
    }
    
     %>
<div class="row">
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 account-address">
        <div id="layout-page" class="clearfix">
            <span class="header-contact header-page clearfix text-center" style="display: none">
                <h1>
                    Địa chỉ</h1>
            </span>
            <div class="row">
                <div class="col-xs-12 col-sm-3 sidebar-account">
                    <div class="AccountSidebar" style="display: none">
                        <h4 class="AccountTitle titleSidebar">
                            Tài khoản</h4>
                        <div class="AccountContent">
                            <div class="AccountList">
                                <ul class="list-unstyled">
                                    <li class="current"><a href="/account">Thông tin tài khoản</a></li>
                                    <li><a href="/account/addresses">Danh sách địa chỉ</a></li>
                                    <li class="last"><a href="/account/logout">Đăng xuất</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-9">
                    <div class="row">
                        <div class="content-page">
                            <div class="col-md-7 col-sm-12 col-xs-12">
                                <div id="address_tables">
                                    <div class="address_table">
                                        <div id="edit_address_1005298365" class="customer_address edit_address">
                                            <h2 style="text-align: center">
                                                Tài khoản</h2><br />
                                                <asp:Label ID="block_error" runat="server"></asp:Label>
                                            <%--<form accept-charset='UTF-8' action='register/add/1/dang-ky.aspx' id='address_form_1005298365'
                                            method='post'>--%>
                                            <input name='form_type' type='hidden' value='customer_address'>
                                            <input name='utf8' type='hidden' value='✓'>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                                <input type="text" id="txtTenDangNhap" name="txtTenDangNhap"  class="form-control textbox" size="40" value="<%=strCustomerName %>"
                                                    placeholder="Tên đăng nhập" />
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="icon-login icon-shield "></i></span>
                                                <input type="password" id="txtMatKhau" name="txtMatKhau" class="form-control textbox" name="" size="40" value=""
                                                    placeholder="Mật khẩu" />
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="icon-login icon-shield "></i></span>
                                                <input type="password" id="txtReMatKhau" name="txtReMatKhau" class="form-control textbox" name="" size="40" value=""
                                                     placeholder="Nhập lại mật khẩu" />
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                                <input type="text" id="txtHoTen" name="txtHoTen" class="form-control textbox" name="" size="40" value="<%=strFullName %>"
                                                    placeholder="Họ tên" />
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                                                <input type="text" id="txtEmail" name="txtEmail" class="form-control textbox" name="" size="40" value="<%=strEmail %>"
                                                    placeholder="Email" />
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                                <select class="form-control textbox" id="ddlGioiTinh" name="ddlGioiTinh">
                                                    <option value="1" <%if(intSex==1){%> selected="selected" <%} %>  >Nam</option>
                                                    <option value="0" <%if(intSex==0){%> selected="selected" <%} %> >Nữ</option>
                                                </select>
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                                <input type="text" id="txtDiaChi" class="form-control textbox" name="txtDiaChi" size="40" value="<%=strAddress %>"
                                                    placeholder="Địa chỉ">
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                                                <input type="text" id="txtDienThoai" class="form-control textbox" name="txtDienThoai" size="40" value="<%=strPhone %>"
                                                    placeholder="Điện thoại">
                                            </div>
                                            
                                            <div class="action_bottom">
                                                <asp:Panel ID="PnAdd" runat="server">
                                               

                                                    <%--<input class="btn bt-primary" type="submit" id="btnDangKy" value="Đăng ký" runat="server" onserverclick="btnDangKy_ServerClick" />--%>
                                                    <input class="btn bt-primary" type="button" id="btnDangKy" value="Đăng ký" onclick="register()"/>

                                                </asp:Panel>
                                                <asp:Panel ID="PnEdit" runat="server">
                                                <input class="btn bt-primary" type="button" id="btnCapNhat" name="btnCapNhat" value="Cập nhật" onclick="updateInfo('<%=clsInput.getNumericInput("key", 0) %>')"/>
                                                    <%--<input class="btn bt-primary" type="submit" id="btnCapNhat" value="Cập nhật" runat="server" onserverclick="btnCapNhat_ServerClick" />--%>
                                                </asp:Panel>
                                                <span class="">hoặc <a href="<%= clsConfig.GetHostUrl() %>" >
                                                    Hủy</a></span>
                                            </div>
                                            <%--</form>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
