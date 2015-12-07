<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Leave List</title>
<%@include file="PartBootstrap.jsp"%>
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
							<h3 id="timeline">Leave List</h3>
						</div>
						<!-- END JUDUL -->

						<!-- BREADCRUMB -->
						<ul class="breadcrumb">
							<li><span class="fa fa-dashboard"></span>
								<a href="location.href='<bean:write name="leaveForm" property="urlPortal"/><%= request.getAttribute("zx") %>'">Dashboard</a>
							</li>
							<li><span class="fa fa-paper-plane"></span><a href="javascript:navigateToPage('mainMenu')">&nbsp;Leave</a></li>
							<li><span class="fa fa-list"></span> Leave List</li>
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
									<li class="active"><a href="#pending" role="tab" data-toggle="tab">Active Leave </a></li>
									<li><a href="#history" role="tab" data-toggle="tab">Leave History </a></li>
								</ul>


								<!-- ISI TAB 1 -->
								<div class="tab-content">
									<div class="tab-pane active" id="pending">
										<br />
										<div class="col-md-12">
											<table class="table table-striped table-hover table-condensed table-bordered" id="sort">
												<thead>
													<tr>
														<th>Leave Date</th>
														<th>Type</th>
														<th>Description</th>
														<th>Submission Date</th>
														<th>Approval Status</th>
														<th class="tengah">Action</th>
													</tr>
												</thead>
												<logic:notEmpty name="leaveForm" property="employeeLeaveList">
													<logic:iterate name="leaveForm"	property="employeeLeaveList" id="leave">
														<tr>
															<td	id="leaveMainDayRange<bean:write name="leave" property="leaveId"/>">
															<logic:lessEqual name="leave" property="totalLeaveDay" value="1">
																	<bean:write name="leave" property="firstDayOfLeave" />
															</logic:lessEqual> 
															<logic:greaterThan name="leave"	property="totalLeaveDay" value="1">
																	<bean:write name="leave" property="firstDayOfLeave" /> - 
																	<bean:write	name="leave" property="lastDayOfLeave" />
															</logic:greaterThan> 
																<input type="hidden" 
																	id="leaveMainId<bean:write name="leave" property="leaveId"/>"
																	value="<bean:write name="leave" property="leaveId"/>" />
																<input type="hidden" 
																	id="leaveMainDays<bean:write name="leave" property="leaveId"/>"
																	value="<bean:write	name="leave" property="totalLeaveDay" />">
																<input type="hidden"
																	id="leaveMainExp<bean:write name="leave" property="leaveId"/>"
																	value="<bean:write name="leave" property="expiredDate" />">
																<input type="hidden"
																	id="leaveMainApp<bean:write name="leave" property="leaveId"/>"
																	value="<bean:write name="leave" property="approvedBy" />">
																<input type="hidden"
																	id="leaveMainAppComm<bean:write name="leave" property="leaveId"/>"
																	value="<bean:write name="leave" property="approvalComment" />">
																<input type="hidden"
																	id="leaveMainAppDate<bean:write name="leave" property="leaveId"/>"
																	value="<bean:write name="leave" property="approvalDate" />">
															</td>
															<td
																id="leaveMainType<bean:write name="leave" property="leaveId"/>">
																<bean:write	name="leave" property="leaveType" /></td>
															<td
																id="leaveMainDesc<bean:write name="leave" property="leaveId"/>">
																<bean:write	name="leave" property="description" /></td>
															<td
																id="leaveMainSub<bean:write name="leave" property="leaveId"/>">
																<bean:write	name="leave" property="submitDate" /></td>
															<td
																id="leaveMainStatus<bean:write name="leave" property="leaveId"/>">
																<logic:equal name="leave" property="approvalStatus"	value="1">
																	<i class="fa fa-spinner fa-spin" style="color: green;"></i> Pending [Request]</logic:equal>
																<logic:equal name="leave" property="approvalStatus"	value="2">
																	<i class="fa fa-spinner fa-spin" style="color: orange;"></i> Pending [Cancel]</logic:equal>
																<logic:equal name="leave" property="approvalStatus" value="3">
																	<i class="fa fa-check" style="color: green;"></i> Accepted</logic:equal> 
																<logic:equal name="leave" property="approvalStatus" value="4">
																	<i class="fa fa-close" style="color: red;"></i> Rejected</logic:equal>
																<logic:equal name="leave" property="approvalStatus"	value="5">
																	<i class="fa fa-minus" style="color: red;"></i> Cancelled</logic:equal>
															</td>
															<td class="tengah">
																<button type="button" class="btn btn-success"
																	onclick="javascript:getAsyncLeaveDetail('<bean:write name="leave" property="leaveId" />')">
																	<i class="fa fa-eye"></i> View
																</button> 
																<logic:notEqual name="leave" property="approvalStatus" value="4">
																	<logic:notEqual name="leave" property="approvalStatus" value="5">
																		<logic:notEqual name="leave" property="approvalStatus" value="2">
																			<button type="button" data-toggle="modal" data-target="#deleteModal"
																				class="btn btn-danger" onclick="javascript:flyToPage('cancelleave','<bean:write name="leave" property="leaveId"/>')">
																				<i class="fa fa-close"></i> Cancel Leave
																			</button>
																		</logic:notEqual>
																	</logic:notEqual>
																</logic:notEqual>
															</td>
														</tr>
													</logic:iterate>
												</logic:notEmpty>
											</table>
										</div>
									</div>
									<!-- END TAB 1 -->

									<!-- ISI TAB 2 -->
									<div class="tab-pane" id="history">
										<div class="col-md-12">
											<br />
											<table
												class="table table-striped table-hover table-condensed table-bordered"
												id="sort2">
												<thead>
													<tr>
														<th>Leave Date</th>
														<th>Type</th>
														<th>Description</th>
														<th>Submission Date</th>
														<th>Approval Status</th>
														<th class="tengah">Action</th>
													</tr>
												</thead>
												<logic:notEmpty name="leaveForm" property="employeeHistoryLeaveList">
													<logic:iterate name="leaveForm"	property="employeeHistoryLeaveList" id="leave">
														<tr>
															<td
																id="leaveMainDayRange<bean:write name="leave" property="leaveId"/>">
																<logic:lessEqual name="leave" property="totalLeaveDay" value="1">
																	<bean:write name="leave" property="firstDayOfLeave" />
																</logic:lessEqual> 
																<logic:greaterThan name="leave" property="totalLeaveDay" value="1">
																	<bean:write name="leave" property="firstDayOfLeave" /> - 
																	<bean:write name="leave" property="lastDayOfLeave" />
																</logic:greaterThan> 
																<input type="hidden" id="leaveMainId<bean:write name="leave" property="leaveId"/>"
																	value="<bean:write name="leave" property="leaveId"/>" />
																<input type="hidden"
																	id="leaveMainDays<bean:write name="leave" property="leaveId"/>"
																	value="<bean:write	name="leave" property="totalLeaveDay" />">
																<input type="hidden"
																	id="leaveMainExp<bean:write name="leave" property="leaveId"/>"
																	value="<bean:write name="leave" property="expiredDate" />">
																<input type="hidden"
																	id="leaveMainApp<bean:write name="leave" property="leaveId"/>"
																	value="<bean:write name="leave" property="approvedBy" />">
																<input type="hidden"
																	id="leaveMainAppComm<bean:write name="leave" property="leaveId"/>"
																	value="<bean:write name="leave" property="approvalComment" />">
																<input type="hidden"
																	id="leaveMainAppDate<bean:write name="leave" property="leaveId"/>"
																	value="<bean:write name="leave" property="approvalDate" />">
															</td>
															<td
																id="leaveMainType<bean:write name="leave" property="leaveId"/>">
																<bean:write	name="leave" property="leaveType" /></td>
															<td
																id="leaveMainDesc<bean:write name="leave" property="leaveId"/>">
																<bean:write	name="leave" property="description" /></td>
															<td
																id="leaveMainSub<bean:write name="leave" property="leaveId"/>">
																<bean:write	name="leave" property="submitDate" /></td>
															<td
																id="leaveMainStatus<bean:write name="leave" property="leaveId"/>">
																<logic:equal name="leave" property="approvalStatus" value="1">
																	<i class="fa fa-spinner fa-spin" style="color: blue;"></i> Pending [Request]</logic:equal>
																<logic:equal name="leave" property="approvalStatus"	value="2">
																	<i class="fa fa-spinner fa-spin" style="color: orange;"></i> Pending [Cancel]</logic:equal>
																<logic:equal name="leave" property="approvalStatus"	value="3">Accepted</logic:equal> 
																<logic:equal name="leave" property="approvalStatus" value="4">
																	<i class="fa fa-close" style="color: red;"></i> Rejected</logic:equal>
																<logic:equal name="leave" property="approvalStatus"	value="5">
																	<i class="fa fa-minus" style="color: red;"></i> Cancelled</logic:equal>
															</td>
															<td>
																<button type="button"
																	onclick="javascript:getAsyncLeaveDetail('<bean:write name="leave" property="leaveId" />')"
																	class="btn btn-success">
																	<i class="fa fa-eye"></i> View
																</button>
															</td>
														</tr>
													</logic:iterate>
												</logic:notEmpty>
											</table>
										</div>
									</div>
									<!-- END TAB 2 -->

								</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- MODAL -->

	<div class="modal fade" id="modalClickRow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Detail Leave</h4>
				</div>
				<div class="modal-body ">
					<div class="row">
						<div class="col-md-8">

							<table id="leaveModal"
								class="table table-condensed table-borderless">
								<tr>
									<td class="kanan fontBold" width="38%">Leave Type :</td>
									<td id="leaveModalType"></td>
								</tr>
								<tr>
									<td class="kanan fontBold">Leave Date :</td>
									<td id="leaveModalDayRange"></td>
								</tr>
								<tr>
									<td class="kanan fontBold">Total Day(s) of Leave :</td>
									<td id="leaveModalDays"></td>
								</tr>
								<tr>
									<td class="kanan fontBold">Description :</td>
									<td id="leaveModalDesc"></td>
								</tr>
								<tr>
									<td class="kanan fontBold">Approval Status :</td>
									<td id="leaveModalStatus"></td>
								</tr>
								<tr>
									<td class="kanan fontBold">Approved By :</td>
									<td id="leaveModalApp"></td>
								</tr>
								<tr>
									<td class="kanan fontBold">Approval Comment :</td>
									<td id="leaveModalAppComm"></td>
								</tr>
								<tr>
									<td class="kanan fontBold">Approval Date :</td>
									<td id="leaveModalAppDate"></td>
								</tr>
								<tr>
									<td class="kanan fontBold">Submission Date Status :</td>
									<td id="leaveModalSub"></td>
								</tr>
								<tr>
									<td class="kanan fontBold">Expiration Date :</td>
									<td id="leaveModalExp"></td>
								</tr>
							</table>
						</div>
						<div class="col-md-4">
							<h5>
								<small><b>LEAVE DATE</b></small>
							</h5>
							<hr style="margin: -5px 0 5px 0">
							<br />
							<table class="table table-hover table-condensed table-bordered"
								id="leaveDetailModal">
							</table>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal">
						<i class="fa fa-close"></i> Close
					</button>
				</div>
			</div>
		</div>
	</div>

	<!-- END MODAL -->
	
	<!-- MODAL DELETE-->
