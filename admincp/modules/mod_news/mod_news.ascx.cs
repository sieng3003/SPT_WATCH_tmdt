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

public partial class admincp_modules_mod_news_mod_news : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Hien thi drodown
        displayCategory();
        //==============================================
        string strDo = clsInput.getStringInput("do", 0);
        int intId = clsInput.getNumericInput("id", 0);
        int intCat = clsInput.getNumericInput("cat", 0);
        string strKey = clsInput.getStringInput("key",0);

        string strS = "";
        if (intCat > 0)
            strS += "&cat=" + intCat;
        if (strKey != "")
            strS += "&key=" + strKey;

        //Doi vi tri ban ghi - Di chuyen len
        if (strDo == "up")
        {
            clsSwap.swapUpRecord("tbl_news", "PK_NewsID", intId, "FK_LangID = " + lang.getLangID());
            Response.Redirect(clsConfig.getCurrentUrl(strS));
        }
        //Doi vi tri ban ghi - Di chuyen xuong
        if (strDo == "down")
        {
            clsSwap.swapDownRecord("tbl_news", "PK_NewsID", intId, "FK_LangID = " + lang.getLangID());
            Response.Redirect(clsConfig.getCurrentUrl(strS));
        }
        //Khoa ban ghi
        if (strDo == "lock")
        {
            clsDatabase.ExecuteQuery("update tbl_news set C_Active = 0 where PK_NewsID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl(strS));
        }
        //Mo khoa ban ghi
        if (strDo == "unlock")
        {
            clsDatabase.ExecuteQuery("update tbl_news set C_Active = 1 where PK_NewsID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl(strS));
        }
        //Xoa du lieu
        if (strDo == "delete")
        {
            clsDatabase.ExecuteQuery("delete tbl_news where PK_NewsID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl(strS));
        }
        //Xoa nhieu ban ghi
        if (strDo == "DeleteAll")
        {
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("delete from tbl_news where PK_NewsID in (" + strAllRecord + ")");
            Response.Redirect(clsConfig.getCurrentUrl(strS));
        }
        //Active nhieu ban ghi
        if (strDo == "ActiveAll")
        {
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("update tbl_news set C_Active = 1 where PK_NewsID in (" + strAllRecord + ")");
            Response.Redirect(clsConfig.getCurrentUrl(strS));
        }
        //InActive nhieu ban ghi
        if (strDo == "InActiveAll")
        {
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("update tbl_news set C_Active = 0 where PK_NewsID in (" + strAllRecord + ")");
            Response.Redirect(clsConfig.getCurrentUrl(strS));
        }
    }
    private void displayCategory()
    {
        //Dropdown
        int intCat = clsInput.getNumericInput("cat",0);
        int intSelected = 0;
        DataTable dtCategory = clsDatabase.getDataTable("select * from tbl_category_news where  FK_LangID = " + lang.getLangID() + " and C_PointUrl = 0 and   FK_ParentID = 0 order by C_Rank desc");
        cat.Items.Clear();
        cat.Items.Add(new ListItem("", "0"));
        intSelected++;
        for (int i = 0; i < dtCategory.Rows.Count; i++)
        {
            cat.Items.Add(new ListItem(dtCategory.Rows[i]["C_Name"].ToString(), dtCategory.Rows[i]["PK_CategoryID"].ToString()));
            DataTable dtCategorySub = clsDatabase.getDataTable("select * from tbl_category_news where FK_ParentID = " + dtCategory.Rows[i]["PK_CategoryID"].ToString() + " AND FK_LangID = " + lang.getLangID() + " order by C_Rank desc");

            if (Convert.ToInt32(dtCategory.Rows[i]["PK_CategoryID"].ToString()) == intCat)
                cat.SelectedIndex = intSelected;

            intSelected++;

            if (dtCategorySub.Rows.Count > 0)
            {
                for (int j = 0; j < dtCategorySub.Rows.Count; j++)
                {
                    cat.Items.Add(new ListItem(Server.HtmlDecode("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;") + dtCategorySub.Rows[j]["C_Name"].ToString(), dtCategorySub.Rows[j]["PK_CategoryID"].ToString()));
                    if (Convert.ToInt32(dtCategorySub.Rows[j]["PK_CategoryID"].ToString()) == intCat)
                        cat.SelectedIndex = intSelected;
                    intSelected++;
                }
            }
          
        }
    }

}
