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
        <!--#include file="header_not_logged_in.html" -->
        <div class="row">
            <div class="col-sm-2">
                <div style="color: black"><h2>Sign Up</h2></div>
                <br/>
                <label>Be part of Longueuil Life, and find the love of your life.</label>
                <br/>
                <br/>
                <a href="signup.asp" class="btn btn-info btn-lg">
                    <strong>Sign Up</strong>
                </a>
            </div>
            <div class="col-sm-8">
                <img src="images/dating2.jpg" alt="Love" class="img-responsive"/>
            </div>
            <div class="col-sm-2" style="text-align:end">
                <div style="color: black"><h2>Login</h2></div>
                <br/>
                <label>Already part of our community? Access your account here.</label>
                <br/>
                <br/>
                <a href="login.asp" class="btn btn-info btn-lg">
                    <strong>Login</strong>
                </a>
            </div>
        </div>
    </div>
</body>
</html>
