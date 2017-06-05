<%@ Language="javascript" %>
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
        function clearMessage()
        {
            document.getElementById("divMessage").innerHTML = "";
        }
    </script>
</head>
<body style="background-color:#fff; color:#808080" onload="bodyOnLoad();">
    <div class="container">
        <!--#include file="header_not_logged_in.html" -->
        <div class="row">
            <div class="col-sm-8">
                <img src="images/dating4.jpg" alt="Love" class="img-responsive"/>
            </div>
            <div class="col-sm-4 panel panel-default">
                <form action="validateLogin.asp" method="post" onreset="clearMessage();">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h2>Members only</h2>
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <label for="txtEmail">Email:</label>
                                <input type="email" class="form-control" id="txtEmail" name="txtEmail" maxlength="30" required>
                            </div>
                            <div class="form-group">
                                <label for="txtPassword">Password:</label>
                                <input type="password" class="form-control" id="txtPassword" name="txtPassword" required>
                            </div>
                            <input id="btnSubmit" type="submit" value="Enter" class="btn btn-success"/>
                            <input id="btnReset" type="reset" value="Clear" class="btn btn-danger"/>
                        </div>
                        <div class="alert alert-warning" id="divMessage">
                            <%= "<strong>" + Session("MESSAGE") + "</strong>" %>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>