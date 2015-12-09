<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="shortcut icon" type="image/ico" href="asset/img/icon.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">
	function navigateToPage(task) {

		document.forms[0].task.value = task;
		if (task == "masterMassLeave")
			document.forms[0].action = "/HRIS_Leave/manageSpecialDate.do?method=showMassLeaveList";
		else if (task == "masterNationalHoliday")
			document.forms[0].action = "/HRIS_Leave/manageSpecialDate.do?method=showNationalHolidayList";

		document.forms[0].submit();
	}
</script>
</head>
<body onload="startTime()">
	<html:form action="/leaveAction" method="post">
		<html:hidden name="leaveForm" property="task" />
		<!-- NAVBAR -->
		<nav class="navbar navbar-inverse navbar-fixed-top role="navigation">

		<!-- LOGO -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-ex1-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#"> <img alt="Brand"
				src="asset/img/logo-hover.png">
			</a>
		</div>
		<!-- END LOGO -->

		<ul class="nav navbar-right top-nav">
			<!-- DROPDOWN USER -->
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown"><i class=" fa fa-user" id="warnaPutih"></i>
					<font color="white">Hi, <%=session.getAttribute("employeeName") %></font> <b class="caret"
					id="warnaPutih"></b></a>
				<ul class="dropdown-menu">
					<li><a href="javascript:navigateToPage('logout');"><span
							class="glyphicon glyphicon-log-out"></span> Log Out</a></li>
				</ul></li>
			<!-- END DROPDOWN USER -->
		</ul>
		
		<!-- SIDEBAR -->
		<div class="collapse navbar-collapse navbar-ex1-collapse">
			<ul class="nav navbar-nav side-nav">
				<!-- SIDEBAR 0 -->
					<li><a><i
							class="fa fa-paper-plane"></i> Leave Management</a></li>
							
				<!-- SIDEBAR 1a dan 1b -->
				<li><a href="javascript:;" data-toggle="collapse"
					data-target="#demo2"><i class="fa fa-fw fa-arrows-v"></i>
						Request <i class="fa fa-fw fa-caret-down"></i></a>
					<ul id="demo2" class="collapse">
						<li><a href="javascript:navigateToPage('leaveInput');"><i
								class="fa fa-question-circle"></i> Leave</a></li>
						<li><a href="javascript:navigateToPage('leaveExtraInput');"><i
								class="fa fa-question-circle"></i> Extra Quota</a></li>
					</ul></li>

				<!-- SIDEBAR 2 -->
				<logic:equal name="leaveForm" property="currentSideBar" value="2">
					<li class="active"><a
						href="javascript:navigateToPage('leaveList');"><i
							class="fa fa-list"></i> Leave List</a></li>
				</logic:equal>
				<logic:notEqual name="leaveForm" property="currentSideBar" value="2">
					<li><a href="javascript:navigateToPage('leaveList');"><i
							class="fa fa-list"></i> Leave List</a></li>
				</logic:notEqual>

				<!-- SIDEBAR 3 -->

				<!-- SIDEBAR 4a dan 4b -->
				<li><a href="javascript:;" data-toggle="collapse"
					data-target="#demo3"><i class="fa fa-fw fa-arrows-v"></i>
						Request Approval <i class="fa fa-fw fa-caret-down"></i></a>
					<ul id="demo3" class="collapse">
						<li><a href="javascript:navigateToPage('leaveApproval');"><i
							class="fa fa-check-square-o"></i> Leave</a></li>
						<li><a href="javascript:navigateToPage('leaveExtraApproval')"><i
								class="fa fa-check-square-o"></i> Extra Quota</a></li>
					</ul></li>

				<% if(session.getAttribute("roleId").toString().equals("1")||session.getAttribute("roleId").toString().equals("3")){ %>
						<li><a href="javascript:;" data-toggle="collapse"
							data-target="#demo"><i class="fa fa-fw fa-arrows-v"></i> HR
								Menu <i class="fa fa-fw fa-caret-down"></i></a>
							<ul id="demo" class="collapse">
								<li><a
									href="javascript:navigateToPage('leaveCancellationApproval')"> <span
										class="fa fa-check-square-o"></span> Approve Leave Cancellation
								</a></li>
								
								<li><a
									href="javascript:navigateToPage('leaveListAllEmployees');"> <span
										class="fa fa-list"></span> View All Employees Leave
								</a></li>
		
								<li><a href="javascript:navigateToPage('masterMassLeave');">
										<span class="fa fa-reply-all"></span> Manage Mass Leave
								</a></li>
								<li><a
									href="javascript:navigateToPage('masterNationalHoliday');"> <span
										class="fa fa-calendar"></span> Manage National Holiday
								</a></li>
								<li><a href="javascript:navigateToPage('eod');"> <span
										class="fa fa-clock-o"></span> EOD Manually
								</a></li>
							</ul></li>
					<%} %>

			</ul>
		</div>
		<!-- END SIDEBAR --> </nav>

		</nav>
		<!-- END NAVBAR -->
	</html:form>
	<!-- MODAL -->
	<div class="modal fade" id="modalLogin" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">User Profile</h4>
				</div>
				<div class="modal-body ">

					<!-- PANEL PASSWORD-->
					<div class="panel panel-info ">
						<div class="panel-heading">
							<h5 class="panel-title">
								<span class="glyphicon glyphicon-lock"></span> Change Password
							</h5>
						</div>
						<div class="panel-body">
							<table align="center" class="table table-nonfluid table-hover ">
								<tr>
									<td class="kanan fontBold">Old Password:</td>
									<td><input type="password"></td>
								</tr>
								<tr>
									<td class="kanan fontBold">New Password :</td>
									<td><input type="password"></td>
								</tr>
								<tr>
									<td class="kanan fontBold">Retype New Password :</td>
									<td><input type="password"></td>
								</tr>
							</table>
						</div>
					</div>
					<!-- PANEL -->
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary">
						<i class="fa fa-check"></i>Save changes
					</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">
						<i class="fa fa-close"></i>Close
					</button>
				</div>
			</div>
		</div>
	</div>
	<!-- MODAL -->
</body>
</html>