<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="PartBootstrap.jsp"%>
<title>Leave Approval</title>
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
								<h3 id="timeline">Leave Approval</h3>
							</div>
							<!-- END JUDUL -->

							<!-- BREADCRUMB -->
							<ul class="breadcrumb">
								<li><span class="fa fa-dashboard"></span><a href="#">Dashboard</a></li>
								<li><span class="fa fa-paper-plane"></span><a href="javascript:navigateToPage('mainMenu')">&nbsp;Leave</a></li>
								<li><span class="fa fa-check-square-o"></span> Leave Approval</li>
							</ul>
							<!-- END BREADCRUMB -->

							<div class="col-md-12">
								<!--  alert error -->
								<logic:notEmpty name="leaveForm" property="error">
									<div class="alert alert-danger alert-dismissible" role="alert">
										<button type="button" class="close" data-dismiss="alert" aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<i class="fa fa-info-circle"></i>
										<bean:write name="leaveForm" property="error" />
									</div>
								</logic:notEmpty>
								<!--  alert error -->
								
								<!--  alert info -->
								<logic:notEmpty name="leaveForm" property="info">
									<div class="alert alert-info alert-dismissible" role="alert">
										<button type="button" class="close" data-dismiss="alert" aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<i class="fa fa-info-circle"></i>
										<bean:write name="leaveForm" property="info" />
									</div>
								</logic:notEmpty>
								<!--  alert info -->
								
								<!-- TAB -->
								<ul id="mytabs" class="nav nav-tabs" role="tablist">
									<li class="active"><a href="#pending" role="tab" data-toggle="tab">Pending Approval</a></li>
									<li><a href="#history" role="tab" data-toggle="tab">History	Approval</a></li>
								</ul>

								<!-- ISI TAB PENDING-->
								<div class="tab-content">

									<!-- TAB PERSONAL -->
									<div class="tab-pane active" id="pending">
										<br />
										<div class="col-md-12">
											<table class="table table-striped table-hover table-condensed table-bordered" id="sort">
												<thead>
													<tr>
														<th>Employee NIK</th>
														<th>Employee Name</th>
														<th>Leave Date</th>
														<th>Leave Type</th>
														<th>Leave Description</th>
														<th>Actions Button</th>
													</tr>
												</thead>
												<tbody>
													<logic:notEmpty name="leaveForm" property="employeeLeaveList">
														<logic:iterate id="leave" name="leaveForm" property="employeeLeaveList">
															<tr>
																<td><bean:write name="leave" property="employeeNik" /></td>
																<td id="leaveMainEmpName<bean:write name="leave" property="employeeId" />">
																	<bean:write name="leave" property="employeeName" /></td>
																<td id="leaveMainDays<bean:write name="leave" property="employeeId" />"> 
																	<logic:lessEqual name="leave" property="totalLeaveDay"	value="1">
																		<bean:write name="leave" property="firstDayOfLeave" />
																	</logic:lessEqual> 
																	<logic:greaterThan name="leave" property="totalLeaveDay" value="1">
																		<bean:write name="leave" property="firstDayOfLeave" /> - 
																		<bean:write	name="leave" property="lastDayOfLeave" />
																	</logic:greaterThan></td>
																<td><bean:write name="leave" property="leaveType" /></td>
																<td id="leaveMainDesc<bean:write name="leave" property="employeeId" />">
																	<bean:write name="leave" property="description" /></td>
																<td><button data-toggle="modal" data-target="#modalClickRow" type="button" class="btn btn-primary" class="btn btn-success" data-backdrop="static"
																	onclick="javascript:onModalShow('approveleave','<bean:write name="leave" property="employeeId"/>','<bean:write name="leave" property="leaveId"/>','Approve Leave');">
																		<i class="fa fa-check"></i> Approve
																	</button>
																	<button data-toggle="modal"	data-target="#modalClickRow" type="button" class="btn btn-danger" data-backdrop="static"
																	onclick="javascript:onModalShow('rejectleave','<bean:write name="leave" property="employeeId"/>','<bean:write name="leave" property="leaveId"/>','Reject Leave');">
																		<i class="fa fa-close"></i> Reject
																	</button></td>
															</tr>
														</logic:iterate>
													</logic:notEmpty>
												</tbody>
											</table>

										</div>
									</div>
									<!-- END TAB PENDING -->

									<!-- ISI TAB HISTORY -->
									<div class="tab-pane" id="history">
										<div class="col-md-12">
										<br/>
										<table class="table table-striped table-hover table-condensed table-bordered" id="sortHistory">
											<thead>
												<tr>
													<th>Employee NIK</th>
													<th>Employee Name</th>
													<th>Leave Date</th>
													<th>Leave Type</th>
													<th>Leave Description</th>
													<th>Status</th>
												</tr>
											</thead>
											
											<tbody>
												<logic:notEmpty name="leaveForm" property="employeeHistoryLeaveList">
													<logic:iterate id="iterateHistoryLeave" name="leaveForm" property="employeeHistoryLeaveList">
														<tr>
															<td><bean:write name="iterateHistoryLeave" property="employeeNik"/></td>
															<td><bean:write name="iterateHistoryLeave" property="employeeName"/></td>
															<td>			
																<logic:equal name="iterateHistoryLeave" property="totalLeaveDay" value="1">	
																	<bean:write name="iterateHistoryLeave" property="firstDayOfLeave"/>
																</logic:equal>
																<logic:notEqual name="iterateHistoryLeave" property="totalLeaveDay" value="1">
																	<bean:write name="iterateHistoryLeave" property="firstDayOfLeave"/> - 
																	<bean:write name="iterateHistoryLeave" property="lastDayOfLeave"/>
																</logic:notEqual>
															</td>
															<td><bean:write name="iterateHistoryLeave" property="leaveType"/></td>
															<td><bean:write name="iterateHistoryLeave" property="description"/></td>
															<td>
																<logic:equal name="iterateHistoryLeave" property="approvalStatus" value="3">
																	<i class="fa fa-check" style="color: green"></i> Approved
																</logic:equal>
																<logic:equal name="iterateHistoryLeave" property="approvalStatus" value="4">
																	<i class="fa fa-close" style="color: red"></i> Rejected
																</logic:equal>
																<logic:equal name="iterateHistoryLeave" property="approvalStatus" value="5">
																	<i class="fa fa-minus" style="color: red"></i> Cancelled
																</logic:equal>
															</td>
														</tr>
													</logic:iterate>
												</logic:notEmpty>
											</tbody>
										</table>
										</div>
									</div>
									<!-- END TAB PROFESIONAL -->
								</div>
								<!-- END TAB CONTENT -->

							</div>
						</div>
					</div>
				</div>
			</div>
	</div>

	<%@include file="PartJavascript.jsp"%>

	<!-- MODAL -->
