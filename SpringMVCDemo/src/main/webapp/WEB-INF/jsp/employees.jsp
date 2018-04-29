<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
 <%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
     <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
     <title>Insert title here</title>
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
     <link rel="stylesheet" href="https://cdn.datatables.net/1.10.4/css/jquery.dataTables.min.css">
     <script src="https://cdn.datatables.net/1.10.4/js/jquery.dataTables.min.js"></script>
 <script>
 var tmp = JSON.stringify("${employeeList}");    
 //alert(tmp);
 var obj = jQuery.parseJSON(tmp);
 //alert( obj.name === "John" );
$(document).ready(function(){
	$("#empform").hide()
    /* $("#editbutt01").click(function(){
    	alert("inside edit click ");
    	var empid=$("#editbutt01").val();
    	alert('empid::'+empid);
    	editEmp(empid);
    });*/
    
    $("#viewBTDT").click(function(){
    	viewBTdataTab();
    }); 
    
	 $("#addemp").click(function(){
		 $("#empform").show();
	    }); 
});

var callMe  = function(thisValue){
	//alert("inside edit click ");
	var empid=thisValue;
	//alert('empid::'+empid);
	editEmp(empid);
}

var buildDtTable = function(data){
		//Building dynamic table
		//Style:01
		/* $('#dtTable').html('<table class="table table-bordered"><thead></thead><tbody></tbody></table>');

			$('#dtTable > table > thead')
					.append('<tr>'
									+
									'<th>ID</th>'
									+
									'<th>Name</th>'
									+
									'<th>Age</th>'
									+
									'<th>Department</th>'
									+
									'</tr>'); */

			$('#tmpTable')
					.dataTable(
							{
								bPaginate : true,
								bFilter : true,
								bInfo : true,
								ordering : true,
								deferRender : true,
								"drawCallback": function(settings) {
									
								},
								data : jQuery.parseJSON(data),
								columns : [
										{
											"title" : "ID",
											"data" : "id"
										},
										{"title" : "Name","data" : "name"},
										{"title" : "Age","data" : "age"},
										{
											"title" : "Department",
											"data" : "dept",
											"render": function(thisFunData){
												if(thisFunData.toLowerCase() == "it") return "IT Department";
												if(thisFunData.toLowerCase() == "it1") return "IT Department 01";
												else return thisFunData;
											}
										}
								],
								/* dom : 'Bfrtip',
								buttons : [
									'print'
								] */
							});

		}

		var viewBTdataTab = function() {
			var formURL = "http://localhost:8080/SpringMVCDemo/empDetails";
			$.ajax({
				url : formURL,
				type : 'POST'
			}).done(function(data) {
				//alert('data::'+data);
				buildDtTable(data);
				//dtTable
			}).fail(function(data) {
				alert('Error. Please contact Emmes');
			});
		}
		var editEmp = function(empid) {
			$("#empform").show();
			var formURL = "http://localhost:8080/SpringMVCDemo/editview/"
					+ empid;
			$.ajax({
				url : formURL,
				type : 'POST'
			}).done(function(data) {
				$.each(data, function(key, value) {
					if (key === "id") {
						$('#id').val(value);
					} else if (key === "name") {
						$('#name').val(value);
					} else if (key === "age") {
						$('#age').val(value);
					} else if (key === "dept") {
						$('#dept').val(value);
					}
				});
			}).fail(function(data) {
				alert('Error. Please contact Emmes');
			});
		};
		/* var isFieldEmpty=function(){
		 var id= $('#id').val();
		 if(id==""){
		 alert("id should not be empty");
		 }
		 }
		 /* 
		 */
		/* var searchbyID=function(){
		var searchid=$('#sremp').val();
		alert('searchid:'+searchid);
		var formURL = "http://localhost:8080/SpringMVCDemo/search/"+searchid;
		 var postData = {
		            SERARCHID:searchid
		     };
		 $.ajax({
		        url: formURL,
		        data: postData,
		        type: 'POST'
		    }).done(function (data) {
		      alert('obj:'+obj);
		    }).fail(function (data) {
		       alert('Error. Please contact Emmes');
		    })
		}
		var loadempList=function(){
		var formURL = "http://localhost:8080/SpringMVCDemo/empList";
		 
		 $.ajax({
		        url: formURL,
		        type: 'POST'
		    }).done(function (data) {
		      alert('obj:'+data);
		    }).fail(function (data) {
		       alert('Error. Please contact Emmes');
		    })
		} */
	</script>
   </head>
   <body>
   
     <h3>List of Employees</h3>
      <input type="submit" value="View BSDT" id="viewBTDT"/>
        <input type="submit" value="ADD" id="addemp"/>
       <table class="table table-bordered" style="width: 400px" id="tabid1">
         <tr>
           <th>Id</th>
           <th>Name</th>
           <th>Age</th>
           <th>Department</th>
           <th>EDIt</th>
            <th>Delete</th>
         </tr>
         <c:forEach items="${employeeList}" var="employee">
         <tr>
           <td width="60" align="center">${employee.id}</td>
           <td width="60" align="center">${employee.name}</td>
           <td width="60" align="center">${employee.age}</td>
           <td width="60" align="center">${employee.dept}</td>
           <td width="60" align="center">
           <button id="" value="${employee.id}" onClick="callMe(this.value)">EDIT</button></td>
           <td width="60" align="center">
          <%--  <a href="delete/${employee.id}">Delete</a> --%>
           <button id="deletebutt01" value="${employee.id}" >delete</button></td>
         </tr>
      </c:forEach>
    </table>
     <br>
     <br>
    <div id="empform" style="display:none">
      <form:form method="post" action="/SpringMVCDemo/saveemp" commandName="employee">
        <div class="table-responsive" >
          <table class="table table-bordered" style="width: 300px">
            <tr>
              <td>Id :</td>
              <td><form:input type="text" path="id" id="id" /></td>
            </tr>
            <tr>
              <td>Name :</td>
              <td><form:input type="text" path="name" id="name"/></td>
            </tr>
            <tr>
              <td>Age :</td>
              <td><form:input type="text" path="age" id="age"/></td>
            </tr>
            <tr>
              <td>Department :</td>
              <td><form:input type="text" path="dept" id="dept"/></td>
            </tr>
            <tr>
              <td></td>
              <td><input class="btn btn-primary btn-sm" type="submit" value="Submit" id="saveEmp" /></td>
            </tr>
          </table>
        </div>
      </form:form>
      </div>
      <div id="dtTable">
      	<table class="table table-bordered" id="tmpTable"></table>
      </div>
  </body>
</html>