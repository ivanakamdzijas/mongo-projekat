<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css">





<title>Plan ishrane</title>
</head>
<body>

<div class="body"></div>
	<div class="grad"></div>
	<div class="header">
	<h2>Plan ishrane</h2>
<c:if test="${empty cilj && empty ukupnoKcal}">
	<form class = "login1" action="/recepti/odabratiCilj" method="get">
		<br><br>
		
	Odaberite cilj koji želite da postignete  <select name="cilj">
				<option value=1600>Redukcija masnog tkiva - do 1600 kcal</option>
				<option value=1700>Redukcija masnog tkiva - do 1700 kcal</option>
				<option value=1500>Izgradnja mišićne mase do - 1500 kcal</option>
				<option value=2000>Izgradnja mišićne mase do - 2000 kcal</option>
			</select>
			<input value="Dalje" type="submit">
			<br>
			<br>
	</form>
	</c:if>
	
	<c:if test="${!empty cilj && empty ukupnoKcal }">
	Odabran cilj do ${cilj } kcal.
	<br>
	<br>
	<br> Kreirajte svoj dnevni plan ishrane:
	<br>
	<br>


	<form  action="/recepti/izracunati" method="get">
	<table>
	<tr>
	<td>
		Odaberite dorucak:
		</td><td><select name="dorucak">
			<c:forEach var="d" items="${dor }">
				<option value=${d.idR }>${d.nazivRecepta }</option>
			</c:forEach>
		</select></td>
		</tr>
		 <tr><td>Odaberite rucak:</td><td><select name="rucak">
			<c:forEach var="r" items="${ruckovi }">
				<option value=${r.idR }>${r.nazivRecepta }</option>
			</c:forEach>
		</select></td></tr>
		 <tr><td>Odaberite veceru:</td><td><select name="vecera">
			<c:forEach var="v" items="${vecere}">
				<option value=${v.idR }>${v.nazivRecepta }</option>
			</c:forEach>
		</select></td></tr>
		 <tr><td>Odaberite dezert:</td><td><select name="dezert">
			<c:forEach var="dez" items="${dezerti }">
				<option value=${dez.idR }>${dez.nazivRecepta }</option>
			</c:forEach>
		</select></td></tr>
		<tr><td></td><td>
		<input value="Izracunaj" type="submit"></td>
		</tr>
		</table>
	</form>
	</c:if>

<c:if test="${!empty ukupnoKcal }">
	<h3>Dnevni plan: do ${ciljK } kcal</h3><br><br>
	<table>
	<tr>
	<th>doručak:</th><td>${nazivDor }</td>
	</tr>
	<tr>
	<th>ručak:</th><td>${nazivR }</td>
	</tr>
	<tr>
	<th>večera:</th><td>${nazivV }</td>
	</tr>
	<tr>
	<th>dezert:</th><td>${nazivDez }</td>
	</tr>
	</table><br><br>
	Odnos nutritivnog sadržaja obroka i preporučenih vrednosti:
	<br>
	<br>
	<table border = "1">
		<tr>
			<th>kalorije:</th>
			<td>${ukupnoKcal }</td>
			
			<th>preporučeno do</th>
			<td>${ciljK} kcal</td>
		</tr>
		<tr>
			<th>proteini:</th>
			<td>${ukupnoPr }</td>
			
			<th rowspan ="3"></th>
			<td>${prepPr}</td>
		</tr>
		<tr>
			<th>masti:</th>
			<td>${ukupnoMa }</td>
			
			
			<td>${prepMa}</td>
		</tr>
		<tr>
			<th>ugljeni hidrati:</th>
			<td>${ukupnoUh }</td>
			
			
			<td>${prepUh}</td>
		</tr>

	</table><br><br>
	${napomena }
</c:if>

</div>
	<br>

	<div id='cssmenu'>
 
 <ul>
 	<li><a href='/index.jsp'>Pocetna stranica</a></li>
 	<li class='active has-sub'><a href='#'>Odaberite akciju</a>
 	<ul>
 	<li><a class='has-sub' href="/OReceptima.jsp">O našim receptima</a></li>
 	<li><a class='has-sub' href="/PrikazRecepata.jsp">Recepti</a></li>
	 <li><a class='has-sub' href="/UnosRecepta.jsp">Unos novog recepta</a></li>
	 
	 <li><a class='has-sub' href="/PlanIshrane.jsp">Plan ishrane</a></li>
	 </ul>
	 </li>
 </ul>
 


</div>

</body>
</html>