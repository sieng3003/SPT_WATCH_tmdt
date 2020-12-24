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

public partial class admincp_modules_mod_permission_mod_group_permission : System.Web.UI.UserControl
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
        if (strDo == "group_permission")
        {
            //Xoa thong tin lien quan de thuc hien lai viec phan quyen
            clsDatabase.ExecuteQuery("delete from tbl_permission where FK_GroupMemberID=" + intId + " and C_Change = 1");

            string strAllRecord = Request.Form["listArrRecord"];
            //split into character ","
            string[] separator = new string[] { "," };
            string[] strSplitArr = strAllRecord.Split(separator, StringSplitOptions.RemoveEmptyEntries);
            foreach (string str in strSplitArr)
            {
                if (str != "0")
                    clsDatabase.ExecuteQuery("insert into tbl_permission(FK_MenuID, FK_GroupMemberID) values (" + str + "," + intId.ToString() + ")");
            }
            //clsDatabase.ExecuteQuery("insert into tbl_permission(FK_MenuID, FK_GroupMemberID) values ('" + strAllRecord + "',"+ intId.ToString() +")");
            Response.Redirect("Default.aspx?page=group&mod=permission");
        }
    }

}
