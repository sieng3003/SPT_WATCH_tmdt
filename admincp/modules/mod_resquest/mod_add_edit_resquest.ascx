<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_add_edit_resquest.ascx.cs" Inherits="admincp_modules_mod_resquest_mod_add_edit_resquest" %>
<%@Import Namespace = "System.Data" %>
<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<script type="text/javascript">
    function clearForm() {
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
                        <td width="95%"><span class="title">Quản trị danh mục tin tức</span></td>
                    </tr>    		
                </table>
                <table class="content">
                    <tr>
                        <td>
	                        <table class="header" cellpadding="0" cellspacing="0">
		                        <tr>
			                        <th>Thêm - Sửa thông tin danh mục</th>
		                        </tr>	
	                        </table>
	                        <table class="boder" cellSpacing="1" cellPadding="1">
		                        <tr>
			                        <td >
				                        <table width="100%">
					                        <tr>
						                        <td align="right" width="100%" valign="bottom">
						                        <a href="Default.aspx?page=category_news&mod=news" title="Danh sách danh mục"><img src="images/icons/list.gif" class="icon" ></a>&nbsp;&nbsp;&nbsp;
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
						                        <th>Tên danh mục :<span class="note">*</span></th>
						                        <td><asp:TextBox runat="server" type="text" size="70" id="txtName"></asp:TextBox></td>
					                        </tr>
					                        <tr style="display:none">
						                        <th valign="top">Thông tin :</th>
						                        <td>
							                        <FCKeditorV2:FCKeditor ID="FCKeditor2" ToolbarSet="Basic" runat="server">
			                                        </FCKeditorV2:FCKeditor>
						                        </td>
					                        </tr>
                							<tr>
						                        <th valign="top">Thông tin :</th>
						                        <td>
							                        <CKEditor:CKEditorControl ID="CKEditor_ThongTin" runat="server"></CKEditor:CKEditorControl>
						                        </td>
					                        </tr>
					                        <tr>
						                        <th>Danh mục cha :</th>
						                        <td><asp:DropDownList id="DrdCategory" runat="server"></asp:DropDownList></td>
					                        </tr>
                							
					                       <tr>
						                        <th valign="top"></th>
						                        <td><asp:CheckBox id="ChkMenuNgang" runat="server" Text="Hiển thị ở menu ngang (Trang bên ngoài)"></asp:CheckBox>
			                                </td>
					                        </tr>
					                       
					                        <tr>
						                        <th valign="top"></th>
						                        <td><asp:CheckBox id="ChkUrl" runat="server" Text="Hiển thị đường dẫn liên kết đến website khác"></asp:CheckBox>	  
			                          <br />
                								
						                        <asp:TextBox runat="server" type="text" size="70" id="txtUrl"></asp:TextBox>	&nbsp; (Example: http://www.abc.com)
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


