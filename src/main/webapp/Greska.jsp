<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css">



<title>Greška</title>
</head>
<body>

	

	<div class="body"></div>
	<div class="grad"></div>
	<div class="header">
		<div>
		<br><br><br>
			<b>Došlo je do greške, izvinite zbog neprijatnosti.</b><br>
			
		</div>

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