<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_msg.ascx.cs" Inherits="admincp_modules_mod_msg_mod_msg" %>
<asp:Label ID="lblUrl" runat="server"></asp:Label>
<table align="center" class="content" style="width:400px">
  <tr><td>
 	<table class="header" cellpadding="0" cellspacing="0">
    	<tr>
        	<th>Thông báo</th>
      	</tr>	
	</table>
	<table class="report" width="391">
		<tr>
			<td width="50" align="center" valign="baseline">
			<img border="0" src="images/loading.gif" align="right" ></td>
			<td width="300" valign="top" align="justify"><font color="#000080">Đang thực hiện chức năng, bạn hãy đợi trong giây lát. Click vào link dưới nếu bạn không muốn đợi lâu</font></td>
		</tr>
		<tr>
			<td colspan="2" align="center" valign="baseline"><img border="0" src="images/next1.png">&nbsp;<b><asp:Label ID="lblUrlNext" runat="server"></asp:Label></b></td>
		</tr>
	</table>
</td></tr></table>