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

public partial class admincp_modules_mod_adv_mod_adv : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //==============================================
        string strDo = clsInput.getStringInput("do", 0);
        int intId = clsInput.getNumericInput("id", 0);
        int intGetPage = clsInput.getNumericInput("getpage",0);
        int intP = clsInput.getNumericInput("p", 0);
        string strPage = "";
        string strParam = "";
        if (intGetPage > 0)
        {
            strPage += " and C_Page = " + intGetPage.ToString();
            strParam += "&getpage=" + intGetPage ;
        }
        strParam += "&p=" + intP;
        //Doi vi tri ban ghi - Di chuyen len
        if (strDo == "up")
        {
            clsSwap.swapUpRecord("tbl_adv", "PK_AdvID", intId, "FK_LangID = " + lang.getLangID() + strPage);
            
            Response.Redirect(clsConfig.getCurrentUrl(strParam));
        }
        //Doi vi tri ban ghi - Di chuyen xuong
        if (strDo == "down")
        {
            clsSwap.swapDownRecord("tbl_adv", "PK_AdvID", intId, "FK_LangID = " + lang.getLangID() + strPage);           
            Response.Redirect(clsConfig.getCurrentUrl(strParam));
        }
        //Khoa ban ghi
        if (strDo == "lock")
        {
            clsDatabase.ExecuteQuery("update tbl_adv set C_Active = 0 where PK_AdvID = " + intId.ToString());
            //Response.Write(strParam);
            Response.Redirect(clsConfig.getCurrentUrl(strParam));
        }
        //Mo khoa ban ghi
        if (strDo == "unlock")
        {
            clsDatabase.ExecuteQuery("update tbl_adv set C_Active = 1 where PK_AdvID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl(strParam));
        }
        //Xoa du lieu
        if (strDo == "delete")
        {
            clsDatabase.ExecuteQuery("delete tbl_adv where PK_AdvID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl(strParam));
        }
        //Xoa nhieu ban ghi
        if (strDo == "DeleteAll")
        {
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("delete from tbl_adv where PK_AdvID in (" + strAllRecord + ")");
            Response.Redirect(clsConfig.getCurrentUrl(strParam));
        }
        //Active nhieu ban ghi
        if (strDo == "ActiveAll")
        {
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("update tbl_adv set C_Active = 1 where PK_AdvID in (" + strAllRecord + ")");
            Response.Redirect(clsConfig.getCurrentUrl(strParam));
            //Response.Write(intP);
        }
        //InActive nhieu ban ghi
        if (strDo == "InActiveAll")
        {
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("update tbl_adv set C_Active = 0 where PK_AdvID in (" + strAllRecord + ")");
            Response.Redirect(clsConfig.getCurrentUrl(strParam));
        }
    }
}
