<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script> 
        $(function () {
        	var val=1;
            var ddlValidation = $("<select id='ddlValidation'/>");
            ddlValidation.append("<option value='+val+'>" + '' + "</option>");
            ddlValidation.append("<option value=1>" + val + "</option>");
            ddlValidation.append("<option value=2>" + "Value2" + "</option>");
            ddlValidation.append("<option value=3>" + "Value3" + "</option>");
            ddlValidation.append("<option value=4>" + "Value4" + "</option>");
             ddlValidation.val(0);
            $('#divmain').append(ddlValidation);
        });
    </script>
</head>

<body>
 <div id="divmain">
 </div>
 
</body>
</html>