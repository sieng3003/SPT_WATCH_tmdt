using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Xml;
using System.Text;
using System.Globalization;

/// <summary>
/// Summary description for file
/// </summary>
public class clsFile
{
    public clsFile()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static string getTrangthaiThoitiet(string rssLink)
    {
        try
        {
            XmlDocument doc = new XmlDocument();
            doc.Load(rssLink);
            XmlNodeList bookList = doc.GetElementsByTagName("Item");
            foreach (XmlNode node in bookList)
            {
                XmlElement bookElement = (XmlElement)node;
                string strKieuthoitiet = bookElement.GetElementsByTagName("AdImg")[0].InnerText;
                //ddl.Items.Add(ctry);
                return ("http://vnexpress.net/Images/Weather/" + strKieuthoitiet);
            }
            return "";
        }
        catch
        {
            return "";
        }
    }
    public static string getNhietdoThoitiet(string rssLink)
    {
        try
        {
            XmlDocument doc = new XmlDocument();
            doc.Load(rssLink);
            XmlNodeList bookList = doc.GetElementsByTagName("Item");
            string strNhietdo = "";
            foreach (XmlNode node in bookList)
            {
                XmlElement bookElement = (XmlElement)node;
                string strAnh1 = bookElement.GetElementsByTagName("AdImg1")[0].InnerText;
                string strAnh2 = bookElement.GetElementsByTagName("AdImg2")[0].InnerText;

                string[] separator = new string[] { "." };
                string[] strNhietdo1 = strAnh1.Split(separator, StringSplitOptions.RemoveEmptyEntries);
                string[] strNhietdo2 = strAnh2.Split(separator, StringSplitOptions.RemoveEmptyEntries);
                //lay danh sach tham so cuoi
                strNhietdo = strNhietdo1[0].ToString() + strNhietdo2[0].ToString();

                return (strNhietdo);
            }
            return "";
        }
        catch
        {
            return "";
        }
    }
    public static bool fileExists(string strPath)
    {
        //HttpContext.Current.Response.Write(HttpContext.Current.Server.MapPath(strPath));
        if (File.Exists(HttpContext.Current.Server.MapPath(strPath)))
            return true;
        return false;
    }
    public static void fileDelete(string strPath)
    {
        if (fileExists(strPath))
            File.Delete(HttpContext.Current.Server.MapPath(strPath));
    }
    private static string GetFileSize(int byteCount)
    {
        string size = "0 Bytes";
        if (byteCount >= 1073741824)
            size = String.Format("{0:##.##}", byteCount / 1073741824) + " GB";
        else if (byteCount >= 1048576)
            size = String.Format("{0:##.##}", byteCount / 1048576) + " MB";
        else if (byteCount >= 1024)
            size = String.Format("{0:##.##}", byteCount / 1024) + " KB";
        else if (byteCount > 0 && byteCount < 1024)
            size = byteCount.ToString() + " Bytes";

        return size;
    }
    public static string fileSize(string strPath)
    {
        if (clsFile.fileExists(strPath))
        {
            FileInfo fi = new FileInfo(HttpContext.Current.Server.MapPath(strPath));
            return clsFile.GetFileSize((int)fi.Length);
        }
        return "0";
    }

    public static bool checkImagesUploadSize(HtmlInputFile uploadFile)
    {
        if (uploadFile.PostedFile.ContentLength > 0)
        {
            string fname = uploadFile.PostedFile.FileName;
            int fsize = uploadFile.PostedFile.ContentLength;
            //gioi han upload 1Mb
            if (fsize > 4048756)
                return false;
        }
        return true;
    }

    public static bool checkImagesUploadType(HtmlInputFile uploadFile)
    {
        if (uploadFile.PostedFile.ContentLength > 0)
        {
            string fname = uploadFile.PostedFile.FileName;
            fname = fname.Substring(fname.LastIndexOf('\\') + 1);
            if (fname != "")
            {
                string[] separator_ListType = new string[] { "." };
                string[] strExtension = fname.Split(separator_ListType, StringSplitOptions.RemoveEmptyEntries);
                if (strExtension[strExtension.Length-1].ToLower().Trim() == "jpg")
                    return true;
                if (strExtension[strExtension.Length - 1].ToLower().Trim() == "gif")
                    return true;
                if (strExtension[strExtension.Length - 1].ToLower().Trim() == "png")
                    return true;
                if (strExtension[strExtension.Length - 1].ToLower().Trim() == "jpeg")
                    return true;

            }
        }
        return false;
    }

