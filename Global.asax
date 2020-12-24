<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        Application["visitors_online"] = 0;
        // Code that runs on application startup
        //file lang
        int lang = 1;
        //this.Application["lang"] = lang;  

        // Code that runs on application startup
        Application["FCKeditor:UserFilesPath"] = "../../../../../data/";     
               
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        Application.Lock();
        Application["visitors_online"] = Convert.ToUInt32(Application["visitors_online"]) - 1;
        Application.UnLock();
        
        //  Code that runs on application shutdown
        this.Session["login"] = false;
        this.Session["Username"] = null;
        this.Session["Per"] = -1;
        
    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        this.Session.Timeout = 50; //50 minute timeout
        Application.Lock();
        Application["visitors_online"] = Convert.ToUInt32(Application["visitors_online"]) + 1;
        Application.UnLock();

        
        
        // Code that runs when a new session is started
        this.Session["lang"]="1";
    }

    void Session_End(object sender, EventArgs e) 
    {
        Application.Lock();
        Application["visitors_online"] = Convert.ToUInt32(Application["visitors_online"]) - 1;
        Application.UnLock();
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>