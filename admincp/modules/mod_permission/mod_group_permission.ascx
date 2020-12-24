<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_group_permission.ascx.cs" Inherits="admincp_modules_mod_permission_mod_group_permission" %>
<%@Import Namespace = "System.Data" %>
<script type="text/javascript">
function checkPermissionForm(field, strAction,intID)
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
		
	if(confirm ('Ban da chac chan thuc hien tac vu nay chua?'))
    {	    	        
        field.listArrRecord.value=strListArr;	        
        field.action = "Default.aspx?page=group_permission&mod=permission&do=" + strAction + "&id=" + intID;
	    field.submit();		    
	    return false;
	}
	return false;
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
					<td width="5%">
					<a href="Default.aspx?page=add_edit_menu&mod=menu&do=add">
									<img src="images/icons/add.gif" class="icon" onmouseover="Tip('Thêm bản ghi mới')">
									</a>
					</td>
					<td width="95%"><span class="title">
					Phân quyền chức năng theo nhóm
					</span></td>
				</tr>    		
			</table>
				<table class="content">
					<tr>
						<td>
						<table class="header" cellpadding="0" cellspacing="0">
							<tr>
								<th>
								Phân quyền chức năng hệ thống cho nhóm quyền: 
								<%         
                                    int intID = clsInput.getNumericInput("id", 0);
                                    DataTable dtGroup = clsDatabase.getDataTable("select C_Name from tbl_groupmember where PK_GroupMemberID =" + intID);
                                    Response.Write(dtGroup.Rows[0]["C_Name"].ToString());								    					    					    				                        					    				    
								     %>
								</th>
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
									<a href="#" onclick="window.location.reload();" onmouseover = "Tip('Reload lại trang');"><img src="images/icons/refresh.gif" class="icon" ></a>
								</td>
							</tr>
						</table>
						</div>
						<!--
						<div style="overflow: auto; height: 400px;">
						-->
						<table class="table" cellSpacing="1" cellPadding="1">		
							<tr>
								<th  width="2%" >
								<input onmouseover="Tip('Select/Deselect All')" class="input_checkbox" onclick="checkAll(document.getElementById('activeForm'));" type="checkbox" value="Check All" name="allbox" />
								</th>
								<th  width="30%" >Tên Menu</th>	
								<th  width="68%" >Đường dẫn</th>								
								
							</tr> 			
							<!-- BEGIN block_row -->
					<%	
                        string strSql = "select * from tbl_menu where FK_ParentID = 0 AND FK_LangID = " + lang.getLangID() + " and C_Active=1 order by C_Rank desc";
                        DataTable dt,dtSub;
                        dt = clsDatabase.getDataTable(strSql);
                        bool boolChecked = false;
                        string strChecked = "";		    	    
                        if (dt.Rows.Count > 0)
                        {
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {
                                boolChecked = false;
                                strChecked = "";
                                boolChecked = clsFunction.checkGroupPermissionRecord(intID, Convert.ToInt32(dt.Rows[i]["PK_MenuID"]));
                                if (boolChecked == true)
                                    strChecked = " checked ";
					     %>
							<tr onmouseover="change_color(this,3)" onmouseout="delete_color(this,3)">
								<td align="center" id="level2">
								<% Response.Write("<input name=\"row[]\" type=\"checkbox\" " + strChecked + " class=\"input_checkbox\" id=\"row[]\" value=\"" + dt.Rows[i]["PK_MenuID"].ToString() + "\" />"); %>								
								</td>	
								<td align="left" id="Td1" >								
								<img src="images/arrow.gif">&nbsp;<%= dt.Rows[i]["C_Name"].ToString() %></td>
								<td align="left" id="Td2"><%= dt.Rows[i]["C_Url"].ToString() %></td>	
									
							</tr>
					         <%      
                                //Hien thi danh muc con  
                                string strSqlSub = "select * from tbl_menu where FK_ParentID = " + dt.Rows[i]["PK_MenuID"].ToString() + " AND FK_LangID = " + lang.getLangID() + " and C_Active=1 order by C_Rank desc";
                                dtSub = clsDatabase.getDataTable(strSqlSub);
                                bool boolSubChecked = false;
                                string strSubChecked = "";	
                                if (dtSub.Rows.Count > 0)
                                {
                                    for (int j = 0; j < dtSub.Rows.Count; j++)
                                    {
                                        boolSubChecked = false;
                                        strSubChecked = "";
                                        boolSubChecked = clsFunction.checkGroupPermissionRecord(intID, Convert.ToInt32(dtSub.Rows[j]["PK_MenuID"]));
                                        if (boolSubChecked == true)
                                            strSubChecked = " checked ";
                                         %>
                                                <tr onmouseover="change_color(this,3)" onmouseout="delete_color(this,3)">
									                   <td align="center" id="level3">
								                        <% Response.Write("<input name=\"row[]\" type=\"checkbox\" " + strSubChecked + " class=\"input_checkbox\" id=\"row[]\" value=\"" + dtSub.Rows[j]["PK_MenuID"].ToString() + "\" />"); %>								
								                        </td>
								                    <td align="left" id="Td3">								
								                    <img src="images/dot12.gif">&nbsp;
								                    
								                    
								                    <%= dtSub.Rows[j]["C_Name"].ToString()%></td>
								                    <td align="left" id="Td4" ><%= dtSub.Rows[j]["C_Url"].ToString()%></td>	
								                    
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
			<!--			
			</div>
			-->
			<br>
                    <table class="page">
                        <tr>
	                        <td>	                        
                            <input type="submit" class="button" id="BtnSubmit" onclick="return checkPermissionForm(document.getElementById('activeForm'),'group_permission',<%= Request.QueryString["id"] %>);" value="Phân quyền" >			                               
                        <input type="button" value="Quay lại" onclick="javascript:history.go(-1)" class="button">                            				                                               
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
