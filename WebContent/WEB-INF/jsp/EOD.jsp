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
<title>End Of Day (EOD)</title>
</head>
<body>
	<div id="wrapper">
		<%@include file="PartNavbar.jsp"%>
		<div id="page-wrapper">

			<!-- CONTAINER -->
			<div class="container-fluid">
				<div class="row">

					<!-- ISI CONTENT --> 
					<html:form action="/leaveAction">
					<html:hidden name="leaveForm" property="task" value="doeod"/>
					<div class="col-md-12">
						<!--JUDUL-->
						<div class="page-header">
							<h3 id="timeline">End Of Day (EOD) Manually</h3>
						</div>
						<!-- END JUDUL -->

						<!-- BREADCRUMB -->
						<ul class="breadcrumb">
							<li><span class="fa fa-dashboard"></span><a	href="#"> Dashboard</a></li>
							<li><span class="fa fa-paper-plane"></span><a href="javascript:navigateToPage('mainMenu')">&nbsp;Leave</a></li>
							<li><span class="fa fa-clock-o"></span> EOD Manually</li>
						</ul>
						<!-- END BREADCRUMB -->

						<div class="tengah">
							<table align="center" class="table table-nonfluid table-borderless">
								<tr>
									<td class="fontBold kanan">Last EOD : </td>									
									<td class="kiri"><bean:write name="leaveForm" property="eodBean.eodDate" /></td>
								</tr>
								<tr>
									<td class="fontBold kanan">By : </td>
									<td class="kiri"><bean:write name="leaveForm" property="eodBean.eodActor"/></td>
								</tr>

							</table>

							<logic:equal name="leaveForm" property="eodBean.flagEod" value="1">
								<button type="submit" class="btn btn-primary" class="btn btn-primary">
									<span class="fa fa-check"></span> EOD Manually
								</button>
							</logic:equal>
						</div>
					</div>
				</html:form>
				</div>
			</div>
		</div>
	</div>
<%@include file="PartJavascript.jsp"%>
</body>
</html>