<%@ Language="javascript" %>
<!-- #include file="checkSession.asp" -->
<!-- #include file="functions.asp" -->
<%
    var ref = Request.QueryString("refM");

    sql = "SELECT * FROM Users WHERE refUser = " + ref;

    var mycon = new ActiveXObject("ADODB.Connection");
    mycon.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("./App_Data/dblonglife.mdb"));
   
    var myrec = new ActiveXObject("ADODB.Recordset");
    myrec.Open(sql, mycon);

    Session("MESSAGE")="";
    if (myrec.EOF)
    {
        myrec.Close();
        mycon.Close();
    }

    birthDate = myrec.Fields("BirthDate").Value;
    tAge = calculateAge(birthDate);
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
        .auto-style1 {
            width: 104px;
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
                <h3><%= unescape(myrec.Fields("UserName").Value) %></h3>
            </div>
            <div class="col-sm-4">
                <table class="nav-justified">
                    <tr>
                        <td class="auto-style1"><h4 id="age">Age:</h4> </td>
                        <td><%= tAge %></td>
                    </tr>
                    <tr>
                        <td class="auto-style1"><h4>City:</h4></td>
                        <td><%= unescape(myrec.Fields("City").Value) %></td>
                    </tr>
                    <tr>
                        <td class="auto-style1"><h4>Looking For:</h4></td>
                        <td><%= myrec.Fields("LookingFor").Value %><br/></td>
                    </tr>
                    <tr>
                        <td class="auto-style1"><h4>Status:</h4></td>
                        <td><%= myrec.Fields("Status").Value %></td>
                    </tr>
                </table>
                <h4>About me:</h4><p> <%= unescape(myrec.Fields("AboutMe").Value) %> </p>
                <h4>Ideal date:</h4><p> <%= unescape(myrec.Fields("IdealDate").Value) %> </p>      
                <p>
                    <a href="compose.asp?refM=<%= myrec.Fields("RefUser").Value%>">
                        <span class="glyphicon glyphicon-envelope"></span>Send a Message
                    </a>
                </p>
            </div>
            <div class="col-sm-4" />
            <%
                myrec.Close();
                mycon.Close();
            %>
        </div>
    </div>
</body>
</html>	