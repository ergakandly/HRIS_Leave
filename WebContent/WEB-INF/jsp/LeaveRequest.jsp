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
<title>Leave Request</title>
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
							<h3 id="timeline">Leave Request</h3>
						</div>
						<!-- END JUDUL -->

						<!-- BREADCRUMB -->
						<ul class="breadcrumb">
							<li><span class="fa fa-dashboard"></span>
								<a href="<bean:write name="leaveForm" property="urlPortal"/><%= request.getAttribute("zx") %>">Dashboard</a>
							</li>
							<li><span class="fa fa-paper-plane"></span><a href="javascript:navigateToPage('mainMenu')">&nbsp;Leave</a></li>
							<li><span class="fa fa-question-circle"></span> Leave Request</li>
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
						</div>

						<div class="col-md-6">
							<html:form action="/leaveAction" styleId="validate-form" styleClass="validate-form">
								<!-- PANEL -->
								<div class="panel panel-info ">
									<div class="panel-heading">
										<i class="fa fa-check"></i> Leave Request
									</div>
									<div class="panel-body">
										<table class="table table-borderless table-nonfluid">
											<tbody>
												<tr>
													<td class="kanan">Type of Leave :</td>
													<td><html:select name="leaveForm" property="selectedLeaveType" styleClass="form-control form-control-md"
															styleId="leaveType">
															<logic:notEmpty name="leaveForm" property="leaveType">
																<logic:iterate id="iterateLeaveType" name="leaveForm" property="leaveType">
																	<bean:define id="leaveTypeId" name="iterateLeaveType" property="LEAVETYPEID" type="java.lang.String" />
																	<html:option value="<%=leaveTypeId%>">
																		<bean:write name="iterateLeaveType"	property="LEAVETYPE" />
																	</html:option>
																</logic:iterate>
															</logic:notEmpty>
														</html:select></td>
												</tr>
												<tr id="td1">
													<td class="kanan">First Day of Leave <font color="red">*</font>:</td>
													<td>
														<div class="form-group">
															<div class="input-group">
																<input type="text" name="startLeaveDate" class="span form-control form-control-md-1" id="dpd1" readonly="readonly"></input>
																<span class="input-group-addon input-number-resize" id="basic-addon1"
																	style="height: 22px !important; width: 50px !important; padding-top: 0; padding-bottom: 0; border-bottom-right-radius: 15px;"><i
																	class="fa fa-calendar" id="btnCal1"></i></span>
															</div>
														</div>
													</td>
												</tr>
												<tr id="td2">
													<td class="kanan">Last Day of Leave <font color="red">*</font>:</td>
													<td>
														<div class="form-group">
															<div class="input-group">
																<input type="text" name="lastLeaveDate"	class="span form-control form-control-md-1" id="dpd2" readonly="readonly"></input>
																<span class="input-group-addon input-number-resize" id="basic-addon1"
																	style="height: 22px !important; width: 50px !important; padding-top: 0; padding-bottom: 0; border-bottom-right-radius: 15px;"><i
																	class="fa fa-calendar" id="btnCal2"></i></span>
															</div>
														</div>
													</td>
												</tr>
												<tr id="td3">
													<td class="kanan">Leave Date <font color="red">*</font>:</td>
													<td>
														<div class="form-group">
														<div class="input-group">
																<input type="text" name="startLeaveDate" class="span form-control form-control-md-1" id="dpd3" readonly="readonly"></input>
																<span class="input-group-addon input-number-resize" id="basic-addon1"
																	style="height: 22px !important; width: 50px !important; padding-top: 0; padding-bottom: 0; border-bottom-right-radius: 15px;"><i
																	class="fa fa-calendar" id="btnCal2"></i></span>
															</div>
														</div>
													</td>
												</tr>
												<tr>
													<td class="kanan">Description <font color="red">*</font>:</td>
			
													<td>
														<div class="form-group">
															<html:textarea name="leaveForm" property="description" styleClass="form-textarea"></html:textarea>
														</div>
													</td>
												</tr>
												<tr>
													<td class="kanan">Approved By :</td>
													<td><html:select name="leaveForm" property="selectedLeaveApprover" styleClass="form-control form-control-md">
															<logic:notEmpty name="leaveForm" property="leaveApprover">
																<logic:iterate id="iterateLeaveApprover" name="leaveForm" property="leaveApprover">
																	<bean:define id="approverId" name="iterateLeaveApprover" property="EMPLOYEEID" type="java.lang.String" />
																	<html:option value="<%=approverId%>">
																		<bean:write name="iterateLeaveApprover" property="EMPLOYEENAME" />
																	</html:option>
																</logic:iterate>
															</logic:notEmpty>
														</html:select></td>
												</tr>
												<tr>
													<td colspan="3" align="center">
													<html:hidden name="leaveForm" property="task" value="processleaverequest" />

														<button type="submit" class="btn btn-primary">
															<span class="glyphicon glyphicon-check"></span>Submit
														</button>
														<button type="button" class="btn btn-danger" onclick="javascript:navigateToPage('mainMenu');">
															<span class="glyphicon glyphicon-remove"></span>Cancel
														</button></td>
												</tr>
											</tbody>
										</table>

									</div>
								</div>
								<!-- END PANEL -->
							</html:form>
						</div>
						<div class="col-md-6">
							<h5>
								<small><b>PRIMARY QUOTA</b></small>
							</h5>
							<hr style="margin: -5px 0 5px 0">
							<div class="col-xs-6 col-md-4">
								<div class="panel status panel-mango">
									<div class="panel-heading">
										<h1 class="panel-title text-center">
											<bean:write name="leaveForm" property="currentEmployee.lastQuota" />
										</h1>
									</div>
									<div class="tengah">
										<strong>Last Period Quota</strong><br> <small
											class="fontBold fontMerah"><u>expired</u><br /> 
											<bean:write	name="leaveForm" property="currentEmployee.lastQuotaExpiredDate" /> </small>
									</div>
								</div>
							</div>
							<div class="col-xs-6 col-md-4">
								<div class="panel status panel-lime">
									<div class="panel-heading">
										<h1 class="panel-title text-center">
											<bean:write name="leaveForm" property="currentEmployee.currentLeaveQuota" />
										</h1>
									</div>
									<div class="tengah">
										<strong>Current Period Quota</strong><br /> <small
											class="fontBold fontMerah"><u>expired</u><br /> 
											<bean:write	name="leaveForm" property="currentEmployee.currentQuotaExpiredDate" /> </small>
									</div>
								</div>
							</div>
							<div class="col-xs-6 col-md-4">
								<div class="panel status panel-rose">
									<div class="panel-heading">
										<h1 class="panel-title text-center">
											<bean:write name="leaveForm" property="currentEmployee.rewardQuota" />
										</h1>
									</div>
									<div class="tengah">
										<strong>Reward Quota</strong><br /> <small
											class="fontBold fontMerah"><u>expired</u><br /> 
											<bean:write	name="leaveForm" property="currentEmployee.rewardQuotaExpiredDate" /> </small>
									</div>
								</div>
							</div>
							<br /> <br />

							<h5>
								<small><b>EXTRA QUOTA</b></small>
							</h5>
							<hr style="margin: -5px 0 5px 0">

							<logic:notEmpty name="leaveForm" property="extraQuotaList">
								<logic:iterate name="leaveForm" property="extraQuotaList"
									id="extraQuota">
									<div class="col-md-3">
										<div class="panel status panel-candy">
											<div class="panel-heading">
												<h3 class="panel-title2 text-center">1</h3>
											</div>
											<div class="tengah">
												<small class="fontBold fontMerah"><u>expired</u><br />
													<bean:write name="extraQuota" property="expiredDate" /> </small>
											</div>
										</div>
									</div>
								</logic:iterate>
							</logic:notEmpty>

						</div>
					</div>
				</div>
			</div>
		</div>
		<%@include file="PartJavascript.jsp"%>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$("#td3").hide();
	});
	
	$(function() {
		$('.datepicker').datepicker({});
	});
	
	function flyToPage(task) {
		document.forms[1].task.value = task;
		document.forms[1].submit();
	}
	
	$(function() {
		$(document).ready(
				function() {
					$("#leaveType").change(
							function() {
								$('#validate-form').bootstrapValidator(
										'resetField', 'startLeaveDate');
								$('#validate-form').bootstrapValidator(
										'resetField', 'lastLeaveDate');
								$('#validate-form').bootstrapValidator(
										'resetField', 'description');
	
								if ($("#leaveType :selected").val() == "4") {
									$("#dpd1").attr("name", "notUsed");
									$("#td1").hide();
									$("#td2").hide();
									$("#td3").show();
								} else {
									$("#td3").hide();
									$("#td1").show();
									$("#td2").show();
								}
							});
				});
	
	});
	
	$(window)
			.load(
					function() {
						var nowTemp = new Date();
						var now = new Date(nowTemp.getFullYear(), nowTemp
								.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
	
						var checkin = $('#dpd1').datepicker({
							onRender : function(date) {
							}
						})
								.on(
										'changeDate',
										function(ev) {
											var newDate = new Date(ev.date);
											newDate.setDate(newDate.getDate());
											checkout.setValue(newDate);
											checkin.hide();
											$('#validate-form')
													.bootstrapValidator(
															'revalidateField',
															'startLeaveDate');
											$('#validate-form')
													.bootstrapValidator(
															'revalidateField',
															'lastLeaveDate');
											$('#dpd2')[0].focus();
										}).data('datepicker');
						var checkout = $('#dpd2').datepicker(
								{
									onRender : function(date) {
										return date.valueOf() < checkin.date
												.valueOf() ? 'disabled' : '';
									}
								})
								.on(
										'changeDate',
										function(ev) {
											$('#validate-form')
													.bootstrapValidator(
															'revalidateField',
															'lastLeaveDate');
											checkout.hide();
										}).data('datepicker');
	
						var extraDate = $('#dpd3')
								.datepicker(
										{
											onRender : function(date) {
												return date.valueOf() <= now
														.valueOf() ? 'disabled'
														: '';
											}
										}).on(
										'changeDate',
										function(ev) {
											extraDate.hide();
											$('#validate-form')
													.bootstrapValidator(
															'revalidateField',
															'startLeaveDate');
										}).data('datepicker');
					});
				
	$('#btnCal1').click(function() {
		$(document).ready(function() {
			$("#dpd1").datepicker().focus();
		});
	});

	$('#btnCal2').click(function() {
		$(document).ready(function() {
			$("#dpd2").datepicker().focus();
		});
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
							startLeaveDate : {
								validators : {
									notEmpty : {
										message : 'Leave Date is required and cannot be empty'
									},

								}
							},
							lastLeaveDate : {
								validators : {
									notEmpty : {
										message : 'Leave Date is required and cannot be empty'
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