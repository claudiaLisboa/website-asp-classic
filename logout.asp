<%@ Language="javascript" %>
<%
    Session("RefUser") = "";
    Session("MESSAGE") = "";
    Response.Redirect("login.asp");
%>
