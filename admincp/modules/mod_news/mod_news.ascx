<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_news.ascx.cs" Inherits="admincp_modules_mod_news_mod_news" %>

<%@Import Namespace = "System.Data" %>

<script type="text/javascript">
function checkSubmitActiveInactiveForm(field, strAction)
{
    var obj=document.getElementsByName("row[]");
    var strListArr = '0,';
	var isChecked=false;
	for(i=0;i<obj.length;i++)	
		if(obj[i].checked)
		{
			isChecked=true;	
			strListArr = strListArr + obj[i].value + ',';		
		}	
		
	strListArr = strListArr + '0';
		
	if(!isChecked)
	{
		alert('Ban chua chon ban ghi de thuc hien tac vu');
		return false;
	}
	else
	{
	    if(confirm ('Ban da chac chan thuc hien tac vu nay chua?'))
	    {	    
	        field.listArrRecord.value=strListArr;
	        field.action = "Default.aspx?page=news&mod=news&do=" + strAction;
		    field.submit();
		    return true;
		}
		else
		    return false;
	}
	return false;
}

function checkFormSearch(field)
{
/*
    if(field.key.value =='')
    {
        alert('Ban hay nhap vao thong tin tim kiem');
        field.key.focus();
        return false;
    }
    */
    field.action="Default.aspx?page=news&mod=news&do=search&key="+field.key.value+"&cat="+field.ctl03$cat.value+"&per="+field.per.value;
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
					<td width="95%"><span class="title">Quản lý tin tức</span></td>
				</tr>    		
			</table>
				<table class="content">
					<tr>
						<td>
						<table class="header" cellpadding="0" cellspacing="0">
							<tr>
								<th>Danh sách các bài viết</th>
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
												Tên :&nbsp;<input type="text" name="key" style="width:200px" />&nbsp;	
												Thuộc danh mục											
												&nbsp;<select name="cat" id="cat" runat="server"></select>&nbsp;
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
												<input type="submit" value="Search" class="button" onmouseover="Tip('Tìm kiếm thông tin')" onclick="return checkFormSearch(document.getElementById('activeForm'));" />
												<input type="reset" value="Reset" class="button" onmouseover="Tip('Gõ lại thông tin tìm kiếm')" />
											</th>
										</tr>
									</table>
								</td>
								<td align="right" width="20%" valign="bottom">
								<%= clsHtml.add(2, "Default.aspx?page=add_edit_news&mod=news&do=add")%>									
								</td>
							</tr>
						</table>
						</div>
						<table class="table" cellSpacing="1" cellPadding="1">		
							<tr>
								<th  width="2%" >
								<input onmouseover="Tip('Select/Deselect All')" class="input_checkbox" onclick="checkAll(document.getElementById('activeForm'));" type="checkbox" value="Check All" name="allbox" />
								</th>
								<th  width="55%" >Tiêu đề</th>									
								<th  width="20%" >Thuộc danh mục</th>
																
								<th  width="5%" >Hot</th>										
								<th  width="6%" >Sắp xếp</th>
								<th  width="12%" >Quản trị</th>
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
			            //check search
			            string strSearchCat = "";					    		    
                        int intCat = clsInput.getNumericInput("cat", 0);
                        if (intCat != 0)
                            strSearchCat = " and (tbl_category_news.PK_CategoryID = " + intCat + " or tbl_category_news.FK_ParentID = " + intCat + ")";
                		    		    
                        string strKey = clsInput.getStringInput("key", 0);
                        string strSearch = "";
                        if (strKey != null)
                            strSearch = " and (tbl_news.C_Name like '%" + strKey + "%' or tbl_news.C_Des like '%" + strKey + "%' or tbl_news.C_Content like '%" + strKey + "%' )";                        		    
                        //------------------------------ 		    
                        string strSqlCount = "select count(*) from tbl_news inner join tbl_category_news on tbl_news.FK_CategoryID = tbl_category_news.PK_CategoryID where tbl_news.FK_LangID = " + lang.getLangID() + strSearch + strSearchCat;
                        int intTotalPage = clsPaging.getTotalPage(strSqlCount, intPageSize);
                        string strParamPage = "page=" + Request.QueryString["page"] + "&mod=" + Request.QueryString["mod"] + "&key=" + strKey + "&cat=" + intCat + "&per="+intPer.ToString();		    			            		    		    		    
                        //========================================		    		                             	    	               			        		    
                        string strSql = "select tbl_news.*, tbl_category_news.C_Name as CategoryName from tbl_news inner join tbl_category_news on tbl_news.FK_CategoryID = tbl_category_news.PK_CategoryID where tbl_news.FK_LangID = " + lang.getLangID() + strSearch + strSearchCat + " order by tbl_news.C_Rank desc";
                        DataTable dt;
                        dt = clsDatabase.getDataTable(strSql,intStartRecord,intPageSize);
                        if (dt.Rows.Count > 0)
                        {
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {
                                DataTable dsGrandFather = clsDatabase.getDataTable("Select * from tbl_category_news where PK_CategoryID in (Select FK_ParentID from tbl_category_news where PK_CategoryID=" + dt.Rows[i]["FK_CategoryID"].ToString()+")");
                                string grandFatherName = "";
                                if (dsGrandFather.Rows.Count > 0) grandFatherName = dsGrandFather.Rows[0]["C_Name"].ToString();			    				    				    
					     %>
							<tr class="light">
								<td align="center">
								<% Response.Write("<input name=\"row[]\" type=\"checkbox\" class=\"input_checkbox\" id=\"row[]\" value=\"" + dt.Rows[i]["PK_NewsID"].ToString() + "\" />"); %>								
								</td>
								<td align="left">								
								<img src="images/arrow.gif">								
								&nbsp;
								<%= dt.Rows[i]["C_Name"].ToString() %>
								</td>								
								<td align="left">														
								&nbsp;
								<%=grandFatherName%> - <%= dt.Rows[i]["CategoryName"].ToString()%>
								</td>
								
																
								<td align="center" >														
								&nbsp;
								<% if ((int)dt.Rows[i]["C_Hot"]==1)
                                    {
                                %>                                        
                                        <img src="images/tick.png" />                                        
                                <% 
                                    }
                                %>
								</td>		
											
								<td align="center">
								<% if (clsSwap.getMaxRankRecord("tbl_news  inner join tbl_category_news on tbl_news.FK_CategoryID = tbl_category_news.PK_CategoryID", "tbl_news", "tbl_news.FK_LangID =" + lang.getLangID()) > (int)dt.Rows[i]["C_Rank"])
                                    {
                                %>
                                    <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=up&id=" + dt.Rows[i]["PK_NewsID"].ToString() + "'>"); %>
								    <img src="images/arrow-up.gif"  onmouseover="Tip('Di chuyển lên')" border="0">
								    <%= "</a>" %>
		                        <%
                                    }		                         
                                %>
								<% if (clsSwap.getMinRankRecord("tbl_news  inner join tbl_category_news on tbl_news.FK_CategoryID = tbl_category_news.PK_CategoryID", "tbl_news", "tbl_news.FK_LangID =" + lang.getLangID()) < (int)dt.Rows[i]["C_Rank"])
                                    {
                                %>
								    <% Response.Write("<a href='" + clsConfig.getCurrentUrl() + "&do=down&id=" + dt.Rows[i]["PK_NewsID"].ToString() + "'>"); %>
								    <img src="images/arrow-down.gif"  onmouseover="Tip('Di chuyển xuống')" border="0">
								    <%= "</a>"%>
		                        <% } %>
								</td>
								<td align="center">
								<%
                                    string strS = "";
                                    if (intCat > 0)
                                        strS += "&cat="+intCat;
                                    if (strKey != "")
                                        strS += "&key="+strKey;
								 %>
								<% if ((int)dt.Rows[i]["C_Active"] == 0)
                                   {
                                %>
								   <%= clsHtml.UnLock(2, clsConfig.getCurrentUrl() + "&do=unlock&id=" + dt.Rows[i]["PK_NewsID"].ToString() + strS)%>
		                        <%
                                    }
                                    else
                                    {		                         
                                %>
                                <%= clsHtml.Lock(2, clsConfig.getCurrentUrl() + "&do=lock&id=" + dt.Rows[i]["PK_NewsID"].ToString() + strS)%>
								<% } %>									
								&nbsp;							
								<%= clsHtml.edit(2, "Default.aspx?page=add_edit_news&mod=news&do=edit&id=" + dt.Rows[i]["PK_NewsID"].ToString() + strS)%> 
								&nbsp;								
								<%= clsHtml.del(2, clsConfig.getCurrentUrl() + "&do=delete&id=" + dt.Rows[i]["PK_NewsID"].ToString() + strS)%>    							
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