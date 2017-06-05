<%
    // Checking whether session variable RefUser is defined and set. If it is not, send the user back to login.asp.
    if (typeof Session("RefUser") === "undefined" || Session("RefUser") == "")
    {
        Session("MESSAGE") = "Please login.";
        Response.Redirect("login.asp");
    }
    else
    {
        Session("MESSAGE") = "";
    }
%>
