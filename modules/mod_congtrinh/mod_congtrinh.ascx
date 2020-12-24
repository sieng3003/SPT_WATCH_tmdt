<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_congtrinh.ascx.cs" Inherits="modules_mod_congtrinh_mod_congtrinh" %>
<%@Import Namespace = "System.Data" %>
<%
    int intTabId = 2;
    int intCatID = 0;
    if (lang.getLangID() == 2)
        intCatID = 22;
    else
        intCatID = 11;
    string strCatName = lang.setLangValue("Typical Building", "Công trình tiêu biểu");
 %>
<div class="">
        <div class="blockright">
        <div class="guide">
       	  <a href="#" class="norB"><%= lang.setLangValue("Home", "Trang chủ") %> &raquo;</a> <a href="#"><%= lang.setLangValue("Typical Building", "Công trình tiêu biểu")%></a></div>
          <div class="tabright"> <span><%= lang.setLangValue("Typical Building", "Công trình tiêu biểu")%></span> </div>
			<div class="contentright">
            	<div class="listbuild">
                	
                    	<ul>
                    	<%
    //------------------------------	
             
    int intCurPage = 0;
    int intStartRecord = 0;
    int intPageSize = 12;
    //------------------------------ 

     
   //-------------------------------		    		    
    intCurPage = clsPaging.getCurPage();
    intStartRecord = clsPaging.getStartRecord(intCurPage, intPageSize);
    //------------------------------ 		    
    string strSqlCount = "select count(*) from tbl_news  where FK_LangID = " + lang.getLangID() + "  and tbl_news.C_Active = 1 and (tbl_news.FK_CategoryID = "+intCatID+")";
    int intTotalPage = clsPaging.getTotalPage(strSqlCount, intPageSize);
    //string strParamPage = "page=" + Request.QueryString["page"] + "&mod=" + Request.QueryString["mod"] + "&key=" + strKey + "&catid=" + clsInput.getNumericInput("catid", 0);

    //========================================
    DataTable dtSub = clsDatabase.getDataTable("select top 5 tbl_news.* from tbl_news where FK_LangID = " + lang.getLangID() + "   and tbl_news.C_Active = 1 and (tbl_news.FK_CategoryID = " + intCatID + ") order by tbl_news.C_Rank desc", intStartRecord, intPageSize);
    
    
    int j = 0;
    
    if (dtSub.Rows.Count > 0)
    {
        //for (j = 0; j < dtSub.Rows.Count; j++)
        for (j = 0; j < dtSub.Rows.Count; j++)
        {
	%>
	        <% if (dtSub.Rows[j]["C_Img"].ToString() != "") {
                if (clsFile.fileExists("~/" + dtSub.Rows[j]["C_Img"].ToString()))
                {
             %>
                        	<li>
                              <a href="<%= clsConfig.GetHostUrl() %>/detail-news/<%= intTabId %>/<%= dtSub.Rows[j]["PK_NewsID"].ToString() %>/<%= clsFunction.RemoveUnicode(dtSub.Rows[j]["C_Name"].ToString()) %>.aspx"><img src="<%= clsConfig.GetHostUrl() %>/<%= dtSub.Rows[j]["C_Img"].ToString() %>" width="150" height="200" />
                            <%= dtSub.Rows[j]["C_Name"].ToString() %></a></li>
                <% } } %>
     <% 
           }
       } 
        %>                       
                            
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
                    str = str + "<a href='" + clsConfig.GetHostUrl() + "/cong-trinh-p_" + iPage.ToString() + "/" + intTabId + "/" + intCatID + "/" + clsFunction.RemoveUnicode(strCatName) + ".aspx" + "'>" + iPage.ToString() + "</a>";
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
            </div>
        </div>
        <!-- end blockright-->
      </div>