<html:form action="/leaveAction">
	<html:hidden name="leaveForm" property="task" />
	<html:hidden name="leaveForm" property="selectedLeaveId" />
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="#deactivateModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Notification</h4>
				</div>
				<div class="modal-body">
					<div class="alert alert-danger kiri" role="alert">
						<i class="fa fa-exclamation-triangle"></i> 
						Are you sure want to cancel this leave?
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-danger" >
						<i class="fa fa-trash"></i> Yes
					</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">
						<i class="fa fa-close"></i> No
					</button>
				</div>
			</div>
		</div>
	</div>
</html:form>
	<!-- END MODAL DELETE-->
	<%@include file="PartJavascript.jsp"%>
	<script type="text/javascript">
		function flyToPage(task, id) {
			document.forms[1].task.value = task;
			document.forms[1].selectedLeaveId.value = id;
		}
	
		function getAsyncLeaveDetail(id) {
			var day = null;
			if ($('#leaveMainDays' + id).val() > 1)
				day = " Days";
			else
				day = " Day";
	
			$("#leaveDetailModal").html('');
			$('#leaveModalDayRange').html($('#leaveMainDayRange' + id).text());
			$('#leaveModalType').html($('#leaveMainType' + id).text());
			$('#leaveModalDesc').html($('#leaveMainDesc' + id).text());
			$('#leaveModalApp').html($('#leaveMainApp' + id).val());
			$('#leaveModalAppComm').html($('#leaveMainAppComm' + id).val());
			$('#leaveModalAppDate').html($('#leaveMainAppDate' + id).val());
			$('#leaveModalDays').html($('#leaveMainDays' + id).val() + day);
			$('#leaveModalStatus').html($('#leaveMainStatus' + id).text());
			$('#leaveModalSub').html($('#leaveMainSub' + id).text());
			$('#leaveModalExp').html($('#leaveMainExp' + id).val());
			$.getJSON("/HRIS_Leave/leaveAction.do", {
				selectedLeaveId : id,
				task : "asyncleavedetail"
			}, function(data) {
	
				var content = "<thead><tr><th>Day</th><th>Date</th></tr></thead>";
	
				$.each(data, function(index, element) {
					content += "<tbody><tr><td>" + element.leaveDay + "</td><td>"
							+ element.leaveDate + "</td></tr></tbody>";
				});
	
				$("#leaveDetailModal").html(content);
			});
	
			$('#modalClickRow').modal({
				show : true
			});
		}
	
		$(document).ready(function() {
			$('#sort').dataTable({
				"columns" : [ null, null, null, null, null, {
					"orderable" : false
				} ]
			});
		});
		$(document).ready(function() {
			$('#sort2').dataTable({
				"columns" : [ null, null, null, null, null, {
					"orderable" : false
				} ]
			});
		});
	</script>
</body>
</html>