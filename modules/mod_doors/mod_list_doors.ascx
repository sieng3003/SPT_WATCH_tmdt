<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mod_list_doors.ascx.cs" Inherits="modules_mod_doors_mod_list_doors" %>
<%@Import Namespace = "System.Data" %>
<%
    int intTabId = 7;
    int intParentID = 0;
    if (lang.getLangID() == 2)
        intParentID = 37;
    else
        intParentID = 35;
    string strCatName = "";
    int intCatID = clsInput.getNumericInput("catid",0);
 %>
<div class="">
      	<div class="guide">
       	  <a href="#" class="norB"><%= lang.setLangValue("Home", "Trang chủ")%> &raquo;</a> <a href="#"><%= lang.setLangValue("Plastic Doors, Doors", "Cửa nhựa, cửa cuốn")%></a></div>
        <div class="blockright">
          <div class="tabright"> <span>
          <%
              DataTable dtCatName = clsDatabase.getDataTable("select C_Name from tbl_category_news where FK_LangID = " + lang.getLangID() + " and PK_CategoryID =" + intCatID);
              if(dtCatName.Rows.Count > 0)
              {
                  strCatName = dtCatName.Rows[0]["C_Name"].ToString();
           %>
          <%= dtCatName.Rows[0]["C_Name"].ToString() %>
          <% } %>
          </span> </div>
          
          
          
          
          
  <%
    DataTable dtListdoors = clsDatabase.getDataTable("select tbl_news.* from tbl_news where FK_LangID = " + lang.getLangID() + "   and tbl_news.C_Active = 1 and tbl_news.FK_CategoryID =  " + intCatID + " order by tbl_news.C_Rank desc");

   if (dtListdoors.Rows.Count > 0)
    {
   %>        
          
          
          <div class="comment">
            	
              
 <%
     
        //for (j = 0; j < dtSub.Rows.Count; j++)
        for (int idoors = 0; idoors < dtListdoors.Rows.Count; idoors++)
        {
	%>              	
                	
                	<div style="padding-top:5px;">
                	<span class="norB"><a href="<%= clsConfig.GetHostUrl() %>/detail-news/0/<%= dtListdoors.Rows[idoors]["PK_NewsID"].ToString() %>/<%= clsFunction.RemoveUnicode(dtListdoors.Rows[idoors]["C_Name"].ToString()) %>.aspx"><%= dtListdoors.Rows[idoors]["C_Name"].ToString()%></a></span>
					
                </div>
                
   <% 
           }      
        %>             	
                	
             
            </div>
          
  <% } %>        
          
          
          
          
          
          
          
          
          
          <div class="listitem">
            <ul>
            <%
    //------------------------------	
             
    int intCurPage = 0;
    int intStartRecord = 0;
    int intPageSize = 28;
    //------------------------------ 

     
   //-------------------------------		    		    
    intCurPage = clsPaging.getCurPage();
    intStartRecord = clsPaging.getStartRecord(intCurPage, intPageSize);
    //------------------------------ 		    
    string strSqlCount = "select count(*) from tbl_doors  where FK_LangID = " + lang.getLangID() + "  and tbl_doors.C_Active = 1 and (tbl_doors.FK_CategoryID = "+intCatID+")";
    int intTotalPage = clsPaging.getTotalPage(strSqlCount, intPageSize);
    //string strParamPage = "page=" + Request.QueryString["page"] + "&mod=" + Request.QueryString["mod"] + "&key=" + strKey + "&catid=" + clsInput.getNumericInput("catid", 0);

    //========================================
    DataTable dtSub = clsDatabase.getDataTable("select tbl_doors.* from tbl_doors where FK_LangID = " + lang.getLangID() + "   and tbl_doors.C_Active = 1 and (tbl_doors.FK_CategoryID = " + intCatID + ") order by tbl_doors.C_Rank desc", intStartRecord, intPageSize);
    
    
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
                              <a href="<%= clsConfig.GetHostUrl() %>/detail-doors/<%= intTabId %>/<%= dtSub.Rows[j]["PK_doorsID"].ToString() %>/<%= clsFunction.RemoveUnicode(dtSub.Rows[j]["C_Name"].ToString()) %>.aspx"><img src="<%= clsConfig.GetHostUrl() %>/<%= dtSub.Rows[j]["C_Img"].ToString() %>" width="150" height="90" />
                            <%= dtSub.Rows[j]["C_Name"].ToString() %></a><br /><%= dtSub.Rows[j]["C_Intro"].ToString()%></li>
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
                    str = str + "<a href='" + clsConfig.GetHostUrl() + "/doors-p_" + iPage.ToString() + "/" + intTabId + "/" + intCatID + "/" + clsFunction.RemoveUnicode(strCatName) + ".aspx" + "'>" + iPage.ToString() + "</a>";
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
        <!-- end blockright-->
        
      </div>