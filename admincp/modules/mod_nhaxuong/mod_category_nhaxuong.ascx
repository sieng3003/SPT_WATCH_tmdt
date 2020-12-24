<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_category_nhaxuong.ascx.cs" Inherits="admincp_modules_mod_nhaxuong_mod_category_nhaxuong" %>
<%@Import Namespace = "System.Data" %>
<table bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">
	<tbody>
		<tr>
			<td class="DarkText" style="background-position: center top; background-repeat: repeat-x; background-attachment: scroll;" align="center" background="images/bg_silver.gif" valign="top">
			
			<form method="POST">
			<table class="main" cellpadding="0" cellspacing="0">
			<tr>
				<td>
				<table class="title" cellpadding="3" cellspacing="3">
				<tr>
					<td width="5%">
					<!--
					<img border="0" src="images/icons/laguage.gif" align="bottom" class="icon" onMouseOver="doFade(this,100,30,6)" onMouseOut="doFade(this,50,50,6)" id="icon">
					-->					
					<%= clsHtml.add(2, "Default.aspx?page=add_edit_category_nhaxuong&mod=nhaxuong&do=add")%>
					</td>
					<td width="95%"><span class="title">Quản lý lĩnh vực nhà xưởng</span></td>
				</tr>    		
			</table>
				<table class="content">
					<tr>
						<td>
						<table class="header" cellpadding="0" cellspacing="0">
							<tr>
								<th>Danh mục nhà xưởng</th>
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
								
								</td>
								<td align="right" width="20%" valign="bottom">
									
									
								</td>
							</tr>
						</table>
						</div>
						<table class="table" cellSpacing="1" cellPadding="1">		
							<tr>								
								<th  width="72%" >Tên danh mục</th>	
								<th  width="6%" >Sắp xếp</th>
								<th  width="12%" >Quản trị</th>
							</tr> 			
							<!-- BEGIN block_row -->
					<%	
                        //------------------------------
                        int intCurPage = 0;
                        int intStartRecord = 0;
                        int intPageSize = 20;
                        intCurPage = clsPaging.getCurPage();
                        intStartRecord = clsPaging.getStartRecord(intCurPage, intPageSize);
                                                	
                        //------------------------------ 
                        string strSqlCount = "select count(*) from tbl_category_nhaxuong where FK_LangID = " + lang.getLangID();
                        int intTotalPage = clsPaging.getTotalPage(strSqlCount, intPageSize);
                        string strParamPage = "page=" + Request.QueryString["page"] + "&mod=" + Request.QueryString["mod"];		    			            		    		    		    
                        //========================================		    		                             	    	               			        		    
                        string strSql = "select * from tbl_category_nhaxuong where FK_LangID = " + lang.getLangID() + " order by C_Rank desc";
                        DataTable dt;
                        dt = clsDatabase.getDataTable(strSql,intStartRecord,intPageSize);
                        if (dt.Rows.Count > 0)
                        {
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {	    				    				    				    
					     %>
							<tr class="light" >								
								<td align="left">								
								<img src="images/arrow.gif">
								
								&nbsp;
								<%= dt.Rows[i]["C_Name"].ToString() %>
								</td>
																
														
								<td align="center">
								<% if (clsSwap.getMaxRankRecord("tbl_category_nhaxuong", "FK_LangID =" + lang.getLangID()) > (int)dt.Rows[i]["C_Rank"])
                                    {
                                %>
                                    <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=up&id=" + dt.Rows[i]["PK_CategoryID"].ToString() + "&parentid=0" + "'>"); %>
								    <img src="images/arrow-up.gif"  onmouseover="Tip('Di chuyển lên')" border="0">
								    <%= "</a>" %>
		                        <%
                                    }		                         
                                %>
								<% if (clsSwap.getMinRankRecord("tbl_category_nhaxuong", "FK_LangID =" + lang.getLangID()) < (int)dt.Rows[i]["C_Rank"])
                                    {
                                %>
								    <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=down&id=" + dt.Rows[i]["PK_CategoryID"].ToString() + "&parentid=0" + "'>"); %>
								    <img src="images/arrow-down.gif"  onmouseover="Tip('Di chuyển xuống')" border="0">
								    <%= "</a>"%>
		                        <% } %>
								</td>
								<td align="center">
								
								<% if ((int)dt.Rows[i]["C_Active"] == 0)
                                   {
                                %>
								   <%= clsHtml.UnLock(2, clsConfig.getCurrentUrl() + "&do=unlock&id=" + dt.Rows[i]["PK_CategoryID"].ToString())%>
		                        <%
                                    }
                                    else
                                    {		                         
                                %>
                                <%= clsHtml.Lock(2, clsConfig.getCurrentUrl() + "&do=lock&id=" + dt.Rows[i]["PK_CategoryID"].ToString())%>
								<% } %>									
								&nbsp;							
								<%= clsHtml.edit(2, "Default.aspx?page=add_edit_category_nhaxuong&mod=nhaxuong&do=edit&id=" + dt.Rows[i]["PK_CategoryID"].ToString())%> 
								&nbsp;								
								<%= clsHtml.del(2, clsConfig.getCurrentUrl() + "&do=delete&id=" + dt.Rows[i]["PK_CategoryID"].ToString())%>	
								     							
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