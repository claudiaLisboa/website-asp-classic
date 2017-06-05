<%@ Language="javascript" %>
<!-- #include file="checkSession.asp" -->
<!-- #include file="functions.asp" -->
<%
    // Clearing the session variable MESSAGE.
    Session("MESSAGE") = "";

    // Connecting to the database.
    var mycon = new ActiveXObject("ADODB.Connection");
    mycon.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("./App_Data/dblonglife.mdb"));


    // Retrieving some information of the logged in user.
    var sqlUser = "SELECT refUser, UserName, Email, LookingFor FROM Users WHERE RefUser = " + Session("RefUser");
    var recUser = new ActiveXObject("ADODB.Recordset");
    recUser.Open(sqlUser, mycon);


    // Retrieving all cities to populate cboCity.
    var sqlCity = "SELECT DISTINCT City FROM Users";
    var recCity = new ActiveXObject("ADODB.Recordset");
    recCity.Open(sqlCity, mycon);


    // Retrieving the search terms used.
    // The test Request().Count > 0 below was taken from:
    // http://stackoverflow.com/questions/18110633/how-to-check-if-a-post-submitted-field-exists-in-vbscript
    // It is used to check whether the Request.Form element has been sent to this page.
    // If Count == 0 it means the Request.Form element has not been sent and its value will be undefined.
    var searchSex = "";
    if (Request("cboSex").Count > 0)
    {
        searchSex = Request.Form("cboSex");
    }
    else
    {
        searchSex = recUser.Fields("LookingFor").Value;
    }
    var searchMaritalStatus = "";
    if (Request("cboMaritalStatus").Count > 0)
    {
        searchMaritalStatus = Request.Form("cboMaritalStatus");
    }
    var searchCity = "";
    if (Request("cboCity").Count > 0)
    {
        searchCity = Request.Form("cboCity");
    }
    var searchAge = "";
    if (Request("cboAge").Count > 0)
    {
        searchAge = Request.Form("cboAge");
    }


    // Retrieving matches based on the search terms.
    var sqlMatches = "SELECT RefUser, UserName, BirthDate, City, Sex, Status, DATEDIFF('yyyy', BirthDate, Now()) as age FROM Users";
    sqlMatches += " WHERE RefUser <> " + Session("RefUser");
    if (searchSex != "")
    {
        sqlMatches += " AND Sex = '" + searchSex + "'";
    }
    if (searchMaritalStatus != "")
    {
        sqlMatches += " AND Status = '" + searchMaritalStatus + "'";
    }
    if (searchCity != "")
    {
        sqlMatches += " AND City = '" + searchCity + "'";
    }
    if (searchAge != "")
    {
        var ageLower = parseInt(searchAge);
        var ageUpper = ageLower + 10;
        if (ageLower == 80)
        {
            sqlMatches += " AND DATEDIFF('yyyy', BirthDate, Now()) >= " + ageLower;
        }
        else
        {
            sqlMatches += " AND DATEDIFF('yyyy', BirthDate, Now()) BETWEEN " + ageLower + " AND " + ageUpper;
        }
    }
    sqlMatches += " ORDER BY UserName";

    var recMatches = new ActiveXObject("ADODB.Recordset");
    recMatches.Open(sqlMatches, mycon);

    if (recMatches.EOF)
    {
        Session("MESSAGE") = "No matches for your profile.";
    }
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
        function setSearchFields()
        {
            var cboSex = document.getElementById("cboSex");
            cboSex.value = "<%=searchSex%>";
            var cboMaritalStatus = document.getElementById("cboMaritalStatus");
            cboMaritalStatus.value = "<%=searchMaritalStatus%>";
            var cboCity = document.getElementById("cboCity");
            cboCity.value = "<%=searchCity%>";
            var cboAge = document.getElementById("cboAge");
            cboAge.value = "<%=searchAge%>";
        }
        function bodyOnLoad()
        {
            bodyBackground();
            setSearchFields();
        }
    </script>
