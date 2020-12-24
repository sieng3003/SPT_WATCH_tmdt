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

public partial class admincp_modules_menu_mod_menu : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strDo = clsInput.getStringInput("do", 0);
        int intId = clsInput.getNumericInput("id", 0);
        //get ParentID
        string strParentID = "";            
        //Doi vi tri ban ghi - Di chuyen len
        if (strDo == "up")
        {
            strParentID = clsDatabase.getStringFieldDataTable("FK_ParentID", "tbl_menu", "where PK_MenuID = " + intId.ToString() + " and FK_LangID = " + lang.getLangID().ToString());
            clsSwap.swapUpRecord("tbl_menu", "PK_MenuID", intId, "FK_ParentID = "+ strParentID +" and FK_LangID = " + lang.getLangID());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Doi vi tri ban ghi - Di chuyen xuong
        if (strDo == "down")
        {
            strParentID = clsDatabase.getStringFieldDataTable("FK_ParentID", "tbl_menu", "where PK_MenuID = " + intId.ToString() + " and FK_LangID = " + lang.getLangID().ToString());
            clsSwap.swapDownRecord("tbl_menu", "PK_MenuID", intId, "FK_ParentID = "+ strParentID +" and FK_LangID = " + lang.getLangID());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Khoa ban ghi
        if (strDo == "lock")
        {
            clsDatabase.ExecuteQuery("update tbl_menu set C_Active = 0 where PK_MenuID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Mo khoa ban ghi
        if (strDo == "unlock")
        {
            clsDatabase.ExecuteQuery("update tbl_menu set C_Active = 1 where PK_MenuID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Xoa du lieu
        if (strDo == "delete")
        {
            clsDatabase.ExecuteQuery("delete tbl_menu where PK_MenuID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
    }
}