<html:form action="/leaveAction.do" styleId="validate-form" styleClass="validate-form">
	<html:hidden name="leaveForm" property="task"/>
	<html:hidden name="leaveForm" property="selectedLeaveId" />
	<html:hidden name="leaveForm" property="approvedEmployeeId" />
	<div class="modal fade" id="modalClickRow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 id="modalTitle"></h4>
				</div>
				<div class="modal-body">
					<table class="table table-condensed table-borderless" id="leaveApprovalModal">
						<tr>
							<td class="fontBold kanan">Employee Name :</td>
							<td id="leaveModalEmpName"></td>
						</tr>
						<tr>
							<td class="fontBold kanan">Leave Date :</td>
							<td id="leaveModalDays"></td>
						</tr>
						<tr>
							<td class="fontBold kanan">Description :</td>
							<td id="leaveModalDesc"></td>
						</tr>
						<tr>
							<td class="fontBold kanan">Comment <font color="red">*</font> :</td>
							<td><div class="form-group"><html:textarea name="leaveForm"	property="approvalComment" styleClass="form-textarea">
							</html:textarea></div></td>
						</tr>
					</table>
					<br />
					<div class="modal-footer">
						<button type="submit" type="button"	class="btn btn-primary">
							<i class="fa fa-check"></i> Submit
						</button>
						<button type="button" type="button"	class="btn btn-danger" data-dismiss="modal" onclick="javascript:onModalClose();">
							<i class="fa fa-close"></i> Cancel
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	</html:form>
	<!-- END MODAL -->
</body>
<script type="text/javascript">
	function onModalShow(task, employeeId, leaveId, title) {
		onModalClose();
		document.getElementById("modalTitle").innerHTML = title;
		$('#leaveModalEmpName').html($('#leaveMainEmpName' + employeeId).text());
		$('#leaveModalDays').html($('#leaveMainDays' + employeeId).text());
		$('#leaveModalDesc').html($('#leaveMainDesc' + employeeId).text());
		
		document.forms[1].task.value = task;
		document.forms[1].selectedLeaveId.value = leaveId;
		document.forms[1].approvedEmployeeId.value = employeeId;
	}
	
	function onModalClose()
	{
		document.forms[1].elements["approvalComment"].value ="";
		$('#validate-form').bootstrapValidator('resetField','approvalComment');
	}

	$('#validate-form')
			.bootstrapValidator(
					{
						//        live: 'disabled',
						message : 'This value is not valid',
						feedbackIcons : {
							valid : 'glyphicon glyphicon-ok',
							invalid : 'glyphicon glyphicon-remove',
							validating : 'glyphicon glyphicon-refresh'
						},
						fields : {
							approvalComment : {
								validators : {
									notEmpty : {
										message : 'Comment is required and cannot be empty'
									},

									stringLength : {
										message : 'Comment content must be less than 100 characters',
										max : function(value, validator, $field) {
											return 100 - (value.match(/\r/g) || []).length;
										}
									}
								}
							}
						}
					});
	
	$(document).ready(function() {
		$('#sort').dataTable( {
			 "columns": [
			             null,
			             null,
			             null,
			             null,
			             null,
			             { "orderable": false }
			            ]
		} );
	});
	
	$(document).ready(function() {
		$('#sortHistory').DataTable();
	});
</script>
</html>