<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css">





<title>Prikaz recepata</title>
</head>
<body>

	<div class="body"></div>
	<div class="grad"></div>
	<div class="header">



	
		${porukaBrisanje }


		<c:if test="${empty poNaslovu && empty poSastojku }">
			<form  action="/recepti/filtrirajKat" method="get">
				Odaberite kategoriju: <select name="kat">
					<option value=1  <c:if test="${kat== 1 || empty kat}"> <c:out value= "selected='selected'"/> </c:if> >doručak</option>
					<option value=2 <c:if test="${kat == 2}"> <c:out value= "selected='selected'"/>  </c:if>>ručak</option>
					<option value=3 <c:if test="${kat == 3}"> <c:out value= "selected='selected'"/>  </c:if>>večera</option>
					<option value=4 <c:if test="${kat == 4}"> <c:out value= "selected='selected'"/>  </c:if>>dezert</option>
					<option value=5 <c:if test="${kat == 5}"> <c:out value= "selected='selected'"/>  </c:if>>po naslovu</option>
					<option value=6 <c:if test="${kat == 6}"> <c:out value= "selected='selected'"/>  </c:if>>po sastojku</option>
				</select> <input type="submit" value="Pretraži">
			</form>
		</c:if>
		<c:if test="${!empty poNaslovu }">

			<form  action="/recepti/filtrirajNaslov" method="get">
				<b>${poNaslovu }</b><br>
				<br> <input type="text" name="poNaslovu"
					placeholder="unesite naziv recepta"> <input type="submit"
					value="Pretraži">
			</form>
		</c:if>

		<c:if test="${!empty poSastojku}">

			<form  action="/recepti/filtrirajSastojak" method="get">
				<b>${poSastojku }</b><br>
				<br> <input type="text" name="poSastojku"
					placeholder="unesite naziv sastojka"> <input type="submit"
					value="Pretraži">
			</form>
		</c:if>


		<br>
		<br>
		<br>
		<c:if test="${!empty receptiKat}">
			<h3>Recepti</h3>
			<table>

				<c:forEach var="r" items="${receptiKat}">
					<tr>

						<td>${r.nazivRecepta}</td>
						<td><a href="/recepti/prikaziJedanRecept?idR=${r.idR }">Prikaži</a></td>
						
					</tr>
				</c:forEach>

			</table>
		</c:if>
		<br>
		<br>
		
		<c:if test="${!empty recep  &&  prikaziRecept}">
			<table>
				<tr>
					<th>Naziv recepta:</th>
					<td>${recep.nazivRecepta }</td>
				</tr>
				<tr>
					<th>Vreme pripreme:</th>
					<td>${recep.trajanje }</td>
				</tr>
				<tr>
					<th>Kategorija:</th>
					<td>${kategorija }</td>
				</tr>
				<tr>
					<th>Sastojci:</th>
					<td><c:forEach items="${sastojciPrikaz}" var="s">
								${s.nazivSastojka } ${s.kolicina } ${s.mj }<br>
						</c:forEach></td>
				</tr>
				<tr>
					<th>Način pripreme:</th>
					<td>${recep.nacinPripreme }</td>
				</tr>
				<tr>
					<td>
						<table border="1">
							<tr>
								<th>kcal:</th>
								<td>${ recep.kcal}</td>
							</tr>
							<tr>
								<th>pr:</th>
								<td>${ recep.pr}</td>
							</tr>
							<tr>
								<th>ma:</th>
								<td>${ recep.ma}</td>
							</tr>
							<tr>
								<th>uh:</th>
								<td>${ recep.uh}</td>
							</tr>
						</table>
					</td>
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




	</div>

</body>
</html>