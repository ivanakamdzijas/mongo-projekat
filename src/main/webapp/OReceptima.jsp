<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css">




<title>O receptima</title>
</head>
<body>

	<div class="body">
	
	
	</div>
	<div class="grad">
	
	
	
	</div>
	<div class="header">
	<br><br><br>
	<b>Ovo je web portal posvećen zdravoj ishrani.<br>
		<br> Naša ideja je bila da postavimo preukusne, neobične zdrave
			recepte i na taj način podsetimo ljude koliko može biti ukusno
			hraniti se <br>zdravo.<br> Želeli smo da Vas inspirišemo i
			podstaknemo da unapredite svoj stil života i posvetite više pažnje
			svom zdravlju.<br> Ovaj portal je otvoren tako da svako može
			postavljati svoje recepte.<br>
		<br>
		<br> Ovde možete pogledati <a href="/recepti/prikazatiTabelu">podatke
				o prosečnim kalorijskim vrednostima</a> u našim receptima
		</b> <br>
		<br>
		<c:if test="${!empty prosecnoKcalD }">
			<table border="1">
				<tr>
					<th></th>
					<th>kcal</th>
					<th>pr</th>
					<th>ma</th>
					<th>uh</th>
				</tr>
				<tr>
					<th>doručak</th>
					<td>${prosecnoKcalD }</td>
					<td>${prosecnoPrD }</td>
					<td>${prosecnoMaD }</td>
					<td>${prosecnoUhD }</td>
				</tr>
				<tr>
					<th>ručak</th>
					<td>${prosecnoKcalR }</td>
					<td>${prosecnoPrR }</td>
					<td>${prosecnoMaR }</td>
					<td>${prosecnoUhR }</td>
				</tr>
				<tr>
					<th>večera</th>
					<td>${prosecnoKcalV }</td>
					<td>${prosecnoPrV }</td>
					<td>${prosecnoMaV }</td>
					<td>${prosecnoUhV }</td>
				</tr>
				<tr>
					<th>dezert</th>
					<td>${prosecnoKcalDez }</td>
					<td>${prosecnoPrDez }</td>
					<td>${prosecnoMaDez }</td>
					<td>${prosecnoUhDez }</td>
				</tr>
			</table>
		</c:if>
		
	</div>
	<br>

	<div id='cssmenu'>

		<ul>

			<li><a href='/index.jsp'>Pocetna stranica</a></li>
			<li class='active has-sub'><a href='#'>Odaberite akciju</a>
				<ul>
					<li><a class='has-sub' href="/OReceptima.jsp">O našim
							receptima</a></li>
					<li><a class='has-sub' href="/PrikazRecepata.jsp">Recepti</a></li>
					<li><a class='has-sub' href="/UnosRecepta.jsp">Unos novog
							recepta</a></li>

					<li><a class='has-sub' href="/PlanIshrane.jsp">Plan
							ishrane</a></li>



				</ul></li>

		</ul>
		<br> <br>




	</div>
</body>
</html>