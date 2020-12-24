<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_resquest.ascx.cs" Inherits="admincp_modules_mod_resquest_mod_resquest" %>


<%@Import Namespace = "System.Data" %>
<script type="text/javascript">
    function checkSubmitActiveInactiveForm(field, strAction) {
        var obj = document.getElementsByName("row[]");
        var strListArr = '0,';
        var isChecked = false;
        for (i = 0; i < obj.length; i++)
            if (obj[i].checked) {
                isChecked = true;
                strListArr = strListArr + obj[i].value + ',';
            }

        strListArr = strListArr + '0';

        if (!isChecked) {
            alert('Ban chua chon ban ghi de thuc hien tac vu');
            return false;
        }
        else {
            if (confirm('Ban da chac chan thuc hien tac vu nay chua?')) {
                //=================================================
                //set process page
                obj = document.getElementById("loading_page");
                obj.style.visibility = (obj.style.visibility == 'visible') ? 'hidden' : 'visible';
                //=================================================
                field.listArrRecord.value = strListArr;
                field.action = "Default.aspx?page=resquest&mod=resquest&do=" + strAction;
                field.submit();
                return true;
            }
            else
                return false;
        }
        return false;
    }

    function checkFormSearch(field) {
        /*
        if(field.key.value =='')
        {
        alert('Ban hay nhap vao thong tin tim kiem');
        field.key.focus();
        return false;
        }
        */
        //=================================================
        //set process page
        obj = document.getElementById("loading_page");
        obj.style.visibility = (obj.style.visibility == 'visible') ? 'hidden' : 'visible';
        //=================================================
        field.action = "Default.aspx?page=resquest&mod=resquest&do=search&key=" + field.key.value + "&per=" + field.per.value;
        field.submit();
        return true;
    }

