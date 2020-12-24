<%@ Page Language="C#" AutoEventWireup="true" CodeFile="edit_tindang.aspx.cs"  EnableEventValidation = "false" Inherits="admincp_edit_tindang" %>
<%@ Register Assembly="NatsNet.Web.UI.Controls" Namespace="NatsNet.Web.UI.Controls"  TagPrefix="cc1" %>
<%@Import Namespace = "System.Data" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Trang Quản trị thông tin</title>
    <link href="css/theme.css" type=text/css rel=stylesheet>
	<link href="css/tabpane.css" type=text/css rel=stylesheet>	
    <LINK href="css/style.css" type=text/css rel=stylesheet>
    
	<SCRIPT language=JavaScript 		src="js/xmlhttp.js" type=text/javascript></SCRIPT>		
	<script language="JavaScript" 	src="js/other.js" type='text/javascript'></script>	
	<script type="text/javascript" src="js/transmenu_Packed.js"></script>
	

<!-- base href="http://nammon.com.vn/" -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../images/main.css" rel="stylesheet" type="text/css" />
<link href="../images/text.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
<script type = "text/javascript">
var pageUrl = '<%=ResolveUrl("~/dangtin.aspx")%>'
function PopulateTinhthanh() {
    $("#<%=drdQuanhuyen.ClientID%>").attr("disabled", "disabled");
    $("#<%=drdTenduan.ClientID%>").attr("disabled", "disabled");
    if ($('#<%=drdTinhthanh.ClientID%>').val() == "0") {
        $('#<%=drdQuanhuyen.ClientID %>').empty().append('<option selected="selected" value="0">Please select</option>');
        $('#<%=drdTenduan.ClientID %>').empty().append('<option selected="selected" value="0">Please select</option>');
    }
    else {
        $('#<%=drdQuanhuyen.ClientID %>').empty().append('<option selected="selected" value="0">Loading...</option>');
        $.ajax({
            type: "POST",
            url: pageUrl + '/PopulateCountries',
            data: '{continentId: ' + $('#<%=drdTinhthanh.ClientID%>').val() + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnCountriesPopulated,
            failure: function(response) {
                alert(response.d);
            }
        });
    }
}

function OnCountriesPopulated(response) {
    PopulateControl(response.d, $("#<%=drdQuanhuyen.ClientID %>"));
}
</script>
<script type = "text/javascript">
function PopulateTenduan() {
    $("#<%=drdTenduan.ClientID%>").attr("disabled", "disabled");
    if ($('#<%=drdQuanhuyen.ClientID%>').val() == "0") {
        $('#<%=drdTenduan.ClientID %>').empty().append('<option selected="selected" value="0">Please select</option>');
    }
    else {
        $('#<%=drdTenduan.ClientID %>').empty().append('<option selected="selected" value="0">Loading...</option>');
        $.ajax({
            type: "POST",
            url: pageUrl + '/PopulateTenduan',
            data: '{countryId: ' + $('#<%=drdQuanhuyen.ClientID%>').val() + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnCitiesPopulated,
            failure: function(response) {
                alert(response.d);
            }
        });
    }
}

function OnCitiesPopulated(response) {
    PopulateControl(response.d, $("#<%=drdTenduan.ClientID %>"));
}
</script>
<script type = "text/javascript">
function PopulateControl(list, control) {
    if (list.length > 0) {
        control.removeAttr("disabled");
        control.empty().append('<option selected="selected" value="0">Please select</option>');
        $.each(list, function() {
            control.append($("<option></option>").val(this['Value']).html(this['Text']));
        });
    }
    else {
        control.empty().append('<option selected="selected" value="0">Not available<option>');
    }
}
</script>


<script type="text/javascript">


function IsNumeric(strString)
   //  check for valid numeric strings	
   {
   var strValidChars = "0123456789.-";
   var strChar;
   var blnResult = true;

   if (strString.length == 0) return false;

   //  test strString consists of valid characters listed above
   for (i = 0; i < strString.length && blnResult == true; i++)
      {
      strChar = strString.charAt(i);
      if (strValidChars.indexOf(strChar) == -1)
         {
         blnResult = false;
         }
      }
   return blnResult;
   }


function changeDuan()
{
    chkDuankhac = document.getElementById("chkDuankhac");
    var el = document.getElementById('divDuankhac');
    var el1 = document.getElementById('divDuan');
   if(chkDuankhac.checked == true)
   {        
        el.style.display = "block";
        el1.style.display = "none";
   }
   else
   {
        el.style.display = "none";
        el1.style.display = "block";
   }
}





