<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs"  EnableEventValidation = "false" Inherits="adminSongda_Default" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  >
<head runat="server">
    <title>Trang Quản trị thông tin</title>
    <link href="css/theme.css" type=text/css rel=stylesheet>
	<link href="css/tabpane.css" type=text/css rel=stylesheet>	
    <LINK href="css/style.css" type=text/css rel=stylesheet>
    
	<SCRIPT language=JavaScript 		src="js/xmlhttp.js" type=text/javascript></SCRIPT>		
	<script language="JavaScript" 	src="js/other.js" type='text/javascript'></script>	
	<script type="text/javascript" src="js/transmenu_Packed.js"></script>
	
</head>
<body topmargin="0" leftmargin="0">
<script type="text/javascript" src="js/wz_tooltip.js"></script>


<link rel="stylesheet" href="css/maroon.css" />
<script type="text/javascript" src="js/zapatec.js"></script>
<script type="text/javascript" src="js/calendar.js"></script>
<script type="text/javascript" src="js/calendar-en.js"></script>
<!-- Loading page -->
<div style="visibility: hidden;" id="loading_page">
<table width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td width="50%" align="center">
	<div class="page_transfer">

	Đang cập nhật dữ liệu
	<br /><br /><img src="images/loading.gif">
	<br /><br />(Xin chờ trong giây lát !)
	</div>
    </td>

  </tr>
</table>

	
</div>
<!-- End loading page -->

<!-- top --><form id="activeForm" runat="server" enctype="multipart/form-data" name="activeForm">




    
    <table class="center" cellpadding="0" cellspacing="0" width="1000">
    <tr>
        <td>
        <asp:PlaceHolder ID="inc_top" runat="server"></asp:PlaceHolder>
        </td>
    </tr>
    <tr><td valign="top">
			<asp:PlaceHolder ID="inc_content" runat="server"></asp:PlaceHolder>
	</td></tr></table>
    <!-- main -->
   
    	

    </form>
    <!-- footer -->
</body>



</html>
