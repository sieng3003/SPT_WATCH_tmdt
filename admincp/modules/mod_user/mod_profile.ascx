<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_profile.ascx.cs" Inherits="admincp_modules_mod_user_mod_profile" %>
<%@Import Namespace = "System.Data" %>
<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>

<script type="text/javascript">
function clearForm()
{
    document.forms[0].reset();
    return false;
}
</script>

<table bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">
	<tbody>
		<tr>
			<td class="DarkText" style="background-position: center top; background-repeat: repeat-x; background-attachment: scroll;" align="center" background="images/bg_silver.gif" valign="top">
			
			<table class="main" cellpadding="0" cellspacing="0">
			<tr>
				<td>
				
				<!-- Body -->				
	            <table class="title" cellpadding="3" cellspacing="3">
                    <tr>
                        <td width="5%"><img border="0" src="images/icons/laguage.gif" align="bottom" class="icon" ></td>
                        <td width="95%"><span class="title">Profile</span></td>
                    </tr>    		
                </table>
                <table class="content">
                    <tr>
                        <td>
	                        <table class="header" cellpadding="0" cellspacing="0">
		                        <tr>
			                        <th>Sửa thông tin cá nhân</th>
		                        </tr>	
	                        </table>
	                        <table class="boder" cellSpacing="1" cellPadding="1">
		                        <tr>
			                        <td >
				                        <table width="100%">
					                        <tr>
						                        <td align="right" width="100%" valign="bottom">
						                        <a href="Default.aspx?page=user&mod=user" title="Danh sách danh mục"><img src="images/icons/list.gif" class="icon" ></a>&nbsp;&nbsp;&nbsp;
						                        <a href="#" onclick="window.location.reload();" title="{src_refresh}"><img src="images/icons/refresh.gif" class="icon" ></a>
						                        			</td>
					                        </tr>
				                        </table>
				                        <table class="form">
					                        <!-- BEGIN block_error -->
					                        <tr >
						                        <td></td>
						                        <td>
						                            <asp:Label ID="block_error" runat="server"></asp:Label>
						                        </td>
					                        </tr>
					                        <!-- END block_error -->
					                        <tr>
						                        <th>Tên truy nhập :<span class="note">*</span></th>
						                        <td><asp:TextBox runat="server" type="text" size="70" id="txtUserName"></asp:TextBox>
						                        <asp:Label ID="lblUserName" runat="server"></asp:Label>
						                        </td>
					                        </tr>
					                        <tr>
						                        <th>Mật khẩu :<span class="note">*</span></th>
						                        <td><asp:TextBox runat="server" type="text" TextMode="Password" size="70" id="txtUserPass"></asp:TextBox></td>
					                        </tr>
					                        <tr>
						                        <th>Nhập lại mật khẩu :<span class="note">*</span></th>
						                        <td><asp:TextBox runat="server" type="text" size="70" TextMode="Password" id="txtReUserPass"></asp:TextBox></td>
					                        </tr>
					                        <tr>
						                        <th>Họ tên :<span class="note"></span></th>
						                        <td><asp:TextBox runat="server" type="text" size="70" id="txtFullName"></asp:TextBox></td>
					                        </tr>
					                        <tr>
						                        <th>Email :<span class="note"></span></th>
						                        <td><asp:TextBox runat="server" type="text" size="70" id="txtEmail"></asp:TextBox></td>
					                        </tr>
					                        <tr>
						                        <th>Giới tính :<span class="note"></span></th>
						                        <td>
						                        <select id="DrdSex" runat="server">
						                        <option value="1">Nữ</option>
						                        <option value="2">Nam</option>
						                        </select>
						                        </td>
					                        </tr>
					                        <tr>
						                        <th>Ngày sinh :<span class="note"></span></th>
						                        <td><asp:TextBox runat="server" type="text" size="70" id="txtBirth"></asp:TextBox></td>
					                        </tr>
					                        <tr>
						                        <th>Địa chỉ :<span class="note"></span></th>
						                        <td><asp:TextBox runat="server" type="text" size="70" id="txtAdd"></asp:TextBox></td>
					                        </tr>
					                        <tr>
						                        <th>Điện thoại :<span class="note"></span></th>
						                        <td><asp:TextBox runat="server" type="text" size="70" id="txtPhone"></asp:TextBox></td>
					                        </tr>
					                        
					                        
					                        <tr>
						                        <th valign="top">Mô tả :</th>
						                        <td>
							                        <FCKeditorV2:FCKeditor ID="FCKeditor2" ToolbarSet="Basic" runat="server">
			                                        </FCKeditorV2:FCKeditor>
						                        </td>
					                        </tr>
                							
					                        
                							
					                        
				                        </table>
				                        <br>
				                        <table class="page">
					                        <tr>
						                        <td>
						                        
			                                    <asp:Panel ID="PnEdit" runat="server">
				                                <input type="submit" class="button" runat="server" id="BtnEdit" value="Sửa lại" onserverclick="BtnEdit_ServerClick">			    
			                                    <input type="reset" value="Nhập lại" class="button">
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