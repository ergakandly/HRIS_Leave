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

	function startTime() {
		var today = new Date();
		var h = today.getHours();
		var m = today.getMinutes();
		var s = today.getSeconds();
		var day = today.getDay();
		var weekday = "";
		var date = today.getDate();
		var month = today.getMonth();
		var monthname = "";
		var year = today.getFullYear();

		switch (day) {
		case 0:
			weekday = "Sunday";
			break;
		case 1:
			weekday = "Monday";
			break;
		case 2:
			weekday = "Tuesday";
			break;
		case 3:
			weekday = "Wednesday";
			break;
		case 4:
			weekday = "Thursday";
			break;
		case 5:
			weekday = "Friday";
			break;
		case 6:
			weekday = "Saturday";
			break;
		}

		switch (month) {
		case 0:
			monthname = "January";
			break;
		case 1:
			monthname = "February";
			break;
		case 2:
			monthname = "March";
			break;
		case 3:
			monthname = "April";
			break;
		case 4:
			monthname = "May";
			break;
		case 5:
			monthname = "June";
			break;
		case 6:
			monthname = "July";
			break;
		case 7:
			monthname = "August";
			break;
		case 8:
			monthname = "September";
			break;
		case 9:
			monthname = "October";
			break;
		case 10:
			monthname = "November";
			break;
		case 11:
			monthname = "Desember";
			break;
		}

		m = checkTime(m);
		s = checkTime(s);
		document.getElementById('timeText').innerHTML = weekday + ", " + date
				+ " " + monthname + " " + year + " [" + h + ":" + m + ":" + s
				+ " WIB]";
		var t = setTimeout(startTime, 500);
	}
	function checkTime(i) {
		if (i < 10) {
			i = "0" + i
		}
		; // add zero in front of numbers < 10
		return i;
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
<!-- 			<li><label id="timeText"></label></li> -->

			<!-- NOTIFICATION 
			<li class="dropdown"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown"><span id="warnaPutih"
					class="glyphicon glyphicon-bell"></span> <small><span
						class="badge">3</span></small> <b class="caret" id="warnaPutih"></b></a>
				<ul class="dropdown-menu message-dropdown">
					<li class="message-preview"><a href="#">
							<div class="media">
								<span class="pull-left"> <img class="media-object"
									src="http://placehold.it/50x50" alt="">
								</span>
								<div class="media-body">
									<h5 class="media-heading">
										<strong>John Smith</strong>
									</h5>
									<p class="small text-muted">
										<i class="fa fa-clock-o"></i> Yesterday at 4:32 PM
									</p>
									<p>Lorem ipsum dolor sit amet, consectetur...</p>
								</div>
							</div>
					</a></li>
					<li class="message-preview"><a href="#">
							<div class="media">
								<span class="pull-left"> <img class="media-object"
									src="http://placehold.it/50x50" alt="">
								</span>
								<div class="media-body">
									<h5 class="media-heading">
										<strong>John Smith</strong>
									</h5>
									<p class="small text-muted">
										<i class="fa fa-clock-o"></i> Yesterday at 4:32 PM
									</p>
									<p>Lorem ipsum dolor sit amet, consectetur...</p>
								</div>
							</div>
					</a></li>
					<li class="message-preview"><a href="#">
							<div class="media">
								<span class="pull-left"> <img class="media-object"
									src="http://placehold.it/50x50" alt="">
								</span>
								<div class="media-body">
									<h5 class="media-heading">
										<strong>John Smith</strong>
									</h5>
									<p class="small text-muted">
										<i class="fa fa-clock-o"></i> Yesterday at 4:32 PM
									</p>
									<p>Lorem ipsum dolor sit amet, consectetur...</p>
								</div>
							</div>
					</a></li>
					<li class="message-footer"><a href="#">Read All New
							Messages</a></li>
				</ul></li>
			<!-- END NOTIFICATION -->

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
				<logic:equal name="leaveForm" property="currentSideBar" value="0">
					<li class="active"><a
						href="javascript:navigateToPage('mainMenu');"><i
							class="fa fa-paper-plane"></i> HRIS Leave</a></li>
				</logic:equal>
				<logic:notEqual name="leaveForm" property="currentSideBar" value="0">
					<li><a href="javascript:navigateToPage('mainMenu');"><i
							class="fa fa-paper-plane"></i> HRIS Leave</a></li>
				</logic:notEqual>

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
<%-- 				<logic:equal name="leaveForm" property="currentSideBar" value="3"> --%>
<!-- 					<li class="active"><a -->
<!-- 						href="javascript:navigateToPage('historyLeaveList');"><i -->
<!-- 							class="fa fa-calendar"></i> Leave History</a></li> -->
<%-- 				</logic:equal> --%>
<%-- 				<logic:notEqual name="leaveForm" property="currentSideBar" value="3"> --%>
<!-- 					<li><a href="javascript:navigateToPage('historyLeaveList');"><i -->
<!-- 							class="fa fa-calendar"></i> Leave History</a></li> -->
<%-- 				</logic:notEqual> --%>

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
				
				<%   if(session.getAttribute("roleId").equals("2")){  %>
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