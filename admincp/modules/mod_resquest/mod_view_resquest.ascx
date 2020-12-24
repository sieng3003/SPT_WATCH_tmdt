<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_view_resquest.ascx.cs" Inherits="admincp_modules_mod_resquest_mod_view_resquest" %>


<%@Import Namespace = "System.Data" %>
<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>

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
                        <td width="95%"><span class="title">Yêu cầu</span></td>
                    </tr>    		
                </table>
                <table class="content">
                    <tr>
                        <td>
	                        <table class="header" cellpadding="0" cellspacing="0">
		                        <tr>
			                        <th>Xem thông tin đặt hàng</th>
		                        </tr>	
	                        </table>
	                        <table class="boder" cellSpacing="1" cellPadding="1">
		                        <tr>
			                        <td >
				               <%
                                   DataTable dt = clsDatabase.getDataTable("select * from tbl_resquest where PK_ResquestID = " + clsInput.getNumericInput("id",0));

                                   DataTable dtSanPham = clsDatabase.getDataTable("Select tbl_product.C_Name AS TenSanPham,tbl_category_news.C_Name AS TenLoaiSanPham from tbl_product inner join tbl_category_news on tbl_product.FK_CategoryID=tbl_category_news.PK_CategoryID where tbl_product.PK_ProductID=" + clsInput.getNumericInput("id", 0));    				    				    
                                   
				                   if(dt.Rows.Count > 0)
                                   {            
				                %>
				                        <table class="form">
					                        
					                        <tr>
						                        <th>Tên khách hàng :</th>
						                        <td>
						                        <%= dt.Rows[0]["C_Name"].ToString() %>
						                        </td>
					                        </tr>					                        
					                        <tr>
						                        <th>Điện thoại :</th>
						                        <td>
						                        <%= dt.Rows[0]["C_Mobile"].ToString() %>
						                        </td>
					                        </tr>
					                        <tr>
						                        <th>Email :</th>
						                        <td>
						                        <%= dt.Rows[0]["C_Email"].ToString() %>
						                        </td>
					                        </tr>
					                        
					                        <tr>
						                        <th>Địa chỉ :</th>
						                        <td>
						                        <%= dt.Rows[0]["C_Address"].ToString() %>
						                        
						                        </td>
					                        </tr>
					                        <tr>
						                        <th>Ngày đặt hàng :</th>
						                        <td>
						                        <%= DateTime.Parse(dt.Rows[0]["C_Create"].ToString()).ToString("dd/MM/yyyy hh:mm")%>
						                        </td>
					                        </tr>
					                        <tr>
						                        <th>Mặt hàng cần mua :</th>
						                        <td>
						                            <span style="color:Red;font-weight:bold">
                                <%= dtSanPham.Rows[0]["TenSanPham"].ToString()%> 
                                (<%= dtSanPham.Rows[0]["TenLoaiSanPham"].ToString()%>)
                                </span>
						                        </td>
					                        </tr>
					                        <tr>
						                        <th>Nội dung :</th>
						                        <td>

                                                <textarea name="ctl02$txtContent" disabled="disabled" rows="2" cols="20" id="ctl02_txtContent" style="height:200px;width:50%;"><%=dt.Rows[0]["C_Content"].ToString()%> </textarea>

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