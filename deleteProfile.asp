<%@ Language="javascript" %>
<!-- #include file="checkSession.asp" -->
<%
    var mycon = new ActiveXObject("ADODB.Connection");
    mycon.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("./App_Data/dblonglife.mdb"));

    var sql = "DELETE FROM Users WHERE RefUser =" + Session("RefUser") ;
    mycon.Execute(sql);

    Session("RefUser") = "";
    Session("MESSAGE") = "Profile deleted!";
    mycon.Close();
    Response.Redirect("login.asp");
%>
