using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class admincp_modules_mod_permission_mod_user_permission : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //====================================
        //clsHtml.checkDelPermission(5);
        //====================================
        //Response.Write(checkRecord(4,6).ToString());
        string strDo = clsInput.getStringInput("do", 0);
        int intId = clsInput.getNumericInput("id", 0);
        if (intId == 0)
            Response.Redirect("Default.aspx?page=group&mod=permission");
        
        if (strDo == "user_permission")
        {
            string strAllRecord = Request.Form["listArrRecord"];
            //Response.Write(strAllRecord);
            
            //get Group System
            //int intGroupSystem = 0;
            //DataTable dt = clsDatabase.getDataTable("select PK_GroupMemberID from tbl_groupmember where C_System = 1");
            //if (dt.Rows.Count > 0)
            //{
            //    intGroupSystem = Convert.ToInt32(dt.Rows[0]["PK_GroupMemberID"]);
            //}
            //Response.Write(intGroupSystem.ToString());
            //re set cac nhom ve group system
            //clsDatabase.ExecuteQuery("update tbl_user set FK_GroupMemberID = " + intGroupSystem + " where C_Change = 1 and PK_UserID not in (" + strAllRecord + ")");
            //gan lai nhom cho cac user
            
            
            //clsDatabase.ExecuteQuery("update tbl_user set FK_GroupMemberID = " + intId + " where PK_UserID in (" + strAllRecord + ")");
            //Xoa thong tin o tbl_user_groupmember co FK_GroupMember
            clsDatabase.ExecuteQuery("delete from tbl_user_groupmember where FK_GroupMemberID = " + intId);
            //insert thong tin
            //Cat chuoi tinh tu tag ","
            string[] separator_ListUser = new string[] { "," };
            string[] strSplitArr_ListUser = strAllRecord.Split(separator_ListUser, StringSplitOptions.RemoveEmptyEntries);
            foreach (string str1 in strSplitArr_ListUser)
            {
                if (str1 != "0")
                {
                    //Insert thong tin vao table
                    //Response.Write(str + "<br>");
                    clsDatabase.ExecuteQuery("insert into tbl_user_groupmember(FK_UserID,FK_GroupMemberID) values(" + str1 + "," + intId + ")");
                }
            }
            //clsDatabase.ExecuteQuery("insert into tbl_user_groupmember(FK_UserID)");
            
            Response.Redirect("Default.aspx?page=group&mod=permission");
            
        }
         
    }
}