function checkFormSubmit()
{
    drdLoaidiaoc = document.getElementById("drdLoaidiaoc").value;
    drdLoaidiaoc1 = document.getElementById("drdLoaidiaoc1").value;
    drdTinhthanh = document.getElementById("drdTinhthanh").value;
    drdQuanhuyen = document.getElementById("drdQuanhuyen").value;
    txtDientichsudung = document.getElementById("txtDientichsudung").value;
    txtGia = document.getElementById("txtGia").value;
    txtDiachi = document.getElementById("txtDiachi").value;
    
    txtTieude = document.getElementById("txtTieude").value;
    txtNoidung = document.getElementById("txtNoidung").value;
    
    txtNguoilienhe = document.getElementById("txtNguoilienhe").value;
    txtDienthoai = document.getElementById("txtDienthoai").value;
    txtDidong = document.getElementById("txtDidong").value;
    txtDiachilienhe = document.getElementById("txtDiachilienhe").value;
    //alert(document.getElementById("drdQuanhuyen").name);
    //alert(drdLoaidiaoc);
     if(drdLoaidiaoc == 0)
    {
        alert('Bạn hãy chọn loại địa ốc');
        document.forms[0].drdLoaidiaoc.focus();
        return false;
    }
   
    if(drdTinhthanh == 0)
    {
        alert('Bạn hãy chọn tỉnh thành');
        document.forms[0].drdTinhthanh.focus();
        return false;
    }
    if(drdQuanhuyen == 0)
    {
        alert('Bạn hãy chọn quận huyện');
        document.forms[0].drdQuanhuyen.focus();
        return false;
    }
    
    if(txtDiachi == 0)
    {
        alert('Bạn hãy chọn địa chỉ');
        document.forms[0].txtDiachi.focus();
        return false;
    }
    
    if(txtGia == 0)
    {
        alert('Bạn hãy nhập vào mức giá');
        document.forms[0].txtGia.focus();
        return false;
    }
    if(!IsNumeric(txtGia))
    {
        alert('Mức giá phải là kiểu số. Ví dụ: \n200 = 200 triệu\n2000 = 2 tỷ');
        document.forms[0].txtGia.focus();
        return false;
    }
    if(txtDientichsudung == 0)
    {
        alert('Bạn hãy nhập vào diện tích sử dụng');
        document.forms[0].txtDientichsudung.focus();
        return false;
    }
    
    if(txtTieude == "")
    {
        alert('Bạn hãy nhập vào tiêu đề tin đăng');
        document.forms[0].txtTieude.focus();
        return false;
    }
    
    if(txtNoidung == "")
    {
        alert('Bạn hãy nhập vào nội dung');
        document.forms[0].txtNoidung.focus();
        return false;
    }
    
    if(txtNguoilienhe == "")
    {
        alert('Bạn hãy nhập vào thông tin người liên hệ');
        document.forms[0].txtNguoilienhe.focus();
        return false;
    }
    if(txtDienthoai == "")
    {
        alert('Bạn hãy nhập vào điện thoại');
        document.forms[0].txtDienthoai.focus();
        return false;
    }
    if(txtDidong == "")
    {
        alert('Bạn hãy nhập vào di động');
        document.forms[0].txtDidong.focus();
        return false;
    }
    if(txtDiachilienhe == "")
    {
        alert('Bạn hãy nhập vào địa chỉ liên hệ');
        document.forms[0].txtDiachilienhe.focus();
        return false;
    }    
    return true;
}

</script>


<script language="javascript">
function loadDuan()
{
    //chkDuankhac = document.getElementById("chkDuankhac");
    var el = document.getElementById('divDuankhac');
    var el1 = document.getElementById('divDuan');

    <%
        int intID = clsInput.getNumericInput("id", 0);
        DataTable dtEdit = clsDatabase.getDataTable("select TOP 1 C_CheckDuankhac from tbl_tindang where PK_TindangID = " + intID);
        if (dtEdit.Rows.Count > 0)
        {
            if (Convert.ToInt32(dtEdit.Rows[0]["C_CheckDuankhac"].ToString())== 1)
            {
      %>
                el.style.display = "block";
                el1.style.display = "none";
                
      <%           
            }
        }
     %>
 }
</script>

</head><body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" onload=loadDuan();>
<form id="frmForm" runat="server">

<!-- begin header -->
<asp:PlaceHolder ID="inc_top" runat="server"></asp:PlaceHolder>
<!-- end header -->
<table align="center" border="0" cellpadding="0" cellspacing="0" width="1000">
  <tbody><tr>
    <td height="5"> </td>
  </tr>
</tbody></table>






<table bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">
	<tbody>
		<tr>
			<td class="DarkText" style="background-position: center top; background-repeat: repeat-x; background-attachment: scroll;" align="center" background="images/bg_silver.gif" valign="top">
			
			<table class="main" cellpadding="0" cellspacing="0">
			<tr>
				<td>
				
				<!-- Body -->				
	            <table class="title" cellpadding="3" cellspacing="3">
                    <tr>
                        <td width="5%"><img border="0" src="images/icons/laguage.gif" align="bottom" class="icon" ></td>
                        <td width="95%"><span class="title">Hệ thống quản lý thông tin</span></td>
                    </tr>    		
                </table>
                <table class="content">
                    <tr>
                        <td>
	                        
	                       
	                       
	                       
	                       
	                       
	                       
	                       
	                       
	                       <table align="center" border="0" cellpadding="0" cellspacing="0" width="700">
	<tbody><tr>
		<!-- Bat dau noi dung o giua -->		
		<td valign="top" width="100%">
			

        
        
        
        
        
        
        
