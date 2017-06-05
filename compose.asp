<%@ Language="javascript" %>
<!-- #include file="checkSession.asp" -->
<%
    var ref = Request.QueryString("refM");

    var mycon = new ActiveXObject("ADODB.Connection");
    mycon.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("./App_Data/dblonglife.mdb"));

    var sql = "SELECT refUser, UserName FROM Users WHERE refUser=" + ref;

    var myrec = new ActiveXObject("ADODB.Recordset");
    myrec.Open(sql, mycon);
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
        input {
            width: 600px;
            border: 3px solid #cccccc;
            padding: 5px;
            font-family: Tahoma, sans-serif;
            background-image: url(bg.gif);
            background-position: bottom right;
            background-repeat: no-repeat;
        }
        textarea#styled {
            width: 600px;
            height: 120px;
            border: 3px solid #cccccc;
            padding: 5px;
            font-family: Tahoma, sans-serif;
            background-image: url(bg.gif);
            background-position: bottom right;
            background-repeat: no-repeat;
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
            <div class="col-sm-4" style="width:500px;">
                <p style="text-align: center">NEW MESSAGE</p>
                <form action="send.asp" method="post" onsubmit="verify()">
                    <table style="width:500px;">
                        <tr>
                            <td class="auto-style6">TO:</td>
                            <td class="auto-style7">
                                <select id="cboReceiver" name="cboReceiver" size="1" >
                                <option value="<%= myrec("refUser").Value %>"><%= myrec.Fields("UserName").Value %></option>
                            </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style6">Subject:</td>
                            <td class="auto-style7">
                                <input id="Text1" type="text" name="txtSubject" required="required" size="55" maxlength="50"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style4">Message:<br />
                                <br />
                                <br />
                                <br />
                                <br />
                            </td>
                            <td class="auto-style5">
                                <textarea id="styled" name="txtMessage" required="required" ></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">&nbsp;</td>
                            <td class="auto-style3">
                                &nbsp;<input id="Submit1" type="submit" value="Send" class="btn btn-success"/>&nbsp;&nbsp;&nbsp;&nbsp;<input id="Reset1" type="reset" value="Clear" class="btn btn-danger"/>
                            </td>
                        </tr>
                    </table>
                </form> 
            </div>
        </div>
    </div>
</body>
</html>