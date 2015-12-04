<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="PartBootstrap.jsp"%>
<title>Extra Leave Approval</title>
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
								<h3 id="timeline">Extra Quota Approval</h3>
							</div>
							<!-- END JUDUL -->

							<!-- BREADCRUMB -->
							<ul class="breadcrumb">
								<li><span class="fa fa-dashboard"></span><a href="#">Dashboard</a></li>
								<li><span class="fa fa-paper-plane"></span><a href="javascript:navigateToPage('mainMenu')">&nbsp;Leave</a></li>
								<li><span class="fa fa-check-square-o"></span> Extra Quota Approval</li>
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
								
								<table
									class="table table-striped table-hover table-condensed table-bordered"
									id="sort">
									<thead>
										<tr>
											<th>Employee NIK</th>
											<th>Employee Name</th>
											<th>Substituted Date</th>
											<th>Description</th>
											<th>Actions Button</th>
										</tr>
									</thead>
									<tbody>
										<logic:notEmpty name="leaveForm" property="extraQuotaList">
											<logic:iterate id="ext" name="leaveForm"
												property="extraQuotaList">
												<tr>
													<td><bean:write name="ext" property="employeeNik" /></td>
													<td id="leaveMainEmpName<bean:write name="ext" property="extraLeaveQuotaId"/>">
														<bean:write name="ext" property="employeeName" /></td>
													<td id="leaveMainDays<bean:write name="ext" property="extraLeaveQuotaId"/>">
														<bean:write name="ext" property="substitutedDate" /></td>
													<td id="leaveMainDesc<bean:write name="ext" property="extraLeaveQuotaId"/>">
														<bean:write name="ext" property="description" /></td>
													<td>
														<button type="button" class="btn btn-primary"	data-toggle="modal" data-target="#modalClickRow" data-backdrop="static"
														onclick="javascript:onModalShow('approveextraquota','<bean:write name="ext" property="extraLeaveQuotaId"/>', 'Approve Extra Quota');" >
															<i class="fa fa-check"></i> Approve
														</button>
														<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#modalClickRow" data-backdrop="static"
														onclick="javascript:onModalShow('rejectextraquota','<bean:write name="ext" property="extraLeaveQuotaId"/>', 'Reject Extra Quota');" >
															<i class="fa fa-close"></i> Reject
														</button>
													</td>
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

	<%@include file="PartJavascript.jsp"%>
	<!-- MODAL -->
<html:form action="/leaveAction.do" styleId="validate-form" styleClass="validate-form">
	<html:hidden name="leaveForm" property="task" />
	<html:hidden name="leaveForm" property="approvedExtraQuotaId" />
	
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
					<table class="table table-condensed table-borderless" id="extraLeaveApprovalModal">
						<tr>
							<td class="fontBold kanan">Employee Name :</td>
							<td id="leaveModalEmpName"></td>
						</tr>
						<tr>
							<td class="fontBold kanan">Substituted Date :</td>
							<td id="leaveModalDays"></td>
						</tr>
						<tr>
							<td class="fontBold kanan">Description :</td>
							<td id="leaveModalDesc"></td>
						</tr>
						<tr>
							<td class="fontBold kanan">Comment <font color="red">*</font> :</td>
							<td><div class="form-group"><html:textarea name="leaveForm"
									property="approvalComment" styleClass="form-textarea"></html:textarea></div></td>
						</tr>
					</table>
					<br />
					<div class="tengah">
						<button type="submit" class="btn btn-primary">
							<i class="fa fa-check"></i> Submit
						</button>
						<button class="btn btn-danger" data-dismiss="modal" onclick="javascript:onModalClose();">
							<i class="fa fa-close"></i> Cancel
						</button>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</html:form>
	<!-- MODAL -->
<script type="text/javascript">
	function onModalShow(task, extraQuotaId, title) {
		onModalClose();
		document.getElementById("modalTitle").innerHTML = title;
		$('#leaveModalEmpName').html($('#leaveMainEmpName' + extraQuotaId).text());
		$('#leaveModalDays').html($('#leaveMainDays' + extraQuotaId).text());
		$('#leaveModalDesc').html($('#leaveMainDesc' + extraQuotaId).text());
		
		document.forms[1].task.value = task;
		document.forms[1].approvedExtraQuotaId.value = extraQuotaId;
	}
	
	function onModalClose()
	{
		document.forms[1].elements["approvalComment"].value ="";
		$('#validate-form').bootstrapValidator('resetField','approvalComment');
	}

	$(document).ready(function() {
		$('#sort').dataTable( {
			 "columns": [
			             null,
			             null,
			             null,
			             null,
			             { "orderable": false }
			            ]
		} );
	});
		
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
</script>
</body>
</html>