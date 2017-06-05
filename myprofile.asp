<%@ Language="javascript" %>
<!-- #include file="checkSession.asp" -->
<!-- #include file="functions.asp" -->
<%
    // Clearing the session variable MESSAGE.
    Session("MESSAGE") = "";

    var mycon = new ActiveXObject("ADODB.Connection");
    mycon.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("./App_Data/dblonglife.mdb"));

    // Retrieving information of the logged in user.
    var sqlUser = "SELECT * FROM Users WHERE RefUser = " + Session("RefUser");
    var recUser = new ActiveXObject("ADODB.Recordset");
    recUser.Open(sqlUser, mycon);

    if (recUser.EOF)
    {
        recUser.Close();
        mycon.Close();
    }

    var username = recUser.Fields("UserName").Value;
    var sex = recUser.Fields("Sex").Value;
    var lookingFor = recUser.Fields("LookingFor").Value;
    var city = recUser.Fields("City").Value;
    var maritalStatus = recUser.Fields("Status").Value;
    var email = recUser.Fields("Email").Value;
    var aboutMe = recUser.Fields("AboutMe").Value;
    var idealDate = recUser.Fields("IdealDate").Value;

    // Retrieving the BirthDate field and formatting it as YYYY-MM-DD.
    var birthDate = new Date(recUser.Fields("BirthDate").Value);

    var birthYear = birthDate.getFullYear().toString();
    var birthMonth = (birthDate.getMonth() + 1).toString();
    birthMonth = ("00" + birthMonth).slice(-2);
    var birthDay = birthDate.getDate().toString();
    birthDay = ("00" + birthDay).slice(-2);

    var birthDateYMD = birthYear + "-" + birthMonth + "-" + birthDay;
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
        function confirmDeleteProfile()
        {
            if (confirm("Do you really want to delete your profile?") == true)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        function deleteProfile()
        {
            if (confirm("Do you really want to delete your profile?") == true)
            {
                window.location = "deleteProfile.asp";
                return true;
            }
            else
            {
                return false;
            }
        }

        function bodyOnLoad()
        {
            bodyBackground();
            setFields();
        }

        function setFields()
        {
            var txtName = document.getElementById("txtName");
            txtName.value = unescape("<%=username%>");
            var cboSex = document.getElementById("cboSex");
            cboSex.value = "<%=sex%>";
            var cboLook = document.getElementById("cboLook");
            cboLook.value = "<%=lookingFor%>";
            var txtCity = document.getElementById("txtCity");
            txtCity.value = unescape("<%=city%>");
            var cboMaritalStatus = document.getElementById("cboMaritalStatus");
            cboMaritalStatus.value = "<%=maritalStatus%>";
            var txtBirthdate = document.getElementById("txtBirthdate");
            txtBirthdate.value = "<%=birthDateYMD%>";
            var txtEmail = document.getElementById("txtEmail");
            txtEmail.value = "<%=email%>";
            var txtAbout = document.getElementById("txtAbout");
            txtAbout.value = unescape("<%=aboutMe%>");
            var txtIdeal = document.getElementById("txtIdeal");
            txtIdeal.value = unescape("<%=idealDate%>");
        }

        function checkPassword()
        {
            if (document.getElementById("txtpwd1").value == document.getElementById("txtpwd2").value)
            {
                return true;
            }
            else
            {
                window.alert("The password must be the same");
                return false;
            }
        }
    </script>
</head>
<body style="background-color:#fff; color:#808080" onload="bodyOnLoad();">
    <div class="container">
        <!--#include file="header_logged_in.html" -->
        <div class="row">
            <ul class="nav nav-tabs">
                <li><a href="home.asp"><span class="glyphicon glyphicon-home"></span> Home</a></li>
                <li class="active"><a href="#"><span class="glyphicon glyphicon-user"></span> Profile</a></li>
                <li>
                    <a href="messages.asp">
                        <span class="glyphicon glyphicon-envelope"></span> Messages <span class="badge"><%=getMessageCount(mycon, Session("RefUser")) %></span>
                    </a>
                </li>
                <li><a href="logout.asp"><span class="glyphicon glyphicon-user"></span> Logout</a></li>
            </ul>
            <form action="updateProfile.asp" method="post" onsubmit="return checkPassword()">
                <div class="col-sm-4">
                    <h3>Change your profile</h3>
                    <!---------- NAME ---------->
                    <p>
                        <strong>Name:</strong> 
                        <input type="text" name="txtName" id="txtName" size="30" maxlength="25" value="<%=unescape(username)%>" required/>
                    </p>
                    <label>Sex:</label>
                    <!---------- SEX ---------->
			        <select id="cboSex" name="cboSex">
				        <option value="Woman">Female</option>
				        <option value="Man">Male</option>
			        </select>
                    <!---------- LOOKING FOR ---------->
                    <label>Looking for:</label>
			        <select id="cboLook" name="cboLook">
				        <option value="Man">Man</option>
				        <option value="Woman">Woman</option>
			        </select>
                    <!---------- CITY ---------->
                    <p>
                        <strong>City:</strong> 
                        <input type="text" name="txtCity" id="txtCity" size="30" maxlength="25" value="<%=unescape(city)%>" required/>
                    </p>
                    <!---------- MARITAL STATUS ---------->
                    <label>Status:</label>
			        <select id="cboMaritalStatus" name="cboMaritalStatus">
				        <option value="Single">Single</option>
				        <option value="Married">Married</option>
				        <option value="Dating">Dating</option>
				        <option value="Confused">Confused</option>
			        </select>
                    <!---------- BIRTHDATE ---------->
                    <p>
                        <strong>Birthdate:</strong>
                        <!-- TODO: Use separate fields for year, month, and date instead? -->
                        <input type="date" id="txtBirthdate" name="txtBirthdate" required
                             value="<%= birthDateYMD%>" readonly>
<!--                        <input type="text" id="txtBirthdate" name="txtBirthdate" readonly value="<%= birthDateYMD%>">-->
                    </p>
                    <!---------- EMAIL (readonly) ---------->
                    <p>
                        <strong>Email:</strong> 
                        <input type="email" name="txtEmail" id="txtEmail" readonly value="<%=email%>"/>
                    </p>
                    <!---------- PASSWORD ---------->
                    <p>
                        <strong>Password:</strong> 
                        <input id="txtpwd1" maxlength="10" name="txtpwd1" size="20" type="password" required/>
                    </p>
                    <!---------- RETYPE PASSWORD ---------->
                    <p>
                        <strong>Repeat Password:</strong> 
                        <input id="txtpwd2" maxlength="10" name="txtpwd2" size="20" type="password" required/>
                    </p>
                </div>
                <div class="col-sm-4">
                    <p><strong>About me:</strong></p>
                    <textarea rows="4" cols="50" name="txtAbout" id="txtAbout"><%=unescape(aboutMe)%></textarea>
                    <p><strong>Ideal Date:</strong></p>
                    <textarea rows="4" cols="50" name="txtIdeal" id="txtIdeal"><%=unescape(idealDate)%></textarea>
                    <input id="btnSave" name="btnSave" type="submit" value="Save" class="btn btn-success"/>
                    <input id="btnReset" name="btnReset" type="reset" value="Cancel" class="btn btn-danger"/>
                    <div class="pull-right">
                        <button id="btnDeleteProfile" name="btnDeleteProfile" type="button" class="btn btn-danger"
                            onclick="return deleteProfile()">Delete Profile</button>
                    </div>
                </div>
                <div class="col-sm-4">
                <%
                recUser.Close();
                mycon.Close();
                %>
                </div>
            </form>
        </div>
    </div>
</body>
</html>	