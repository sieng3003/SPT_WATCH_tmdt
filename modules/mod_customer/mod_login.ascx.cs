using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class modules_mod_customer_mod_login : System.Web.UI.UserControl
{
    public string urlHistory = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        
        string action = clsInput.getStringInput("action", 0);
        string customerName = clsInput.getStringInput("customerName", 0);
        string customerPassword = clsInput.getStringInput("customerPassword", 0);
        if (!String.IsNullOrEmpty(customerName) && !String.IsNullOrEmpty(customerPassword))
        {
            #region login
            LblError.Text = "Đăng nhập không thành công, hãy thực hiện lại!";
            LblError.Visible = false;
            DataTable dsCustommer = clsDatabase.getDataTable("Select * from tbl_customer order by C_Rank desc");
            string strCustomerName = customerName;
            string strCustomerPassword = customerPassword;
            

            if (!String.IsNullOrEmpty(strCustomerName) && !String.IsNullOrEmpty(strCustomerPassword))
            {
                string CustomerName = strCustomerName.Trim().Replace("'", "''");
                string CustomerPassword = clsFunction.fnEncrypt(strCustomerPassword.Trim());
                string sql = "select * from tbl_customer where C_CustomerName='" + CustomerName + "'and C_CustomerPass='" + CustomerPassword + "' and C_Active = 1";

                DataTable dt = clsDatabase.getDataTable(sql);
                if (dt.Rows.Count > 0)
                {
                    this.Session["C_CustomerName"] = dt.Rows[0]["C_CustomerName"].ToString();
                    this.Session["C_CustomerFullName"] = dt.Rows[0]["C_FullName"].ToString();
                    this.Session["C_CustomerEmail"] = dt.Rows[0]["C_Email"].ToString();
                    this.Session["C_CustomerPass"] = dt.Rows[0]["C_CustomerPass"].ToString();
                    this.Session["C_CustomerPhone"] = dt.Rows[0]["C_Phone"].ToString();
                    this.Session["C_CustomerAddress"] = dt.Rows[0]["C_Address"].ToString();

                    this.Session["customerlogin"] = "1";
                    this.Session["PK_CustomerID"] = Convert.ToInt32(dt.Rows[0]["PK_CustomerID"]);
                    Response.Redirect(clsConfig.GetHostUrl());
                }
                else
                    LblError.Visible = true;
                //=======================
            }
            else
            {
                LblError.Visible = true;
            }
            #endregion
        }
        if(action.Equals("logout"))
        {
            this.Session["C_CustomerFullName"] = null;
            this.Session["C_CustomerEmail"] = null;
            this.Session["C_CustomerPass"] = null;
            this.Session["customerlogin"] = null;
            this.Session["PK_CustomerID"] = null;
            Response.Redirect(clsConfig.GetHostUrl());
        }
        
    }
    protected void btnLogin_onserverclick(object sender, EventArgs e)
    {
        LblError.Text = "Đăng nhập không thành công, hãy thực hiện lại!";
        LblError.Visible = false;
        DataTable dsCustommer = clsDatabase.getDataTable("Select * from tbl_customer order by C_Rank desc");
        string strCustomerName = "";
        string strCustomerPassword = "";
        if (Request.Form["txtCustomerName"] != null)
        {
            strCustomerName = Request.Form["txtCustomerName"].ToString();
        }
        if (Request.Form["txtCustomerPassword"] != null)
        {
            strCustomerPassword = Request.Form["txtCustomerPassword"].ToString();
        }

        if (!String.IsNullOrEmpty(strCustomerName) && !String.IsNullOrEmpty(strCustomerPassword))
        {
            string CustomerName = strCustomerName.Trim().Replace("'", "''");
            string CustomerPassword = clsFunction.fnEncrypt(strCustomerPassword.Trim());
            string sql = "select * from tbl_customer where C_CustomerName='" + CustomerName + "'and C_CustomerPass='" + CustomerPassword + "' and C_Active = 1";

            DataTable dt = clsDatabase.getDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                this.Session["C_CustomerName"] = dt.Rows[0]["C_CustomerName"].ToString();
                this.Session["C_CustomerFullName"] = dt.Rows[0]["C_FullName"].ToString();
                this.Session["C_CustomerEmail"] = dt.Rows[0]["C_Email"].ToString();
                this.Session["C_CustomerPass"] = dt.Rows[0]["C_CustomerPass"].ToString();
                this.Session["C_CustomerPhone"] = dt.Rows[0]["C_Phone"].ToString();
                this.Session["C_CustomerAddress"] = dt.Rows[0]["C_Address"].ToString();

                this.Session["customerlogin"] = "1";
                this.Session["PK_CustomerID"] = Convert.ToInt32(dt.Rows[0]["PK_CustomerID"]);  
                Response.Redirect(clsConfig.GetHostUrl());
            }
            else
                LblError.Visible = true;
            //=======================
        }
        else
        {
            LblError.Visible = true;
        }
    }
}