<%@ Language="javascript" %>
<%
    // Retrieving user email and password from Request.Form.
    var email = Request.Form("txtEmail").Item;
    var pwd = Request.Form("txtPassword").Item;
    
    // Server.MapPath usage taken from: http://stackoverflow.com/questions/8656685/connect-to-ms-access-database-from-classic-asp
    var mycon = new ActiveXObject("ADODB.Connection");
    mycon.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("./App_Data/dblonglife.mdb"));

    var sql = "SELECT RefUser FROM Users WHERE Email = '" + email + "' AND Password = '" + pwd + "'";

    var recUser = new ActiveXObject("ADODB.Recordset");
    recUser.Open(sql, mycon);

    if (recUser.EOF)
    {
        // No user was found with the provided email and password.

        // Closing recordset and connection.
        recUser.Close();
        mycon.Close();
        // Clearing the session variable RefUser and informing that email and/or password are invalid.
        Session("RefUser") = "";
        Session("MESSAGE") = "Email or Password are invalid!";
        // Redirecting to login.asp.
        Response.Redirect("login.asp");
    }
    else
    {
        // Saving the RefUser in the session variable RefUser.
        Session("RefUser") = recUser.Fields("RefUser").Value;
        Session("MESSAGE") = "";
    }

    // Closing recordset and connection.
    recUser.Close();
    mycon.Close();

    // Redirecting to home.asp.
    Response.Redirect("home.asp");
%>