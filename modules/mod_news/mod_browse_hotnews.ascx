<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_browse_hotnews.ascx.cs" Inherits="modules_mod_news_mod_browse_hotnews" %>
<%@Import Namespace = "System.Data" %>

<div class="">
        <div class="blockright">
        <div class="guide">
       	  
       	 
       	   <div class="guide">
       	  <a href="#" class="norB"><%= lang.setLangValue("Home", "Trang chủ")%> &raquo;</a> <a href="#"><%= lang.setLangValue("Hot news", "Tin nổi bật")%></a></div>
       	  </div>
          <div class="tabright"> <span>
          CÁC BÀI VIẾT
          </span> </div>
          
			<div class="contentright">
            	
		
            
            <div class="comment">
            	
               <div style="clear:both"></div>
               <div class="listcomment">
 <%
    //------------------------------	
             
    int intCurPage = 0;
    int intStartRecord = 0;
    int intPageSize = 6;
    //------------------------------ 

     
   //-------------------------------		    		    
    intCurPage = clsPaging.getCurPage();
    intStartRecord = clsPaging.getStartRecord(intCurPage, intPageSize);
    //------------------------------ 		    
    string strSqlCount = "select count(*) from tbl_news  where FK_LangID = " + lang.getLangID() + "  and tbl_news.C_Active = 1 and tbl_news.C_Hot = 1";
    int intTotalPage = clsPaging.getTotalPage(strSqlCount, intPageSize);
    //string strParamPage = "page=" + Request.QueryString["page"] + "&mod=" + Request.QueryString["mod"] + "&key=" + strKey + "&catid=" + clsInput.getNumericInput("catid", 0);

    //========================================
    DataTable dtSub = clsDatabase.getDataTable("select tbl_news.* from tbl_news where FK_LangID = " + lang.getLangID() + "   and tbl_news.C_Active = 1 and tbl_news.C_Hot =  1 order by tbl_news.C_Rank desc", intStartRecord, intPageSize);
    
    
    int j = 0;
    if (dtSub.Rows.Count == 1)
        Response.Redirect(clsConfig.GetHostUrl()+"/detail-news/"+ dtSub.Rows[j]["PK_NewsID"].ToString()+"/"+ clsFunction.RemoveUnicode(dtSub.Rows[j]["C_Name"].ToString())+".aspx");
    if (dtSub.Rows.Count > 0)
    {
        //for (j = 0; j < dtSub.Rows.Count; j++)
        for (j = 0; j < dtSub.Rows.Count; j++)
        {
	%>              	
                	
                	<div class="blockcomment">
                	<span class="norB"><a href="<%= clsConfig.GetHostUrl() %>/detail-news/0/<%= dtSub.Rows[j]["PK_NewsID"].ToString() %>/<%= clsFunction.RemoveUnicode(dtSub.Rows[j]["C_Name"].ToString()) %>.aspx"><%= dtSub.Rows[j]["C_Name"].ToString() %></a></span>
					<p>
					<%
					    if(dtSub.Rows[j]["C_Img"].ToString() != "")
					    {
					 %>
					<img src="<%= clsConfig.GetHostUrl() %>/<%= dtSub.Rows[j]["C_Img"].ToString() %>" style="float:left; width:100px; padding-right:5px; padding-bottom:3px;" />
					<% } %>
					<%= clsInput.decodeStr(dtSub.Rows[j]["C_Des"].ToString())%>
					</p>
                <div style="clear:both"></div>
                </div>
                
   <% 
           }
       } 
        %>             	
                	
                	
               </div>
              
			  
			  
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
                    str = str + "<a href='" + clsConfig.GetHostUrl() + "/hot-news-p_" + iPage.ToString() + "/tab.aspx" + "'>" + iPage.ToString() + "</a>";
                }
            }
            //--------------------------------------------

            //str = str + "<a href='#'>Trang sau</a>";
            //--------------------------------------------
        }
        
        Response.Write(str);
					 %>
			 
			  </div>
			  
			  
			  
            </div>
            </div>
        </div>
        <!-- end blockright-->
      </div>
    
    