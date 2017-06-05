<%@ Language="javascript" %>
<!-- #include file="checkSession.asp" -->
<%
    var mycon = new ActiveXObject("ADODB.Connection");
    mycon.Open("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("./App_Data/dblonglife.mdb"));

    var name = escape(Request.Form("txtName"));
    var sex = Request.Form("cboSex");
    var look = Request.Form("cboLook");
    var city = escape(Request.Form("txtCity"));
    var maritalStatus = Request.Form("cboMaritalStatus");
    var pwd = Request.Form("txtpwd1");
    var about = escape(Request.Form("txtAbout"));
    var ideal = escape(Request.Form("txtIdeal"));

    var sql = "";
    sql = "UPDATE Users "
        + "SET UserName = '" + name + "', "
        + "Sex = '" + sex + "', "
        + "LookingFor = '" + look + "', "
        + "city = '" + city + "', "
        + "Status = '" + maritalStatus + "', "
        + "[Password] = '" + pwd + "', "
        + "AboutMe = '" + about + "', "
        + "IdealDate = '" + ideal + "' "
        + "WHERE RefUser = " + Session("RefUser");
    
    mycon.Execute(sql);
    
    mycon.Close();
    Response.Redirect("home.asp");
%>