</head>
<body style="background-color:#fff; color:#808080" onload="bodyOnLoad();">
    <div class="container">
        <!--#include file="header_logged_in.html" -->
        <div class="row">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#"><span class="glyphicon glyphicon-home"></span> Home</a></li>
                <li><a href="myprofile.asp"><span class="glyphicon glyphicon-user"></span>Your Profile</a></li>
                <li>
                    <a href="messages.asp">
                        <span class="glyphicon glyphicon-envelope"></span> Messages <span class="badge"><%=getMessageCount(mycon, Session("RefUser")) %></span>
                    </a>
                </li>
                <li><a href="logout.asp"><span class="glyphicon glyphicon-user"></span> Logout</a></li>
            </ul>
            <div class="row well well-sm">
                <form action="home.asp" method="post">
                    <div class="pull-left">
                        <h4>Welcome, <%= unescape(recUser.Fields("UserName").Value) %>!</h4>
                    </div>
                    <div class="pull-right">
                        <!---------- SEARCH FIELDS ---------->
                        <div class="form-group">
                            <div class="form-inline">
                                <!---------- SEX ---------->
                                <label for="cboSex">Sex:</label>
			                    <select id="cboSex" name="cboSex" class="form-control">
				                    <option value=""></option>
				                    <option value="Woman">Female</option>
				                    <option value="Man">Male</option>
			                    </select>
                                <!---------- MARITAL STATUS ---------->
                                <label for="cboMaritalStatus">Status:</label>
			                    <select id="cboMaritalStatus" name="cboMaritalStatus" class="form-control">
				                    <option value=""></option>
                                    <option value="Single">Single</option>
                                    <option value="Married">Married</option>
                                    <option value="Dating">Dating</option>
                                    <option value="Confused">Confused</option>
                                </select>
                                <!---------- CITY ---------->
                                <label for="cboCity">City:</label>
			                    <select id="cboCity" name="cboCity" class="form-control">
				                    <option value=""></option>
                                    <% while (!recCity.EOF) { %>
                                    <option value="<%= recCity("City").Value%>"><%= recCity.Fields("City").Value%></option>
                                    <% recCity.MoveNext();} recCity.Close();%>
                                </select>
                                <!---------- AGE RANGE ---------->
                                <label for="cboAge">Age between:</label>
			                    <select id="cboAge" name="cboAge" class="form-control">
				                    <option value=""></option>
				                    <option value="20">20 - 30</option>
                                    <option value="30">30 - 40</option>
                                    <option value="40">40 - 50</option>
                                    <option value="50">50 - 60</option>
                                    <option value="60">60 - 70</option>
                                    <option value="70">70 - 80</option>
                                    <option value="80">80 - + </option>
                                </select>
                                <input id="btnSearch" type="submit" value="Search" class="btn btn-info"/>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <!-- Taken from: http://stackoverflow.com/questions/20376179/create-3-side-by-side-panel-in-bootstrap -->
            <div class="panel panel-default" style="background-color:transparent;">
                <div class="row">
                    <h4 style="color:#f00"><%=Session("MESSAGE") %></h4>
                    <% while(!recMatches.EOF) { %>
                        <div class="col-lg-3 col-md-3 col-sm-3">
                            <div class="panel panel-default center-block" style="padding:10px; width:200px; border:1px solid green;" >
                                <h4> <%= unescape(recMatches.Fields("UserName").Value) %></h4>
                                <p>Sex: <%= recMatches.Fields("Sex").Value %></p>   
                                <p id="age">Age: <%= recMatches.Fields("age").Value%></p>
                                <p>Status: <%= recMatches.Fields("Status").Value %></p>   
                                <p>City: <%= recMatches.Fields("City").Value %></p>   
                                <p>
                                    <a href="profile.asp?refM=<%= recMatches.Fields("RefUser").Value%>">
                                        <span class="glyphicon glyphicon-user"></span>&nbsp;See Profile
                                    </a>
                                </p>
                                <p>
                                    <a href="compose.asp?refM=<%= recMatches.Fields("RefUser").Value%>">
                                        <span class="glyphicon glyphicon-envelope"></span>&nbsp;Send a Message
                                    </a>
                                </p>
                            </div>
                        </div>
                        <% recMatches.MoveNext(); %>
                    <% } %>
                    <% recMatches.Close(); %>
                </div>
            </div>
        </div>
    </div>
<%
    recUser.Close();
    mycon.Close();
%>
</body>
</html>