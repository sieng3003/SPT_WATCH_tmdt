using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;


/// <summary>
/// Summary description for clsDate
/// </summary>
public class clsDate
{
	public clsDate()
	{
		//
		// TODO: Add constructor logic here
		//
	}


    public static string SetStrTime(string dt)
    {
        if (dt != "")
        {
            string sdatetime, sYear, sMonth, sDay, sHour, sMinute;
            string[] arr1 = dt.Split(new string[] { " " }, StringSplitOptions.None);
            string[] arr2 = arr1[0].Split(new string[] { "/" }, StringSplitOptions.None);

            sYear = arr2[2];
            sMonth = arr2[1];
            sDay = arr2[0];



            return sMonth + "/" + sDay + "/" + sYear;
        }
        else
            return "";
    }



    public static string DateToTimeStamp()
    {

        string sdatetime, sYear, sMonth, sDay, sHour, sMinute, sSecond;
        sYear = DateTime.Now.Year.ToString();
        sMonth = DateTime.Now.Month.ToString();
        sDay = DateTime.Now.Day.ToString();
        sHour = DateTime.Now.Hour.ToString();
        sMinute = DateTime.Now.Minute.ToString();
        sSecond = DateTime.Now.Second.ToString();
        if (sMonth.Length < 2) sMonth = "0" + sMonth;
        if (sDay.Length < 2) sDay = "0" + sDay;
        if (sHour.Length < 2) sHour = "0" + sHour;
        if (sMinute.Length < 2) sDay = "0" + sMinute;
        Random random = new Random();
        int num = random.Next(1000);

        sdatetime = sDay + "_" + sMonth + "_" + sYear + "_" + sHour + "" + sMinute + "" + sSecond + "_" + num;

        return sdatetime;

    }

    
    public static string GetStrTime(string format)
    {

        string sdatetime, sYear, sMonth, sDay, sHour, sMinute, sSecond;
        sYear = DateTime.Now.Year.ToString();
        sMonth = DateTime.Now.Month.ToString();
        sDay = DateTime.Now.Day.ToString();
        sHour = DateTime.Now.Hour.ToString();
        sMinute = DateTime.Now.Minute.ToString();
        sSecond = DateTime.Now.Second.ToString();
        if (sMonth.Length < 2) sMonth = "0" + sMonth;
        if (sDay.Length < 2) sDay = "0" + sDay;
        if (sHour.Length < 2) sHour = "0" + sHour;
        if (sMinute.Length < 2) sDay = "0" + sMinute;


        switch (format)
        {
            case "yyyymmdd":
                sdatetime = sYear + "/" + sMonth + "/" + sDay;
                break;
            case "mmddyyyy":
                sdatetime = sMonth + "/" + sDay + "/" + sYear;
                break;
            case "ddmmyyyy":
                sdatetime = sDay + "/" + sMonth + "/" + sYear;
                break;
            case "yyyymmddhhmm":
                sdatetime = sYear + "/" + sMonth + "/" + sDay + " " + sHour + ":" + sMinute;
                break;
            case "ddmmyyyyhhmmss":
                sdatetime = sMonth + "/" + sDay + "/" + sYear + " " + sHour + ":" + sMinute + ":" + sSecond;
                break;
            default:
                sdatetime = sDay + "/" + sMonth + "/" + sYear;
                break;
        }

        return sdatetime;

    }

    public static string GetStrTime(DateTime dtRef, string format)
    {

        string sdatetime, sYear, sMonth, sDay, sHour, sMinute, sSecond;
        sYear = dtRef.Year.ToString();
        sMonth = dtRef.Month.ToString();
        sDay = dtRef.Day.ToString();
        sHour = dtRef.Hour.ToString();
        sMinute = dtRef.Minute.ToString();
        sSecond = dtRef.Second.ToString();
        if (sMonth.Length < 2) sMonth = "0" + sMonth;
        if (sDay.Length < 2) sDay = "0" + sDay;
        if (sHour.Length < 2) sHour = "0" + sHour;
        if (sMinute.Length < 2) sMinute = "0" + sMinute;
        if (sSecond.Length < 2) sSecond = "0" + sSecond;

        switch (format)
        {
            case "yyyymmdd":
                sdatetime = sYear + "/" + sMonth + "/" + sDay;
                break;
            case "mmddyyyy":
                sdatetime = sMonth + "/" + sDay + "/" + sYear;
                break;
            case "ddmmyyyy":
                sdatetime = sDay + "/" + sMonth + "/" + sYear;
                break;
            case "hhmmss":
                sdatetime = sHour + ":" + sMinute + ":" + sSecond;
                break;
            case "yyyymmddhhmm":
                sdatetime = sDay + "/" + sMonth + "/" + sYear + " " + sHour + ":" + sMinute + ":00";
                break;
            case "yyyymmddhhmmss":
                sdatetime = sDay + "/" + sMonth + "/" + sYear + " " + sHour + ":" + sMinute + ":" + sSecond;
                break;
            default:
                sdatetime = sDay + "/" + sMonth + "/" + sYear;
                break;
        }

        return sdatetime;
    }
    
