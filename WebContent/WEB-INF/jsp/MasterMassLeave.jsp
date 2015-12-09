<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Master Mass Leave</title>
<%@include file="PartBootstrap.jsp"%>
<script type="text/javascript">
	function submitForm() {
		//untuk delete
		document.forms["specialDateForm"].submit();
	}
	
	function addModal(){
		document.forms["specialDateForm"].elements["currentSpecialDateBean.description"].value ="";
		document.forms["specialDateForm"].elements["currentSpecialDateBean.date"].value="";
		document.forms["specialDateForm"].action = "/HRIS_Leave/manageSpecialDate.do?method=saveAddMassLeave";
	}	
	
	function editModal(desc, date, specialDateId) {
		document.forms["specialDateForm"].elements["currentSpecialDateBean.description"].value = desc;
		document.forms["specialDateForm"].elements["currentSpecialDateBean.date"].value=date;
		document.forms["specialDateForm"].action = "/HRIS_Leave/manageSpecialDate.do?method=editMassLeave";
		document.forms["specialDateForm"].specialDateId.value= specialDateId;
	}
	
	function deleteModal(specialDateId){
		document.forms["specialDateForm"].action = "/HRIS_Leave/manageSpecialDate.do?method=deleteMassLeave";
		document.forms["specialDateForm"].specialDateId.value= specialDateId;
	}
	
	function onModalClose(){
		$('#validate-form').bootstrapValidator('resetField','currentSpecialDateBean.date');
		$('#validate-form').bootstrapValidator('resetField','currentSpecialDateBean.description');
		document.forms["specialDateForm"].elements["currentSpecialDateBean.description"].value ="";
		document.forms["specialDateForm"].elements["currentSpecialDateBean.date"].value="";
	}
	
	function getAsyncSpecialDate() {
		var action="getAsyncSpecialDate";
		$
				.getJSON(
					"/HRIS_Leave//manageSpecialDate.do?method="+action,
					{
						selectedYear : $('#selectedYear').val(),
						specialDateId : "2"
					},
					function(data) {
						var content="<tr><th>Date</th>"
							+"<th>Description</th></tr>";
						$.each(data, function(index, element) {
							
							content += "<tr><td>" + element.date
									+ "</td><td>" + element.description
									+ "</td></tr>";
						});
						
						$('#historySpecialDate').html(content);
					});
	}
</script>


