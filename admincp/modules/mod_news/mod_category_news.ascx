<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_category_news.ascx.cs" Inherits="admincp_modules_mod_news_mod_category_news" %>
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
					<%= clsHtml.add(2, "Default.aspx?page=add_edit_category_news&mod=news&do=add")%>
					</td>
					<td width="95%"><span class="title">Quản lý danh mục hệ thống</span></td>
				</tr>    		
			</table>
				<table class="content">
					<tr>
						<td>
						<table class="header" cellpadding="0" cellspacing="0">
							<tr>
								<th>Danh mục tin tức</th>
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
								<th  width="70%" >Tên danh mục</th>	
								<th  width="6%" >Menu ngang</th>
								<th  width="6%" >Granite</th>
								<th  width="6%" >Product</th>			
								
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
                        string strSqlCount = "select count(*) from tbl_category_news where FK_ParentID = 0 AND FK_LangID = " + lang.getLangID();
                        int intTotalPage = clsPaging.getTotalPage(strSqlCount, intPageSize);
                        string strParamPage = "page=" + Request.QueryString["page"] + "&mod=" + Request.QueryString["mod"];		    			            		    		    		    
                        //========================================		    		                             	    	               			        		    
                        string strSql = "select * from tbl_category_news where FK_ParentID = 0 AND FK_LangID = " + lang.getLangID() + " order by C_Rank desc";
                        DataTable dt;
                        dt = clsDatabase.getDataTable(strSql,intStartRecord,intPageSize);
                        if (dt.Rows.Count > 0)
                        {
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {

                                string strEdit = clsHtml.edit(2, "Default.aspx?page=add_edit_category_news&mod=news&do=edit&id=" + dt.Rows[i]["PK_CategoryID"].ToString());
                                string strDelete = clsHtml.del(2, clsConfig.getCurrentUrl() + "&do=delete&id=" + dt.Rows[i]["PK_CategoryID"].ToString());
                                string tsssss = "";	    				    				    				    
					     %>
							<tr class="light" >								
								<td align="left">								
								<img src="images/arrow.gif">
								
								&nbsp;
								<%= dt.Rows[i]["C_Name"].ToString() %>
								</td>
								<td align="center" >
								<% if ((int)dt.Rows[i]["C_MenuNgang"] == 1)
                                    {
                                %>                                        
                                        <img src="images/tick.png" />                                        
                                <% 
                                    }
                                %>
								</td>								
								
								
								<td align="center" >
								<% if ((int)dt.Rows[i]["C_Granite"] == 1)
                                    {
                                %>                                        
                                        <img src="images/tick.png" />                                        
                                <% 
                                    }
                                %>
								</td>
								<td align="center" >
								<% if ((int)dt.Rows[i]["C_Product"] == 1)
                                    {
                                %>                                        
                                        <img src="images/tick.png" />                                        
                                <% 
                                    }
                                %>
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
								<%= clsHtml.edit(2, "Default.aspx?page=add_edit_category_news&mod=news&do=edit&id=" + dt.Rows[i]["PK_CategoryID"].ToString())%> 
								&nbsp;								
								<%= clsHtml.del(2, clsConfig.getCurrentUrl() + "&do=delete&id=" + dt.Rows[i]["PK_CategoryID"].ToString())%>	
										
                                	
                              


								</td>  	
							</tr>
							
							
							
					                    <%	
                                    string strSqlSub = "select * from tbl_category_news where FK_ParentID = "+ dt.Rows[i]["PK_CategoryID"].ToString() +" AND FK_LangID = " + lang.getLangID() + " order by C_Rank desc";
                                    DataTable dtSub;
                                    dtSub = clsDatabase.getDataTable(strSqlSub);
                                    if (dtSub.Rows.Count > 0)
                                    {
                                        for (int j = 0; j < dtSub.Rows.Count; j++)
                                        {	    				    				    				    
			                         %>
					                    <tr class="light" >								
						                    <td align="left">								
						                    <img src="images/dot12.gif">
            								<% if (clsSwap.getMaxRankRecord("tbl_category_news", "FK_ParentID = " + dt.Rows[i]["PK_CategoryID"].ToString() + " and FK_LangID =" + lang.getLangID()) > (int)dtSub.Rows[j]["C_Rank"])
                                                {
                                            %>
                                                <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=up&id=" + dtSub.Rows[j]["PK_CategoryID"].ToString() + "&parentid=" + dt.Rows[i]["PK_CategoryID"].ToString() + "'>"); %>
						                        <img src="images/arrow-up.gif"  onmouseover="Tip('Di chuyển lên')" border="0">
						                        <%= "</a>" %>
                                            <%
                                                }		                         
                                            %>
						                    <% if (clsSwap.getMinRankRecord("tbl_category_news", "FK_ParentID = " + dt.Rows[i]["PK_CategoryID"].ToString() + " and FK_LangID =" + lang.getLangID()) < (int)dtSub.Rows[j]["C_Rank"])
                                                {
                                            %>
						                        <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=down&id=" + dtSub.Rows[j]["PK_CategoryID"].ToString() + "&parentid=" + dt.Rows[i]["PK_CategoryID"].ToString() + "'>"); %>
						                        <img src="images/arrow-down.gif"  onmouseover="Tip('Di chuyển xuống')" border="0">
						                        <%= "</a>"%>
                                            <% } %>
						                    &nbsp;
						                    <%= dtSub.Rows[j]["C_Name"].ToString()%>
						                    </td>
						                    <td align="center" >
								            <% if ((int)dtSub.Rows[j]["C_MenuNgang"] == 1)
                                                {
                                            %>                                        
                                                    <img src="images/tick.png" />                                        
                                            <% 
                                                }
                                            %>
								            </td>								
						                   
						                    
						                    <td align="center" >
						                    <% if ((int)dtSub.Rows[j]["C_Granite"] == 1)
                                                {
                                            %>                                        
                                                    <img src="images/tick.png" />                                        
                                            <% 
                                                }
                                            %>
						                    </td>
						                    <td align="center" >
						                    <% if ((int)dtSub.Rows[j]["C_Product"] == 1)
                                                {
                                            %>                                        
                                                    <img src="images/tick.png" />                                        
                                            <% 
                                                }
                                            %>
						                    </td>								
						                   
						                    <td align="center">
						                    <% if ((int)dtSub.Rows[j]["C_Active"] == 0)
                                               {
                                            %>
						                       <%= clsHtml.UnLock(2, clsConfig.getCurrentUrl() + "&do=unlock&id=" + dtSub.Rows[j]["PK_CategoryID"].ToString())%>
                                            <%
                                                }
                                                else
                                                {		                         
                                            %>
                                            <%= clsHtml.Lock(2, clsConfig.getCurrentUrl() + "&do=lock&id=" + dtSub.Rows[j]["PK_CategoryID"].ToString())%>
						                    <% } %>									
						                    &nbsp;							
						                    <%= clsHtml.edit(2, "Default.aspx?page=add_edit_category_news&mod=news&do=edit&id=" + dtSub.Rows[j]["PK_CategoryID"].ToString())%> 
						                    &nbsp;								
						                    <%= clsHtml.del(2, clsConfig.getCurrentUrl() + "&do=delete&id=" + dtSub.Rows[j]["PK_CategoryID"].ToString())%>	
            								     							
						                    </td>	
					                    </tr>
					                    
					                    
					                    
					                    
					                                           
					                    
					                    
					                    
					                    
			                    <%                                                               
                                        }
                                    }
                    			        
                             %>
							
							
							
							
							
							
							
							
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