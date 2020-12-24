<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="admincp_login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head >
    <title>Trang quản lý thông tin</title>
    <style>
	
	 H1 { font-size: 14pt; font-family: Arial; font-weight: bold; margin-bottom: 2px; }	
			
	.WindowBackground {
		background-color: #ECE9D8;
		border-color: #999999 #CCCCCC #CCCCCC #999999;
		border-style: solid;
		border-width: 1px;
		padding: 10px;
		}
		
	.WindowText {
		font-family: Trebuchet MS, Arial;
		font-size: 10pt;
		
		}
	
	.InsertCell {  border: 1px #CCCCFF solid;
						width: 100%;
						height: 35px;
					}
		
	
	.LeftStyle { font-family: Arial;
					  font-size: 8pt;
					}
	
	.TableHeader { font-family: Verdana, Tahoma, sans-serif;
						font-size: 10pt;
						background-color: #ECE9D8;
						border-color: #EEEEEE #999999 #999999 #EEEEEE;
						border-style: solid;
						border-width: 1px;
						font-weight: bold;
						
					}
	
	.InputBorder { 
		  font-family: Trebuchet MS, Arial;
		  font-size: 9pt;
		  background-color: #FFFFFF;
		  border: windowframe 1px solid;
		  }		
		
	
	.TableGrid {
			font-family: Verdana, Tahoma, sans-serif;
			font-size: 9pt;
			background-color: window;
			color: windowtext;
			border-right: threedlightshadow 1px solid;
			border-bottom: threedlightshadow 1px solid;
			color: #666666;
			padding-left: 3px;
			padding-right: 3px;
		}
	
	.TableInput {
						font-family: Tahoma, Arial, Helvetica, sans-serif;
						font-size: 9pt;
						border: 1px #9999ff solid;
						padding-bottom: 3px;
						padding-left: 3px;
					} 

	.TableInputOff {
						font-family: Tahoma, Arial, Helvetica, sans-serif;
						font-size: 9pt;
						background-color: #eeeeff;
						color: #9999ff;
						border: 1px #9999ff solid;
						padding-bottom: 3px;
						padding-left: 3px;
					}
	
	:link { color: #336699; text-decoration: none; }
	:visited { color: #336699;  text-decoration: none;}
	:Active { color: #FF0000; }
	:Focus { color: #FF0000; }
	:hover { color: #FF0000; 
	
	
	a.ItemLink { color: #999999; }
	a.ItemLink:visited { color: #999999; }
	a.ItemLink:Active { color: #FF0000; }
	a.ItemLink:Focus { color: #FF0000; }
	a.ItemLink:hover { color: #FF0000; }
	
		
</style>
</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
    
    <asp:Label id="LblError" runat="server" CssClass="WindowText" Width="360px" Height="8px" ForeColor="Red"></asp:Label><br />
    <table height="90%" width="100%">
<tbody><tr><td height="35%" valign="top">
	&nbsp;</td></tr>	
<tr><td align="center" valign="top">
	
	<table cellpadding="0" cellspacing="0" width="350"><tbody><tr><td colspan="3">	<table cellpadding="0" cellspacing="0" width="100%">	<tbody><tr><td>		<img src="images/img_login/TitleBar_Left.gif"></td>	<td background="images/img_login/TitleBar_Background.gif">		<img src="images/img_login/icon_ASPEntMan.gif"></td>	<td background="images/img_login/TitleBar_Background.gif" width="100%">		<font style="font-family: Trebuchet MS,Arial; color: rgb(255, 255, 255); font-size: 10pt; font-weight: bold; text-shadow: rgb(51, 51, 51) 1px 1px ;">			&nbsp;Connect to Server		</font>	</td><td background="images/img_login/TitleBar_Background.gif" valign="bottom">	   &nbsp;</td><td background="images/img_login/TitleBar_Background.gif">		&nbsp;&nbsp;&nbsp;&nbsp;	</td><td background="images/img_login/TitleBar_Background.gif">		<a href="javascript:window.close();" onmouseout="document['CloseImage'].src = 'images/windows/TitleBar_CloseButton.gif';" onmouseover="document['CloseImage'].src = 'images/windows/TitleBar_CloseButtonOver.gif';">		<img src="images/img_login/TitleBar_CloseButton.gif" name="CloseImage" border="0"></a></td>	<td>		<img src="images/img_login/TitleBar_Right.gif"></td>	</tr>	</tbody></table></td></tr><tr><td background="images/img_login/border_Left.gif"></td><td class="WindowBackground" width="100%">


		<table class="WindowText" width="100%">
		<tbody>
		<tr><td nowrap="nowrap">
			Username:	
		</td><td>
			<asp:TextBox id="TxtUsername" runat="server" Width="210px"></asp:TextBox>
		</td></tr>
		<tr><td nowrap="nowrap">
			Password:	
		</td><td>
			<asp:TextBox TextMode="Password" id="TxtPassword" runat="server" Width="210px"></asp:TextBox>
		</td></tr>
		<tr><td colspan="2" style="padding-top: 10px;" align="center">
		<asp:Button id="Dangnhap" runat="server" CssClass="ButtonStyle" Text="Đăng nhập" onclick="Dangnhap_Click"></asp:Button>
			
		</td></tr></tbody></table>
		

	</td><td background="images/img_login/border_right.gif"></td></tr><tr><td>	<img src="images/img_login/border_BottomLeft.gif"></td><td background="images/img_login/border_Bottom.gif"></td><td>	<img src="images/img_login/border_BottomRight.gif"></td></tr></tbody></table>

</td></tr>
</tbody></table>
    
    
    </div>
    </form>
</body>
</html>
