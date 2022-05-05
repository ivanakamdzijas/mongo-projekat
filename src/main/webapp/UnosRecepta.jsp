<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styles.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css">




<title>Unos recepta</title>
</head>
<body>

<div class="body"></div>
	<div class="grad"></div>
	<div class="header">
	
	
	
	<form  action="/recepti/saveOReceptu" method="post">
		<table>
			<tr>
				<td>Naziv recepta:</td>
				<c:if test="${empty recept }">
					<td><input type="text" name="nazivRecepta" placeholder="Unesite naziv recepta"></td>
				</c:if>
				<c:if test="${!empty recept }">
					<td>${recept.nazivRecepta }</td>
				</c:if>
			</tr>


			<tr>
				<td>Vreme pripreme:</td>
				<c:if test="${empty recept }">
					<td><input type="text" name="trajanje" placeholder="Unesite očekivano vreme pripreme"></td>
				</c:if>
				<c:if test="${!empty recept }">
					<td>${recept.trajanje }</td>
				</c:if>
			</tr>
			<tr>
				<td>Kategorija:</td>
				<c:if test="${empty recept }">
					<td><select name="kategorija">
							<option value="1">dorucak</option>
							<option value="2">rucak</option>
							<option value="3">vecera</option>
							<option value="4">dezert</option>
					</select></td>
				</c:if>
				<c:if test="${!empty recept }">
					<td>${kategorija }</td>
				</c:if>
			</tr>
			<tr>
				<td>kalorija:</td>
				<c:if test="${empty recept }">
					<td><input type="text" name="kcal" placeholder="Unesite kcal"></td>
				</c:if>
				<c:if test="${!empty recept }">
					<td>${recept.kcal }</td>
				</c:if>
			</tr>
			<tr>
				<td>ugljenih hidrata:</td>
				<c:if test="${empty recept }">
					<td><input type="text" name="uh" placeholder="Unesite udeo uh u gramima"></td>
				</c:if>
				<c:if test="${!empty recept }">
					<td>${recept.uh }</td>
				</c:if>
			</tr>
			<tr>
				<td>masti:</td>
				<c:if test="${empty recept }">
					<td><input type="text" name="ma" placeholder="Unesite udeo ma u gramima"></td>
				</c:if>
				<c:if test="${!empty recept }">
					<td>${recept.ma }</td>
				</c:if>
			</tr>
			<tr>
				<td>proteina:</td>
				<c:if test="${empty recept }">
					<td><input type="text" name="pr" placeholder="Unesite udeo pr u gramima"></td>
				</c:if>
				<c:if test="${!empty recept }">
					<td>${recept.pr }</td>
				</c:if>
			</tr>

			
				<tr>
					<td></td>
					<td><c:if test="${empty recept && empty poruka}"><input type="submit" value="Dalje"></c:if></td>
				</tr>
			
		</table>
	</form>
	<c:if test="${! empty recept && empty brojac }">
		<form  action="/recepti/unosBrojaSastojaka" method="get">
			<table>
				<tr>
					<td>Broj sastojaka:</td>
					<td><input type="text" name="brojac" placeholder="Unesite broj sastojaka"></td>
				</tr>
				<tr><td><input type="submit" value="Dalje"></td></tr>
			</table>
			
		</form>

	</c:if>
	<c:if test="${! empty brojac  }">
		<form  action="/recepti/saveSastojci" method="post">
			<table>

				

				<tr>
			<td>Sastojci:</td>
			<td></td></tr>
					<c:if test="${ empty sastojci }">
					<c:forEach var="i" begin="1" end="${brojac }">
						<tr>

							<td><input type="text" name="nazivSastojka" placeholder="Unesite naziv sastojka"></td>

							<td><input type="text" name="kolicina" placeholder="Unesite količinu"></td>

							<td><input type="text" name="mj" placeholder="Unesite mernu jedinicu"></td>
						</tr>
						</c:forEach>
						<tr>
						<td>
						<input type="submit" value="Dalje">
						</td>
						</tr>
					</c:if>
					
					<c:if test="${!empty sastojci }">
						<c:forEach var="sastojak" items="${sastojci }">
						<tr>

							<td>${sastojak.nazivSastojka}</td>

							<td>${sastojak.kolicina}</td>

							<td>${sastojak.mj}</td>
						</tr>
						</c:forEach>
					</c:if>
					
				

			</table>



		</form>
	</c:if>
	<c:if test="${! empty sastojci }">
		<form action="/recepti/sacuvaj" method="post">
			<table><tr><td>
			Nacin pripreme: </td><td><textarea style="width: 400px;
	height: 180px;"name="nacinPripreme" placeholder="Unesite način pripreme"></textarea>
			</td>
			<tr><td></td>
			<td><input type="submit" value="Sacuvaj recept"></td>
			
		</tr></table>
		</form>
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