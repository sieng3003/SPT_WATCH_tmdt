<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_buy_product.ascx.cs" Inherits="modules_mod_product_mod_buy_product" %>

<%@Import Namespace = "System.Data" %>
<form method="post" id="frmContact" runat="server">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript" src="<%= clsConfig.GetHostUrl() %>/js/dropdowncontent.js"></script>
<script type="text/javascript">


function ValidateEmailAddress(str) {

		var at="@"
		var dot="."
		var lat=str.indexOf(at)
		var lstr=str.length
		var ldot=str.indexOf(dot)
		if (str.indexOf(at)==-1){
		   alert("Email không hợp lệ")
		   return false
		}

		if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
		   alert("Email không hợp lệ")
		   return false
		}

		if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
		    alert("Email không hợp lệ")
		    return false
		}

		 if (str.indexOf(at,(lat+1))!=-1){
		    alert("Email không hợp lệ")
		    return false
		 }

		 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
		    alert("Email không hợp lệ")
		    return false
		 }

		 if (str.indexOf(dot,(lat+2))==-1){
		    alert("Email không hợp lệ")
		    return false
		 }
		
		 if (str.indexOf(" ")!=-1){
		    alert("Email không hợp lệ")
		    return false
		 }
 		 return true					
	}

function checkFormReg()
{

    if(document.getElementById('<%= txtHoten.ClientID %>').value =='')
    {
        
        alert("<%= lang.setLangValue("Please input your fullname","Bạn hãy nhập vào họ tên") %>");
        document.getElementById('<%= txtHoten.ClientID %>').focus();
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
    if(document.getElementById('<%= txtHoten.ClientID %>').value =='')
    {
        alert("<%= lang.setLangValue("Please input your email","Bạn hãy nhập vào email") %>");
        document.getElementById('<%= txtHoten.ClientID %>').focus();
        return false;
    }
    
    if(ValidateEmailAddress(document.getElementById('<%= txtEmail.ClientID %>').value) == false)
        return false;
    /*
    if(document.frmContact.txtAddress.value == "")
    {
        alert("Bạn hãy nhập vào địa chỉ");
        document.frmContact.txtAddress.focus();
        return false;
    }
    */
    if(document.getElementById('<%= txtContent.ClientID %>').value =='')
    {
        alert("<%= lang.setLangValue("Please input your content","Bạn hãy nhập vào nội dung") %>");
        document.getElementById('<%= txtContent.ClientID %>').focus();
        return false;
    }
//    if(document.frmContact.txtImgVerifyCode.value == "")
//    {
//        alert("<%= lang.setLangValue("Please input your captcha","Bạn hãy nhập vào mã xác thực") %>");
//        document.frmContact.txtImgVerifyCode.focus();
//        return false;
//    }
    return true;
}
</script>

<%
    int intTabId = 4;
    int intParentID = 0;
    if (lang.getLangID() == 2)
        intParentID = 21;
    else
        intParentID = 13;
    string strCatName = "";
    int intCatID = 0;
    int intID = clsInput.getNumericInput("id",0);
 %>
 <%
     DataTable dtCatName = clsDatabase.getDataTable("select TOP 1 tbl_category_news.C_Name as CatName, tbl_product.* from tbl_category_news inner join tbl_product on tbl_category_news.PK_CategoryID = tbl_product.FK_CategoryID where tbl_category_news.FK_LangID = " + lang.getLangID() + " and tbl_product.PK_ProductID =" + intID);
              if(dtCatName.Rows.Count > 0)
              {
  %>
<div class="">
        <div class="blockright">
        <div class="guide">
       	  <a href="#" class="norB"><%= lang.setLangValue("Home", "Trang chủ")%> &raquo;</a> <a href="#"><%= lang.setLangValue("Product", "sản phẩm")%></a></div>
          <div class="tabright"> <span>
          <%
              
                  strCatName = dtCatName.Rows[0]["CatName"].ToString();
                  intCatID = Convert.ToInt32(dtCatName.Rows[0]["FK_CategoryID"].ToString());
           %>
          <%= dtCatName.Rows[0]["CatName"].ToString()%>
          
          </span> </div>
			<div class="contentright">
            	<div class="detailtbuild">
                       <% if (dtCatName.Rows[0]["C_Img"].ToString() != "")
                {
                    if (clsFile.fileExists("~/" + dtCatName.Rows[0]["C_Img"].ToString()))
                {
             %>
                       <img id="imgNewsDetail" src="<%= clsConfig.GetHostUrl() %>/<%= dtCatName.Rows[0]["C_Img"].ToString() %>" class="imgfloat" alt="" />
                       <div style="clear:both"></div>
                       <script language="javascript" type="text/javascript">
                           var theImg = document.getElementById('imgNewsDetail');
                           if (theImg.width > 350)
                               theImg.width = 350;
						    </script>
               <% } } %>
               
                           <div class="titbuild"><%= lang.setLangValue("Product name", "Tên sản phẩm")%>: <%= dtCatName.Rows[0]["C_Name"].ToString()%> </div>  
                          <%= clsInput.decodeStr(dtCatName.Rows[0]["C_Des"].ToString())%>
           		  <div style="clear:both"></div>
           		  <div style="clear:both"></div>
                </div>
                
          <!-- end item-->
          <div style="color:Red;font-weight:bold;font-size:12pt">
          Mua sản phẩm
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <asp:Label ID="block_error" runat="server" ></asp:Label>  
          </div>               
<div class="formcontact fl" >
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
         <li class="l1">&nbsp;</li>
        <li class="l2"><a id="A1" href="#" runat="server" onclick="return checkFormReg();" onserverclick="btnSubmit_Click"  class="btn">Gửi yêu cầu</a> 
        <a href="<%= clsConfig.GetHostUrl() %>/buy-product/<%= intTabId %>/<%= dtCatName.Rows[0]["PK_ProductID"].ToString() %>/<%= clsFunction.RemoveUnicode(dtCatName.Rows[0]["C_Name"].ToString()) %>.aspx" class="btn">Xoá</a></li>
    </ul>
    
     
  </div>
  <div style="clear:both"></div>
			</div>
        </div>
        <!-- end blockright-->
      </div>


<% } %> 

</form>     