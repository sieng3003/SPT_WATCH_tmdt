<%@ Page Language="C#" AutoEventWireup="true" CodeFile="contact.aspx.cs" Inherits="contact" %>
<%@ Register Assembly="NatsNet.Web.UI.Controls" Namespace="NatsNet.Web.UI.Controls"  TagPrefix="cc1" %>
<%@Import Namespace = "System.Data" %>
<script>


function ValidateEmailAddress(str) {

		var at="@"
		var dot="."
		var lat=str.indexOf(at)
		var lstr=str.length
		var ldot=str.indexOf(dot)
		if (str.indexOf(at)==-1){
		   alert("Invalid E-mail address")
		   return false
		}

		if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
		   alert("Invalid E-mail address")
		   return false
		}

		if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
		    alert("Invalid E-mail address")
		    return false
		}

		 if (str.indexOf(at,(lat+1))!=-1){
		    alert("Invalid E-mail address")
		    return false
		 }

		 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
		    alert("Invalid E-mail address")
		    return false
		 }

		 if (str.indexOf(dot,(lat+2))==-1){
		    alert("Invalid E-mail address")
		    return false
		 }
		
		 if (str.indexOf(" ")!=-1){
		    alert("Invalid E-mail address")
		    return false
		 }
 		 return true					
	}

function checkFormReg()
{
    if(document.frmContact.txtHoten.value == "")
    {
        alert("<%= lang.setLangValue("Please input your fullname","Bạn hãy nhập vào họ tên") %>");
        document.frmContact.txtHoten.focus();
        return false;
    }
    /*
    if(document.frmContact.txtPhone.value == "")
    {
        alert("Bạn hãy nhập vào điện thoại");
        document.frmContact.txtPhone.focus();
        return false;
    }
    */
    if(document.frmContact.txtEmail.value == "")
    {
        alert("<%= lang.setLangValue("Please input your email","Bạn hãy nhập vào email") %>");
        document.frmContact.txtEmail.focus();
        return false;
    }
    
    if(ValidateEmailAddress(document.frmContact.txtEmail.value) == false)
        return false;
    /*
    if(document.frmContact.txtAddress.value == "")
    {
        alert("Bạn hãy nhập vào địa chỉ");
        document.frmContact.txtAddress.focus();
        return false;
    }
    */
    if(document.frmContact.txtContent.value == "")
    {
        alert("<%= lang.setLangValue("Please input your content","Bạn hãy nhập vào nội dung") %>");
        document.frmContact.txtContent.focus();
        return false;
    }
    if(document.frmContact.txtImgVerifyCode.value == "")
    {
        alert("<%= lang.setLangValue("Please input your captcha","Bạn hãy nhập vào mã xác thực") %>");
        document.frmContact.txtImgVerifyCode.focus();
        return false;
    }
    return true;
}
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>HOANGLONGCO</title>
<link href="<%= clsConfig.GetHostUrl() %>/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript" src="<%= clsConfig.GetHostUrl() %>/js/dropdowncontent.js"></script>
</head>
<body>
<form method="post" id="frmContact" runat="server">
<div class="site">
  <div class="container">
    
    
   <asp:PlaceHolder ID="inc_header" runat="server"></asp:PlaceHolder>
    
    <div class="midle">
    <div class="guide">
       	  <a href="#" class="norB"><%= lang.setLangValue("Home","Trang chủ") %> &raquo;</a> <a href="#"><%= lang.setLangValue("Contact us","Liên hệ") %></a></div>
          <div class="contact">
          <%
            if(lang.getLangID() == 1) {
           %>
           <img src="<%= clsConfig.GetHostUrl() %>/images/map.png" width="450" />
           <% } else { %>
           <img src="<%= clsConfig.GetHostUrl() %>/images/map_eng.png" width="450" />
           <% } %>
         <%
             DataTable dt = clsDatabase.getDataTable("select Contact from tbl_siteinfo where FK_LangID=" + lang.getLangID());
                if (dt.Rows.Count > 0)
                    Response.Write(clsInput.decodeStr(dt.Rows[0]["Contact"].ToString()));
                 %>
        
        <asp:Label ID="block_error" runat="server"></asp:Label>                 
<div class="formcontact fl">
  	<ul>
    	<li class="l1"><%= lang.setLangValue("Full Name","Họ tên") %></li>
        <li class="l2"><asp:TextBox ID="txtHoten" runat="server" Width="100%"></asp:TextBox></li>
        <li class="l1"><%= lang.setLangValue("Phone","Điện thoại") %></li>
        <li class="l2"><asp:TextBox ID="txtPhone" runat="server" Width="100%"></asp:TextBox></li>
        <li class="l1"><%= lang.setLangValue("Email","Email") %></li>
        <li class="l2"><asp:TextBox ID="txtEmail" runat="server" Width="100%"></asp:TextBox></li>
        <li class="l1"><%= lang.setLangValue("Address","Địa chỉ") %></li>
        <li class="l2"><asp:TextBox ID="txtAddress" runat="server" Width="100%"></asp:TextBox></li>
         <li class="l1"><%= lang.setLangValue("Content","Nội dung") %></li>
        <li class="l2"><asp:TextBox ID="txtContent" TextMode="MultiLine" runat="server" Height="200" Width="100%"></asp:TextBox></li>
        <!--<li class="l1"><%= lang.setLangValue("Captcha code", "Mã xác thực")%></li>
        <li class="l2"><cc1:imageverifier id="ImageVerifier1" runat="server"></cc1:imageverifier></li>
        <li class="l1"><%= lang.setLangValue("Input your captcha code","Nhập mã trên") %></li>
        <li class="l2"><asp:TextBox ID="txtImgVerifyCode" name="txtImgVerifyCode" runat="server" Width="160px"></asp:TextBox></li>-->
         <li class="l1">&nbsp;</li>
        <li class="l2"><a href="#" runat="server" onclick="return checkFormReg();" onserverclick="btnSubmit_Click" class="btn">Gửi</a> <a href="<%= clsConfig.GetHostUrl() %>/contact.aspx" class="btn">Xoá</a></li>
    </ul>
    
     
  </div>
  <div style="clear:both"></div>
  
   		 </div>
          <!-- end contact-->
    </div>
    <!-- end midle-->
    <div style="clear:both"></div>
  </div>
  <!-- end container-->
  <div class="bottom">
    <asp:PlaceHolder ID="inc_footer" runat="server"></asp:PlaceHolder>
  </div>
</div>
</form>
</body>
</html>
