<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="row">
	<div class="datatable-scroll-wrap">
		<c:choose>
			<c:when test="${type==3}">
				<table class="table table-bordered table-hover datatable-highlight1">
					<thead>
						<tr class="bg-pink-400" role="row">
							<th class="sorting_desc">Employee Name</th>
							<th class="sorting">Holiday</th>
							<th class="sorting">Date</th>
						</tr>
					</thead>
					<tbody>

						<c:forEach items="${list}" var="list">
							<tr role="row" class="odd">
								<td>${list.empName}</td>
								<td>${list.leaveTitle}</td>
								<td>${list.leaveFromdt}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:when>
			<c:otherwise>
				<table class="table table-bordered table-hover datatable-highlight1">
					<thead>
						<tr class="bg-pink-400" role="row">
							<th class="sorting_desc">Employee Name</th>
							<th class="sorting">Leave Type</th>
							<th class="sorting">Date</th>
							<th class="sorting">Initial Authority</th>
							<th class="sorting">Final Authority</th>
						</tr>
					</thead>
					<tbody>

						<c:forEach items="${list}" var="list">
							<tr role="row" class="odd">
								<td>${list.empName}</td>
								<td>${list.leaveTitle}</td>
								<td>${list.leaveFromdt}&nbsp;To&nbsp;${list.leaveTodt}</td>
								<td>${list.initialAuthName}</td>
								<td>${list.finalAuthName}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:otherwise>
		</c:choose>

	</div>

</div>
