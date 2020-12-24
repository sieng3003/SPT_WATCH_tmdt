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

public partial class admincp_modules_mod_user_mod_control_user : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strDo = clsInput.getStringInput("do", 0);
        int intId = clsInput.getNumericInput("id", 0);
        
        //Khoa ban ghi
        if (strDo == "lock")
        {
            //====================================
            clsHtml.checkLockPermission(4);
            //====================================
            clsDatabase.ExecuteQuery("update tbl_user set C_Active = 0 where PK_UserID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Mo khoa ban ghi
        if (strDo == "unlock")
        {
            //====================================
            clsHtml.checkLockPermission(4);
            //====================================
            clsDatabase.ExecuteQuery("update tbl_user set C_Active = 1 where PK_UserID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Xoa du lieu
        if (strDo == "delete")
        {
            //====================================
            clsHtml.checkDelPermission(4);
            //====================================
            clsDatabase.ExecuteQuery("delete tbl_user where PK_UserID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Xoa nhieu ban ghi
        if (strDo == "DeleteAll")
        {
            //====================================
            clsHtml.checkProcessDelPermission(4);
            //====================================
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("delete from tbl_user where PK_UserID in (" + strAllRecord + ")");
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Active nhieu ban ghi
        if (strDo == "ActiveAll")
        {
            //====================================
            clsHtml.checkProcessLockPermission(4);
            //====================================
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("update tbl_user set C_Active = 1 where PK_UserID in (" + strAllRecord + ")");
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //InActive nhieu ban ghi
        if (strDo == "InActiveAll")
        {
            //====================================
            clsHtml.checkProcessUnLockPermission(4);
            //====================================
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("update tbl_user set C_Active = 0 where PK_UserID in (" + strAllRecord + ")");
            Response.Redirect(clsConfig.getCurrentUrl());
        }
    }
}
