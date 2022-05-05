<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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





<title>Prikaz recepta</title>
</head>
<body>

<div class="body"></div>
	<div class="grad"></div>
	<div class="header">
	
	<table style="width:70%">
			<tr>
			<th>Naziv recepta:</th>
			<td>${recept.nazivRecepta }</td>
			<td><c:if test="${!porukaDaNaziv }">
					<a href="/recepti/izmeniNazivDa">Izmeni?</a>
				</c:if></td>
			<td><c:if test="${porukaDaNaziv }">
					<form action="/recepti/izmeniNaziv">
						<input type="text" name="noviNaziv"><br><input type="submit" placeholder="Unesite naziv recepta"
							value="Sacuvaj">
					</form>
				</c:if></td>
		</tr>
		<tr>
			<th>Vreme pripreme:</th>
			<td>${recept.trajanje }</td>
			<td><c:if test="${!porukaDaTrajanje }">
					<a href="/recepti/izmeniTrajanjeDa">Izmeni?</a>
				</c:if></td>
			<td><c:if test="${porukaDaTrajanje }">
					<form action="/recepti/izmeniTrajanje"> 
						<input type="text" name="novoTr"placeholder="Unesite očekivano vreme pripreme">
						<br><input type="submit"
							value="Sacuvaj">
					</form>
				</c:if></td>
		</tr>
		<tr>
			<th>Kategorija:</th>
			<td>${kategorija }</td>
			<td><c:if test="${!porukaDaKat }">
					<a href="/recepti/izmeniKatDa">Izmeni?</a>
				</c:if></td>
			<td><c:if test="${porukaDaKat }">
					<form action="/recepti/izmeniKat">
						<select name="kat">
							<option value="1">doručak</option>
							<option value="2">ručak</option>
							<option value="3">večera</option>
							<option value="4">dezert</option>
						</select><br><input type="submit" value="Sacuvaj">
					</form>
				</c:if></td>
		</tr>
		<tr>
			<th>Sastojci:</th>
			<td></td>
			<td><a href="/recepti/izmeniSastojkeDa">Ponovo uneti
					sastojke?</a></td>
			<td><c:if test="${!porukaDaSastojci }">
					<c:forEach items="${sastojci}" var="s">
						<tr>
							<td></td>
							<td>${s.nazivSastojka } ${s.kolicina } ${s.mj }</td>
						</tr>
					</c:forEach>
				</c:if></td>

			<td><c:if test="${porukaDaSastojci }">
				<c:if test="${empty noviBrojac }">
					<td>
						<form action="/recepti/izmeniSastojkeBr">
							Unesite broj sastojaka:<br> <input type="text" name="noviBrojac" placeholder="Unesite  novi broj sastojaka">
							<br><input type="submit" value="Dalje">
						</form>
					</td>
					</c:if>
					<c:if test="${!empty noviBrojac }">
					<form action="/recepti/izmeniSastojke">
						<table>
							<c:forEach var="i" begin="1" end="${noviBrojac }">
								<tr>

									<td><input type="text" name="novoNazivSastojka" placeholder="Unesite novi naziv sastojka"></td>

									<td><input type="text" name="novoKolicina" placeholder="Unesite novu količinu"></td>

									<td><input type="text" name="novoMj" placeholder="Unesite novu mernu jedinicu"></td>
								</tr>

							</c:forEach>
								<tr><td>
									<input type = "submit" value = "Sačuvaj">
								</td></tr>
								
						</table>
					</form>
					</c:if>
				</c:if></td>

		</tr>



		<tr>
			<th>Način pripreme:</th>
			<td style = "width:300px;">${recept.nacinPripreme }</td>
			<td><c:if test="${!porukaDaNacin }">
					<a href="/recepti/izmeniNacinDa">Izmeni?</a>
				</c:if></td>
			<td><c:if test="${porukaDaNacin }">
					<form action="/recepti/izmeniNacin">
						<textarea style="width: 400px;
	height: 180px;" name="noviNacin"   placeholder="Unesite način pripreme"></textarea><br>
	<br><input type="submit"
							value="Sačuvaj">
					</form>
				</c:if></td>
		</tr>
		<tr>
			<td>
				<table border="1">
					<tr>
						<th>kcal:</th>
						<td>${ recept.kcal}</td>
					</tr>
					<tr>
						<th>pr:</th>
						<td>${ recept.pr}</td>
					</tr>
					<tr>
						<th>ma:</th>
						<td>${ recept.ma}</td>
					</tr>
					<tr>
						<th>uh:</th>
						<td>${ recept.uh}</td>
					</tr>

				</table>
			</td>
			<td></td>
			<td><c:if test="${!porukaDaTab }">
					<a href="/recepti/izmeniTabDa">Izmeni tablicu nutritivnih
						vrednosti?</a>
				</c:if></td>
			<td><c:if test="${porukaDaTab }">
					<form action="/recepti/izmeniTab">
						<table>
							<tr>
								<td>kalorija:</td>
								<td><input type="text" name="novoKcal" placeholder="Unesite broj kcal"></td>
							</tr>
							<tr>
								<td>ugljenih hidrata:</td>
								<td><input type="text" name="novoUh" placeholder="Unesite udeo uh u gramima"></td>
							</tr>
							<tr>
								<td>masti:</td>
								<td><input type="text" name="novoMa" placeholder="Unesite udeo ma u gramima"></td>
							</tr>
							<tr>
								<td>proteina:</td>
								<td><input type="text" name="novoPr" placeholder="Unesite udeo pr u gramima"></td>
							</tr>
						</table>
						<br>
						<input type="submit" value="Sacuvaj">
					</form>
				</c:if></td>
		</tr>
	</table>
	<c:if test="${! empty poruka }">
	${poruka }<br>
		<br>
	</c:if>
	<a href="/recepti/obrisiRecept?idR=${recept.idR }">Da li želite da
		uklonite ovaj recept?</a>

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