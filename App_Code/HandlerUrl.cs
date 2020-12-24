using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace UrlHandlerNameSpace
{

    /// <summary>

    /// Demo url HttpHandler

    /// </summary>

    public class DemoUrlHandler : IHttpHandler
    {

        /// <summary>

        /// Process my requet

        /// </summary>

        /// <param name="context"></param>

        public void ProcessRequest(HttpContext context)
        {
            string strUrl = HttpContext.Current.Request.Url.AbsolutePath.ToString();
            //string strUrl = "http://www.domain.com/tranfer/contact/do,update-act,ok-id,10/fdslfks.html";
            //this.Title = title;
            //Response.Write(Request.Url.AbsolutePath.ToString());
            //====================================================
            //Cat chuoi tinh tu tag "pages"
            string[] separator = new string[] { "tranfer" };
            string[] strSplitArr = strUrl.Split(separator, StringSplitOptions.RemoveEmptyEntries);
            //lay danh sach tham so cuoi
            string strParentString = strSplitArr[1].ToString();
            //dinh dang se la parameter = "/contact/do,update-act,ok-id,10/fdslfks.html";
            //Loai bo ky tu / o dau
            strParentString = strParentString.Substring(1);
            //dinh dang se la parameter = "contact/do,update-act,ok-id,10/fdslfks.html";
            string[] separator1 = new string[] { "/" };
            string[] strSplitArr1 = strParentString.Split(separator1, StringSplitOptions.RemoveEmptyEntries);
            //gan bien param pages
            string strParamPage = strSplitArr1[0];
            // Xu ly danh sach querystring trong strSplitArr1[1]
            string strQueryString = strSplitArr1[1];
            string[] separator2 = new string[] { "-" };
            string[] strSplitArr2 = strQueryString.Split(separator2, StringSplitOptions.RemoveEmptyEntries);

            string strParameterQueryString = "";

            foreach (string arrStr in strSplitArr2)
            {
                string[] separator3 = new string[] { "," };
                string[] strSplitArr3 = arrStr.Split(separator3, StringSplitOptions.RemoveEmptyEntries);
                strParameterQueryString = strParameterQueryString + "&" + strSplitArr3[0] + "=" + strSplitArr3[1];
            }
            string strPage = "~/admincp/Default.aspx?page=" + strParamPage + strParameterQueryString;
            //HttpContext.Current.Response.Write(strPage);
            //====================================================
            //HttpContext.Current.Request.CurrentExecutionFilePath.
            //HttpContext.Current.Response.Write(clsConfig.getGlobalBackEnPath());
            //HttpContext.Current.RewritePath(strPage);
            HttpContext.Current.Server.Transfer("~/Default.aspx?page=" + strParamPage + strParameterQueryString);
        }
        public bool IsReusable
        {

            get
            {

                return true;

            }

        }

    }

}

