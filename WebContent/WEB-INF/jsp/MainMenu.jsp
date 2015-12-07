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
<title>Leave Menu</title>
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
							<h3 id="timeline">HRIS Leave Module</h3>
						</div>
						<!-- END JUDUL -->

						<!-- BREADCRUMB -->
						<ul class="breadcrumb">
							<li><span class="fa fa-dashboard"></span>
								<a href="<bean:write name="leaveForm" property="urlPortal"/><%= request.getAttribute("zx") %>">Dashboard</a>
							</li>
							<li><span class="fa fa-paper-plane"></span> Leave</li>
						</ul>
						<!-- END BREADCRUMB -->

						<div class="row">

							<!-- Table 1 -->
							<div class="col-xs-6">

								<!-- PANEL -->
								<div class="panel panel-info ">
									<div class="panel-heading">
										<i class="fa fa-paper-plane"></i> Upcoming Mass Leave
									</div>
									<div class="panel-body">
										<table align="center"
											class="table table-striped table-hover table-condensed">
											<thead>
												<tr>
													<th>Date</th>
													<th>Description</th>
												</tr>
											</thead>
											<tbody>
												<logic:notEmpty name="leaveForm" property="upcomingMassleave">
													<logic:iterate id="upcomingMassLeaveList" name="leaveForm" property="upcomingMassleave">
														<tr>
															<td><bean:write name="upcomingMassLeaveList" property="date" /></td>
															<td><bean:write name="upcomingMassLeaveList" property="description" /></td>
														</tr>
													</logic:iterate>
												</logic:notEmpty>
											</tbody>
										</table>
									</div>
								</div>
								<!-- END PANEL -->
							</div>
							<!-- End Table 1 -->

							<!-- Table 2 -->
							<div class="col-xs-6">
								<!-- PANEL -->
								<div class="panel panel-danger ">
									<div class="panel-heading">
										<i class="fa fa-send-o"></i> Upcoming National Holiday
									</div>
									<div class="panel-body">
										<table class="table table-striped table-hover table-condensed">
											<thead>
												<tr>
													<th>Date</th>
													<th>Description</th>
												</tr>
											</thead>
											<tbody>
												<logic:notEmpty name="leaveForm" property="upcomingNationalHoliday">
													<logic:iterate id="upcomingNationalHolidayList"	name="leaveForm" property="upcomingNationalHoliday">
														<tr>
															<td><bean:write name="upcomingNationalHolidayList" property="date" /></td>
															<td><bean:write name="upcomingNationalHolidayList" property="description" /></td>
														</tr>
													</logic:iterate>
												</logic:notEmpty>
											</tbody>
										</table>
									</div>
								</div>
								<!-- END PANEL -->
							</div>
							<!-- End Table 2 -->
						</div>
					</div>
					<!-- END ISI CONTENT -->

				</div>
			</div>
		</div>
	</div>
	<!-- END CONTAINER -->
	<%@include file="PartJavascript.jsp"%>
</body>
</html>