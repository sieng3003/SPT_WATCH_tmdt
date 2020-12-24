using System;
using System.Collections.Generic;
//using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class admincp_modules_mod_resquest_mod_resquest : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strDo = clsInput.getStringInput("do", 0);
        int intId = clsInput.getNumericInput("id", 0);
        //Doi vi tri ban ghi - Di chuyen len
        if (strDo == "up")
        {
            clsSwap.swapUpRecord("tbl_resquest", "PK_resquestID", intId, "FK_LangID = " + lang.getLangID());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Doi vi tri ban ghi - Di chuyen xuong
        if (strDo == "down")
        {
            clsSwap.swapDownRecord("tbl_resquest", "PK_resquestID", intId, "FK_LangID = " + lang.getLangID());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Khoa ban ghi
        if (strDo == "lock")
        {
            //====================================
            //clsHtml.checkLockPermission(4);
            //====================================
            clsDatabase.ExecuteQuery("update tbl_resquest set C_Active = 0 where PK_resquestID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Mo khoa ban ghi
        if (strDo == "unlock")
        {
            //====================================
            //clsHtml.checkLockPermission(4);
            //====================================
            clsDatabase.ExecuteQuery("update tbl_resquest set C_Active = 1 where PK_resquestID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Xoa du lieu
        if (strDo == "delete")
        {
            //====================================
            //clsHtml.checkDelPermission(4);
            //====================================
            clsDatabase.ExecuteQuery("delete tbl_resquest where PK_resquestID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Xoa nhieu ban ghi
        if (strDo == "DeleteAll")
        {
            //====================================
            //clsHtml.checkProcessDelPermission(4);
            //====================================
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("delete from tbl_resquest where PK_resquestID in (" + strAllRecord + ")");
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Active nhieu ban ghi
        if (strDo == "ActiveAll")
        {
            //====================================
            //clsHtml.checkProcessLockPermission(4);
            //====================================
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("update tbl_resquest set C_Active = 1 where PK_resquestID in (" + strAllRecord + ")");
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //InActive nhieu ban ghi
        if (strDo == "InActiveAll")
        {
            //====================================
            //clsHtml.checkProcessUnLockPermission(4);
            //====================================
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("update tbl_resquest set C_Active = 0 where PK_resquestID in (" + strAllRecord + ")");
            Response.Redirect(clsConfig.getCurrentUrl());
        }
    }

}