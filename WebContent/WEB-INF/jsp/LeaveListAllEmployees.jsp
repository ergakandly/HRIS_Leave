<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="PartBootstrap.jsp"%>
<title>List All Employees</title>
</head>
<body>
	<div id="wrapper">
		<%@include file="PartNavbar.jsp"%>
		
<html:form action="/leaveAction">
	<html:hidden name="leaveForm" property="task" />
	<html:hidden name="leaveForm" property="selectedEmployee" />
		<div id="page-wrapper">
			<!-- CONTAINER -->
			<div class="container-fluid">
				<!-- Columns are always 50% wide, on mobile and desktop -->
				<div class="row">

						<!-- ROW 12 -->
						<div class="col-md-12">

							<!--JUDUL-->
							<div class="page-header">
								<h3 id="timeline">Leave List All Employee</h3>
							</div>

							<!-- BREADCRUMB -->
							<ul class="breadcrumb">
								<li><span class="fa fa-dashboard"></span>
									<a href="<bean:write name="leaveForm" property="urlPortal"/><%= request.getAttribute("zx") %>">Dashboard</a>
								</li>
								<li><span class="fa fa-paper-plane"></span><a href="javascript:navigateToPage('mainMenu')">&nbsp;Leave</a></li>
								<li><span class="fa fa-list"></span> List All Employee</li>
							</ul>
							<!-- END BREADCRUMB -->

							<!-- ISI CONTENT -->
							<div class="col-md-10 col-md-offset-1">


								<table align="center"
									class="table table-striped table-hover table-condensed table-bordered"
									id="sort">
									<thead>
										<tr>
											<th>Employee NIK</th>
											<th>Employee Name</th>
											<th>Department</th>
											<th>Location</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>
										<logic:notEmpty name="leaveForm" property="employeeList">
											<logic:iterate name="leaveForm" property="employeeList"	id="employee">
												<tr>								
													<td id="leaveMainEmpNik<bean:write name="employee" property="employeeId" />">
														<bean:write name="employee" property="employeeNik" />
													</td>
													
													<td id="leaveMainEmpName<bean:write name="employee" property="employeeId" />">
														<bean:write name="employee"	property="employeeName" /></td>
													<td id="leaveMainDept<bean:write name="employee" property="employeeId" />">
														<bean:write name="employee"	property="departmentName" /></td>
													<td id="leaveMainLocation<bean:write name="employee" property="employeeId" />">
														<bean:write name="employee"	property="locationName" /></td>
													<td><button type="button" class="btn btn-success" data-toggle="modal" data-backdrop="static"
															data-target="#modalView"
															onclick="javascript:getCategoryYear('<bean:write name="employee" property="employeeId" />')"
															aria-label="Left Align">
															<i class="fa fa-eye"></i> View
														</button></td>
												</tr>
											</logic:iterate>
										</logic:notEmpty>
									</tbody>
								</table>
							</div>
						</div>
						<!-- END ROW 12 -->

				</div>
			</div>
		</div>	</html:form>
</div>

	<%@include file="PartJavascript.jsp"%>

	<!-- MODAL VIEW-->
	<div class="modal fade" id="modalView" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 id="modalLabel">View Leave Employee</h4>
				</div>
				<div class="modal-body">
						<table id="employeeData" class="table table-condensed table-borderless">
							<tr>
								<td class="kanan fontBold" width="50%">Employee NIK</td>
								<td id="leaveModalEmpNik" width="50%"></td>
							</tr>
							<tr>
								<td class="kanan fontBold">Employee Name</td>
								<td id="leaveModalEmpName"></td>
							</tr>
							<tr>
								<td class="kanan fontBold">Department</td>
								<td id="leaveModalDept"></td>
							</tr>
							<tr>
								<td class="kanan fontBold">Location</td>
								<td id="leaveModalLocation"></td>
							</tr>
							<tr>	
								<td class="kanan fontBold">Search By Submission Date Year:</td>
								<td id="categoryYear"></td>	
							</tr>
							
						</table>
						<br/>
						
						<!-- table AJAX -->
						<table align="center" class="table table-striped table-hover table-condensed" id="leaveList"> 
								
						</table>
								
						<div class="modal-footer">
							<button type="button" class="btn btn-danger" data-dismiss="modal">
								<i class="fa fa-close"></i>Close
							</button>
						</div>
				</div>

			</div>
		</div>
	</div>

	<!-- END MODUL VIEW -->
	<script type="text/javascript">
		$(document).ready(function() {
			$('#sort').dataTable({
				"columns" : [ null, null, null, null, {
					"orderable" : false
				} ]
			});
		});
		
		$(function() {
			$('[data-toggle="tooltip"]').tooltip()
		})
		
			$("#menu-toggle").click(function(e) {
		e.preventDefault();
		$("#wrapper").toggleClass("active");
		});

		function flyToPage(task, id) {
			document.forms[1].task.value = task;
			document.forms[1].selectedEmployee.value = id;
			document.forms[1].submit();
	
		}
		
		function getCategoryYear(selectedEmployee) {
			
			$('#leaveModalEmpNik').html($('#leaveMainEmpNik' + selectedEmployee).text());
			$('#leaveModalEmpName').html($('#leaveMainEmpName' + selectedEmployee).text());
			$('#leaveModalDept').html($('#leaveMainDept' + selectedEmployee).text());
			$('#leaveModalLocation').html($('#leaveMainLocation' + selectedEmployee).text());
			
			$
			.getJSON(
					"/HRIS_Leave/leaveAction.do",
					{
						selectedEmployee: selectedEmployee,
						task : "asyncGetCategoryYear"
					},
					function(data) {
						getAsyncSingleEmployeeLeaveList(selectedEmployee, "default");
						
						var content = 
							'<select id="selectedYear" name="selectedYear" class="form-control-mn"'
							+' onchange="javascript:getAsyncSingleEmployeeLeaveList'
							+"('"+selectedEmployee+"',this.value);\">";
	
						$.each(data, function(index, element) {
							content += '<option value=" '+element+'">'+element+'</option>';
						});
						content+='</select>';
						$("#categoryYear").html(content);				
					});
			
			$('#modalClickRow').modal({
				show : true
			});
		}
		
		function getAsyncSingleEmployeeLeaveList(selectedEmployee,selectedYear) {
			$
			.getJSON(
					"/HRIS_Leave/leaveAction.do",
					{
						selectedYear : selectedYear,
						selectedEmployee: selectedEmployee,
						task : "asyncSingleEmployeeLeaveList"
					},
					function(data) {
	
						var content = 
						"<tr>"+
						"<th>Leave Date</th>"+
						"<th>Total Day</th>"+
						"<th>Leave Type</th>"+
						"<th>Description</th>"+
						"<th>Date of Request</th>"+
						"<th>Expired Date</th>"+
						"<th>Approved By</th></tr>";
	
						$.each(data, function(index, element) {
							if(element.totalLeaveDay > 1)
								element.firstDayOfLeave = element.firstDayOfLeave+" - "+element.lastDayOfLeave
							else
								element.firstDayOfLeave = element.firstDayOfLeave;
								
							content += "<tr><td>" + element.firstDayOfLeave
									+ "</td><td>" + element.totalLeaveDay
									+ "</td><td>" + element.leaveType
									+ "</td><td>" + element.description
									+ "</td><td>" + element.submitDate
									+ "</td><td>" + element.expiredDate
									+ "</td><td>" + element.approvedBy
									+ "</td></tr>";
						});
						$("#leaveList").html(content);
					});
			
			$('#modalClickRow').modal({
				show : true
			});
		}
	</script>
</body>
</html>