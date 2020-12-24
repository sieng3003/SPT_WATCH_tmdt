<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_add_edit_adv_flash.ascx.cs" Inherits="admincp_modules_mod_adv_mod_add_edit_adv_flash" %>
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
                        <td width="95%"><span class="title">Quản trị logo Adv - Flash</span></td>
                    </tr>    		
                </table>
                <table class="content">
                    <tr>
                        <td>
	                        <table class="header" cellpadding="0" cellspacing="0">
		                        <tr>
			                        <th>Thêm - Sửa thông tin</th>
		                        </tr>	
	                        </table>
	                        <table class="boder" cellSpacing="1" cellPadding="1">
		                        <tr>
			                        <td >
				                       
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
						                        <th>Tên logo :<span class="note">*</span></th>
						                        <td><asp:TextBox runat="server" type="text" size="70" id="txtName"></asp:TextBox></td>
					                        </tr>					                        
					                        <tr>
						                        <th>Thuộc trang :</th>
						                        <td>
						                        <select name="DrdPage" id="DrdPage" runat="server">
						                        <option value="1">Home</option>
						                        <option value="2">News & Event</option>
						                        <option value="3">Industrial Zone</option>
						                        <option value="4">Hot Deals</option>
						                        <option value="5">Leal Framework</option>
						                        <option value="6">Services</option>
						                        <option value="7">Contact</option>
						                        </select>
						                        </td>
					                        </tr>
					                        <tr>
						                        <th>Vị trí :</th>
						                        <td>
						                        <select name="DrdPlace" id="DrdPlace" runat="server">
						                        <option value="1">Bên phải</option>
						                        <option value="2">Giữa</option>
						                        <option value="3">Dưới</option>
						                        </select>
						                        </td>
					                        </tr>
					                        <tr>
						                        <th>Độ dài :<span class="note">*</span></th>
						                        <td><asp:TextBox runat="server" type="text" size="30" id="txtWidth"></asp:TextBox></td>
					                        </tr>
					                        <tr>
						                        <th>Độ rộng :<span class="note">*</span></th>
						                        <td><asp:TextBox runat="server" type="text" size="30" id="txtHeight"></asp:TextBox></td>
					                        </tr>
					                        <tr>
						                        <th valign="top">Trích dẫn :</th>
						                        <td>
							                        <FCKeditorV2:FCKeditor ID="FCKeditor1" ToolbarSet="Basic" runat="server">
			                                        </FCKeditorV2:FCKeditor>
						                        </td>
					                        </tr>
					                       
                							
					                       
                							<tr>
						                        <th valign="top">Hình ảnh</th>
						                        <td>
						                        <input id="uploadFile" style="WIDTH: 291px; HEIGHT: 22px" type="file" size="50" runat="server" />
			                                </td>
					                        </tr>
					                        <tr>
				                               <td>
                                                   </td>
				                               <td>
				                                    <asp:Panel ID="PnImg" runat="server" Visible="false">
						                            <asp:Label ID="LblImg" runat="server"></asp:Label>
						                            <img src="images/b_drop.png"  /> [ <a href="Default.aspx?page=add_edit_adv_flash&mod=adv&do=edit&id=<%= clsInput.getNumericInput("id",0) %>&act=delFile&getpage=<%= clsInput.getNumericInput("getpage",0) %>"> Xóa ảnh này </a> ]
					                            </asp:Panel>
				                               </td>
				                            </tr>
				                        </table>
				                        <br>
				                        <table class="page">
					                        <tr>
						                        <td>
						                        <asp:Panel ID="PnAdd" runat="server">
				                                <input type="submit" class="button" runat="server" id="BtnSubmit" value="Thêm mới" onserverclick="BtnSubmit_ServerClick">			    
			                                    <input type="reset" value="Nhập lại" class="button">
					                        <input type="button" value="Quay lại" onclick="javascript:history.go(-1)" class="button">
			                                    </asp:Panel>
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