</head>
<body>
	<div id="wrapper">
		<%@include file="PartNavbar.jsp"%>
		<div id="page-wrapper">
			<div class="container-fluid">
				<div class="row">

					<div class="col-md-12">

						<!--JUDUL-->
						<div class="page-header">
							<h3 id="timeline">Mass Leave</h3>
						</div>
						<!-- END JUDUL -->

						<!-- BREADCRUMB -->
						<ul class="breadcrumb">
							<li><span class="fa fa-dashboard"></span>
								<a href="<bean:write name="leaveForm" property="urlPortal"/><%= request.getAttribute("zx") %>">Dashboard</a>
							</li>
							<li><span class="fa fa-paper-plane"></span><a href="javascript:navigateToPage('mainMenu');">Leave</a></li>
							<li><span class="fa fa-reply-all"></span> Mass Leave</li>
						</ul>
						<!-- END BREADCRUMB -->
						
						<logic:notEmpty name="specialDateForm" property="error"> 
					       <div class="alert alert-danger alert-dismissible" role="alert"> 
					          <button type="button" class="close" data-dismiss="alert" 
					           aria-label="Close"> 
					           <span aria-hidden="true">&times;</span> 
					          </button> 
					          <i class="fa fa-info-circle"></i> <bean:write name="specialDateForm" property="error"/> 
					       </div> 
				     	</logic:notEmpty>
					</div>
					<!-- END ADD NEW -->
					<br>


					<div class="col-xs-7">

						<!-- PANEL -->
						<div class="panel panel-info ">
							<div class="panel-heading">
								<i class="fa fa-reply-all"></i> Upcoming Mass Leave
							</div>
							<div class="panel-body">
								<center>
									<button type="button" onclick="javascript:addModal();"
										class="btn btn-primary" id="addBtn" data-toggle="modal"
										data-backdrop="static" data-target="#modalAddMassLeave">
										<i class="fa fa-plus"></i> Add New Mass Leave
									</button>
								</center>
								<br />

								<table align="center"
									class="table table-striped table-hover table-condensed">
									<thead>
										<tr>
											<th class="tengah">Date</th>
											<th>Description</th>
											<th class="tengah">Button Actions</th>
										</tr>
									</thead>

									<logic:notEmpty name="specialDateForm" property="specialDateList">
										<logic:iterate id="specialDateIteration" name="specialDateForm" property="specialDateList">
											<tr>
												<td><bean:write name="specialDateIteration" property="date" /></td>
												<td><bean:write name="specialDateIteration"	property="description" /></td>
												<td class="tengah">
												<button type="button" onclick="javascript:editModal('<bean:write name="specialDateIteration" property="description"/>','<bean:write name="specialDateIteration"
														property="date" />','<bean:write name="specialDateIteration" property="id"/>');"
														class="btn btn-info editBtn" class="btn btn-primary"
														data-toggle="modal" data-backdrop="static"
														data-target="#modalAddMassLeave">
														<span class="fa fa-pencil"></span> Edit
													</button>&nbsp;
													<button type="button" class="btn btn-danger"
															data-toggle="modal" data-target="#deleteModal" onclick="javascript:deleteModal('<bean:write name="specialDateIteration" property="id"/>')">
															<i class="fa fa-trash"></i> Delete
													</button>
													</td>
											</tr>
										</logic:iterate>
									</logic:notEmpty>
								</table>
							</div>
						</div>
						<!-- END PANEL -->

					</div>
					<!-- END COL 7 -->

					<div class="col-xs-5">

						<!-- PANEL -->
						<div class="panel panel-grey ">
							<div class="panel-heading">
								<i class="fa fa-reply-all"></i> History Mass Leave
							</div>

							<div class="panel-body">

								<label class="fontbold">Search By Year:</label>
								<html:select onchange="javascript:getAsyncSpecialDate();"
									styleId="selectedYear" styleClass="form-control-resize"
									name="specialDateForm" property="selectedYear">
									<logic:notEmpty name="specialDateForm" property="categoryYearList">
										<logic:iterate id="iterateYear" name="specialDateForm" property="categoryYearList">
											<bean:define id="categoryYear" name="iterateYear" type="java.lang.String" />
											<html:option value="<%=categoryYear%>">
												<bean:write name="iterateYear" />
											</html:option>
										</logic:iterate>
									</logic:notEmpty>
								</html:select>
								<br/> <br/>
								<table align="center" id="historySpecialDate"
									class="table table-striped table-hover table-condensed">
									<thead>
										<tr>
											<th>Date</th>
											<th>Description</th>
										</tr>
									</thead>
									<tbody>
										<logic:notEmpty name="specialDateForm" property="historySpecialDateList">
											<logic:iterate id="historySpecialDateIteration"	name="specialDateForm" property="historySpecialDateList">
												<tr>
													<td><bean:write name="historySpecialDateIteration" property="date" /></td>
													<td><bean:write name="historySpecialDateIteration" property="description" /></td>
												</tr>
											</logic:iterate>
										</logic:notEmpty>
									</tbody>
								</table>
							</div>
						</div>
						<!-- END PANEL -->
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%@include file="PartJavascript.jsp"%>
	<!-- MODAL ADD/EDIT-->
	<div class="modal fade" id="modalAddMassLeave" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 id="modalLabel">Mass Leave</h4>
				</div>
				<div class="modal-body">
					<html:form action="/manageSpecialDate" styleId="validate-form" styleClass="validate-form">
						<html:hidden name="specialDateForm" property="specialDateId" />
						<table align="center"
							class="table table-nonfluid table-hover table-nonfluid table-borderless">
							<tr>
								<td class="fontBold kanan">Date <font color="red">*</font>:</td>
								<td><div class="form-group">
								<input name="currentSpecialDateBean.date" type="text" class="span form-control" id="dpd1"
									readonly="readonly"></input></div></td>

							</tr>
							<tr>
								<td class="fontBold kanan">Description <font color="red">*</font>:</td>
								<td><div class="form-group"><html:textarea name="specialDateForm" styleClass="form-textarea"
										property="currentSpecialDateBean.description"></html:textarea></div></td>
							</tr>
									
						</table>
					
							<div class="modal-footer">
							<html:hidden name="specialDateForm" property="action" value="/HRIS_Leave/manageSpecialDate.do?method=saveAddMassLeave"/>
								<button type="submit" class="btn btn-primary" id="info">
									<i class="fa fa-check"></i>Submit
								</button>
								<button type="button" onclick="javascript:onModalClose();"
									class="btn btn-danger" data-dismiss="modal">
									<i class="fa fa-close"></i>Close
								</button>
							</div>
					</html:form>
				</div>

			</div>
		</div>
	</div>
	<!-- END MODUL ADD/EDIT -->

	<!-- MODAL DELETE-->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="#deactivateModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">
						Notification
					</h4>
				</div>
				<div class="modal-body">
					<div class="alert alert-danger kiri" role="alert">
						<i class="fa fa-exclamation-triangle"></i> Are you sure want to
						delete this Mass Leave?
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" onclick="javascript:submitForm()">
						<i class="fa fa-trash"></i> Delete
					</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">
						<i class="fa fa-close"></i> Cancel
					</button>
				</div>
			</div>
		</div>
	</div>
	<!-- END MODAL DELETE-->
	
<script type="text/javascript">
	$(function() {
		$('.datepicker').datepicker({});
		$('#addBtn').click(function(){
			$("#modalLabel").html("Add Mass Leave");
		});
		$('.editBtn').click(function(){
			$("#modalLabel").html("Edit Mass Leave");
		});
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
										return date.valueOf() <= now
												.valueOf() ? 'disabled'
												: '';
									}
								}).on('changeDate', function(ev) {
									checkin.hide();
									$('#validate-form').bootstrapValidator('revalidateField','currentSpecialDateBean.date');
						}).data('datepicker');
			});

	$('#validate-form').bootstrapValidator({
//	       live: 'disabled',
			excluded:'disabled',
	        message: 'This value is not valid',
	        feedbackIcons: {
	            valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
	        },
	        fields: {
	        	'currentSpecialDateBean.date': {
	                 validators: {
	                     notEmpty: {
	                         message: 'Date is required and cannot be empty'
	                     },
				       
	                 }
	             },
	             'currentSpecialDateBean.description': {
	                validators: {
	                    notEmpty: {
	                        message: 'Description is required and cannot be empty'
	                    },
	                    
	                    stringLength: {
	                        message: 'Description content must be less than 100 characters',
	                        max: function (value, validator, $field) {
	                            return 100 - (value.match(/\r/g) || []).length;
	                    }}
	                }
	            }
	        }
	    });
</script>
</body>
</html>