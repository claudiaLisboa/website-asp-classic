<%@ Language="javascript" %>
<!-- #include file="checkSession.asp" -->
<%
    var mycon = new ActiveXObject("ADODB.Connection");
    mycon.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("./App_Data/dblonglife.mdb"));
	
    var title = escape(Request.Form("txtSubject"));
    var message = escape(Request.Form("txtMessage"));
    var sender = Session("RefUser");
    var receiver = Request.Form("cboReceiver");

    var sql = "insert into Messages(Title,Message,Sender,Receiver,New) values('" + title + "','" + message + "'," + sender + "," + receiver + ", 1 )";

    mycon.Execute(sql);
    
    Session("MESSAGE") = "Your message has been sent!";
    
    Response.Redirect("home.asp");
%>