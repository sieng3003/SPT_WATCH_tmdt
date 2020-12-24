<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_view_user.ascx.cs" Inherits="admincp_modules_mod_user_mod_view_user" %>
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
			                        <th>Xem thông tin cá nhân</th>
		                        </tr>	
	                        </table>
	                        <table class="boder" cellSpacing="1" cellPadding="1">
		                        <tr>
			                        <td >
				               <%
                                   DataTable dt = clsDatabase.getDataTable("select * from tbl_user where PK_UserID = " + clsInput.getNumericInput("id",0));
				                   if(dt.Rows.Count > 0)
                                   {            
				                %>
				                        <table class="form">
					                        
					                        <tr>
						                        <th>Tên truy nhập :</th>
						                        <td>
						                        <%= dt.Rows[0]["C_UserName"].ToString() %>
						                        </td>
					                        </tr>					                        
					                        <tr>
						                        <th>Họ tên :</th>
						                        <td>
						                        <%= dt.Rows[0]["C_FullName"].ToString() %>
						                        </td>
					                        </tr>
					                        <tr>
						                        <th>Email :</th>
						                        <td>
						                        <%= dt.Rows[0]["C_Email"].ToString() %>
						                        </td>
					                        </tr>
					                        
					                        <tr>
						                        <th>Giới tính :</th>
						                        <td>
						                        <%
                                                    if (dt.Rows[0]["C_FullName"].ToString() == "1")
                                                        Response.Write("Nữ");
                                                    else
                                                        Response.Write("Nam");
						                         %>
						                        
						                        </td>
					                        </tr>
					                        <tr>
						                        <th>Ngày sinh :</th>
						                        <td>
						                        <%= dt.Rows[0]["C_Birth"].ToString() %>
						                        </td>
					                        </tr>
					                        <tr>
						                        <th>Địa chỉ :</th>
						                        <td>
						                        <%= dt.Rows[0]["C_Add"].ToString() %>
						                        </td>
					                        </tr>
					                        <tr>
						                        <th>Điện thoại :</th>
						                        <td>
						                        <%= dt.Rows[0]["C_Phone"].ToString() %>
						                        </asp:TextBox></td>
					                        </tr>
					                        
					                        
					                        <tr>
						                        <th valign="top">Mô tả :</th>
						                        <td>
							                        <%= clsInput.decodeStr(dt.Rows[0]["C_Des"].ToString()) %>
						                        </td>
					                        </tr>
                							
					                       
                							
					                        
				                        </table>				                        
				                        <% } %>
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