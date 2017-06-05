<%@ Language="javascript" %>
<%
    var sql = "";

    var mycon = new ActiveXObject("ADODB.Connection");
    mycon.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("./App_Data/dblonglife.mdb"));

    var name = escape(Request.Form("txtName"));
	var sex = Request.Form("cboSex");
	var look = Request.Form("cboLook");
	var city = escape(Request.Form("txtCity"));
	var maritalStatus = Request.Form("cboMaritalStatus");
	var birthDateYMD = Request.Form("txtBirthdateYMD");
	var email = Request.Form("txtEmail");
	var pwd = Request.Form("txtPassword");
	var about = escape(Request.Form("txtAbout"));
	var ideal = escape(Request.Form("txtIdealDate"));

	
	var recCheckUser = new ActiveXObject("ADODB.Recordset");

	sql = "SELECT Email FROM Users WHERE Email='" + email + "'";

    recCheckUser.Open(sql, mycon);
    if (!recCheckUser.EOF)
    {
        recCheckUser.Close();
        mycon.Close();
        alert("The user already exists.");
        Response.Redirect("index.asp");
    }

    sql = "INSERT INTO Users "
        + "(UserName, Sex, LookingFor, City, Status, BirthDate, Email, [Password], AboutMe, IdealDate) "
        + "VALUES "
        + "('" + name + "', '" + sex + "', '" + look + "', '" + city + "', '" + maritalStatus + "', '" + birthDateYMD + "', '" + email + "', '" + pwd + "', '" + about + "', '" + ideal + "')";
    mycon.Execute(sql);


    recCheckUser.Close();
    mycon.Close();
    Response.Redirect("index.asp");
%>