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

public partial class admincp_modules_mod_permission_mod_group : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strDo = clsInput.getStringInput("do", 0);
        int intId = clsInput.getNumericInput("id", 0);
        //Doi vi tri ban ghi - Di chuyen len
        if (strDo == "up")
        {
            clsSwap.swapUpRecord("tbl_groupmember", "PK_GroupMemberID", intId, " FK_LangID = " + lang.getLangID() + " and C_System <> 1");
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Doi vi tri ban ghi - Di chuyen xuong
        if (strDo == "down")
        {
            clsSwap.swapDownRecord("tbl_groupmember", "PK_GroupMemberID", intId, " FK_LangID = " + lang.getLangID() + " and C_System <> 1");
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Khoa ban ghi
        if (strDo == "lock")
        {
            //====================================
            clsHtml.checkLockPermission(5);
            //====================================
            clsDatabase.ExecuteQuery("update tbl_groupmember set C_Active = 0 where PK_GroupMemberID = " + intId.ToString() + " and C_System <> 1");
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Mo khoa ban ghi
        if (strDo == "unlock")
        {
            //====================================
            clsHtml.checkLockPermission(5);
            //====================================
            clsDatabase.ExecuteQuery("update tbl_groupmember set C_Active = 1 where PK_GroupMemberID = " + intId.ToString() + " and C_System <> 1");
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Xoa du lieu
        if (strDo == "delete")
        {
            //====================================
            clsHtml.checkDelPermission(5);
            //====================================
            //Xoa thong tin o bang phan quyen
            clsDatabase.ExecuteQuery("delete from tbl_permission where FK_GroupMemberID = " + intId);
            clsDatabase.ExecuteQuery("delete tbl_groupmember where PK_GroupMemberID = " + intId.ToString() + " and C_System <> 2  and C_System <> 1");
            //reset user cua nhom quyen nay ve nhom quyen mac dinh cua he thong
            clsDatabase.ExecuteQuery("update tbl_user set FK_GroupMemberID = 3 where FK_GroupMemberID = " + intId);
            Response.Redirect(clsConfig.getCurrentUrl());
        }
    }
}