    public static bool checkFileUploadType(HtmlInputFile uploadFile)
    {
        if (uploadFile.PostedFile.ContentLength > 0)
        {
            string fname = uploadFile.PostedFile.FileName;
            fname = fname.Substring(fname.LastIndexOf('\\') + 1);
            if (fname != "")
            {
                string[] separator_ListType = new string[] { "." };
                string[] strExtension = fname.Split(separator_ListType, StringSplitOptions.RemoveEmptyEntries);
                if (strExtension[strExtension.Length - 1].ToLower().Trim() == "avi")
                    return false;
                if (strExtension[strExtension.Length - 1].ToLower().Trim() == "mpg")
                    return false;
                if (strExtension[strExtension.Length - 1].ToLower().Trim() == "flv")
                    return false;
                if (strExtension[strExtension.Length - 1].ToLower().Trim() == "wmv")
                    return false;
                if (strExtension[strExtension.Length-1].ToLower().Trim() == "wma")
                    return false;

            }
        }
        return true;
    }





    public static string saveFrontImages(HttpPostedFile myFile, string strFolder)
    {
        string strImageURL = "";
        string strImageURLTemp = "";
        string strImageNewName = "";
        if (myFile.ContentLength > 0)
        {
            string dir = HttpContext.Current.Server.MapPath("data/images/" + strFolder);
            string fname = myFile.FileName;

            fname = fname.Substring(fname.LastIndexOf('\\') + 1);
            if (fname != "")
            {
                string[] separator_ListType = new string[] { "." };
                string[] strExtension = fname.Split(separator_ListType, StringSplitOptions.RemoveEmptyEntries);
                strImageNewName = clsDate.DateToTimeStamp() + "." + strExtension[strExtension.Length - 1];



                //string fullname = Path.Combine(dir, fname);
                string fullname = Path.Combine(dir, strImageNewName);
                //HttpContext.Current.Response.Write(strImageNewName);

                //Khai bao lai fname de luu vao CSDL
                //strImageURL = "data/images/" + strFolder + "/" + fname;
                strImageURL = "data/images/" + strFolder + "/" + strImageNewName;
                //strImageURLTemp = "data/images/uploadtemp/" + fname;
                strImageURL.Trim();
                FileStream file = new FileStream(fullname, FileMode.Create, FileAccess.Write);
                // Khai bao vung dem
                byte[] buffer = new byte[myFile.ContentLength];
                // doc tu file duoc upload len vao vung dem
                myFile.InputStream.Read(buffer, 0, myFile.ContentLength);
                // ghi len server
                file.Write(buffer, 0, myFile.ContentLength);
                // day du lieu len dia va dong file
                file.Flush();
                file.Close();
                // Response.Write(ProductImageURL);
                //Di chuyen den trang da chi dinh
                //Response.Redirect("AdminProduct.aspx");
                return strImageURL;

            }
        }
        return "";
    }








    public static string saveImages(HtmlInputFile uploadFile, string strFolder)
    {
        string strImageURL = "";
        string strImageURLTemp = "";
        string strImageNewName = "";
        if (uploadFile.PostedFile.ContentLength > 0)
        {
            string dir = HttpContext.Current.Server.MapPath("../data/images/" + strFolder);
            string fname = uploadFile.PostedFile.FileName;

            fname = fname.Substring(fname.LastIndexOf('\\') + 1);
            if (fname != "")
            {
                string[] separator_ListType = new string[] { "." };
                string[] strExtension = fname.Split(separator_ListType, StringSplitOptions.RemoveEmptyEntries);
                strImageNewName = strExtension[0] + "_" + clsDate.DateToTimeStamp() + "." + strExtension[strExtension.Length-1];
                //string fullname = Path.Combine(dir, fname);
                string fullname = Path.Combine(dir, strImageNewName);
                //HttpContext.Current.Response.Write(strImageNewName);

                //Khai bao lai fname de luu vao CSDL
                //strImageURL = "data/images/" + strFolder + "/" + fname;
                strImageURL = "data/images/" + strFolder + "/" + strImageNewName;
                //strImageURLTemp = "data/images/uploadtemp/" + fname;
                strImageURL.Trim();
                FileStream file = new FileStream(fullname, FileMode.Create, FileAccess.Write);
                // Khai bao vung dem
                byte[] buffer = new byte[uploadFile.PostedFile.ContentLength];
                // doc tu file duoc upload len vao vung dem
                uploadFile.PostedFile.InputStream.Read(buffer, 0, uploadFile.PostedFile.ContentLength);
                // ghi len server
                file.Write(buffer, 0, uploadFile.PostedFile.ContentLength);
                // day du lieu len dia va dong file
                file.Flush();
                file.Close();
                // Response.Write(ProductImageURL);
                //Di chuyen den trang da chi dinh
                //Response.Redirect("AdminProduct.aspx");
                return strImageURL;

            }
        }
        return "";
    }





