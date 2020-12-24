<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_menu.ascx.cs" Inherits="admincp_modules_menu_mod_menu" %>

<%@Import Namespace = "System.Data" %>
<table bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">
	<tbody>
		<tr>
			<td class="DarkText" style="background-position: center top; background-repeat: repeat-x; background-attachment: scroll;" align="center" background="images/bg_silver.gif" valign="top">
			<table class="main" cellpadding="0" cellspacing="0">
			<tr>
				<td>
				<table class="title" cellpadding="3" cellspacing="3">
				<tr>
					<td width="5%">
					<a href="Default.aspx?page=add_edit_menu&mod=menu&do=add">
									<img src="images/icons/add.gif" class="icon" onmouseover="Tip('Thêm bản ghi mới')">
									</a>
					</td>
					<td width="95%"><span class="title">Quản lý Menu hệ thống</span></td>
				</tr>    		
			</table>
				<table class="content">
					<tr>
						<td>
						<table class="header" cellpadding="0" cellspacing="0">
							<tr>
								<th>Danh sách Menu</th>
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
										
								</td>
								<td align="center" width="75%">
									
								</td>
								<td align="right" width="20%" valign="bottom">
									&nbsp;&nbsp;&nbsp;
									
								</td>
							</tr>
						</table>
						</div>
						<table class="table" cellSpacing="1" cellPadding="1">		
							<tr>
								
								<th  width="28%" >Tên Menu</th>	
								<th  width="30%" >Đường dẫn</th>								
								<th  width="6%" >Add</th>
								<th  width="6%" >Edit</th>
								<th  width="6%" >Delete</th>
								<th  width="6%" >Lock</th>				
								<th  width="6%" >Sắp xếp</th>
								<th  width="12%" >Quản trị</th>
							</tr> 			
							<!-- BEGIN block_row -->
					<%	
                        //------------------------------
                        int intCurPage = 0;
                        int intStartRecord = 0;
                        int intPageSize = 10;
                        intCurPage = clsPaging.getCurPage();
                        intStartRecord = clsPaging.getStartRecord(intCurPage, intPageSize);
                                               
                        //------------------------------ 
                        string strSqlCount = "select count(*) from tbl_menu where FK_ParentID = 0 AND FK_LangID = " + lang.getLangID();
                        int intTotalPage = clsPaging.getTotalPage(strSqlCount, intPageSize);
                        string strParamPage = "page=" + Request.QueryString["page"] + "&mod=" + Request.QueryString["mod"];		    			            		    		    		    
                        //========================================		    		                             	    	               			        		    
                        string strSql = "select * from tbl_menu where FK_ParentID = 0 AND FK_LangID = " + lang.getLangID() + " order by C_Rank desc";
                        DataTable dt,dtSub;
                        dt = clsDatabase.getDataTable(strSql,intStartRecord,intPageSize);
                        if (dt.Rows.Count > 0)
                        {
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {	    				    				    				    
					     %>
							<tr  class="light">
									
								<td align="left" id="level1">								
								<img src="images/arrow.gif">&nbsp;
								<img src="images/ThemeOffice/<%= dt.Rows[i]["C_Icon"].ToString() %>">&nbsp;
								<%= dt.Rows[i]["C_Name"].ToString() %></td>
								<td align="left" id="level1"><%= dt.Rows[i]["C_Url"].ToString() %></td>	
								<td align="center" id="level1">
								<% if ((int)dt.Rows[i]["C_Lock"]==1)
                                    {
                                %>                                        
                                        <img src="images/tick.png" />                                        
                                <% 
                                    }
                                %>
								</td>
								<td align="center" id="level1">
								<% if ((int)dt.Rows[i]["C_Edit"]==1)
                                    {
                                %>                                        
                                        <img src="images/tick.png" />                                        
                                <% 
                                    }
                                %>
								</td>
								<td align="center" id="level1">
								<% if ((int)dt.Rows[i]["C_Del"]==1)
                                    {
                                %>                                        
                                        <img src="images/tick.png" />                                        
                                <% 
                                    }
                                %>
								</td>							
								<td align="center" id="level1">
								<% if ((int)dt.Rows[i]["C_Lock"]==1)
                                    {
                                %>                                        
                                        <img src="images/tick.png" />                                        
                                <% 
                                    }
                                %>
								</td>								
								<td align="center" id="level1">
								<% if (clsSwap.getMaxRankRecord("tbl_menu", "FK_ParentID = 0 and FK_LangID =" + lang.getLangID()) > (int)dt.Rows[i]["C_Rank"])
                                    {
                                %>
                                    <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=up&id=" + dt.Rows[i]["PK_MenuID"].ToString() + "'>"); %>
								    <img src="images/arrow-up.gif"  onmouseover="Tip('Di chuyển lên')" border="0">
								    <%= "</a>" %>
		                        <%
                                    }		                         
                                %>
								<% if (clsSwap.getMinRankRecord("tbl_menu", "FK_ParentID = 0 and FK_LangID =" + lang.getLangID()) < (int)dt.Rows[i]["C_Rank"])
                                    {
                                %>
								    <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=down&id=" + dt.Rows[i]["PK_MenuID"].ToString() + "'>"); %>
								    <img src="images/arrow-down.gif"  onmouseover="Tip('Di chuyển xuống')" border="0">
								    <%= "</a>"%>
		                        <% } %>
								</td>
								<td align="center" id="level1">
								<% if ((int)dt.Rows[i]["C_Active"] == 0)
                                   {
                                %>
								    <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=unlock&id=" + dt.Rows[i]["PK_MenuID"].ToString() + "'>"); %>
								    <img src="images/icons/lock.gif" onmouseover="Tip('Khóa bản ghi')" border="0" >&nbsp;
								    <%= "</a>"%>
		                        <%
                                    }
                                    else
                                    {		                         
                                %>
                                <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=lock&id=" + dt.Rows[i]["PK_MenuID"].ToString() + "'>"); %>
								    <img src="images/icons/unlock.gif" onmouseover="Tip('Mở khóa bản ghi')" border="0">&nbsp;
								    <%= "</a>"%>
								<% } %>
								<% Response.Write("<a href='Default.aspx?page=add_edit_menu&mod=menu&do=edit&id=" + dt.Rows[i]["PK_MenuID"].ToString() + "'>"); %>
								    <img src="images/icons/edit.gif" onmouseover="Tip('Sửa bản ghi')" border="0">&nbsp;
								    <%= "</a>"%>
								
								<% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=delete&id=" + dt.Rows[i]["PK_MenuID"].ToString() + "' onclick=\"return confirm('Bạn muốn xóa bản ghi này?');\">"); %>								   
								    <img src="images/icons/delete.gif" onmouseover="Tip('Xóa bản ghi')" border="0">
								    <%= "</a>"%>	
								     							
								</td>	
							</tr>
					         <%      
                                //Hien thi danh muc con  
                                string strSqlSub = "select * from tbl_menu where FK_ParentID = " + dt.Rows[i]["PK_MenuID"].ToString() +" AND FK_LangID = " + lang.getLangID() + " order by C_Rank desc";
                                dtSub = clsDatabase.getDataTable(strSqlSub);
                                if (dtSub.Rows.Count > 0)
                                {
                                    for (int j = 0; j < dtSub.Rows.Count; j++)
                                    {
                                         %>
                                                <tr class="light">
									
								                    <td align="left" id="Td8">								
								                    <img src="images/dot12.gif">&nbsp;
								                    
								                    <% if (clsSwap.getMaxRankRecord("tbl_menu", "FK_ParentID =  " + dt.Rows[i]["PK_MenuID"].ToString() + "  and FK_LangID =" + lang.getLangID()) > (int)dtSub.Rows[j]["C_Rank"])
                                                        {
                                                    %>
                                                        <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=up&id=" + dtSub.Rows[j]["PK_MenuID"].ToString() + "'>"); %>
								                        <img src="images/arrow-up.gif"  onmouseover="Tip('Di chuyển lên')" border="0">
								                        <%= "</a>" %>
		                                            <%
                                                        }		                         
                                                    %>
								                    <% if (clsSwap.getMinRankRecord("tbl_menu", "FK_ParentID =  " + dt.Rows[i]["PK_MenuID"].ToString() + "  and FK_LangID =" + lang.getLangID()) < (int)dtSub.Rows[j]["C_Rank"])
                                                        {
                                                    %>
								                        <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=down&id=" + dtSub.Rows[j]["PK_MenuID"].ToString() + "'>"); %>
								                        <img src="images/arrow-down.gif"  onmouseover="Tip('Di chuyển xuống')" border="0">
								                        <%= "</a>"%>
		                                            <% } %>
								                    <img src="images/ThemeOffice/<%= dtSub.Rows[j]["C_Icon"].ToString() %>">&nbsp;
								                    <%= dtSub.Rows[j]["C_Name"].ToString()%></td>
								                    <td align="left" id="Td9"><%= dtSub.Rows[j]["C_Url"].ToString()%></td>	
								                    <td align="center" id="Td10">
								                    <% if ((int)dtSub.Rows[j]["C_Lock"] == 1)
                                                        {
                                                    %>                                        
                                                            <img src="images/tick.png" />                                        
                                                    <% 
                                                        }
                                                    %>
								                    </td>
								                    <td align="center" id="Td11">
								                    <% if ((int)dtSub.Rows[j]["C_Edit"] == 1)
                                                        {
                                                    %>                                        
                                                            <img src="images/tick.png" />                                        
                                                    <% 
                                                        }
                                                    %>
								                    </td>
								                    <td align="center" id="Td12">
								                    <% if ((int)dtSub.Rows[j]["C_Del"] == 1)
                                                        {
                                                    %>                                        
                                                            <img src="images/tick.png" />                                        
                                                    <% 
                                                        }
                                                    %>
								                    </td>							
								                    <td align="center" id="Td13">
								                    <% if ((int)dtSub.Rows[j]["C_Lock"] == 1)
                                                        {
                                                    %>                                        
                                                            <img src="images/tick.png" />                                        
                                                    <% 
                                                        }
                                                    %>
								                    </td>								
								                    <td align="center" id="Td14">
								                    
								                    </td>
								                    <td align="center" id="Td15">
								                    <% if ((int)dtSub.Rows[j]["C_Active"] == 0)
                                                       {
                                                    %>
								                        <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=unlock&id=" + dtSub.Rows[j]["PK_MenuID"].ToString() + "'>"); %>
								                        <img src="images/icons/lock.gif" onmouseover="Tip('Khóa bản ghi')" border="0" >&nbsp;
								                        <%= "</a>"%>
		                                            <%
                                                        }
                                                        else
                                                        {		                         
                                                    %>
                                                    <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=lock&id=" + dtSub.Rows[j]["PK_MenuID"].ToString() + "'>"); %>
								                        <img src="images/icons/unlock.gif" onmouseover="Tip('Mở khóa bản ghi')" border="0">&nbsp;
								                        <%= "</a>"%>
								                    <% } %>
								                    <% Response.Write("<a href='Default.aspx?page=add_edit_menu&mod=menu&do=edit&id=" + dtSub.Rows[j]["PK_MenuID"].ToString() + "'>"); %>
								                    <img src="images/icons/edit.gif" onmouseover="Tip('Sửa bản ghi')" border="0">&nbsp;
								                    <%= "</a>"%>
                    								
								                    <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=delete&id=" + dtSub.Rows[j]["PK_MenuID"].ToString() + "' onclick=\"return confirm('Bạn muốn xóa bản ghi này?');\">"); %>								   
								                        <img src="images/icons/delete.gif" onmouseover="Tip('Xóa bản ghi')" border="0">
								                        <%= "</a>"%>	
                    								     							
								                    </td>	
							                    </tr>
                                         <%
                                    }
                                }
                             %>
                    <%   
                            //Ket thuc vong for                                              
                            }
                        //Ket thuc if
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
			</td>
		</tr>
	</tbody>		
</table>