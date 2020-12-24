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

public partial class admincp_modules_mod_doors_mod_doors : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //==============================================
        string strDo = clsInput.getStringInput("do", 0);
        int intId = clsInput.getNumericInput("id", 0);
        //Doi vi tri ban ghi - Di chuyen len
        if (strDo == "up")
        {
            clsSwap.swapUpRecord("tbl_doors", "PK_doorsID", intId, "FK_LangID = " + lang.getLangID());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Doi vi tri ban ghi - Di chuyen xuong
        if (strDo == "down")
        {
            clsSwap.swapDownRecord("tbl_doors", "PK_doorsID", intId, "FK_LangID = " + lang.getLangID());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Khoa ban ghi
        if (strDo == "lock")
        {
            clsDatabase.ExecuteQuery("update tbl_doors set C_Active = 0 where PK_doorsID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Mo khoa ban ghi
        if (strDo == "unlock")
        {
            clsDatabase.ExecuteQuery("update tbl_doors set C_Active = 1 where PK_doorsID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Xoa du lieu
        if (strDo == "delete")
        {
            clsDatabase.ExecuteQuery("delete tbl_doors where PK_doorsID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Xoa nhieu ban ghi
        if (strDo == "DeleteAll")
        {
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("delete from tbl_doors where PK_doorsID in (" + strAllRecord + ")");
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Active nhieu ban ghi
        if (strDo == "ActiveAll")
        {
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("update tbl_doors set C_Active = 1 where PK_doorsID in (" + strAllRecord + ")");
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //InActive nhieu ban ghi
        if (strDo == "InActiveAll")
        {
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("update tbl_doors set C_Active = 0 where PK_doorsID in (" + strAllRecord + ")");
            Response.Redirect(clsConfig.getCurrentUrl());
        }
    }
}