</script>
<input type="hidden" name="listArrRecord" />
<table bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">
	<tbody>
		<tr>
			<td class="DarkText" style="background-position: center top; background-repeat: repeat-x; background-attachment: scroll;" align="center" background="images/bg_silver.gif" valign="top">
			
			<table class="main" cellpadding="0" cellspacing="0">
			<tr>
				<td>
				<table class="title" cellpadding="3" cellspacing="3">
				<tr>
					<td width="5%"><img border="0" src="images/icons/laguage.gif" align="bottom" class="icon" onMouseOver="doFade(this,100,30,6)" onMouseOut="doFade(this,50,50,6)" id="icon"></td>
					<td width="95%"><span class="title">Quản lý yêu cầu khách hàng</span></td>
				</tr>    		
			</table>
				<table class="content">
					<tr>
						<td>
						<table class="header" cellpadding="0" cellspacing="0">
							<tr>
								<th>Danh sách yêu cầu khách hàng</th>
							</tr>	
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<div class="boder" style="margin-bottom:3px;">
						<table class="search">
							<tr>
								<td align="right" width="5%">
										<img src="images/icons/search.gif" class="icon" />
								</td>
								<td align="center" width="75%">
									<table width="100%" cellpadding="0" cellspacing="0" border="0">
										<tr>
											<th align="left" valign="middle" width="100%">
												Tên khách hàng :&nbsp;<input type="text" name="key" style="width:200px" />&nbsp;												
												Số bản tin / trang:&nbsp;
												<select name="per"  onmouseover="Tip('Chọn số lượng bản ghi hiển thị lúc tìm kiếm');">
												<option value="0"></option>
												<option value="10">10</option>
												<option value="20">20</option>
												<option value="30">30</option>
												<option value="40">40</option>
												</select>
											</th>
										</tr>
										<tr>
											<th align="left">
												<input type="submit" value="Search" class="button" onmouseover="Tip('Tìm kiếm thông tin')" onclick="return checkFormSearch(document.activeForm);" />
												<input type="reset" value="Reset" class="button" onmouseover="Tip('Gõ lại thông tin tìm kiếm')" />
											</th>
										</tr>
									</table>
								</td>
								<td align="right" width="20%" valign="bottom">
								<%= clsHtml.add(2, "Default.aspx?page=add_edit_resquest&mod=resquest&do=add")%>									
								</td>
							</tr>
						</table>
						</div>
						<table class="table" cellSpacing="1" cellPadding="1">		
							<tr>
								<th  width="2%" >
								<input onmouseover="Tip('Select/Deselect All')" class="input_checkbox" onclick="checkAll(document.activeForm);" type="checkbox" value="Check All" name="allbox" />
								</th>
								<%--<th  width="20%" >Sản phẩm</th>	--%>								
								<th  width="15%" >Họ tên</th>	
								<th  width="15%" >Email</th>
								<th  width="30%" >Địa chỉ</th>	
                                <th  width="10%" >Điện thoại</th>
                                <th  width="10%" >Ngày đặt hàng</th>
                                <%--<th  width="18%" >Nội dung</th>	--%>	
								<th  width="6%" >Sắp xếp</th>
								<th  width="17%" >Quản trị</th>
							</tr> 			
							<!-- BEGIN block_row -->
					<%	
                            		    		    
                        //------------------------------	
                        
			            		    
                        int intCurPage = 0;
                        int intStartRecord = 0;
                        int intPageSize = 20;
                        //------------------------------ 		    
                        //check so luong ban ghi hien thi tren mot trang
                        int intPer = 0;
                        if (clsInput.getStringInput("per", 0) != null)
                            intPer = clsInput.getNumericInput("per", 0);
                        if (intPer > 0)
                            intPageSize = intPer;                        
			            //-------------------------------		    		    
                        intCurPage = clsPaging.getCurPage();
                        intStartRecord = clsPaging.getStartRecord(intCurPage, intPageSize);
                        //------------------------------
			            //check Supper Admin
                        	    		    		    
                        //------------------------------
			            //check search
                        string strKey = clsInput.getStringInput("key", 0);
                        string strSearch = "";
                        if (strKey != null)
                            strSearch = " and (C_Name like '%" + strKey + "%' )";

                        string strParamType = "";
					    
                        //------------------------------ 		    
                        string strSqlCount = "select count(*) from tbl_resquest where 1=1 " + strSearch;
                        int intTotalPage = clsPaging.getTotalPage(strSqlCount, intPageSize);
                        string strParamPage = "page=" + Request.QueryString["page"] + "&mod=" + Request.QueryString["mod"] + "&key=" + strKey + strParamType + "&per=" + intPer.ToString();		    			            		    		    		    
                        //========================================		    		                             	    	               			        		    
                        string strSql = "select * from tbl_resquest where  1=1 " + strSearch + " order by C_Rank desc";
                        DataTable dt;
                        dt = clsDatabase.getDataTable(strSql,intStartRecord,intPageSize);
                        if (dt.Rows.Count > 0)
                        {
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {	    		
                                
                                DataTable dtSanPham= clsDatabase.getDataTable("Select tbl_product.C_Name AS TenSanPham,tbl_category_news.C_Name AS TenLoaiSanPham from tbl_product inner join tbl_category_news on tbl_product.FK_CategoryID=tbl_category_news.PK_CategoryID where tbl_product.PK_ProductID="+dt.Rows[i]["FK_ProductID"].ToString());		    				    				    
					     %>
							<tr class="light">
								<td align="center">
								<% Response.Write("<input name=\"row[]\" type=\"checkbox\" class=\"input_checkbox\" id=\"row[]\" value=\"" + dt.Rows[i]["PK_resquestID"].ToString() + "\" />"); %>								
								</td>
								<%--<td align="left">								
								<img src="images/arrow.gif">								
								&nbsp;
								<%= dtSanPham.Rows[0]["TenSanPham"].ToString()%> <br />
                                &nbsp;&nbsp;&nbsp; (<%= dtSanPham.Rows[0]["TenLoaiSanPham"].ToString()%>)
								</td>--%>								
								<td align="left">	
                                <img src="images/arrow.gif">														
								&nbsp;
								<%= dt.Rows[i]["C_Name"].ToString()%>
								</td>	
								<td align="left" >														
								&nbsp;
								<%= dt.Rows[i]["C_Email"].ToString() %>
								</td>		
								<td align="left">														
								&nbsp;
								<%= dt.Rows[i]["C_Address"].ToString() %>
								</td>	
                                <td align="left">														
								&nbsp;
								<%= dt.Rows[i]["C_Mobile"].ToString() %>
								</td>	
                                <td align="center" >														
								&nbsp;
								<%= DateTime.Parse(dt.Rows[i]["C_Create"].ToString()).ToString("dd/MM/yyyy hh:mm")%>
								</td>	

                                <%--<td align="left">	
                                Sản phẩm cần mua:<br />
                                <span style="color:Red;font-weight:bold">
                                
                                <%= dtSanPham.Rows[0]["TenSanPham"].ToString()%> <br />
                                (<%= dtSanPham.Rows[0]["TenLoaiSanPham"].ToString()%>)
                                </span>
                                <br />													
								&nbsp;
								<%= dt.Rows[i]["C_Content"].ToString()%>
								</td>--%>
                                
                                			
								<td align="center">
								<% if (clsSwap.getMaxRankRecord("tbl_resquest", "") > (int)dt.Rows[i]["C_Rank"])
                                    {
                                %>
                                    <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=up&id=" + dt.Rows[i]["PK_ResquestID"].ToString() + "'>"); %>
								    <img src="images/arrow-up.gif"  onmouseover="Tip('Di chuyển lên')" border="0">
								    <%= "</a>" %>
		                        <%
                                    }		                         
                                %>
								<% if (clsSwap.getMinRankRecord("tbl_resquest", "") < (int)dt.Rows[i]["C_Rank"])
                                    {
                                %>
								    <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=down&id=" + dt.Rows[i]["PK_ResquestID"].ToString() + "'>"); %>
								    <img src="images/arrow-down.gif"  onmouseover="Tip('Di chuyển xuống')" border="0">
								    <%= "</a>"%>
		                        <% } %>
								</td>
								<td align="center">
								
								
                                <%--
                                <%= clsHtml.Lock(2, clsConfig.getCurrentUrl() + "&do=lock&id=" + dt.Rows[i]["PK_ResquestID"].ToString())%>
																
								&nbsp;							
								<%= clsHtml.edit(2, "Default.aspx?page=add_edit_resquest&mod=resquest&do=edit&id=" + dt.Rows[i]["PK_ResquestID"].ToString())%>--%> 

                                <%= clsHtml.view(2, "Default.aspx?page=view_resquest&mod=resquest&id=" + dt.Rows[i]["PK_ResquestID"].ToString())%>
								&nbsp;								
								<%= clsHtml.del(2, clsConfig.getCurrentUrl() + "&do=delete&id=" + dt.Rows[i]["PK_ResquestID"].ToString())%>    							
								</td>	
							</tr>
					<%                                                               
                            }
                        }
			        
         %>
							<!-- END block_row -->
							<tr>
                      <td align="right">&nbsp;</td>
                      <td colspan="7">&nbsp;</td>
                    </tr>
                    <tr>
                      <td align="right"><img src="images/icons/tree.gif" /></td>
                      <td colspan="7" align="left">
                      <%= clsHtml.process_unlock(2)%>
                      <%= clsHtml.process_lock(2)%>
                      <%= clsHtml.process_del(2)%>                      
                        &nbsp; </td>
                    </tr>
						</table>
						<br />
						<table class="page">
							<tr>
								<td>
								<%= clsPaging.drawPage(intPageSize, intCurPage, intTotalPage, strParamPage)%>
								</td>
							</tr>
						</table>
			
						</td>
					</tr>
				</table>
				
				</td>
			</tr>
			</table>
			
			</td>
		</tr>
	</tbody>		
</table>