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
using System.IO;

public partial class admincp_modules_mod_menu_mod_add_edit_menu : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strDo = clsInput.getStringInput("do", 0);
        int intId = clsInput.getNumericInput("id", 0);

        if (strDo == "edit" && intId > 0)
        {
            PnAdd.Visible = false;
            PnEdit.Visible = true;
            if (!Page.IsPostBack)
                edit_menu(intId);
        }
        else if (strDo == "add")
        {
            PnAdd.Visible = true;
            PnEdit.Visible = false;
            if (!Page.IsPostBack)
                add_menu();
        }
        else
        {
            //Hien thi thong bao loi, khong thay tac vu yeu cau
            //==================================================
            //Display Msg
            clsConfig.redirectUrl("Default.aspx?page=menu&mod=menu");
            //==================================================
        }

    }


    private void edit_menu(int intID)
    {
        //DrdCategoryIcon.Items.Add();
        DataTable dt = clsDatabase.getDataTable("select * from tbl_menu where PK_MenuID = " + intID + " and FK_LangID=" + lang.getLangID());
        //==========================
        string strName = "";
        string strUrl = "";
        string strIcon = "";
        int intCheckAdd = 0;
        int intCheckEdit = 0;
        int intCheckDel = 0;
        int intCheckLock = 0;
        int intParentID = 0;
        //==========================

        if (dt.Rows.Count > 0)
        {
            strName = dt.Rows[0]["C_Name"].ToString();
            strUrl = dt.Rows[0]["C_Url"].ToString();
            strIcon = dt.Rows[0]["C_Icon"].ToString();
            intCheckAdd = Convert.ToInt16(dt.Rows[0]["C_Add"]);
            intCheckEdit = Convert.ToInt16(dt.Rows[0]["C_Edit"]);
            intCheckDel = Convert.ToInt16(dt.Rows[0]["C_Del"]);
            intCheckLock = Convert.ToInt16(dt.Rows[0]["C_Lock"]);
            intParentID = Convert.ToInt16(dt.Rows[0]["FK_ParentID"]);
        }
        
        if (Page.IsPostBack)
            return;
        
        //=============================================================        
        
        string[] fileList = Directory.GetFiles(Server.MapPath("images/ThemeOffice/"));        
        string strFileName;               
        //======================================
        string[] separator = new string[] { "ThemeOffice" };
        string[] strSplitArr = new string[200];        
        //======================================        
        DrdCategoryIcon.Items.Add(new ListItem("", ""));
        int intCountIcon = 0;
        foreach (string strSourceFile in fileList)
        {
            if (File.Exists(strSourceFile))
            {                
                strSplitArr = strSourceFile.Split(separator, StringSplitOptions.RemoveEmptyEntries);
                strFileName = strSplitArr[1];
                strFileName = strFileName.Substring(1);                
                //=====================================                
                DrdCategoryIcon.Items.Add(new ListItem(strFileName, strFileName));
                if (strFileName == strIcon)
                    DrdCategoryIcon.SelectedIndex = intCountIcon + 1;
                intCountIcon++;
            }
        }
                
        //=============================================================

        //Dropdown
        DataTable dtCategory = clsDatabase.getDataTable("select * from tbl_Menu where FK_ParentID = 0 AND FK_LangID = " + lang.getLangID() + " order by C_Rank desc");
        DrdCategory.Items.Clear();
        DrdCategory.Items.Add(new ListItem("", "0"));
        int intSelected = 0;
        // Response.Write();
        
        for (int i = 0; i < dtCategory.Rows.Count; i++)
        {
            if(Convert.ToInt16(dtCategory.Rows[i]["PK_MenuID"]) == intID)
                ;
            else
                DrdCategory.Items.Add(new ListItem(dtCategory.Rows[i]["C_Name"].ToString(), dtCategory.Rows[i]["PK_MenuID"].ToString()));
            if (Convert.ToInt16(dtCategory.Rows[i]["PK_MenuID"]) == intParentID)
            {                
                DrdCategory.SelectedIndex = intSelected+1;
            }            
            intSelected++;                                     
        }

        // Set the startup editor value.
        txtName.Text = strName;
        txtUrl.Text = strUrl;
        if (intCheckAdd == 1)
            ChkAdd.Checked = true;
        if (intCheckEdit == 1)
            ChkEdit.Checked = true;
        if (intCheckDel == 1)
            ChkDel.Checked = true;
        if (intCheckLock == 1)
            ChkLock.Checked = true;
        
        if (strIcon != "" || strIcon != null)
            lblIcon.Text = "<img id=\"image\" name=\"image\" src=\"images/ThemeOffice/"+ strIcon +"\" />";        
        if(strIcon == "")
            lblIcon.Text = "<img id=\"image\" name=\"image\" src=\"images/ThemeOffice/blank.png\" />";
        
        //==========================================
    }

    private void add_menu()
    {        
        //==========================
        string strName = "";
        string strUrl = "";
        string strIcon = "";
        int intCheckAdd = 0;
        int intCheckEdit = 0;
        int intCheckDel = 0;
        int intCheckLock = 0;
        //==========================

        
        //=============================================================        

        string[] fileList = Directory.GetFiles(Server.MapPath("images/ThemeOffice/"));
        string strFileName;
        //======================================
        string[] separator = new string[] { "ThemeOffice" };
        string[] strSplitArr = new string[200];
        //======================================        
        DrdCategoryIcon.Items.Add(new ListItem("", ""));
        int intCountIcon = 0;
        foreach (string strSourceFile in fileList)
        {
            if (File.Exists(strSourceFile))
            {
                strSplitArr = strSourceFile.Split(separator, StringSplitOptions.RemoveEmptyEntries);
                strFileName = strSplitArr[1];
                strFileName = strFileName.Substring(1);
                //=====================================                
                DrdCategoryIcon.Items.Add(new ListItem(strFileName, strFileName));
                if (strFileName == strIcon)
                    DrdCategoryIcon.SelectedIndex = intCountIcon + 1;
                intCountIcon++;
            }
        }

        //=============================================================

        //Dropdown
        DataTable dtCategory = clsDatabase.getDataTable("select * from tbl_Menu where FK_ParentID = 0 AND FK_LangID = " + lang.getLangID() + " order by C_Rank desc");
        DrdCategory.Items.Clear();
        DrdCategory.Items.Add(new ListItem("", "0"));

        for (int i = 0; i < dtCategory.Rows.Count; i++)
        {
            DrdCategory.Items.Add(new ListItem(dtCategory.Rows[i]["C_Name"].ToString(), dtCategory.Rows[i]["PK_MenuID"].ToString()));            
        }        
        lblIcon.Text = "<img id=\"image\" name=\"image\" src=\"images/ThemeOffice/blank.png\" />";

        //==========================================        
    }

    protected void BtnSubmit_ServerClick(object sender, EventArgs e)
    {
        //Khoi tao cac gia tri
        string strName = clsInput.encodeStr(txtName.Text);
        string strUrl = clsInput.encodeStr(txtUrl.Text);
        int intCategoryID = Convert.ToInt32(DrdCategory.SelectedValue.ToString());
        string strIcon = DrdCategoryIcon.Value.ToString();
        int intCheckAdd = 0;
        int intCheckEdit = 0;
        int intCheckDel = 0;
        int intCheckLock = 0;
        if (ChkAdd.Checked == true)
            intCheckAdd = 1;
        if (ChkEdit.Checked == true)
            intCheckEdit = 1;
        if (ChkDel.Checked == true)
            intCheckDel = 1;
        if (ChkLock.Checked == true)
            intCheckLock = 1;
        //====================================================
        //Get Url
        int intId = clsInput.getNumericInput("id", 0);
        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strName == "")
            clsErr.setErr("Tiêu đề", "Bạn hãy nhập vào tiêu đề");
        //Ket xuat loi
        if (clsErr.checkErr())
        {
            block_error.Text = clsErr.displayErr();
        }
        else
        {
            string strSql = "insert into tbl_menu(C_Name, C_Url, C_Icon, C_Add, C_Edit, C_Del, C_Lock, FK_ParentID, FK_LangID) values(N'" + strName + "','" + strUrl + "','" + strIcon + "'," + intCheckAdd + "," + intCheckEdit + "," + intCheckDel + "," + intCheckLock + "," + intCategoryID + "," + lang.getLangID() +")";
            clsDatabase.ExecuteQuery(strSql);
            int intInsertId = clsDatabase.getInsertID("tbl_menu", "PK_MenuID");
            clsDatabase.ExecuteQuery("update tbl_menu set C_Rank = " + intInsertId + " where PK_MenuID = " + intInsertId);
            Response.Redirect("Default.aspx?page=menu&mod=menu");
        }

        //===============================================
    }
    protected void BtnEdit_ServerClick(object sender, EventArgs e)
    {        
        //Khoi tao cac gia tri
        string strName = clsInput.encodeStr(txtName.Text);        
        string strUrl = clsInput.encodeStr(txtUrl.Text);
        int intCategoryID = Convert.ToInt32(DrdCategory.SelectedValue.ToString());
        string strIcon = DrdCategoryIcon.Value.ToString();
        int intCheckAdd = 0;
        int intCheckEdit = 0;
        int intCheckDel = 0;
        int intCheckLock = 0;
        if (ChkAdd.Checked == true)
            intCheckAdd = 1;
        if (ChkEdit.Checked == true)
            intCheckEdit = 1;
        if (ChkDel.Checked == true)
            intCheckDel = 1;
        if (ChkLock.Checked == true)
            intCheckLock = 1;
        //====================================================
        //Get Url
        int intId = clsInput.getNumericInput("id", 0);
        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strName == "")
            clsErr.setErr("Tiêu đề", "Bạn hãy nhập vào tiêu đề");
        //Ket xuat loi
        if (clsErr.checkErr())
        {
            block_error.Text = clsErr.displayErr();
        }
        else
        {
            string strSql = "update tbl_menu set C_Name = N'" + strName + "', C_Url = '" + strUrl + "', C_Icon = '" + strIcon + "', C_Add = " + intCheckAdd + ",C_Edit = " + intCheckEdit + ",C_Del = " + intCheckDel + ",C_Lock = " + intCheckLock + ",FK_ParentID = " + intCategoryID + " where PK_MenuID=" + intId;
            clsDatabase.ExecuteQuery(strSql);
            Response.Redirect("Default.aspx?page=menu&mod=menu");
        }
        
        //===============================================
    }
}
