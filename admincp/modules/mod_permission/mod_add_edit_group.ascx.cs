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

public partial class admincp_modules_mod_permission_mod_add_edit_group : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //===============================================================
        CKFinder.FileBrowser _FileBrowser1 = new CKFinder.FileBrowser();
        _FileBrowser1.BasePath = "../ckfinder/";
        _FileBrowser1.SetupCKEditor(CKEditor_ThongTin);
        //===============================================================
        string strDo = clsInput.getStringInput("do", 0);
        int intId = clsInput.getNumericInput("id", 0);

        if (strDo == "edit" && intId > 0)
        {
            PnAdd.Visible = false;
            PnEdit.Visible = true;
            if (!Page.IsPostBack)
                edit_groupmember(intId);
        }
        else if (strDo == "add")
        {
            PnAdd.Visible = true;
            PnEdit.Visible = false;
            if (!Page.IsPostBack)
                add_groupmember();
        }
        else
        {
            //Hien thi thong bao loi, khong thay tac vu yeu cau
            //==================================================
            //Display Msg
            clsConfig.redirectUrl("Default.aspx?page=groupmember&mod=news");
            //==================================================
        }

    }


    private void edit_groupmember(int intID)
    {
        
        DataTable dt = clsDatabase.getDataTable("select * from tbl_groupmember where PK_GroupMemberID = " + intID);
        string strName = "";
        string strDes = "";
        int intCheckAdd = 0;
        int intCheckEdit = 0;
        int intCheckDel = 0;
        int intCheckLock = 0;
        int intCheckView = 0;
        int intCheckProcessLock = 0;
        int intCheckProcessUnLock = 0;
        int intCheckProcessDel = 0;
        

        if (dt.Rows.Count > 0)
        {
            strName = dt.Rows[0]["C_Name"].ToString();
            strDes = dt.Rows[0]["C_Des"].ToString();
            intCheckAdd = Convert.ToInt16(dt.Rows[0]["C_Add"]);
            intCheckEdit = Convert.ToInt16(dt.Rows[0]["C_Edit"]);
            intCheckDel = Convert.ToInt16(dt.Rows[0]["C_Del"]);
            intCheckLock = Convert.ToInt16(dt.Rows[0]["C_Lock"]);
            intCheckView = Convert.ToInt16(dt.Rows[0]["C_View"]);
            intCheckProcessLock = Convert.ToInt16(dt.Rows[0]["C_ProcessLock"]);
            intCheckProcessUnLock = Convert.ToInt16(dt.Rows[0]["C_ProcessUnLock"]);
            intCheckProcessDel = Convert.ToInt16(dt.Rows[0]["C_ProcessDel"]);
        }

        //===============================================================
        FCKeditor2.BasePath = clsConfig.getFckPath();
        //setup lang
        FCKeditor2.Config["AutoDetectLanguage"] = "false";
        FCKeditor2.Config["DefaultLanguage"] = "vi";
        FCKeditor2.Width = 900;
        FCKeditor2.Height = 250;
        //setup thame
        FCKeditor2.Config["SkinPath"] = clsConfig.getFckPath() + "editor/skins/office2003/";
        //===============================================================
        if (Page.IsPostBack)
            return;
        
        // Set the startup editor value.
        txtName.Text = strName;
        FCKeditor2.Value = strDes;
        CKEditor_ThongTin.Text = strDes;
        if (intCheckAdd == 1)
            ChkAdd.Checked = true;
        if (intCheckEdit == 1)
            ChkEdit.Checked = true;
        if (intCheckDel == 1)
            ChkDel.Checked = true;
        if (intCheckLock == 1)
            ChkLock.Checked = true;
        if (intCheckView == 1)
            ChkView.Checked = true;
        if (intCheckProcessLock == 1)
            ChkProcessLock.Checked = true;
        if (intCheckProcessUnLock == 1)
            ChkProcessUnLock.Checked = true;
        if (intCheckProcessDel == 1)
            ChkProcessDel.Checked = true;
        //==========================================
         
    }

    private void add_groupmember()
    {
        string strName = "";
        string strDes = "";
        int intCheckAdd = 0;
        int intCheckEdit = 0;
        int intCheckDel = 0;
        int intCheckLock = 0;
        int intCheckView = 0;
        int intCheckProcessLock = 0;
        int intCheckProcessUnLock = 0;
        int intCheckProcessDel = 0;

        //===============================================================
        FCKeditor2.BasePath = clsConfig.getFckPath();
        //setup lang
        FCKeditor2.Config["AutoDetectLanguage"] = "false";
        FCKeditor2.Config["DefaultLanguage"] = "vi";
        FCKeditor2.Width = 900;
        FCKeditor2.Height = 250;
        //setup thame
        FCKeditor2.Config["SkinPath"] = clsConfig.getFckPath() + "editor/skins/office2003/";
        //===============================================================
        if (Page.IsPostBack)
            return;

        // Set the startup editor value.        
        ChkAdd.Checked = true;        
        ChkEdit.Checked = true;        
        ChkDel.Checked = true;        
        ChkLock.Checked = true;       
        ChkView.Checked = true;        
        ChkProcessLock.Checked = true;        
        ChkProcessUnLock.Checked = true;        
        ChkProcessDel.Checked = true;
        //==========================================
    }

    protected void BtnSubmit_ServerClick(object sender, EventArgs e)
    {
        //Khoi tao cac gia tri
        string strName = clsInput.encodeStr(txtName.Text);
        string strDes = clsInput.encodeStr(FCKeditor2.Value);
        strDes = clsInput.encodeStr(CKEditor_ThongTin.Text);
        int intCheckAdd = 0;
        int intCheckEdit = 0;
        int intCheckDel = 0;
        int intCheckLock = 0;
        int intCheckView = 0;
        int intCheckProcessLock = 0;
        int intCheckProcessUnLock = 0;
        int intCheckProcessDel = 0;
        if (ChkAdd.Checked == true)
            intCheckAdd = 1;
        if (ChkEdit.Checked == true)
            intCheckEdit = 1;
        if (ChkDel.Checked == true)
            intCheckDel = 1;
        if (ChkLock.Checked == true)
            intCheckLock = 1;
        if (ChkProcessLock.Checked == true)
            intCheckProcessLock = 1;
        if (ChkProcessUnLock.Checked == true)
            intCheckProcessUnLock = 1;
        if (ChkProcessDel.Checked == true)
            intCheckProcessDel = 1;
        if (ChkView.Checked == true)
            intCheckView = 1;
        //====================================================
        //Get Url
        int intId = clsInput.getNumericInput("id", 0);
        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strName == "")
            clsErr.setErr("Tiêu đề", "Bạn hãy nhập vào tên nhóm quyền");
        //Ket xuat loi
        if (clsErr.checkErr())
        {
            block_error.Text = clsErr.displayErr();
        }
        else
        {
            string strSql = "insert into tbl_groupmember(C_Name, C_Des, FK_LangID, C_Active, C_Add, C_Edit, C_Del, C_Lock, C_View, C_ProcessLock, C_ProcessUnLock, C_ProcessDel) values(N'" + strName + "',N'" + strDes + "'," + lang.getLangID() + ",0," + intCheckAdd + "," + intCheckEdit + "," + intCheckDel + "," + intCheckLock + "," + intCheckView + "," + intCheckProcessLock + "," + intCheckProcessUnLock + "," + intCheckProcessDel + ")";
            clsDatabase.ExecuteQuery(strSql);
            int intInsertRecord = clsDatabase.getInsertID("tbl_groupmember", "PK_GroupMemberID");
            clsDatabase.ExecuteQuery("update tbl_groupmember set C_Rank = " + intInsertRecord + " where PK_GroupMemberID = " + intInsertRecord);            
            Response.Redirect("Default.aspx?page=group&mod=permission");
        }

        //===============================================
        /*
        //Khoi tao cac gia tri
        string strName = clsInput.encodeStr(txtName.Text);
        string strDes = clsInput.encodeStr(FCKeditor2.Value);
        string strUrl = clsInput.encodeStr(txtUrl.Text);
        int intCategoryID = Convert.ToInt32(DrdCategory.SelectedValue.ToString());
        int intCheckUrl = 0;
        if (ChkUrl.Checked == true)
            intCheckUrl = 1;

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
            string strSql = "insert into tbl_groupmember(FK_LangID, C_Name, C_Des, C_PointUrl, C_Active) values (" + lang.getLangID() + ",N'" + strName + "',N'" + strDes + "','" + intCheckUrl + "',0)";
            clsDatabase.ExecuteQuery(strSql);
            int intInsertRecord = clsDatabase.getInsertID("tbl_groupmember", "PK_GroupMemberID");
            clsDatabase.ExecuteQuery("update tbl_groupmember set C_Rank = " + intInsertRecord + " where PK_GroupMemberID = " + intInsertRecord);
            Response.Redirect("Default.aspx?page=groupmember&mod=news");
        }
        */
        //===============================================
    }
    protected void BtnEdit_ServerClick(object sender, EventArgs e)
    {
        
        //Khoi tao cac gia tri
        string strName = clsInput.encodeStr(txtName.Text);
        string strDes = clsInput.encodeStr(FCKeditor2.Value);
        strDes = clsInput.encodeStr(CKEditor_ThongTin.Text);
        int intCheckAdd = 0;
        int intCheckEdit = 0;
        int intCheckDel = 0;
        int intCheckLock = 0;
        int intCheckView = 0;
        int intCheckProcessLock = 0;
        int intCheckProcessUnLock = 0;
        int intCheckProcessDel = 0;
        if (ChkAdd.Checked == true)
            intCheckAdd = 1;
        if (ChkEdit.Checked == true)
            intCheckEdit = 1;
        if (ChkDel.Checked == true)
            intCheckDel = 1;
        if (ChkLock.Checked == true)
            intCheckLock = 1;
        if (ChkProcessLock.Checked == true)
            intCheckProcessLock = 1;
        if (ChkProcessUnLock.Checked == true)
            intCheckProcessUnLock = 1;
        if (ChkProcessDel.Checked == true)
            intCheckProcessDel = 1;
        if (ChkView.Checked == true)
            intCheckView = 1;
        //====================================================
        //Get Url
        int intId = clsInput.getNumericInput("id", 0);
        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strName == "")
            clsErr.setErr("Tiêu đề", "Bạn hãy nhập vào tên nhóm quyền");
        //Ket xuat loi
        if (clsErr.checkErr())
        {
            block_error.Text = clsErr.displayErr();
        }
        else
        {
            string strSql = "update tbl_groupmember set C_Name = N'" + strName + "', C_Des = N'" + strDes + "', C_Add = " + intCheckAdd + ", C_Edit = " + intCheckEdit + ", C_Del = " + intCheckDel + ", C_Lock = " + intCheckLock + ", C_View = " + intCheckView + ", C_ProcessLock = " + intCheckProcessLock + ", C_ProcessUnLock = " + intCheckProcessUnLock + ", C_ProcessDel = " + intCheckProcessDel + " where PK_GroupMemberID = " + intId + " and C_System <> 1 ";
            clsDatabase.ExecuteQuery(strSql);
            Response.Redirect("Default.aspx?page=group&mod=permission");
        }
        
        //===============================================
    }
}