<table border="0" width="100%" id="table17" class="boder_ghi p1" cellpadding="0" bgcolor="#FFFFFF" style="border-collapse: collapse">
				<tr>
					<td  class="text s10 br p0" style="padding-left:3px; padding-bottom:4px; padding-right:4px;">
					<div align="center">
    		<font style="font-family: Palatino Linotype; color: rgb(255, 0, 0); font-weight: bold; font-size: 16px; padding-bottom: 20px;">
                SỬA THÔNG TIN BẤT ĐỘNG SẢN<br>
   		  </font>
			<font style="font-family: Palatino Linotype; color: rgb(0, 0, 255); font-weight: bold; font-size: 10px;">GIÚP THÔNG TIN CỦA BẠN NHANH CHÓNG ĐẾN VỚI KHÁCH HÀNG</font>
	  </div>
							
						<asp:Label ID="block_error" runat="server"></asp:Label>
						
						
						<table border="0" width="100%" class="text s10 br" id="table18" cellpadding="0" bordercolor="#059ad2" style="border-collapse: collapse">
						<tr>
						  <td colspan="2" style="color: rgb(0, 0, 0);" background="images/bg_row.gif" height="24">
							  <table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tbody><tr>
										<td background="images/menu_path.gif" height="36" width="11"></td>
										<td class="link" background="images/menu_path2.gif"><b>Thông tin mô tả </b></td>
										<td background="images/menu_path1.gif" height="36" width="11"></td>
									</tr>
							  </tbody></table>
						  </td>
					   </tr>
						<tr>
							<td  class="text s10 br p0" style="padding-left:5px; padding-right:5px; padding-top:10px; padding-bottom:10px;">
							
							
							<div align="center">
							
							
							<table border="0" width="100%" cellspacing="5" cellpadding="0">
							<tr>
								<td  class="text s10 br p0" width="151"  align="left">
                                    <strong>Loại tin rao</strong></td>
								<td  class="text s10 br p0" align="left">
								<asp:RadioButtonList runat="server" ID="rdoLoaitinrao" RepeatDirection="Horizontal" CssClass="text s10 br p0">
								<asp:ListItem Value="1" Text="Cần bán" Selected="True"></asp:ListItem>
								<asp:ListItem Value="2" Text="Cho thuê"></asp:ListItem>
								<asp:ListItem Value="3" Text="Dự án"></asp:ListItem>	
								<asp:ListItem Value="4" Text="Cần mua"></asp:ListItem>	
								<asp:ListItem Value="5" Text="Cần thuê"></asp:ListItem>						
								</asp:RadioButtonList>
                                    </td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151"  align="left">
                                    <strong></strong></td>
								<td  class="text s10 br p0" align="left">
								 &nbsp;
								<asp:CheckBox ID="chkActive" runat="server" /> &nbsp;Cho phép hiển thị tin
                                    </td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151"  align="left">
                                    <strong></strong></td>
								<td  class="text s10 br p0" align="left">
								 &nbsp;
								<asp:CheckBox ID="chkVip" runat="server" /> &nbsp;Thiết lập tin VIP
                                    </td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151"  align="left">
                                    <strong></strong></td>
								<td  class="text s10 br p0" align="left">
								 &nbsp;
								<asp:CheckBox ID="chkChungthuc" runat="server" /> &nbsp;Đã chứng thực bởi NAMMON
                                    </td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151"  align="left">
                                    <strong>Số lượng stars</strong></td>
								<td  class="text s10 br p0" align="left">
								<asp:DropDownList runat="server" ID="drdStar" Width="190px">
								<asp:ListItem Value="0">Không thiết lập</asp:ListItem>
								<asp:ListItem Value="1">*</asp:ListItem>
								<asp:ListItem Value="2">**</asp:ListItem>
								<asp:ListItem Value="3">***</asp:ListItem>
								<asp:ListItem Value="4">****</asp:ListItem>
								<asp:ListItem Value="5">*****</asp:ListItem>
								</asp:DropDownList>
                                    </td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Loại địa ốc</strong><span class="note">*</span></td>
								<td  class="text s10 br p0" height="21" align="left">
								<asp:DropDownList runat="server" ID="drdLoaidiaoc" Width="190px">
								<asp:ListItem Value="0">Vui lòng chọn...</asp:ListItem>
								</asp:DropDownList>
							
								
								</td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">&nbsp;</td>
								<td  class="text s10 br p0" height="21" align="left">
								<table border="0" width="70%" id="table19" cellpadding="0" cellspacing="0">
									<tr>
										<td  class="text s10 br p0" width="153" style="height: 21px">
                                            <strong>Tỉnh/ thành phố</strong><span class="note">*</span></td>
										<td  class="text s10 br p0" style="height: 21px">
                                            <strong>Quận/ huyện</strong><span class="note">*</span></td>
									</tr>
									<tr>
										<td  class="text s10 br p0" width="153">										
								           <asp:DropDownList ID="drdTinhthanh" runat="server" AppendDataBoundItems="true"  style="width:190px;" onchange = "PopulateTinhthanh();">
                                            <asp:ListItem Text = "Please select" Value = "0"></asp:ListItem>                 
                                        </asp:DropDownList>
								        </td>
										<td  class="text s10 br p0">
										<asp:DropDownList ID="drdQuanhuyen" runat="server" style="width:190px;" onchange = "PopulateTenduan();">
                                            <asp:ListItem Text = "Please select" Value = "0"></asp:ListItem>                 
                                        </asp:DropDownList>
								        
								        </td>
									</tr>
									
								</table>
								</td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Địa chỉ</strong></td>
								<td  class="text s10 br p0" height="21" align="left">
								<asp:TextBox ID="txtDiachi" runat="server" Width="382px"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Tên dự án</strong></td>
								<td  class="text s10 br p0" height="21" align="left">
								<div id="divDuankhac" style="display:none; width:190px; float:left;">
								<asp:TextBox ID="txtDuankhac" runat="server" Width="190px"></asp:TextBox></div>
								<div id="divDuan" style="float:left; width:190px;">
								<asp:DropDownList runat="server" ID="drdTenduan" Width="190px">
								</asp:DropDownList>
								</div>
								&nbsp;
								<input type="checkbox" id="chkDuankhac" name="chkDuankhac" runat="server" onclick="changeDuan();" />
								&nbsp;Dự án khác
								
								</td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Giá</strong></td>
								<td  class="text s10 br p0" height="21" align="left">
								<asp:TextBox ID="txtGia" runat="server" Width="130px"></asp:TextBox>
								<asp:DropDownList runat="server" ID="drdLoaitiente" Width="60px">
								<asp:ListItem Value="1">Triệu</asp:ListItem>
								</asp:DropDownList>
								&nbsp;/&nbsp;
								<asp:DropDownList runat="server" ID="drdLoaidientich" Width="185px">
								<asp:ListItem Value="1">tháng</asp:ListItem>								
								<asp:ListItem Value="2">m2</asp:ListItem>
								<asp:ListItem Value="3">Tổng diện tích</asp:ListItem>
								</asp:DropDownList>
								
								</td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Môi giới</strong></td>
								<td  class="text s10 br p0" height="21" align="left">
								<asp:RadioButtonList runat="server" ID="rdoMoigioi" RepeatDirection="horizontal" CssClass="text s10 br p0"> 
								<asp:ListItem Value="1" Text="Miễn trung gian" Selected="True"></asp:ListItem>
								<asp:ListItem Value="2" Text="Ký gởi môi giới"></asp:ListItem>
								</asp:RadioButtonList>
								</td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Diện tích sử dụng</strong><span class="note">*</span></td>
								<td  class="text s10 br p0" height="21" align="left">
								<asp:TextBox ID="txtDientichsudung" Width="130px" runat="server"></asp:TextBox>&nbsp;
                                    m<sup>2</sup></td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Diện tích đất</strong><span class="note"></span></td>
								<td  class="text s10 br p0" height="21" align="left">
								<asp:TextBox ID="txtDientichdat" Width="130px" runat="server"></asp:TextBox>&nbsp;
                                    m<sup>2</sup></td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Diện tích khuôn viên</strong></td>
								<td  class="text s10 br p0" height="21" align="left">								
								
								</td>
							</tr>
							<tr>
							    <td colspan="2"  class="text s10 br p0" height="21" align="left">
							    Chiều ngang trước&nbsp;&nbsp;<asp:TextBox runat="server" ID="txtDientichkhuonvien_rong" Width="60px"></asp:TextBox>&nbsp;&nbsp;m
								&nbsp;
								X&nbsp;
								Chiều ngang sau&nbsp;&nbsp;<asp:TextBox runat="server" ID="txtDientichkhuonvien_rongsau" Width="60px"></asp:TextBox>&nbsp;&nbsp;m
								&nbsp;
								X&nbsp;
								Chiều dài&nbsp;&nbsp;<asp:TextBox runat="server" ID="txtDientichkhuonvien_dai" Width="60px"></asp:TextBox>&nbsp;m
							    </td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Diện tích xây dựng</strong></td>
								<td  class="text s10 br p0" height="21" align="left">
								
								</td>
							</tr>
							<tr>
							    <td colspan="2"  class="text s10 br p0" height="21" align="left">
							    Chiều ngang trước&nbsp;&nbsp;<asp:TextBox runat="server" ID="txtDientichxaydung_rong" Width="60px"></asp:TextBox>&nbsp;&nbsp;m
								&nbsp;
								X&nbsp;
								Chiều ngang sau&nbsp;&nbsp;<asp:TextBox runat="server" ID="txtDientichxaydung_rongsau" Width="60px"></asp:TextBox>&nbsp;&nbsp;m
								&nbsp;
								X&nbsp;
								Chiều dài&nbsp;&nbsp;<asp:TextBox runat="server" ID="txtDientichxaydung_dai" Width="60px"></asp:TextBox>&nbsp;m
							    </td>
							</tr>
							</table>
							
							
							
							</div>
							
							
							
							</td>
						</tr>
						</table>
						
					<div style="padding-top:10px;"></div>	
						
					







				<table border="0" width="100%" id="table1" cellpadding="0" bordercolor="#059ad2" style="border-collapse: collapse">
						<tr>
						  <td colspan="2" style="color: rgb(0, 0, 0);" background="images/bg_row.gif" height="24">
							  <table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tbody><tr>
										<td background="images/menu_path.gif" height="36" width="11"></td>
										<td class="link" background="images/menu_path2.gif"><b>Thông tin thêm </b></td>
										<td background="images/menu_path1.gif" height="36" width="11"></td>
									</tr>
							  </tbody></table>
						  </td>
					   </tr>
						<tr>
							<td  class="text s10 br p0" style="padding-left:5px; padding-right:5px; padding-top:10px; padding-bottom:10px;">
							
							
							<div align="center">
							
							
							<table border="0" width="100%">
		<tr>
			<td  class="text s10 br p0">
			
			
			
			
			<table border="0" width="100%" id="table20" cellspacing="5" cellpadding="0">
									<tr>
										<td  class="text s10 br p0" align="left">
                                            <strong>Tình trạng pháp lý</strong></td>
										<td  class="text s10 br p0" align="left">
                                            <strong>Số phòng khách</strong></td>
									</tr>
									<tr>
										<td  class="text s10 br p0" align="left">
					                    <asp:DropDownList runat="server" ID="drdTinhtrangphaply" Width="190px">
					                    </asp:DropDownList>
								        </td>
										<td  class="text s10 br p0" align="left">
										<asp:TextBox ID="txtSophongkhach" Width="100px" runat="server" Text="0"></asp:TextBox>
								        
								        </td>
									</tr>
									<tr>
										<td  class="text s10 br p0" align="left">
                                            <strong>Hướng tài sản</strong></td>
										<td  class="text s10 br p0" align="left">
                                            <strong>Số phòng ngủ</strong></td>
									</tr>
									<tr>
										<td  class="text s10 br p0" align="left">
										<asp:DropDownList runat="server" ID="drdHuongtaisan" Width="190px">
					                    </asp:DropDownList>
								        
								    
								</td>
										<td  class="text s10 br p0" align="left">
										<asp:TextBox ID="txtSophongngu" Width="100px" runat="server" Text="0"></asp:TextBox>
								        
								        </td>
									</tr>
									<tr>
										<td  class="text s10 br p0" align="left">
                                            <strong>Đường trước nhà</strong></td>
										<td  class="text s10 br p0" align="left">
                                            <strong>Số phòng tắm/ vệ 
										sinh</strong></td>
									</tr>
									<tr>
										<td  class="text s10 br p0" align="left">
										<asp:DropDownList runat="server" ID="drdDuongtruocnha" Width="190px">
					                    <asp:ListItem Value="0">Vui lòng chọn...</asp:ListItem>
					                    <asp:ListItem Value="1"><2m</asp:ListItem>
					                    <asp:ListItem Value="2">2m đến 5m</asp:ListItem>
					                    <asp:ListItem Value="3">5m đến 10m</asp:ListItem>
					                    <asp:ListItem Value="4">>10m</asp:ListItem>
					                    </asp:DropDownList>
								        
								        </td>
										<td  class="text s10 br p0" align="left">
										<asp:TextBox ID="txtSophongtam" runat="server" Width="100px" Text="0"></asp:TextBox>
								        
								        </td>
									</tr>
									<tr>
										<td  class="text s10 br p0" align="left">
                                            <strong>Số tầng</strong></td>
										<td  class="text s10 br p0" align="left">
                                            <strong>Số phòng khác</strong></td>
									</tr>
									<tr>
										<td  class="text s10 br p0" align="left">
										<asp:TextBox ID="txtSolau" runat="server" Width="100px" Text="0"></asp:TextBox>
								        
								        </td>
										<td  class="text s10 br p0" align="left">
										<asp:TextBox ID="txtSophongkhac" runat="server" Width="100px" Text="0"></asp:TextBox>
								       
								        </td>
									</tr>
								</table>
			
			
			
			
			
			
			
			
			
			</td>
			<td  class="text s10 br p0">
			
			
			
			
			
			<table border="0" width="100%" id="table21" cellspacing="0" cellpadding="0">
											<tr>
												<td  class="text s10 br p0" align="left">
												<input type="checkbox" id="chkDaydutiennghi" runat="server" />Đầy đủ tiện nghi
												</td>
											</tr>
											<tr>
												<td  class="text s10 br p0" align="left">
												<input type="checkbox" id="chkChodauxehoi" runat="server" />Chỗ đậu xe hơi
												</td>
											</tr>
											<tr>
												<td  class="text s10 br p0" align="left">
												<input type="checkbox" id="chkSanvuon" runat="server" />Sân vườn
												</td>
											</tr>
											<tr>
												<td  class="text s10 br p0" align="left">
												<input type="checkbox" id="chkHoboi" runat="server" />Hồ bơi
												</td>
											</tr>
											<tr>
												<td  class="text s10 br p0" align="left">
												<input type="checkbox" id="chkTienkinhdoanh" runat="server" />Tiện kinh doanh
												</td>
											</tr>
											<tr>
												<td  class="text s10 br p0" align="left">
												<input type="checkbox" id="chkTiendeo" runat="server" />Tiện để ở
												</td>
											</tr>
											<tr>
												<td  class="text s10 br p0" align="left">
												<input type="checkbox" id="chkTienlamvanphong" runat="server" />Tiện làm văn phòng
												</td>
											</tr>
											<tr>
												<td  class="text s10 br p0" align="left">
												<input type="checkbox" id="chkTienchosanxuat" runat="server" />Tiện cho sản xuất
												</td>
											</tr>
											<tr>
												<td  class="text s10 br p0" align="left">
												<input type="checkbox" id="chkTienchosinhvienthue" runat="server" />Tiện cho sinh viên thuê
												</td>
											</tr>
										</table>
			
			
			
			
			
			
			</td>
		</tr>
		</table>
							
							
							
							</div>
							
							
							
							</td>
						</tr>
						</table>







						<div style="padding-top:10px;"></div>
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						<table border="0" width="100%" id="table2" cellpadding="0" bordercolor="#059ad2" style="border-collapse: collapse">
						<tr>
						  <td colspan="2" style="color: rgb(0, 0, 0);" background="images/bg_row.gif" height="24">
							  <table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tbody><tr>
										<td background="images/menu_path.gif" height="36" width="11"></td>
										<td class="link" background="images/menu_path2.gif"><b>Mô tả chi tiết tài sản </b></td>
										<td background="images/menu_path1.gif" height="36" width="11"></td>
									</tr>
							  </tbody></table>
						  </td>
					   </tr>
						<tr>
							<td  class="text s10 br p0" style="padding-left:5px; padding-right:5px; padding-top:10px; padding-bottom:10px;">
							
							
							<div align="center">
							
							
							<table border="0" width="100%" cellspacing="5" cellpadding="0">
							
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Tiêu đề</strong></td>
								<td  class="text s10 br p0" height="21" align="left">
									
								<asp:TextBox runat="server" ID="txtTieude" Width="400px"></asp:TextBox>						 
								 </td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Nội dung</strong></td>
								<td  class="text s10 br p0" height="21" align="left">
								<asp:TextBox ID="txtNoidung" runat="server" TextMode="MultiLine" Width="400px" Height="200px"></asp:TextBox>								 
								 </td>
							</tr>
							</table>
							
							
							
							</div>
							
							
							
							</td>
						</tr>
						</table>
			
			
			
			
			
			
			
			
			
			
		<!--	
			
			
			
			
			
			<div style="padding-top:10px;"></div>
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						<table border="0" width="100%" id="table3" cellpadding="0" bordercolor="#059ad2" style="border-collapse: collapse">
						<tr>
						  <td colspan="2" style="color: rgb(0, 0, 0);" background="images/bg_row.gif" height="24">
							  <table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tbody><tr>
										<td background="images/menu_path.gif" height="36" width="11"></td>
										<td class="link" background="images/menu_path2.gif"><b>Cập nhật hình ảnh </b></td>
										<td background="images/menu_path1.gif" height="36" width="11"></td>
									</tr>
							  </tbody></table>
						  </td>
					   </tr>
						<tr>
							<td  class="text s10 br p0" style="padding-left:5px; padding-right:5px; padding-top:10px; padding-bottom:10px;">
							
							
							<div align="center">
							<script language="javascript">
							    var placeFileUpload2 = 0;
							    var placeFileUpload3 = 0;
							    var placeFileUpload4 = 0;
							    var placeFileUpload5 = 0;
							    function addFile2()
							    {
							        if(placeFileUpload2 == 0)
							        {
							            var el = document.getElementById('placeFileUpload2');
                                        el.style.display = "block";
                                        placeFileUpload2 = 1;
                                        return false;
                                    }
                                    if(placeFileUpload3 == 0)
							        {
							            var el = document.getElementById('placeFileUpload3');
                                        el.style.display = "block";
                                        placeFileUpload3 = 1;
                                        return false;
                                    }
                                    if(placeFileUpload4 == 0)
							        {
							            var el = document.getElementById('placeFileUpload4');
                                        el.style.display = "block";
                                        placeFileUpload4 = 1;
                                        return false;
                                    }
                                    if(placeFileUpload5 == 0)
							        {
							            var el = document.getElementById('placeFileUpload5');
                                        el.style.display = "block";
                                        placeFileUpload5 = 1;
                                        return false;
                                    }
                                    alert('Bạn chỉ được upload tối đa là 5 ảnh');
							    }
							    
							    
							    function removeFile2(placeRemove)
							    {
							        if(placeRemove == 2)
							        {
							            var el = document.getElementById('placeFileUpload2');
							            document.getElementById("placeFileUpload2").innerHTML = document.getElementById("placeFileUpload2").innerHTML;

                                        el.style.display = "none";
                                        placeFileUpload2 = 0;
                                        return false;
                                    }
                                    if(placeRemove == 3)
							        {
							            var el = document.getElementById('placeFileUpload3');
							            document.getElementById("placeFileUpload3").innerHTML = document.getElementById("placeFileUpload3").innerHTML;
                                        el.style.display = "none";
                                        placeFileUpload3 = 0;
                                        return false;
                                    }
                                    if(placeRemove == 4)
							        {
							            var el = document.getElementById('placeFileUpload4');
							            document.getElementById("placeFileUpload4").innerHTML = document.getElementById("placeFileUpload4").innerHTML;
                                        el.style.display = "none";
                                        placeFileUpload4 = 0;
                                        return false;
                                    }
                                    if(placeRemove == 5)
							        {
							            var el = document.getElementById('placeFileUpload5');
							            document.getElementById("placeFileUpload5").innerHTML = document.getElementById("placeFileUpload5").innerHTML;
                                        el.style.display = "none";
                                        placeFileUpload5 = 0;
                                        return false;
                                    }
							    }
							    
							    
							</script>
							
							<table border="0" width="100%" cellspacing="5" cellpadding="0">							
							<tr>
								<td  class="text s10 br p0" width="400" height="21" align="left">
								<div id="placeFileUpload1" style="padding-top:5px; padding-bottom:5px; display:block;" >
								<input type="file" runat="server" id="fileUpload1" name="fileUpload1" size="30" />&nbsp;&nbsp;&nbsp;
								</div>
								<div id="placeFileUpload2" style="padding-top:5px; padding-bottom:5px; display:none;" >
								<input type="file" runat="server" id="fileUpload2" name="fileUpload2" size="30" />&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="javascript:removeFile2(2);">[Xóa ảnh]</a>
								</div>
								<div id="placeFileUpload3" style="padding-top:5px; padding-bottom:5px; display:none;" >
								<input type="file" runat="server" id="fileUpload3" name="fileUpload3" size="30" />&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="javascript:removeFile2(3);">[Xóa ảnh]</a>
								</div> 
								<div id="placeFileUpload4" style="padding-top:5px; padding-bottom:5px; display:none;" >
								<input type="file" runat="server" id="fileUpload4" name="fileUpload4" size="30" />&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="javascript:removeFile2(4);">[Xóa ảnh]</a>
								</div>
								<div id="placeFileUpload5" style="padding-top:5px; padding-bottom:5px; display:none;" >
								<input type="file" runat="server" id="fileUpload5" name="fileUpload5" size="30" />&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="javascript:removeFile2(5);">[Xóa ảnh]</a>
								</div>
								<div style="padding-top:5px; padding-bottom:5px; display:block;" >
								<a href="javascript:void(0);" onclick="javascript:addFile2();">[Thêm ảnh]</a>
								</div>
								
								</td>
								<td  class="text s10 br p0" height="21" align="left" valign="top" style="padding-left:15px;">
                                            Định dạng hình ảnh .jpg, .jpeg<br />
                                            Dung lượng tối đa 5MB / 1 hình								 							 
								 </td>
							</tr>
							<tr><td  class="text s10 br p0"></td><td  class="text s10 br p0"></td></tr>
							<tr><td  class="text s10 br p0" colspan="2">
                                <span class="tieude"><em>- Không đăng các hình ảnh mờ hoặc hình có kích thước nhỏ hơn
                                    360x300 pixel.<br />
                                    - Không đăng các hình ảnh có gắn kèm logo hoặc thông điệp quảng cáo.<br />
                                    - Nếu bạn không tải hình ảnh, hệ thống sẽ lấy hình minh hoạ tự động tương ứng với
                                    loại địa ốc mà bạn chọn.</em></span></td></tr>
							</table>
							
							
							
							</div>
							
							
							
							</td>
						</tr>
						</table>
			
			
						
						
		-->				
						
						
						
						
						
						
					<!--	
						
						
				<div style="padding-top:10px;"></div>
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						<table border="0" width="100%" id="table4" cellpadding="0" bordercolor="#059ad2" style="border-collapse: collapse">
						<tr>
						  <td colspan="2" style="color: rgb(0, 0, 0);" background="images/bg_row.gif" height="24">
							  <table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tbody><tr>
										<td background="images/menu_path.gif" height="36" width="11"></td>
										<td class="link" background="images/menu_path2.gif"><b>Cập nhật vị trí trên bản đồ </b></td>
										<td background="images/menu_path1.gif" height="36" width="11"></td>
									</tr>
							  </tbody></table>
						  </td>
					   </tr>
						<tr>
							<td  class="text s10 br p0" style="padding-left:5px; padding-right:5px; padding-top:10px; padding-bottom:10px;">
							
							
							<div align="center">
							
							
							cập nhật vị trí trên bản đồ
							
							
							
							</div>
							
							
							
							</td>
						</tr>
						</table>



        -->
        
        
        
        
        
        



			
			
			
			
			<div style="padding-top:10px;"></div>
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						<table border="0" width="100%" id="table5" cellpadding="0" bordercolor="#059ad2" style="border-collapse: collapse">
						<tr>
						  <td colspan="2" style="color: rgb(0, 0, 0);" background="images/bg_row.gif" height="24">
							  <table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tbody><tr>
										<td background="images/menu_path.gif" height="36" width="11"></td>
										<td class="link" background="images/menu_path2.gif"><b>Thông tin liên hệ </b></td>
										<td background="images/menu_path1.gif" height="36" width="11"></td>
									</tr>
							  </tbody></table>
						  </td>
					   </tr>
						<tr>
							<td  class="text s10 br p0" style="padding-left:5px; padding-right:5px; padding-top:10px; padding-bottom:10px;">
							
							
							<div align="center">
							
							
							<table border="0" width="100%" cellspacing="0" cellpadding="0">
							
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Người liên hệ</strong> *</td>
								<td  class="text s10 br p0" height="21" align="left">
								<asp:TextBox runat="server" ID="txtNguoilienhe" Width="400px"></asp:TextBox>				 
								 </td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Điện thoại</strong> *</td>
								<td  class="text s10 br p0" height="21" align="left">
								 <asp:TextBox runat="server" ID="txtDienthoai" Width="400px"></asp:TextBox>														 
								 </td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Di động</strong> *</td>
								<td  class="text s10 br p0" height="21" align="left">
								<asp:TextBox runat="server" ID="txtDidong" Width="400px"></asp:TextBox>
								 </td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Địa chỉ</strong> *</td>
								<td  class="text s10 br p0" height="21" align="left">
								 <asp:TextBox runat="server" ID="txtDiachilienhe" Width="400px"></asp:TextBox>
								 </td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Ghi chú</strong></td>
								<td  class="text s10 br p0" height="21" align="left">
								<asp:TextBox runat="server" TextMode="MultiLine" ID="txtGhichu" Width="400px" Height="200px"></asp:TextBox>
								 </td>
							</tr>
							</table>
							
							
							
							</div>
							
							
							
							</td>
						</tr>
						</table>









		
						
						
						
						
						<table border="0" width="100%" id="table6" cellpadding="0" bordercolor="#059ad2" style="border-collapse: collapse">
						
						<tr>
							<td  class="text s10 br p0" style="padding-left:5px; padding-right:5px; padding-top:10px; padding-bottom:10px;">
							
							
							<div align="center">
							
							
							<table border="0" width="100%" cellspacing="0" cellpadding="0">
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Mã xác nhận</strong>:</td>
								<td  class="text s10 br p0" height="21" align="left">
								<cc1:imageverifier id="ImageVerifier1" runat="server"></cc1:imageverifier></td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">
                                    <strong>Nhập mã xác nhận</strong>:</td>
								<td  class="text s10 br p0" height="21" align="left">
								<asp:TextBox ID="txtImgVerifyCode" name="txtImgVerifyCode" runat="server" Width="160px"></asp:TextBox>
						    *<span class="gr">(Nhập giống hệt các số phía trên)</span>
								</td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left">&nbsp;</td>
								<td  class="text s10 br p0" height="21" align="left"></td>
							</tr>
							<tr>
								<td  class="text s10 br p0" width="151" height="21" align="left"></td>
								<td  class="text s10 br p0" height="21" align="left">
								<asp:Button runat="server" ID="cmdDangTin" Text="Lưu tin đăng" OnClick="cmdDangTin_Click" OnClientClick="return checkFormSubmit();" />
								</td>
							</tr>
							
							</table>
							
							
							
							</div>
							
							
							
							</td>
						</tr>
						</table>














								
					
					</td>
				</tr>
			</table>
        
        
        
        
        
        
        
		
		
		
		<!-- ket thuc noi dung o giua -->
		
		</td>
		
		
		
	</tr>
</tbody></table>
	                       
	                       
	                       
	                       
	                       
	                       
	                       
	                       
	                       
	                       
	                       
                        </td>
                    </tr>
                </table>
	           
				<!-- End body -->
				
				</td>
			</tr>
			</table>
			
			</td>
		</tr>
	</tbody>		
</table>






</form>
</body></html>
