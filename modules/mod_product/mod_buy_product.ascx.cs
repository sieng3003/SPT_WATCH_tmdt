using System;
using System.Collections.Generic;
//using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class modules_mod_product_mod_buy_product : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((this.Session["fron_login"] == null) || (Convert.ToBoolean(this.Session["fron_login"]) != true))
        {
            this.Session["fron_login"] = true;
            Response.Redirect(clsConfig.GetHostUrl() + "/index.aspx");
        }

        
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
            //
            
            int intID = clsInput.getNumericInput("id", 0);
            //
            string strHoten = clsInput.encodeStr(txtHoten.Text);
            string strPhone = clsInput.encodeStr(txtPhone.Text);
            string strEmail = clsInput.encodeStr(txtEmail.Text);
            string strAddress = clsInput.encodeStr(txtAddress.Text);
            string strContent = clsInput.encodeStr(txtContent.Text);
            string strCreate = clsDate.GetStrTime("yyyymmddhhmm");

            //
            string strSql = "insert into tbl_resquest(C_Name, C_Mobile, C_Email, C_Address,C_Content ,C_Create,C_Status,FK_ProductID,FK_LangID) values (N'" + strHoten + "',N'" + strPhone + "',N'" + strEmail + "',N'" + strAddress + "',N'" + strContent + "','" + strCreate + "',0," + intID + ",1)";
            clsDatabase.ExecuteQuery(strSql);
            int intInsertRecord = clsDatabase.getInsertID("tbl_resquest", "PK_ResquestID");
            clsDatabase.ExecuteQuery("update tbl_resquest set C_Rank = " + intInsertRecord + " where PK_ResquestID = " + intInsertRecord);
            Response.Write("<script>alert('Bạn đã gửi yêu cầu thành công, chúng tôi sẽ sớm trả lời bạn?');</script>");

            txtHoten.Text = "";
            txtPhone.Text = "";
            txtEmail.Text = "";
            txtAddress.Text = "";
            txtContent.Text = "";
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "redirect","alert('Bạn đã gửi yêu cầu thành công, chúng tôi sẽ sớm trả lời bạn?'); window.location='" +Request.ApplicationPath + "/Default.aspx';", true);
            
            
            
            
           
            

        
        
    }
}