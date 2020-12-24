using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class modules_mod_customer_mod_dangky : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string url = HttpContext.Current.Request.Url.AbsoluteUri;
        string action = clsInput.getStringInput("action", 0);
        int intId = clsInput.getNumericInput("key", 0);
        string strCheck = clsInput.getStringInput("tenDangNhap", 0);
        if (action.Equals("add"))
        {
            if (strCheck != null)
            {
                PnAdd.Visible = true;
                PnEdit.Visible = false;
                #region insert
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
                //====================================================

                //tenDangNhap=' + txtTenDangNhap +"&matKhau="+txtMatKhau+"&reMatKhau="+txtReMatKhau+"&hoTen="+txtHoTen+ 
                //'&email=' + txtEmail +"&gioiTinh="+intSex+ '&dienThoai=' + txtDienThoai + '&diaChi=' + txtDiaChi ;

                strCustomerName = clsInput.getStringInput("tenDangNhap", 0);
                strCustomerPass = clsInput.getStringInput("matKhau", 0);
                strReCustomerPass = clsInput.getStringInput("reMatKhau", 0);
                strFullName = clsInput.getStringInput("hoTen", 0);
                strEmail = clsInput.getStringInput("email", 0);
                intSex = clsInput.getNumericInput("gioiTinh", 0);
                strAddress = clsInput.getStringInput("diaChi", 0);
                strPhone = clsInput.getStringInput("dienThoai", 0);

                //====================================================
                //Kiem tra loi
                //An thuoc tinh thong bao loi
                block_error.Text = "";
                if (strCustomerName == "")
                    clsErr.setErr("Tên truy nhập", "Bạn hãy nhập vào tên đăng nhập");
                if (strCustomerPass == "")
                    clsErr.setErr("Mật khẩu", "Bạn hãy nhập vào mật khẩu");
                if (strCustomerPass != strReCustomerPass)
                    clsErr.setErr("Mật khẩu", "Mật khẩu và mật khẩu gõ lại không trùng nhau");
                if (strEmail == "")
                    clsErr.setErr("Email", "Bạn hãy nhập vào Email");
                //Check exist
                DataTable dtCheckExist = clsDatabase.getDataTable("select * from tbl_customer where C_CustomerName = N'" + strCustomerName + "'");
                if (dtCheckExist.Rows.Count > 0)
                {
                    clsErr.setErr("Account", "Tên đăng nhập đã có trong hệ thống, vui lòng nhập tên khác");
                }

                //Ket xuat loi
                if (clsErr.checkErr())
                {
                    string strError = clsErr.displayErr().Replace("<img border=\"0\" src=\"images/icons/warning.gif\" align=\"bottom\">", "");
                    block_error.Text = strError;
                }
                else
                {
                    strCustomerPass = clsFunction.fnEncrypt(strCustomerPass);
                    string strSql = "insert into tbl_customer(C_CustomerName, C_CustomerPass,  FK_LangID, C_FullName, C_Email, C_Sex, C_Des, C_Birth, C_Address, C_Phone) values(N'" + strCustomerName + "','" + strCustomerPass + "'," + lang.getLangID() + ",N'" + strFullName + "',N'" + strEmail + "'," + intSex + ",N'" + strDes + "',N'" + strBirth + "',N'" + strAddress + "',N'" + strPhone + "')";
                    clsDatabase.ExecuteQuery(strSql);
                    int intInsertID = clsDatabase.getInsertID("tbl_customer", "PK_CustomerID");
                    clsDatabase.ExecuteQuery("update tbl_customer set C_Rank = " + intInsertID + " where PK_CustomerID = " + intInsertID);

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "redirect",
                    "alert('Đăng ký thành công!'); window.location='" +
                    clsConfig.GetHostUrl() + "/login/add/1/login.aspx';", true);
                    //Response.Redirect(clsConfig.GetHostUrl() + "/login/add/1/login.aspx");
                }
                #endregion
            }
            else
            {
                PnAdd.Visible = true;
                PnEdit.Visible = false;
            }
        }
        if (action.Equals("edit") && intId > 0)
        {
            if (strCheck == null)
            {
                PnAdd.Visible = false;
                PnEdit.Visible = true;
                edit_customer(intId);
            }
            else
            {
                PnAdd.Visible = false;
                PnEdit.Visible = true;
                #region update info
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
                //====================================================



                //==============================

                strCustomerName = clsInput.getStringInput("tenDangNhap", 0);
                strCustomerPass = clsInput.getStringInput("matKhau", 0);
                strReCustomerPass = clsInput.getStringInput("reMatKhau", 0);
                strFullName = clsInput.getStringInput("hoTen", 0);
                strEmail = clsInput.getStringInput("email", 0);
                intSex = clsInput.getNumericInput("gioiTinh", 0);
                strAddress = clsInput.getStringInput("diaChi", 0);
                strPhone = clsInput.getStringInput("dienThoai", 0);
                //====================================================

                //Kiem tra loi
                //An thuoc tinh thong bao loi
                block_error.Text = "";
                if (strCustomerName == "")
                    clsErr.setErr("Tên truy nhập", "Bạn hãy nhập vào tên đăng nhập");
                if (strCustomerPass == "")
                    clsErr.setErr("Mật khẩu", "Bạn hãy nhập vào mật khẩu");
                if (strCustomerPass != strReCustomerPass)
                    clsErr.setErr("Mật khẩu", "Mật khẩu và mật khẩu gõ lại không trùng nhau");
                if (strEmail == "")
                    clsErr.setErr("Email", "Bạn hãy nhập vào Email");
                //Ket xuat loi
                if (clsErr.checkErr())
                {
                    string strError = clsErr.displayErr().Replace("<img border=\"0\" src=\"images/icons/warning.gif\" align=\"bottom\">", "");
                    block_error.Text = strError;
                }
                else
                {
                    string strSql = "";
                    strSql = "update tbl_customer set C_CustomerName = N'" + strCustomerName + "', C_FullName = N'" + strFullName + "', C_Address = N'" + strAddress + "',C_Email = N'" + strEmail + "',C_Sex = " + intSex + ",C_Birth = N'" + strBirth + "',C_Phone = N'" + strPhone + "',C_Des = N'" + strDes + "' where PK_CustomerID=" + intId;
                    if (strCustomerPass != "")
                    {
                        strCustomerPass = clsFunction.fnEncrypt(strCustomerPass);
                        strSql = "update tbl_customer set C_CustomerName = N'" + strCustomerName + "', C_CustomerPass = '" + strCustomerPass + "', C_FullName = N'" + strFullName + "', C_Address = N'" + strAddress + "',C_Email = N'" + strEmail + "',C_Sex = " + intSex + ",C_Birth = N'" + strBirth + "',C_Phone = N'" + strPhone + "',C_Des = N'" + strDes + "' where PK_CustomerID=" + intId;
                    }
                    clsDatabase.ExecuteQuery(strSql);
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "redirect",
                    "alert('Cập nhật thành công!'); window.location='" +
                    clsConfig.GetHostUrl() + "';", true);
                    //Response.Redirect(clsConfig.GetHostUrl());
                }
                #endregion
            }
        }
        //if (strCheck == null)
        //{
        //    PnAdd.Visible = true;
        //    PnEdit.Visible = false;
        //}
    }
    private void edit_customer(int intID)
    {

        DataTable dt = clsDatabase.getDataTable("select * from tbl_customer where PK_CustomerID = " + intID);
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


        if (dt.Rows.Count > 0)
        {
            strCustomerName = dt.Rows[0]["C_CustomerName"].ToString();
            strCustomerPass = dt.Rows[0]["C_CustomerPass"].ToString();
            strFullName = dt.Rows[0]["C_FullName"].ToString();
            strAddress = dt.Rows[0]["C_Address"].ToString();
            strEmail = dt.Rows[0]["C_Email"].ToString();
            intSex = Convert.ToInt16(dt.Rows[0]["C_Sex"]);
            strBirth = dt.Rows[0]["C_Birth"].ToString();
            strPhone = dt.Rows[0]["C_Phone"].ToString();
            strDes = clsInput.decodeStr(dt.Rows[0]["C_Des"].ToString());
        }

        
        //===============================================================
        if (Page.IsPostBack)
            return;



        // Set the startup editor value.
        
        //txtTenDangNhap.Value = strCustomerName;
        //txtTenDangNhap.Disabled = true;

        //if (Request.Form["txtEmail"] != null)
        //Request.Form["txtEmail"] = strEmail;
        //==========================================
    }

    protected void btnDangKy_ServerClick(object sender, EventArgs e)
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
        //====================================================

        string action = clsInput.getStringInput("action", 0);

        //==============================
        //if (Request.Form["ctl03$txtTenDangNhap"] != null)
        //{
        //    strCustomerName = Request.Form["ctl03$txtTenDangNhap"].ToString();
        //}

        //strCustomerName = txtTenDangNhap.Value;
        if (Request.Form["txtMatKhau"] != null)
        {
            strCustomerPass = Request.Form["txtMatKhau"].ToString().Trim();
        }
        if (Request.Form["txtReMatKhau"] != null)
        {
            strReCustomerPass = Request.Form["txtReMatKhau"].ToString().Trim();
        }
        if (Request.Form["txtHoTen"] != null)
        {
            strFullName = Request.Form["txtHoTen"].ToString().Trim();
        }
        if (Request.Form["txtEmail"] != null)
        {
            strEmail = Request.Form["txtEmail"].ToString().Trim();
        }
        if (Request.Form["ddlGioiTinh"] != null)
        {
            intSex = int.Parse(Request["ddlGioiTinh"].ToString());
        }
        if (Request.Form["txtDiaChi"] != null)
        {
            strAddress = Request.Form["txtDiaChi"].ToString().Trim();
        }
        if (Request.Form["txtDienThoai"] != null)
        {
            strPhone = Request.Form["txtDienThoai"].ToString().Trim();
        }
        //====================================================
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strCustomerName == "")
            clsErr.setErr("Tên truy nhập", "Bạn hãy nhập vào tên đăng nhập");
        if (strCustomerPass == "")
            clsErr.setErr("Mật khẩu", "Bạn hãy nhập vào mật khẩu");
        if (strCustomerPass != strReCustomerPass)
            clsErr.setErr("Mật khẩu", "Mật khẩu và mật khẩu gõ lại không trùng nhau");
        if (strEmail == "")
            clsErr.setErr("Email", "Bạn hãy nhập vào Email");
        //Check exist
        DataTable dtCheckExist = clsDatabase.getDataTable("select * from tbl_customer where C_CustomerName = N'" + strCustomerName + "'");
        if (dtCheckExist.Rows.Count > 0)
        {
            clsErr.setErr("Account", "Tên đăng nhập đã có trong hệ thống, vui lòng nhập tên khác");
        }

        //Ket xuat loi
        if (clsErr.checkErr())
        {
            string strError = clsErr.displayErr().Replace("<img border=\"0\" src=\"images/icons/warning.gif\" align=\"bottom\">","");
            block_error.Text = strError;
        }
        else
        {
            strCustomerPass = clsFunction.fnEncrypt(strCustomerPass);
            string strSql = "insert into tbl_customer(C_CustomerName, C_CustomerPass,  FK_LangID, C_FullName, C_Email, C_Sex, C_Des, C_Birth, C_Address, C_Phone) values(N'" + strCustomerName + "','" + strCustomerPass + "'," + lang.getLangID() + ",N'" + strFullName + "',N'" + strEmail + "'," + intSex + ",N'" + strDes + "',N'" + strBirth + "',N'" + strAddress + "',N'" + strPhone + "')";
            clsDatabase.ExecuteQuery(strSql);
            int intInsertID = clsDatabase.getInsertID("tbl_customer", "PK_CustomerID");
            clsDatabase.ExecuteQuery("update tbl_customer set C_Rank = " + intInsertID + " where PK_CustomerID = " + intInsertID);

            Page.ClientScript.RegisterStartupScript( this.GetType(), "redirect",
            "alert('Đăng ký thành công!'); window.location='" +
            clsConfig.GetHostUrl() + "/login/add/1/login.aspx';", true);
            //Response.Redirect(clsConfig.GetHostUrl() + "/login/add/1/login.aspx");
        }
        
    }
    protected void btnCapNhat_ServerClick(object sender, EventArgs e)
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
        //====================================================

        string action = clsInput.getStringInput("action", 0);

        //==============================
       
        //strCustomerName = txtTenDangNhap.Value;
        if (Request.Form["txtMatKhau"] != null)
        {
            strCustomerPass = Request.Form["txtMatKhau"].ToString();
        }
        if (Request.Form["txtReMatKhau"] != null)
        {
            strReCustomerPass = Request.Form["txtReMatKhau"].ToString();
        }
        if (Request.Form["txtHoTen"] != null)
        {
            strFullName = Request.Form["txtHoTen"].ToString();
        }
        if (Request.Form["txtEmail"] != null)
        {
            strEmail = Request.Form["txtEmail"].ToString();
        }
        if (Request.Form["ddlGioiTinh"] != null)
        {
            intSex = int.Parse(Request["ddlGioiTinh"].ToString());
        }
        if (Request.Form["txtDiaChi"] != null)
        {
            strAddress = Request.Form["txtDiaChi"].ToString();
        }
        if (Request.Form["txtDienThoai"] != null)
        {
            strPhone = Request.Form["txtDienThoai"].ToString();
        }
        //====================================================
        //Get Url
        int intId = clsInput.getNumericInput("key", 0);
        //Kiem tra loi
        //An thuoc tinh thong bao loi
        block_error.Text = "";
        if (strCustomerName == "")
            clsErr.setErr("Tên truy nhập", "Bạn hãy nhập vào tên đăng nhập");
        if (strCustomerPass == "")
            clsErr.setErr("Mật khẩu", "Bạn hãy nhập vào mật khẩu");
        if (strCustomerPass != strReCustomerPass)
            clsErr.setErr("Mật khẩu", "Mật khẩu và mật khẩu gõ lại không trùng nhau");
        if (strEmail == "")
            clsErr.setErr("Email", "Bạn hãy nhập vào Email");
        //Ket xuat loi
        if (clsErr.checkErr())
        {
            string strError = clsErr.displayErr().Replace("<img border=\"0\" src=\"images/icons/warning.gif\" align=\"bottom\">", "");
            block_error.Text = strError;
        }
        else
        {
            string strSql = "";
            strSql = "update tbl_customer set C_CustomerName = N'" + strCustomerName + "', C_FullName = N'" + strFullName + "', C_Address = N'" + strAddress + "',C_Email = N'" + strEmail + "',C_Sex = " + intSex + ",C_Birth = N'" + strBirth + "',C_Phone = N'" + strPhone + "',C_Des = N'" + strDes + "' where PK_CustomerID=" + intId;
            if (strCustomerPass != "")
            {
                strCustomerPass = clsFunction.fnEncrypt(strCustomerPass);
                strSql = "update tbl_customer set C_CustomerName = N'" + strCustomerName + "', C_CustomerPass = '" + strCustomerPass + "', C_FullName = N'" + strFullName + "', C_Address = N'" + strAddress + "',C_Email = N'" + strEmail + "',C_Sex = " + intSex + ",C_Birth = N'" + strBirth + "',C_Phone = N'" + strPhone + "',C_Des = N'" + strDes + "' where PK_CustomerID=" + intId;
            }
            clsDatabase.ExecuteQuery(strSql);
            Page.ClientScript.RegisterStartupScript(this.GetType(), "redirect",
            "alert('Cập nhật thành công!'); window.location='" +
            clsConfig.GetHostUrl()+"';" , true);
            //Response.Redirect(clsConfig.GetHostUrl());
        }
    }
}