    public static string userUploadImages(HtmlInputFile uploadFile, string strFolder, string strTail)
    {
        string strImageURL = "";
        string strImageURLTemp = "";
        string strImageNewName = "";
        if (uploadFile.PostedFile.ContentLength > 0)
        {
            string dir = HttpContext.Current.Server.MapPath("~/data/images/" + strFolder + "/");
            string fname = uploadFile.PostedFile.FileName;

            fname = fname.Substring(fname.LastIndexOf('\\') + 1);
            if (fname != "" && uploadFile.PostedFile != null && checkImagesUploadType(uploadFile) && checkImagesUploadSize(uploadFile))
            {
                string[] separator_ListType = new string[] { "." };
                string[] strExtension = fname.Split(separator_ListType, StringSplitOptions.RemoveEmptyEntries);
                strImageNewName = clsDate.DateToTimeStamp() + "_" + strTail + "." + strExtension[strExtension.Length - 1];



                //string fullname = Path.Combine(dir, fname);
                string fullname = Path.Combine(dir, strImageNewName);
                //HttpContext.Current.Response.Write(strImageNewName);

                //Khai bao lai fname de luu vao CSDL
                //strImageURL = "data/images/" + strFolder + "/" + fname;
                strImageURL = "data/images/" + strFolder + "/" + strImageNewName;
                //strImageURLTemp = "data/images/uploadtemp/" + fname;
                strImageURL.Trim();

                try
                {
                    uploadFile.PostedFile.SaveAs(fullname);
                }
                catch (Exception e)
                {
                    return "";
                }


                return strImageURL;

            }
        }
        return "";
    }




    public static string saveImages(HtmlInputFile uploadFile, string strFolder, int intPlace)
    {
        string strImageURL = "";
        string strImageURLTemp = "";
        string strImageNewName = "";
        if (uploadFile.PostedFile.ContentLength > 0)
        {
            string dir = HttpContext.Current.Server.MapPath("../data/images/" + strFolder);
            string fname = uploadFile.PostedFile.FileName;

            fname = fname.Substring(fname.LastIndexOf('\\') + 1);
            if (fname != "")
            {
                string[] separator_ListType = new string[] { "." };
                string[] strExtension = fname.Split(separator_ListType, StringSplitOptions.RemoveEmptyEntries);
                strImageNewName = intPlace + "_" + clsDate.DateToTimeStamp() + "." + strExtension[strExtension.Length - 1];

                //string fullname = Path.Combine(dir, fname);
                string fullname = Path.Combine(dir, strImageNewName);
                //HttpContext.Current.Response.Write(strImageNewName);

                //Khai bao lai fname de luu vao CSDL
                //strImageURL = "data/images/" + strFolder + "/" + fname;
                strImageURL = "data/images/" + strFolder + "/" + strImageNewName;
                //strImageURLTemp = "data/images/uploadtemp/" + fname;
                strImageURL.Trim();
                FileStream file = new FileStream(fullname, FileMode.Create, FileAccess.Write);
                // Khai bao vung dem
                byte[] buffer = new byte[uploadFile.PostedFile.ContentLength];
                // doc tu file duoc upload len vao vung dem
                uploadFile.PostedFile.InputStream.Read(buffer, 0, uploadFile.PostedFile.ContentLength);
                // ghi len server
                file.Write(buffer, 0, uploadFile.PostedFile.ContentLength);
                // day du lieu len dia va dong file
                file.Flush();
                file.Close();
                // Response.Write(ProductImageURL);
                //Di chuyen den trang da chi dinh
                //Response.Redirect("AdminProduct.aspx");
                return strImageURL;

            }
        }
        return "";
    }

