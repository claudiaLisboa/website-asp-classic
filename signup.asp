<%@ Language="javascript" %>

<%Session("MESSAGE") = ""; %>
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
        function getBirthdateYMD()
        {
            var dob = new Date(document.getElementById('txtBirthdate').value);

            var birthYear = dob.getFullYear().toString();
            var birthMonth = (dob.getMonth() + 1).toString();
            birthMonth = ("00" + birthMonth).slice(-2);
            var birthDay = dob.getDate().toString();
            birthDay = ("00" + birthDay).slice(-2);

            var dobYMD = birthYear + "/" + birthMonth + "/" + birthDay;
            document.getElementById("txtBirthdateYMD").value = dobYMD;
        }
    </script>
</head>
<body style="background-color:#fff; color:#808080" onload="bodyOnLoad();">
    <div class="container">
        <!--#include file="header_not_logged_in.html" -->
        <form action="validateSignup.asp" method="post" onsubmit="return checkPassword())">
            <div class="row">
                <div class="panel panel-default">
                    <div class="panel-heading row">
                        <div class="col-sm-3 col-md-3">
                            <h3>Create your profile</h3>
                        </div>
                        <div class="col-sm-3 col-md-3">
                            <div class="pull-right">
                                <input type="submit" id="btnSignUp" name="btnSignUp" value="Sign Up" class="btn btn-success"/>
                                <input type="reset" id="btnReset" name="btnReset" value="Cancel" class="btn btn-danger"/>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body row">
                        <div class="col-sm-3 col-md-3">
                            <!---------- EMAIL ---------->
                            <div class="form-group">
                                <label for="txtEmail">Email: <small>(this will be your login)</small></label>
                                <input type="email" class="form-control" id="txtEmail" name="txtEmail" maxlength="40" required>
                            </div>
                            <!---------- PASSWORD ---------->
                            <div class="form-group">
                                <div class="form-inline">
                                    <label for="txtPassword">Password:</label>
                                    <input type="password" class="form-control" id="txtPassword" name="txtPassword" maxlength="20" required>
                                </div>
                            </div>
                            <!---------- RETYPE PASSWORD ---------->
                            <div class="form-group">
                                <div class="form-inline">
                                    <label for="txtConfirmPassword">Retype password:</label>
                                    <input type="password" class="form-control" id="txtConfirmPassword" name="txtConfirmPassword" maxlength="20" required>
                                </div>
                            </div>
                            <!---------- NAME ---------->
                            <div class="form-group">
                                <label for="txtName">Name:</label>
                                <input type="text" class="form-control" id="txtName" name="txtName" maxlength="25" required>
                            </div>
                            <!---------- SEX ---------->
                            <div class="form-group">
                                <div class="form-inline">
                                    <label for="cboSex">Sex:</label>
			                        <select id="cboSex" name="cboSex" class="form-control" required>
				                        <option value="Woman">Female</option>
				                        <option value="Man">Male</option>
			                        </select>
                                </div>
                            </div>
                            <!---------- LOOKING FOR---------->
                            <div class="form-group">
                                <div class="form-inline">
                                    <label for="cboLook">Looking for:</label>
			                        <select id="cboLook" name="cboLook" class="form-control" required>
				                        <option value="Man">Man</option>
				                        <option value="Woman">Woman</option>
			                        </select>
                                </div>
                            </div>
                            <!---------- CITY ---------->
                            <div class="form-group">
                                <label for="txtCity">City:</label>
                                <input type="text" class="form-control" id="txtCity" name="txtCity" maxlength="25" required>
                            </div>
                            <!---------- MARITAL STATUS ---------->
                            <div class="form-group">
                                <div class="form-inline">
                                    <label for="cboMaritalStatus">Status:</label>
			                        <select id="cboMaritalStatus" name="cboMaritalStatus" class="form-control" required>
				                        <option value="Single">Single</option>
				                        <option value="Married">Married</option>
				                        <option value="Dating">Dating</option>
				                        <option value="Confused">Confused</option>
			                        </select>
                                </div>
                            </div>
                            <!---------- BIRTHDATE ---------->
                            <div class="form-group">
                                <div class="form-inline">
                                    <label for="txtBirthdate">Birthdate:</label>
                                    <input type="date" id="txtBirthdate" name="txtBirthdate" class="form-control" required onchange="getBirthdateYMD()" onblur="getBirthdateYMD()">
                                    <input type="hidden" id="txtBirthdateYMD" name="txtBirthdateYMD">
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-3 col-md-3">
                            <!-- Picture choosing will not be implemented. -->
                            <!--
                            <p><strong>Choose your profile picture:</strong></p><br />
                            <input type="file" id="picUser" name="picUser" accept="images/*">
                            -->
                            <!---------- ABOUT ME ---------->
                            <div class="form-group">
                                <label for="txtAbout">About me:</label>
                                <textarea rows="4" cols="50" id="txtAbout" name="txtAbout" class="form-control" placeholder="Describe yourself."></textarea>
                            </div>
                            <!---------- IDEAL DATE ---------->
                            <div class="form-group">
                                <label for="txtIdealDate">Ideal Date:</label>
                                <textarea rows="4" cols="50" id="txtIdealDate" name="txtIdealDate" class="form-control" placeholder="Describe your ideal date."></textarea><br /><br />
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-6">
                            <img class="img-responsive" src="images/signup-dating.jpg" alt="Longueuil Life"> 
                        </div>
                    </div>
                </div>
            </div>
            <%=  Session("MESSAGE") %>
        </form>
    </div>
</body>
</html>
