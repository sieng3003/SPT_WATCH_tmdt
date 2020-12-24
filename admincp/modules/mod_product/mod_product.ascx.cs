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

public partial class admincp_modules_mod_product_mod_product : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Hien thi drodown
        displayCategory();
        //==============================================
        string strDo = clsInput.getStringInput("do", 0);
        int intId = clsInput.getNumericInput("id", 0);
        //Doi vi tri ban ghi - Di chuyen len
        if (strDo == "up")
        {
            clsSwap.swapUpRecord("tbl_product", "PK_ProductID", intId, "FK_LangID = " + lang.getLangID());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Doi vi tri ban ghi - Di chuyen xuong
        if (strDo == "down")
        {
            clsSwap.swapDownRecord("tbl_product", "PK_ProductID", intId, "FK_LangID = " + lang.getLangID());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Khoa ban ghi
        if (strDo == "lock")
        {
            clsDatabase.ExecuteQuery("update tbl_product set C_Active = 0 where PK_ProductID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Mo khoa ban ghi
        if (strDo == "unlock")
        {
            clsDatabase.ExecuteQuery("update tbl_product set C_Active = 1 where PK_ProductID = " + intId.ToString());
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Xoa du lieu
        if (strDo == "delete")
        {
            clsDatabase.ExecuteQuery("delete tbl_product where PK_ProductID = " + intId.ToString());
            //Xoa file
            DataTable dt = clsDatabase.getDataTable("select * from tbl_product where PK_ProductID = " + intId);
            if (dt.Rows.Count > 0)
            {
                if (clsFile.fileExists("../" + dt.Rows[0]["C_Img"].ToString()))
                    clsFile.fileDelete("../" + dt.Rows[0]["C_Img"].ToString());
                if (clsFile.fileExists("../" + dt.Rows[0]["C_Img2"].ToString()))
                    clsFile.fileDelete("../" + dt.Rows[0]["C_Img2"].ToString());
            }
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Xoa nhieu ban ghi
        if (strDo == "DeleteAll")
        {
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("delete from tbl_product where PK_ProductID in (" + strAllRecord + ")");
            //Xoa file
            DataTable dt = clsDatabase.getDataTable("select * from tbl_product where PK_ProductID = " + intId);
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (clsFile.fileExists("../" + dt.Rows[i]["C_Img"].ToString()))
                        clsFile.fileDelete("../" + dt.Rows[i]["C_Img"].ToString());
                    if (clsFile.fileExists("../" + dt.Rows[i]["C_Img2"].ToString()))
                        clsFile.fileDelete("../" + dt.Rows[i]["C_Img2"].ToString());
                }
            }
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //Active nhieu ban ghi
        if (strDo == "ActiveAll")
        {
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("update tbl_product set C_Active = 1 where PK_ProductID in (" + strAllRecord + ")");
            Response.Redirect(clsConfig.getCurrentUrl());
        }
        //InActive nhieu ban ghi
        if (strDo == "InActiveAll")
        {
            string strAllRecord = Request.Form["listArrRecord"];
            clsDatabase.ExecuteQuery("update tbl_product set C_Active = 0 where PK_ProductID in (" + strAllRecord + ")");
            Response.Redirect(clsConfig.getCurrentUrl());
        }
    }
    private void displayCategory()
    {
        //Dropdown
        int intCat = clsInput.getNumericInput("cat", 0);
        int intSelected = 0;
        DataTable dtCategory = clsDatabase.getDataTable("select * from tbl_category_news where FK_LangID = " + lang.getLangID() + " and FK_ParentID = 0 order by C_Rank desc");
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
    protected void btn_Reset_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx?page=product&mod=product");
    }
}
