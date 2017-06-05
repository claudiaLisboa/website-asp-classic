<%@ Language="javascript" %>
<!-- #include file="checkSession.asp" -->
<%
    // Clearing the session variable MESSAGE.
    Session("MESSAGE") = "";

    var mycon = new ActiveXObject("ADODB.Connection");
    mycon.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("./App_Data/dblonglife.mdb"));

    // Retrieving information of the logged in user.
    var sqlUser = "SELECT * FROM Users WHERE RefUser = " + Session("RefUser");
    var recUser = new ActiveXObject("ADODB.Recordset");
    recUser.Open(sqlUser, mycon);

    var refUser = recUser.Fields("RefUser").Value;
    var recMessages = new ActiveXObject("ADODB.Recordset");
    var recSender = new ActiveXObject("ADODB.Recordset");

    var sqlMessages = "SELECT Users.RefUser, Messages.RefMessage, Messages.Sender, Messages.Title, Users.UserName" 
    + " FROM  (Messages INNER JOIN Users ON Messages.Sender = Users.RefUser)  Where Messages.Receiver = "  + refUser;
    recMessages.Open(sqlMessages, mycon);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Longueuil Life</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <style type="text/css">
        .panel-heading.row {
            margin: 0;
            padding-left: 0;
            padding-right: 0;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="js/jquery.backstretch.min.js"></script>
    <script src="js/bodyBackground.js"></script>
    <script type="text/javascript">
        function bodyOnLoad()
        {
            bodyBackground();
        }
    </script>
</head>
<body style="background-color:#fff; color:#808080" onload="bodyOnLoad();">
    <div class="container">
        <!--#include file="header_logged_in.html" -->
        <div class="row">
            <ul class="nav nav-tabs">
                <li><a href="home.asp"><span class="glyphicon glyphicon-home"></span>  Home</a></li>
                <li><a href="myprofile.asp"><span class="glyphicon glyphicon-user"></span> Profile</a></li>
                <li class="active"><a href="#"><span class="glyphicon glyphicon-envelope"></span> Messages</a></li>
                <li><a href="logout.asp"><span class="glyphicon glyphicon-user"></span> Logout</a></li>
            </ul>
            <div class="col-sm-4">
                <p> <%=  Session("MESSAGE") %></p>
                <table class="table table-bordered table-hover table-striped table-responsive">
                    <thead>
                        <tr>
                            <td style="color:black">From</td>
                            <td style="color:black">Title</td>
                            <td style="color:black">Action</td>
                        </tr>
                    </thead>
                    <tbody>
                    <% if(recMessages.EOF) { %>
                        <tr>
                            <td colspan="3">There are no messages.</td>
                        </tr>
                    <% } else { %>
                        <% while(!recMessages.EOF) { %>
                        <tr>
                            <td><%= unescape(recMessages.Fields("UserName").Value) %></td>
                            <td><%= unescape(recMessages.Fields("Title").Value) %></td>
                            <td>
                                <a href="read.asp?refM=<%= recMessages.Fields("RefMessage").Value%>">Read</a>
                                &nbsp;&nbsp;
                                <a href="deletemsg.asp?refM=<%= recMessages.Fields("RefMessage").Value%>">Delete</a>
                            </td>
                        </tr>
                        <% recMessages.MoveNext(); } %>
                    <% } %>
                    </tbody>
                </table>
                <%
                    recMessages.Close();
                    recUser.Close();
                    mycon.Close();
                %>
            </div>
            <div class="col-sm-4">
            </div>
            <div class="col-sm-4">
            </div>
        </div>
    </div>
</body>
</html>
