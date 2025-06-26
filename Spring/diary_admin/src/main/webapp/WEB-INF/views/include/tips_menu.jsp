<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
	
	<meta name="viewport" content="width=1190, user-scalable=yes">
	
<script src="./resources/js/header.js"></script>
<script src="./resources/js/tips.js"></script>

<div class="tips-menu">
	<nav class="tips-menu-submenu <c:if test="${tips_menu eq 'transport'}">active</c:if>" data-tips="transport">
		<div class="transport-icon">
			<i class="fa-solid fa-car" style="padding-right:20px;"></i>
			<i class="fa-solid fa-plane" ></i>
		</div>
		<div class="transport-icon" style="padding-top:20px;">
			<i class="fa-solid fa-ship" style="padding-right:20px;"></i>
			<i class="fa-solid fa-train"></i>
		</div>
		
	</nav>
	<nav class="tips-menu-submenu <c:if test="${tips_menu eq 'accomodation'}">active</c:if>" data-tips="accomodation">
		<div class="accomodation-icon">
			<i class="fa-solid fa-bed"></i>
		</div>
	</nav>
	<nav class="tips-menu-submenu <c:if test="${tips_menu eq 'eat'}">active</c:if>" data-tips="eat">
		<div class="eat-icon">
			<i class="fa-solid fa-utensils" style="padding-right:20px;"></i>
			<i class="fa-solid fa-mug-saucer"></i>
		</div>
	</nav>
	<nav class="tips-menu-submenu <c:if test="${tips_menu eq 'etc'}">active</c:if>" data-tips="etc">
		<div class="etc-icon">
			<i class="fa-solid fa-ellipsis"></i>
		</div>
	</nav>
</div>