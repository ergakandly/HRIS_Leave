<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- SCRIPT -->
<%@include file="PartBootstrap.jsp"%>
<title>Extra Quota Request</title>
</head>
<body>
	<div id="wrapper">
		<%@include file="PartNavbar.jsp"%>
		<div id="page-wrapper">

			<!-- CONTAINER -->
			<div class="container-fluid">
				<div class="row">

					<!-- ISI CONTENT -->
					<div class="col-md-12">

						<!--JUDUL-->
						<div class="page-header">
							<h3 id="timeline">Extra Quota Request</h3>
						</div>
						<!-- END JUDUL -->

						<!-- BREADCRUMB -->
						<ul class="breadcrumb">
							<li><span class="fa fa-dashboard"></span><a href="#">Dashboard</a></li>
							<li><span class="fa fa-paper-plane"></span><a href="javascript:navigateToPage('mainMenu')">&nbsp;Leave</a></li>
							<li><span class="fa fa-question-circle"></span> Extra Quota Request</li>
						</ul>
						<!-- END BREADCRUMB -->
						
						<div class="col-md-7">
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
							
							
				<html:form action="/leaveAction" styleId="validate-form" styleClass="validate-form">
					<html:hidden name="leaveForm" property="task" value="processextraquotarequest" />

								<!-- Leave Request -->

								<!-- PANEL -->
								<div class="panel panel-info ">
									<div class="panel-heading">
										<i class="fa fa-check"></i> Extra Leave Request
									</div>
									<div class="panel-body">
										<table class="table table-borderless table-nonfluid">
											<tbody>
												<tr>

													<td class="kanan">Substituted Date :</td>
													<td>
														<div class="form-group">
															<div class="input-group">
																<input type="text" name="substitutedDate"
																	class="span form-control form-control-md-1" id="dpd1" readonly="readonly"></input>
																<span class="input-group-addon" id="basic-addon1"
																	style="height: 22px !important; width: 50px !important; padding-top: 0; padding-bottom: 0; border-bottom-right-radius: 15px;"><i
																	class="fa fa-calendar" id="btnCal1"></i></span>
															</div>
														</div>
													</td>

												</tr>
												<tr>
													<td class="kanan">Description :</td>
													<td><div class="form-group">
															<html:textarea name="leaveForm" property="description" styleClass="form-textarea"></html:textarea>
														</div></td>
												</tr>
												<tr>
													<td class="kanan">Approved By :</td>
													<td><html:select name="leaveForm" property="selectedLeaveApprover" styleClass="form-control form-control-md">
															<logic:notEmpty name="leaveForm" property="leaveApprover">
																<logic:iterate id="iterateLeaveApprover" name="leaveForm" property="leaveApprover">
																	<bean:define id="approverId" name="iterateLeaveApprover" property="EMPLOYEEID" type="java.lang.String" />
																	<html:option value="<%=approverId%>">
																		<bean:write name="iterateLeaveApprover"	property="EMPLOYEENAME" />
																	</html:option>
																</logic:iterate>
															</logic:notEmpty>
														</html:select></td>
												</tr>
												<tr>
													<td colspan="3" align="center">

														<button type="submit" class="btn btn-primary">
															<span class="glyphicon glyphicon-check"></span> Submit
														</button>

														<button type="button" class="btn btn-danger" onclick="javascript:navigateToPage('mainMenu');">
															<span class="glyphicon glyphicon-remove"></span> Cancel
														</button>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<!-- END PANEL -->
								<!-- End Leave Request -->
							</html:form>
						</div>


					</div>

				</div>
			</div>
		</div>
	</div>
	<%@include file="PartJavascript.jsp"%>
</body>
<script type="text/javascript">
	$('#btnCal1').click(function() {
		$(document).ready(function() {
			$("#dpd1").datepicker().focus();
		});
	});
	
	$(function() {
		$('.datepicker').datepicker({});
	});
	
	$(window)
			.load(
					function() {
						var nowTemp = new Date();
						var now = new Date(nowTemp.getFullYear(), nowTemp
								.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);

						var checkin = $('#dpd1')
								.datepicker(
										{
											onRender : function(date) {
												return date.valueOf() >= now
														.valueOf() ? 'disabled'
														: '';
											}
										}).on(
										'changeDate',
										function(ev) {
											$('#validate-form')
													.bootstrapValidator(
															'revalidateField',
															'substitutedDate');
											checkin.hide();
										}).data('datepicker');
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
							substitutedDate : {
								validators : {
									notEmpty : {
										message : 'Substituted Date is required and cannot be empty'
									},

								}
							},
							description : {
								validators : {
									notEmpty : {
										message : 'Description is required and cannot be empty'
									},

									stringLength : {
										message : 'Description content must be less than 100 characters',
										max : function(value, validator, $field) {
											return 100 - (value.match(/\r/g) || []).length;
										}
									}
								}
							}
						}
					});
</script>
</html>