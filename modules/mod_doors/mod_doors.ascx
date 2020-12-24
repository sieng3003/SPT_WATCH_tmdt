<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_doors.ascx.cs" Inherits="modules_doors_mod_doors" %>
<%@Import Namespace = "System.Data" %>
<%
    int intTabId = 7;
    int intParentID = 0;
    if (lang.getLangID() == 2)
        intParentID = 37;
    else
        intParentID = 35;
    string strCatName = "";
    int intCatID = 0;
    int intID = clsInput.getNumericInput("id",0);
 %>
 <%
     DataTable dtCatName = clsDatabase.getDataTable("select TOP 1 tbl_category_news.C_Name as CatName, tbl_doors.* from tbl_category_news inner join tbl_doors on tbl_category_news.PK_CategoryID = tbl_doors.FK_CategoryID where tbl_category_news.FK_LangID = " + lang.getLangID() + " and tbl_doors.PK_doorsID =" + intID);
              if(dtCatName.Rows.Count > 0)
              {
  %>
<div class="">
        <div class="blockright">
        <div class="guide">
       	  <a href="#" class="norB"><%= lang.setLangValue("Home", "Trang chủ")%> &raquo;</a> <a href="#"><%= lang.setLangValue("Plastic Doors, Doors", "Cửa nhựa, cửa cuốn")%></a></div>
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
                       <img id="imgNewsDetail" src="<%= clsConfig.GetHostUrl() %>/<%= dtCatName.Rows[0]["C_Img"].ToString() %>" class="imgfloat" />
                       <script language="javascript">
						    var theImg = document.getElementById('imgNewsDetail');
						    if(theImg.width > 350)
						      theImg.width = 350;
						    </script>
               <% } } %>
                           <div class="titbuild"><%= lang.setLangValue("doors name", "Tên sản phẩm")%>: <%= dtCatName.Rows[0]["C_Name"].ToString()%> </div>  
                          <%= clsInput.decodeStr(dtCatName.Rows[0]["C_Des"].ToString())%>
           		  <div style="clear:both"></div>
           		  <div style="clear:both"></div>
                </div>
                <div class="tabright"> <span><%= lang.setLangValue("The doorss of the same type", "Các sản phẩm cùng loại")%></span> </div>
                <div class="listitem mt10">
            <ul>
            <%
                //------------------------------	

                int intCurPage = 0;
                int intStartRecord = 0;
                int intPageSize = 24;
                //------------------------------ 


                //-------------------------------		    		    
                intCurPage = clsPaging.getCurPage();
                intStartRecord = clsPaging.getStartRecord(intCurPage, intPageSize);
                //------------------------------ 		    
                string strSqlCount = "select count(*) from tbl_doors where FK_LangID = " + lang.getLangID() + " and FK_CategoryID = " + intCatID + " and PK_doorsID <> " + intID;
                int intTotalPage = clsPaging.getTotalPage(strSqlCount, intPageSize);
                //string strParamPage = "page=" + Request.QueryString["page"] + "&mod=" + Request.QueryString["mod"] + "&key=" + strKey + "&catid=" + clsInput.getNumericInput("catid", 0);


                DataTable dtOther = clsDatabase.getDataTable("select * from tbl_doors where FK_LangID = " + lang.getLangID() + " and FK_CategoryID = " + intCatID + " and PK_doorsID <> " + intID, intStartRecord, intPageSize);
                for (int iOther = 0; iOther < dtOther.Rows.Count; iOther++ )   
                {
                  %>
              <% if (dtOther.Rows[iOther]["C_Img"].ToString() != "")
                 {
                     if (clsFile.fileExists("~/" + dtOther.Rows[iOther]["C_Img"].ToString()))
                {
             %>
                        	<li>
                              <a href="<%= clsConfig.GetHostUrl() %>/detail-doors/<%= intTabId %>/<%= dtOther.Rows[iOther]["PK_doorsID"].ToString() %>/<%= clsFunction.RemoveUnicode(dtOther.Rows[iOther]["C_Name"].ToString()) %>.aspx"><img src="<%= clsConfig.GetHostUrl() %>/<%= dtOther.Rows[iOther]["C_Img"].ToString() %>" width="150" height="90" />
                            <%= dtOther.Rows[iOther]["C_Name"].ToString()%></a></li>
                <% } } %>
              <% } %>
            </ul>
            
            
            <div style="clear:both"></div>
            <div class="pages" align="center"> 
            <%
            string str = "";
        //int Pagesize = 10;
        //int intTotalPage = getPage(strTableName, intPagesize, strWhere);
        if (intTotalPage <= 1)
        {
            str = "";
        }
        else
        {
            int intGetP = clsInput.getNumericInput("p",0);
            //--------------------------------------------

            //str += "<a href='#'>Trang trước</a>";
            //--------------------------------------------    
            int intNowPage = intGetP;
            if (intNowPage == 0)
                intNowPage = 1;
            int intPerRecord = 100;
            int intPrePage = intNowPage - intPerRecord;
            if (intPrePage <= 0)
                intPrePage = 1;
            int intNexPage = intNowPage + intPerRecord;
            if (intNexPage > intTotalPage)
                intNexPage = intTotalPage;
            for (int iPage = intPrePage; iPage <= intNexPage; iPage++)
            {     
                //Drd1.Items.Add(i.ToString());
                if (intCurPage == iPage)
                    str = str + "<a href='#'>" + iPage.ToString() + "</a>";
                else
                {
                    str = str + "<a href='" + clsConfig.GetHostUrl() + "/detail-doors-p_" + iPage.ToString() + "/" + intTabId + "/" + intID + "/" + clsFunction.RemoveUnicode(strCatName) + ".aspx" + "'>" + iPage.ToString() + "</a>";
                }
            }
            //--------------------------------------------

            //str = str + "<a href='#'>Trang sau</a>";
            //--------------------------------------------
        }
        
        Response.Write(str);
					 %>
            </div>
            
            
            <div style="clear:both"></div>
          </div>
          <!-- end item-->
			</div>
        </div>
        <!-- end blockright-->
      </div>


<% } %>      