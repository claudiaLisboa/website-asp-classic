<%
    function calculateAge(dateOfBirth)
    {
        var today = new Date();
        var dob = new Date(dateOfBirth);

        var calculateYear = today.getFullYear();
        var calculateMonth = today.getMonth() + 1;
        var calculateDay = today.getDate();

        var birthYear = dob.getFullYear();
        var birthMonth = dob.getMonth();
        var birthDay = dob.getDate();

        var age = calculateYear - birthYear;
        var ageMonth = calculateMonth - birthMonth;
        var ageDay = calculateDay - birthDay;

        if (ageMonth < 0 || (ageMonth == 0 && ageDay < 0))
        {
            age = parseInt(age) - 1;
        }
        return age;
    }

    function getMessageCount(conn, refUser)
    {
        var recMessageCount = new ActiveXObject("ADODB.Recordset");

        var sql = "SELECT COUNT(*) FROM Messages Where Receiver = "  + refUser;
        recMessageCount.Open(sql, conn);

        return recMessageCount.Fields(0).Value;
    }
%>
