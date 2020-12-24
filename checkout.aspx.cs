using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class checkout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string action = clsInput.getStringInput("do",0);
        if (action!=null && action.Equals("add"))
        {
            #region add
            //Khoi tao cac gia tri
            string strCustomerName = "";
            string strCustomerPass = "";
            string strReCustomerPass = "";
            string strFullName = "";
            string strAddress = "";
            string strEmail = "";
            int intSex = 0;
            string strBirth = "";
            string strPhone = "";
            string strDes = "";
            int intHinhThucThanhToan = 0;
            string strCreate = clsDate.GetStrTime("mmddyyyy");
            //====================================================

            
            //==============================

            //==============================
            strCustomerName = clsInput.getStringInput("tenKhachHang",0);
            strEmail = clsInput.getStringInput("email", 0);
            strAddress = clsInput.getStringInput("diaChi", 0);
            strPhone = clsInput.getStringInput("dienThoai", 0);
            strDes = clsInput.getStringInput("ghiChu", 0);
            intHinhThucThanhToan = int.Parse(ddlHinhThucThanhToan.SelectedValue);
            //====================================================
            //Kiem tra loi
            //An thuoc tinh thong bao loi
            block_error.Text = "";
            if (strCustomerName == "")
                clsErr.setErr("Tên khách hàng", "Bạn hãy nhập tên");
            if (strAddress == "")
                clsErr.setErr("Địa chỉ", "Bạn hãy nhập vào địa chỉ");
            //Ket xuat loi
            int intInsertCustomerCartID = 0;
            if (clsErr.checkErr())
            {
                string strError = clsErr.displayErr().Replace("<img border=\"0\" src=\"images/icons/warning.gif\" align=\"bottom\">", "");
                block_error.Text = strError;
            }
            else
            {
                string dateNow = System.DateTime.Now.ToString("yyyyMMddHHmmss");
                string strSql = "insert into tbl_customer_cart( C_CustomerName, FK_LangID, C_FullName, C_Email, C_Address, C_Phone,C_Des,C_Code,C_HinhThucThanhToan,C_Create) values(N'" + strCustomerName + "'," + lang.getLangID() + ",N'" + strFullName + "',N'" + strEmail + "',N'" + strAddress + "',N'" + strPhone + "',N'" + strDes + "',N'" + dateNow + "'," + intHinhThucThanhToan +",'"+strCreate +"')";
                clsDatabase.ExecuteQuery(strSql);
                intInsertCustomerCartID = clsDatabase.getInsertID("tbl_customer_cart", "PK_CustomerID");
                clsDatabase.ExecuteQuery("update tbl_customer_cart set C_Rank = " + intInsertCustomerCartID + " where PK_CustomerID = " + intInsertCustomerCartID);
                //====================
                DataTable cart = null;
                if (Session["cart"] != null) cart = Session["cart"] as DataTable;
                if (cart != null && cart.Rows.Count > 0)
                {


                    foreach (DataRow itemCart in cart.Rows)
                    {
                        int intSoLuong = 0;
                        int n;
                        if (int.TryParse(itemCart["C_SoLuong"].ToString(), out n)) intSoLuong = int.Parse(itemCart["C_SoLuong"].ToString());
                        decimal dcmPrice = 0;
                        decimal dcm;
                        if (decimal.TryParse(itemCart["C_Price"].ToString(), out dcmPrice)) dcmPrice = decimal.Parse(itemCart["C_Price"].ToString());

                        strSql = "insert into tbl_product_cart(C_Name,C_Des, C_Img, C_Img2, FK_CustomerCartID, FK_LangID, C_Active,C_GiaMoi,C_GiaCu,C_Hot,C_Price,C_SoLuong) values (N'" + itemCart["C_Name"].ToString() + "',N'" + strDes + "',N'" + itemCart["C_Img"].ToString() + "',N'" + "" + "'," + intInsertCustomerCartID + "," + lang.getLangID() + ",1," + "0" + "," + "0" + "," + 1 + "," + dcmPrice + "," + intSoLuong + ")";

                        clsDatabase.ExecuteQuery(strSql);
                        int intInsertRecord = clsDatabase.getInsertID("tbl_product_cart", "PK_ProductCartID");
                        clsDatabase.ExecuteQuery("update tbl_product_Cart set C_Rank = " + intInsertRecord + " where PK_ProductCartID = " + intInsertRecord);


                    }

                }
                //====================
                Session["cart"] = null;
                //====================


                //Page.ClientScript.RegisterStartupScript(this.GetType(), "redirect",
                //"alert('Đăng ký thành công!'); window.location='" +
                //clsConfig.GetHostUrl() + "/login/add/1/login.aspx';", true);
                //Response.Redirect(clsConfig.GetHostUrl() + "/login/add/1/login.aspx");
                Response.Redirect(clsConfig.GetHostUrl() + "/hoantatdonhang.aspx?id=" + intInsertCustomerCartID);
            }
            #endregion
        }
    }
    protected void btnHoanTatDonHang_onserverclick(object sender, EventArgs e)
    {
        //Khoi tao cac gia tri
        string strCustomerName = "";
        string strCustomerPass = "";
        string strReCustomerPass = "";
        string strFullName = "";
        string strAddress = "";
        string strEmail = "";
        int intSex = 0;
        string strBirth = "";
        string strPhone = "";
        string strDes = "";
        int intHinhThucThanhToan = 0;
        //====================================================

        string action = clsInput.getStringInput("action", 0);
        //==============================
        
        //==============================
        //strCustomerName = txtTenKhachHang.Text.Trim();
        //strEmail = txtEmail.Text.Trim();
        //strAddress = txtDiaChi.Text.Trim();
        //strPhone = txtDienThoai.Text.Trim();
        //strDes = txtGhiChu.Text.Trim();
        //intHinhThucThanhToan = int.Parse(ddlHinhThucThanhToan.SelectedValue);
        
        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strCustomerName == "")
            clsErr.setErr("Tên khách hàng", "Bạn hãy nhập tên");
        if (strAddress == "")
            clsErr.setErr("Địa chỉ", "Bạn hãy nhập vào địa chỉ");
        //Ket xuat loi
        int intInsertCustomerCartID = 0;
        if (clsErr.checkErr())
        {
            string strError = clsErr.displayErr().Replace("<img border=\"0\" src=\"images/icons/warning.gif\" align=\"bottom\">", "");
            block_error.Text = strError;
        }
        else
        {
            string dateNow = System.DateTime.Now.ToString("yyyyMMddHHmmss");
            string strSql = "insert into tbl_customer_cart( C_CustomerName, FK_LangID, C_FullName, C_Email, C_Address, C_Phone,C_Des,C_Code,C_HinhThucThanhToan) values(N'"+strCustomerName+"'," + lang.getLangID() + ",N'" + strFullName + "',N'" + strEmail + "',N'" + strAddress + "',N'" + strPhone + "',N'" + strDes + "',N'" + dateNow + "',"+intHinhThucThanhToan+")";
            //clsDatabase.ExecuteQuery(strSql);
            //intInsertCustomerCartID = clsDatabase.getInsertID("tbl_customer_cart", "PK_CustomerID");
            //clsDatabase.ExecuteQuery("update tbl_customer_cart set C_Rank = " + intInsertCustomerCartID + " where PK_CustomerID = " + intInsertCustomerCartID);
            //====================
            DataTable cart = null;
            if (Session["cart"] != null) cart = Session["cart"] as DataTable;
            if (cart != null && cart.Rows.Count > 0)
            {


                foreach (DataRow itemCart in cart.Rows)
                {
                    int intSoLuong = 0;
                    int n;
                    if (int.TryParse(itemCart["C_SoLuong"].ToString(), out n)) intSoLuong = int.Parse(itemCart["C_SoLuong"].ToString());
                    decimal dcmPrice = 0;
                    decimal dcm;
                    if (decimal.TryParse(itemCart["C_Price"].ToString(), out dcmPrice)) dcmPrice = decimal.Parse(itemCart["C_Price"].ToString());

                    strSql = "insert into tbl_product_cart(C_Name,C_Des, C_Img, C_Img2, FK_CustomerCartID, FK_LangID, C_Active,C_GiaMoi,C_GiaCu,C_Hot,C_Price,C_SoLuong) values (N'" + itemCart["C_Name"].ToString() + "',N'" + strDes + "',N'" + itemCart["C_Img"].ToString() + "',N'" + "" + "'," + intInsertCustomerCartID + "," + lang.getLangID() + ",1," + "0" + "," + "0" + "," + 1 + "," + dcmPrice + "," + intSoLuong + ")";

                    //clsDatabase.ExecuteQuery(strSql);
                    //int intInsertRecord = clsDatabase.getInsertID("tbl_product_cart", "PK_ProductCartID");
                    //clsDatabase.ExecuteQuery("update tbl_product_Cart set C_Rank = " + intInsertRecord + " where PK_ProductCartID = " + intInsertRecord);


                }
                
            }
            //====================

            //Page.ClientScript.RegisterStartupScript(this.GetType(), "redirect",
            //"alert('Đăng ký thành công!'); window.location='" +
            //clsConfig.GetHostUrl() + "/login/add/1/login.aspx';", true);
            //Response.Redirect(clsConfig.GetHostUrl() + "/login/add/1/login.aspx");
            Response.Redirect(clsConfig.GetHostUrl() + "/hoantatdonhang.aspx?id=" + intInsertCustomerCartID);
        }
    }
}