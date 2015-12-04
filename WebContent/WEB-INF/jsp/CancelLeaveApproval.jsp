<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="PartBootstrap.jsp"%>
<title>Leave Cancellation Approval</title>
</head>
<body>
	<div id="wrapper">
		<%@include file="PartNavbar.jsp"%>


			<div id="page-wrapper">
				<div class="container-fluid">
					<div class="row">

						<!-- ISI CONTENT -->
						<div class="col-md-12">
							<!--JUDUL-->
							<div class="page-header">
								<h3 id="timeline">Leave Cancellation Approval</h3>
							</div>
							<!-- END JUDUL -->

							<!-- BREADCRUMB -->
							<ul class="breadcrumb">
								<li><span class="fa fa-dashboard"></span><a href="#">Dashboard</a></li>
								<li><span class="fa fa-paper-plane"></span><a href="javascript:navigateToPage('mainMenu')">&nbsp;Leave</a></li>
								<li><span class="fa fa-check-square-o"></span> Leave Cancellation Approval</li>
							</ul>
							<!-- END BREADCRUMB -->

							<div class="col-md-10 col-md-offset-1">
								<table align="center"
									class="table table-striped table-hover table-condensed table-bordered" id="sort">
									<thead>
										<tr>
											<th>Employee Name</th>
											<th>Leave Date</th>
											<th>Leave Type</th>
											<th>Leave Description</th>
											<th class="tengah">Actions Button</th>
										</tr>
									</thead>
									<tbody>
										<logic:notEmpty name="leaveForm" property="employeeLeaveList">
											<logic:iterate id="leave" name="leaveForm"	property="employeeLeaveList">
												<tr>
													<td><bean:write name="leave" property="employeeName" /></td>
													<td><logic:lessEqual name="leave" property="totalLeaveDay" value="1">
															<bean:write name="leave" property="firstDayOfLeave" />
														</logic:lessEqual>
														<logic:greaterThan name="leave" property="totalLeaveDay" value="1">
															<bean:write name="leave" property="firstDayOfLeave" /> - 
															<bean:write	name="leave" property="lastDayOfLeave" />
														</logic:greaterThan>
													</td>
													<td><bean:write name="leave" property="leaveType" /></td>
													<td><bean:write name="leave" property="description" /></td>
													<td class="tengah">
														<button data-toggle="modal" data-target="#sure"	type="button" class="btn btn-primary" class="btn btn-success" 
															onclick="javascript:submitForm('approveleavecancellation','<bean:write name="leave" property="leaveId"/>');">
															<i class="fa fa-check"></i> Approve
														</button>
														<button data-toggle="modal" data-target="#sure"	type="button" class="btn btn-danger" 
															onclick="javascript:submitForm('rejectleavecancellation','<bean:write name="leave" property="leaveId"/>');">
															<i class="fa fa-close"></i> Reject
														</button></td>
												</tr>
											</logic:iterate>
										</logic:notEmpty>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
	</div>

	<!-- MODAL MODAL ARE YOU SURE APPROVE -->
<html:form action="/leaveAction.do">
	<html:hidden name="leaveForm" property="task" />
	<html:hidden name="leaveForm" property="selectedLeaveId" />
	<html:hidden name="leaveForm" property="approvedEmployeeId" />
	
	<div class="modal fade" id="sure" tabindex="-1" role="dialog" aria-labelledby="#deactivateModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Notification</h4>
				</div>
				<div class="modal-body">
					<div class="alert alert-info kiri" role="alert" id="alertDiv">
						<i class="fa fa-info-circle"></i> <label id="alert"></label>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">
						<i class="fa fa-check"></i> Yes
					</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">
						<i class="fa fa-close"></i> No
					</button>
				</div>
			</div>
		</div>
	</div>
</html:form>
	<!-- END MODAL ARE YOU SURE APPROVE-->
	
<%@include file="PartJavascript.jsp"%>
<script type="text/javascript">
	function submitForm(task,id)
	{
		document.forms[1].task.value = task;
		document.forms[1].selectedLeaveId.value = id;
		
		if(task == "approveleavecancellation")
		{
			$('#alert').html("Are you sure want to approve??");
			document.getElementById("alertDiv").className = "alert alert-info kiri";	
		}
		else if (task == "rejectleavecancellation")
		{
			$('#alert').html("Are you sure want to reject??");
			document.getElementById("alertDiv").className = "alert alert-danger kiri";	
		}
	}

	$(document).ready(function() {
		$('#sort').dataTable({
			"columns" : [ null, null, null, null, {
				"orderable" : false
			} ]
		});
	});
</script>
</body>
</html>