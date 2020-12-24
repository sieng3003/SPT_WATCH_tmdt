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

public partial class admincp_modules_mod_nhaxuong_mod_add_edit_category_nhaxuong : System.Web.UI.UserControl
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
                edit_category_news(intId);
        }
        else if (strDo == "add")
        {
            PnAdd.Visible = true;
            PnEdit.Visible = false;
            if (!Page.IsPostBack)
                add_category_news();
        }
        else
        {
            //Hien thi thong bao loi, khong thay tac vu yeu cau
            //==================================================
            //Display Msg
            clsConfig.redirectUrl("Default.aspx?page=category_nhaxuong&mod=nhaxuong");
            //==================================================
        }

    }


    private void edit_category_news(int intID)
    {

        DataTable dt = clsDatabase.getDataTable("select * from tbl_category_nhaxuong where PK_CategoryID = " + intID);
        string strName = "";
        string strDes = "";
        int intCheckUrl = 0;
        string strUrl = "";
        int intRight = 0;

        if (dt.Rows.Count > 0)
        {
            strName = clsInput.decodeStr(dt.Rows[0]["C_Name"].ToString());
            strDes = clsInput.decodeStr(dt.Rows[0]["C_Des"].ToString());

        }

        //===============================================================
        FCKeditor2.BasePath = clsConfig.getFckPath();
        //setup lang
        FCKeditor2.Config["AutoDetectLanguage"] = "false";
        FCKeditor2.Config["DefaultLanguage"] = "vi";
        FCKeditor2.Width = 900;
        FCKeditor2.Height = 450;
        //setup thame
        FCKeditor2.Config["SkinPath"] = clsConfig.getFckPath() + "editor/skins/office2003/";
        //===============================================================
        if (Page.IsPostBack)
            return;



        // Set the startup editor value.
        txtName.Text = strName;
        FCKeditor2.Value = strDes;


        //==========================================
    }

    private void add_category_news()
    {

        string strName = "";
        string strDes = "";


        //===============================================================
        FCKeditor2.BasePath = clsConfig.getFckPath();
        //setup lang
        FCKeditor2.Config["AutoDetectLanguage"] = "false";
        FCKeditor2.Config["DefaultLanguage"] = "vi";
        FCKeditor2.Width = 900;
        FCKeditor2.Height = 450;
        //setup thame
        FCKeditor2.Config["SkinPath"] = clsConfig.getFckPath() + "editor/skins/office2003/";
        //===============================================================
        if (Page.IsPostBack)
            return;



        // Set the startup editor value.
        txtName.Text = strName;
        FCKeditor2.Value = strDes;

        //==========================================
    }

    protected void BtnSubmit_ServerClick(object sender, EventArgs e)
    {
        //Khoi tao cac gia tri
        string strName = clsInput.encodeStr(txtName.Text);
        string strDes = clsInput.encodeStr(FCKeditor2.Value);



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
            string strSql = "insert into tbl_category_nhaxuong(FK_LangID, C_Name,  C_Des, C_Active) values (" + lang.getLangID() + ",N'" + strName + "',N'" + strDes + "',1" + ")";
            clsDatabase.ExecuteQuery(strSql);
            int intInsertRecord = clsDatabase.getInsertID("tbl_category_nhaxuong", "PK_CategoryID");
            clsDatabase.ExecuteQuery("update tbl_category_nhaxuong set C_Rank = " + intInsertRecord + " where PK_CategoryID = " + intInsertRecord);
            Response.Redirect("Default.aspx?page=category_nhaxuong&mod=nhaxuong");
        }

        //===============================================
    }
    protected void BtnEdit_ServerClick(object sender, EventArgs e)
    {
        //Khoi tao cac gia tri
        string strName = clsInput.encodeStr(txtName.Text);
        string strDes = clsInput.encodeStr(FCKeditor2.Value);



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
            string strSql = "update tbl_category_nhaxuong set C_Name = N'" + strName + "', C_Des = N'" + strDes + "' where PK_CategoryID=" + intId;
            clsDatabase.ExecuteQuery(strSql);
            Response.Redirect("Default.aspx?page=category_nhaxuong&mod=nhaxuong");
        }
        //===============================================
    }
}
