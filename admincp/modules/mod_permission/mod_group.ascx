<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_group.ascx.cs" Inherits="admincp_modules_mod_permission_mod_group" %>
<%@Import Namespace = "System.Data" %>
<table bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">
	<tbody>
		<tr>
			<td class="DarkText" style="background-position: center top; background-repeat: repeat-x; background-attachment: scroll;" align="center" background="images/bg_silver.gif" valign="top">
			
			<form method="POST">
			<table class="main" cellpadding="0" cellspacing="0">
			<tr>
				<td>
				<table cellpadding="3" cellspacing="3">
				<tr>
					<td width="7%">
					<!--
					<img border="0" src="images/icons/laguage.gif" align="bottom" class="icon" onMouseOver="doFade(this,100,30,6)" onMouseOut="doFade(this,50,50,6)" id="icon">
					-->
					<%= clsHtml.add(2, "Default.aspx?page=add_edit_group&mod=permission&do=add")%>									
					</td>
					<td width="93%"><span class="title">Quản lý nhóm quyền</span></td>
				</tr>    		
			</table>
				<table class="content">
					<tr>
						<td>
						<table class="header" cellpadding="0" cellspacing="0">
							<tr>
								<th>Danh sách nhóm quyền</th>
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
								<!--
										<img src="images/icons/search.gif" class="icon" >
								-->								
								</td>
								<td align="center" width="75%">
								<!--
									<table width="100%" cellpadding="0" cellspacing="0" border="0">
										<tr>
											<th align="left" valign="middle" width="100%">
												Tên :&nbsp;<input type="text" name="key" style="width:200px">&nbsp;												
												Số bản tin / trang:&nbsp;
												<select name="per">
												<option>10</option>
												<option>20</option>
												<option>30</option>
												<option>40</option>
												</select>
											</th>
										</tr>
										<tr>
											<th align="left">
												<input type="submit" value="Search" class="button">
												<input type="reset" value="Reset" class="button">
											</th>
										</tr>
									</table>
									-->
								</td>
								<td align="right" width="20%" valign="bottom">
									
								<a href="#" onclick="window.location.reload();" onmouseover = "Tip('Reload lại trang');"><img src="images/icons/refresh.gif" class="icon" ></a>	
								</td>
							</tr>
						</table>
						</div>
						<table class="table" cellSpacing="1" cellPadding="1">		
							<tr>								
								<th  width="34%" >Tên nhóm quyền</th>									
								<th  width="40%" >Thông tin nhóm quyền</th>
								<th  width="12%" >Phân quyền</th>				
								<th  width="6%" >Sắp xếp</th>
								<th  width="12%" >Quản trị</th>
							</tr> 			
							<!-- BEGIN block_row -->
					<%	
                        //------------------------------
                        int intCurPage = 0;
                        int intStartRecord = 0;
                        int intPageSize = 8;
                        intCurPage = clsPaging.getCurPage();
                        intStartRecord = clsPaging.getStartRecord(intCurPage, intPageSize);
                        
					    string strSqlCount = "select count(*) from tbl_groupmember where  FK_LangID = " + lang.getLangID() + " ";
                        int intTotalPage = clsPaging.getTotalPage(strSqlCount, intPageSize);
                        string strParamPage = "page=" + Request.QueryString["page"] + "&mod=" + Request.QueryString["mod"];		    			            		    		    		    
                        //========================================		    		                             	    	               			        		    
                        string strSql = "select * from tbl_groupmember where  FK_LangID = " + lang.getLangID() + " " + " order by C_Rank desc";
                        DataTable dt;
                        dt = clsDatabase.getDataTable(strSql,intStartRecord,intPageSize);
			            int iGroupUser = 0;
                        int intGroupCount = 0;		        
                        if (dt.Rows.Count > 0)
                        {
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {	    				    				    				    
					     %>
					     <%
								//Lay thong tin cac user thuoc nhom nguoi dung nay
                                string strUserGroup = "<b>Các User thuộc nhóm quyền này:</b><br>";
                                DataTable dtUserGroup = clsDatabase.getDataTable("select C_UserName, C_Email from tbl_user inner join tbl_user_groupmember on tbl_user.PK_UserID = tbl_user_groupmember.FK_UserID inner join tbl_groupmember on tbl_user_groupmember.FK_GroupmemberID = tbl_groupmember.PK_GroupmemberID where tbl_user_groupmember.FK_GroupMemberID = " + dt.Rows[i]["PK_GroupMemberID"].ToString());
                                intGroupCount = 0;
                                for (iGroupUser = 0; iGroupUser < dtUserGroup.Rows.Count; iGroupUser++)
                                {
                                    intGroupCount++;
                                    strUserGroup += dtUserGroup.Rows[iGroupUser]["C_UserName"].ToString() + " (" + dtUserGroup.Rows[iGroupUser]["C_Email"].ToString() + ")" + "<br>"; 
                                }
                                if (intGroupCount == 0)
                                    strUserGroup += "Không có User nào thuộc nhóm quyền này";
                                else
                                    strUserGroup += "<i>Có " + intGroupCount.ToString() + " User thuộc nhóm quyền này</i>";
								 %>
							<tr class="light" >								
								<td align="left" onmouseover="Tip('<%= strUserGroup %>')">								
								<img src="images/arrow.gif">								
								&nbsp;
								<%= dt.Rows[i]["C_Name"].ToString()%>
								</td>
								<td align="left" >
								&nbsp;
								<%= dt.Rows[i]["C_Des"].ToString()%>
								</td>								
								<td align="center" >
								<% Response.Write("<a href='Default.aspx?page=user_permission&mod=permission&id=" + dt.Rows[i]["PK_GroupMemberID"].ToString() + "'>"); %>
								    <img src="images/icons/user.png"  onmouseover="Tip('Gán người sử dụng vào nhóm quyền')" border="0">
								    <%= "</a>"%>
								&nbsp;
								<% Response.Write("<a href='Default.aspx?page=group_permission&mod=permission&id=" + dt.Rows[i]["PK_GroupMemberID"].ToString() + "'>"); %>
								    <img src="images/icons/group.png"  onmouseover="Tip('Gán chức năng vào nhóm quyền')" border="0">
								    <%= "</a>"%>								
								</td>								
								<td align="center">
								<% if (clsSwap.getMaxRankRecord("tbl_groupmember", " FK_LangID =" + lang.getLangID() + " ") > (int)dt.Rows[i]["C_Rank"])
                                    {
                                %>
                                    <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=up&id=" + dt.Rows[i]["PK_GroupMemberID"].ToString() + "'>"); %>
								    <img src="images/arrow-up.gif"  onmouseover="Tip('Di chuyển lên')" border="0">
								    <%= "</a>"%>
		                        <%
                                    }		                         
                                %>
								<% if (clsSwap.getMinRankRecord("tbl_groupmember", " FK_LangID =" + lang.getLangID() + " ") < (int)dt.Rows[i]["C_Rank"])
                                    {
                                %>
								    <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=down&id=" + dt.Rows[i]["PK_GroupMemberID"].ToString() + "'>"); %>
								    <img src="images/arrow-down.gif"  onmouseover="Tip('Di chuyển xuống')" border="0">
								    <%= "</a>"%>
		                        <% } %>
								</td>
								<td align="center">
							<% if ((int)dt.Rows[i]["PK_GroupMemberID"] != 1 && (int)dt.Rows[i]["PK_GroupMemberID"] != 3 && (int)dt.Rows[i]["PK_GroupMemberID"] != 4)
                                {
                            %>
								<% if ((int)dt.Rows[i]["C_Active"] == 0)
                                    {
                                %>
								    <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=unlock&id=" + dt.Rows[i]["PK_GroupMemberID"].ToString() + "'>"); %>
								    <img src="images/icons/lock.gif" onmouseover="Tip('Khóa bản ghi')" border="0" >&nbsp;
								    <%= "</a>"%>
		                        <%
                                    }
                                    else
                                    {		                         
                                            %>
                                            <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=lock&id=" + dt.Rows[i]["PK_GroupMemberID"].ToString() + "'>"); %>
								                <img src="images/icons/unlock.gif" onmouseover="Tip('Mở khóa bản ghi')" border="0">&nbsp;
								                <%= "</a>"%>
								            <% } %>
								            <% Response.Write("<a href='Default.aspx?page=add_edit_group&mod=permission&do=edit&id=" + dt.Rows[i]["PK_GroupMemberID"].ToString() + "'>"); %>
								                <img src="images/icons/edit.gif" onmouseover="Tip('Sửa bản ghi')" border="0">&nbsp;
								                <%= "</a>"%>
            								
								            <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=delete&id=" + dt.Rows[i]["PK_GroupMemberID"].ToString() + "' onclick=\"return confirm('Bạn muốn xóa bản ghi này?');\">"); %>								   
								                <img src="images/icons/delete.gif" onmouseover="Tip('Xóa bản ghi')" border="0">
								                <%= "</a>"%>	
            						<% } %>		     							
								            </td>	
							            </tr>
					            <%                                                               
                                    
                                }
                            }
			        
                            %>
							<!-- END block_row -->
						</table>
						<br>
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
			</form>
			</td>
		</tr>
	</tbody>		
</table>