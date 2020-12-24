<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_user_permission.ascx.cs" Inherits="admincp_modules_mod_permission_mod_user_permission" %>
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
        field.action = "Default.aspx?page=user_permission&mod=permission&do=" + strAction + "&id=" + intID;
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
					
					</td>
					<td width="95%"><span class="title">
					Phân quyền chức năng theo người dùng
					</span></td>
				</tr>    		
			</table>
				<table class="content">
					<tr>
						<td>
						<table class="header" cellpadding="0" cellspacing="0">
							<tr>
								<th>
								Phân quyền người dùng cho nhóm quyền: 
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
								<th  width="30%" >Nick Name</th>	
								<th  width="30%" >Tên người dùng</th>								
								<th  width="38%" >Email</th>
							</tr> 			
							<!-- BEGIN block_row -->
					<%	                      
			            string strSql = "select * from tbl_user where C_Permission <> "+ clsConfig.intAdminPermission +" order by C_Rank desc";					    		    
			            //===================================		    
                        //check supper admin                    
					    if (clsConfig.isSupperAdmin())
                            strSql = "select * from tbl_user order by C_Rank desc";
                        //===================================                    
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
                                boolChecked = clsFunction.checkUserPermissionRecord(intID, Convert.ToInt32(dt.Rows[i]["PK_UserID"]));
                                if (boolChecked == true)
                                    strChecked = " checked ";
					     %>
							<tr onmouseover="change_color(this,4)" onmouseout="delete_color(this,4)">
								<td align="center" id="level2">
								<% Response.Write("<input name=\"row[]\" type=\"checkbox\" " + strChecked + " class=\"input_checkbox\" id=\"row[]\" value=\"" + dt.Rows[i]["PK_UserID"].ToString() + "\" />"); %>								
								</td>	
								<td align="left" id="level3" >								
								<img src="images/arrow.gif">&nbsp;<%= dt.Rows[i]["C_UserName"].ToString() %></td>
								<td align="left" id="level3"><%= dt.Rows[i]["C_FullName"].ToString() %></td>	
								<td align="left" id="level3"><%= dt.Rows[i]["C_Email"].ToString() %></td>	
							</tr>
					         
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
                            <input type="submit" class="button" id="BtnSubmit" onclick="return checkPermissionForm(document.getElementById('activeForm'),'user_permission',<%= Request.QueryString["id"] %>);" value="Phân quyền" >			                               
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