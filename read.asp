<%@ Language="javascript" %>
<!-- #include file="checkSession.asp" -->
<%
    var ref = Request.QueryString("refM");

    var mycon = new ActiveXObject("ADODB.Connection");
    mycon.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("./App_Data/dblonglife.mdb"));

    var sql = "SELECT Users.UserName, Messages.RefMessage, Messages.Title, Messages.Message, Messages.DateMessage, Messages.Sender FROM (Messages INNER JOIN Users ON Messages.Sender = Users.RefUser) WHERE (Messages.RefMessage = "+ref+")";
    
    var myrec = new ActiveXObject("ADODB.Recordset");
    myrec.Open(sql, mycon);

    mycon.Execute("UPDATE Messages SET New=1 WHERE RefMessage=" + ref);
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
                <li><a href="messages.asp"><span class="glyphicon glyphicon-envelope"></span> Messages</a></li>
                <li><a href="logout.asp"><span class="glyphicon glyphicon-user"></span> Logout</a></li>
            </ul>
            <div class="col-sm-4">
                <table class="auto-style1" border="1" width="500">
                    <tr>
                        <td class="auto-style2">From:</td>
                        <td class="auto-style3"><%= unescape(myrec.Fields("UserName").Value) %></td>
                    </tr>
                    <tr>
                        <td class="auto-style2">Title:</td>
                        <td class="auto-style3"><%= unescape(myrec.Fields("Title").Value) %></td>
                    </tr>
                    <tr>
                        <td class="auto-style2">Date:</td>
                        <td class="auto-style3"><%= myrec.Fields("DateMessage").Value %></td>
                    </tr>
                    <tr>
                        <td class="auto-style2">Message</td>
                        <td class="auto-style3"><%= unescape(myrec.Fields("Message").Value) %></td>
                    </tr>
                </table>
                <a href="messages.asp"><p>Back</p></a>
            </div>
            <div class="col-sm-4"/>
            <div class="col-sm-4"/>
        </div>
    </div>
</body>
</html>