    public static string GetDateFromStrVN(string dt)
    {
        string sdatetime, sYear, sMonth, sDay;
        string[] arr1 = dt.Split(new string[] { "-" }, StringSplitOptions.None);
        //string[] arr2 = arr1[0].Split(new string[] { "/" }, StringSplitOptions.None);
        //string[] arr3 = arr1[1].Split(new string[] { ":" }, StringSplitOptions.None);

        sYear = arr1[2];
        sMonth = arr1[1];
        sDay = arr1[0];
        return sMonth + "-" + sDay + "-" + sYear;
    }
    public static string DateToStrVN(string dt)
    {
        string sdatetime, sYear, sMonth, sDay, sHour, sMinute;
        string[] arr1 = dt.Split(new string[] { " " }, StringSplitOptions.None);
        string[] arr2 = arr1[0].Split(new string[] { "/" }, StringSplitOptions.None);
        

        sYear = arr2[2];
        sMonth = arr2[0];
        sDay = arr2[1];

       

        return sDay + "/" + sMonth + "/" + sYear;
    }
    public static string DateToStrVNTextBox(string dt)
    {
        string sdatetime, sYear, sMonth, sDay, sHour, sMinute;
        string[] arr1 = dt.Split(new string[] { " " }, StringSplitOptions.None);
        string[] arr2 = arr1[0].Split(new string[] { "/" }, StringSplitOptions.None);


        sYear = arr2[2];
        sMonth = arr2[0];
        sDay = arr2[1];



        return sDay + "/" + sMonth + "/" + sYear;
    }
    public static string DateToStrVNFull(string dt)
    {
        string sdatetime, sYear, sMonth, sDay, sHour, sMinute, sTime, sAMPM;
        string[] arr1 = dt.Split(new string[] { " " }, StringSplitOptions.None);
        string[] arr2 = arr1[0].Split(new string[] { "/" }, StringSplitOptions.None);


        sYear = arr2[2];
        sMonth = arr2[0];
        sDay = arr2[1];
        sTime = arr1[1];
        sAMPM = arr1[2];


        return sDay + "/" + sMonth + "/" + sYear + " " + sTime + " " + sAMPM;
    }


    public static int GetHour(string dt)
    {
        string sdatetime, sYear, sMonth, sDay, sHour, sMinute;
        string[] arr1 = dt.Split(new string[] { " " }, StringSplitOptions.None);
        string[] arr2 = arr1[0].Split(new string[] { "/" }, StringSplitOptions.None);
        string[] arr3 = arr1[1].Split(new string[] { ":" }, StringSplitOptions.None);

        
        sHour = arr3[0];
        return Convert.ToInt32(sHour);
    }
    public static int GetMinute(string dt)
    {
        string sdatetime, sYear, sMonth, sDay, sHour, sMinute;
        string[] arr1 = dt.Split(new string[] { " " }, StringSplitOptions.None);
        string[] arr2 = arr1[0].Split(new string[] { "/" }, StringSplitOptions.None);
        string[] arr3 = arr1[1].Split(new string[] { ":" }, StringSplitOptions.None);


        sMinute = arr3[1];
        return Convert.ToInt32(sMinute);
    }
    public static int GetSecond(string dt)
    {
        string sdatetime, sYear, sMonth, sDay, sHour, sMinute;
        string[] arr1 = dt.Split(new string[] { " " }, StringSplitOptions.None);
        string[] arr2 = arr1[0].Split(new string[] { "/" }, StringSplitOptions.None);
        string[] arr3 = arr1[1].Split(new string[] { ":" }, StringSplitOptions.None);
        //string[] arr4 = arr1[1].Split(new string[] { ":" }, StringSplitOptions.None);

        sMinute = arr3[2];
        return Convert.ToInt32(sMinute);
    }
}