    public static string saveFile(HtmlInputFile uploadFile, string strFolder)
    {
        string strFileURL = "";
        if (uploadFile.PostedFile.ContentLength > 0)
        {
            string dir = HttpContext.Current.Server.MapPath("../data/file/" + strFolder);
            string fname = uploadFile.PostedFile.FileName;

            fname = fname.Substring(fname.LastIndexOf('\\') + 1);
            string fullname = Path.Combine(dir, fname);
            //Khai bao lai fname de luu vao CSDL
            strFileURL = "data/file/" + strFolder + "/" + fname;
            strFileURL.Trim();
            FileStream file = new FileStream(fullname, FileMode.Create, FileAccess.Write);
            // Khai bao vung dem
            byte[] buffer = new byte[uploadFile.PostedFile.ContentLength];
            // doc tu file duoc upload len vao vung dem
            uploadFile.PostedFile.InputStream.Read(buffer, 0, uploadFile.PostedFile.ContentLength);
            // ghi len server
            file.Write(buffer, 0, uploadFile.PostedFile.ContentLength);
            // day du lieu len dia va dong file
            file.Flush();
            file.Close();
            // Response.Write(ProductImageURL);
            //Di chuyen den trang da chi dinh
            //Response.Redirect("AdminProduct.aspx");
            return strFileURL;
        }
        return strFileURL;
    }
    #region
    public static string uploadFiles(int count, HttpFileCollection files, int countCurrent, string strFolder)
    {
        string dir = HttpContext.Current.Server.MapPath("../data/images/" + strFolder);

        //string dir = "D:\\Tai lieu vpqh\\da_co_ajax\\data\\"+ strFolder;
        //string dir = "C:\\Inetpub\\wwwroot\\da_co_ajax\\data\\" + strFolder;
        string strImageURL = "";
        string urls = "";
        try
        {
            for (int i = countCurrent; i < files.Count; i++)
            {
                try
                {
                    //Get the list of files for attachments
                    HttpPostedFile uploadFile = files[i];
                    string fname = uploadFile.FileName;
                    ///////////////////////////////////
                    string extension = System.IO.Path.GetExtension(fname);
                    if (!fname.Equals(""))
                    {
                        fname = fname.Substring(fname.LastIndexOf('\\') + 1);
                        string dateNow = System.DateTime.Now.ToString("yyyyMMddHHmmss");
                        //Thay ten
                        int index = fname.IndexOf(extension);
                        string cleanPath = (index < 0)
                            ? fname
                            : fname.Remove(index, extension.Length);
                        cleanPath = RemoveUnicode(cleanPath);
                        fname = cleanPath + "_" + dateNow + extension;
                    }
                    /////////////////////////////////
                    string fullname = Path.Combine(dir, fname);
                    //Khai bao lai fname de luu vao CSDL
                    strImageURL = "data/images/" + strFolder + "/" + fname;
                    strImageURL.Trim();

                    FileStream file = new FileStream(fullname, FileMode.Create, FileAccess.Write);
                    urls += strImageURL + "#";
                    // Khai bao vung dem
                    byte[] buffer = new byte[uploadFile.ContentLength];
                    // doc tu file duoc upload len vao vung dem
                    uploadFile.InputStream.Read(buffer, 0, uploadFile.ContentLength);
                    // ghi len server
                    file.Write(buffer, 0, uploadFile.ContentLength);
                    // day du lieu len dia va dong file
                    file.Flush();
                    file.Close();






                }
                catch (Exception e)
                {
                    continue;
                    HttpContext.Current.Response.Write("Biet le 4: " + e.ToString());
                }
            }
        }
        catch
        {
        }

        if (urls.Length > 0)
            urls = urls.Remove(urls.Length - 1);


        return urls;


    }

    #endregion
    public static string RemoveUnicode(string s)
    {
        string stFormD = s.Normalize(NormalizationForm.FormD);
        StringBuilder sb = new StringBuilder();

        for (int ich = 0; ich < stFormD.Length; ich++)
        {
            UnicodeCategory uc = CharUnicodeInfo.GetUnicodeCategory(stFormD[ich]);
            if (uc != UnicodeCategory.NonSpacingMark)
            {
                sb.Append(stFormD[ich]);
            }
        }
        string strResult = sb.ToString().Normalize(NormalizationForm.FormC);
        strResult = strResult.Trim();
        strResult = strResult.Replace("\"", "");
        strResult = strResult.Replace("/", "");
        strResult = strResult.Replace(":", "");
        strResult = strResult.Replace("$", "");
        strResult = strResult.Replace("#", "");
        strResult = strResult.Replace("<", "");
        strResult = strResult.Replace(">", "");
        strResult = strResult.Replace("@", "");
        strResult = strResult.Replace("!", "");
        strResult = strResult.Replace("%", "");
        strResult = strResult.Replace("^", "");
        strResult = strResult.Replace("&", "");
        strResult = strResult.Replace("*", "");
        strResult = strResult.Replace("(", "");
        strResult = strResult.Replace(")", "");
        strResult = strResult.Replace("|", "");
        strResult = strResult.Replace(",", "");
        strResult = strResult.Replace(".", "");
        strResult = strResult.Replace("?", "");
        strResult = strResult.Replace(" ", "-");
        return (strResult);
    }
}
