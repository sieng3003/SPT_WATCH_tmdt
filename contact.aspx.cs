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

public partial class contact : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((this.Session["fron_login"] == null) || (Convert.ToBoolean(this.Session["fron_login"]) != true))
        {
            this.Session["fron_login"] = true;
            Response.Redirect(clsConfig.GetHostUrl() + "/index.aspx");
        }

        inc_header.Controls.Add(LoadControl("~/modules/mod_top/mod_header.ascx"));
        inc_footer.Controls.Add(LoadControl("~/modules/mod_footer/mod_footer.ascx"));
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //if (ImageVerifier1.Text == txtImgVerifyCode.Text)
        {
            string strHoten = clsInput.encodeStr(txtHoten.Text);
            string strPhone = clsInput.encodeStr(txtPhone.Text);
            string strEmail = clsInput.encodeStr(txtEmail.Text);
            string strAddress = clsInput.encodeStr(txtAddress.Text);
            string strContent = clsInput.encodeStr(txtContent.Text);



            // Message body content
            string strFrom = "lang.thang.tren.mang.hn@gmail.com";
            string strTo = "duymanhgranit@gmail.com";
            string strBody = "";


            strBody = strBody + "Ho ten: " + strHoten + "<br>";
            strBody = strBody + "Dien thoai: " + strPhone + "<br>";
            strBody = strBody + "Email: " + strEmail + "<br>";
            strBody = strBody + "Dia chi: " + strAddress + "<br>";
            strBody = strBody + "Noi dung: <br>" + strContent + "<br>";



            //Create Mail Message Object with content that you want to send with mail.
            System.Net.Mail.MailMessage MyMailMessage = new System.Net.Mail.MailMessage(strFrom, strTo,
            "Thong tin duoc gui tu muc lien he o website Hoang Long granite", strBody);

            MyMailMessage.IsBodyHtml = true;

            //Proper Authentication Details need to be passed when sending email from gmail
            System.Net.NetworkCredential mailAuthentication = new
            System.Net.NetworkCredential("lang.thang.tren.mang.hn@gmail.com", "quenmatroi");

            //Smtp Mail server of Gmail is "smpt.gmail.com" and it uses port no. 587
            //For different server like yahoo this details changes and you can
            //get it from respective server.
            System.Net.Mail.SmtpClient mailClient = new System.Net.Mail.SmtpClient("smtp.gmail.com", 587);

            //Enable SSL
            mailClient.EnableSsl = true;

            mailClient.UseDefaultCredentials = false;

            mailClient.Credentials = mailAuthentication;

            mailClient.Send(MyMailMessage);
            //=====================================================================
            block_error.Text = lang.setLangValue("Information has been sent!", "Thông tin đã được gửi đi!");
            Response.Redirect(clsConfig.GetHostUrl() + "/1/note.aspx");

        }
        /*else
        {
            block_error.Text = "";
            clsErr.setFrontErr(lang.setLangValue("Authentication Code", "Mã xác thực"), lang.setLangValue("Authentication code you entered is incorrect", "Mã xác thực bạn nhập vào chưa chính xác"));
            if (clsErr.checkErr())
            {
                block_error.Text = clsErr.displayFrontErr();
            }
        }*/
    }
}
