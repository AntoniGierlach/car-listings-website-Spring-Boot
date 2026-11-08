<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../fragments/header.jsp"/>

<section class="page-container empty-state">
    <h1>Usuń ogłoszenie</h1>
    <p class="lead">Czy na pewno chcesz usunąć ogłoszenie: <strong><c:out value="${advertising.title}"/></strong>?</p>
    <form method="post" action="<c:url value="/admin/advertising/remove/${advertising.id}"/>">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <button type="submit" class="btn btn-danger" name="remove" value="Tak">Tak, usuń</button>
        <button type="submit" class="btn btn-secondary" name="remove" value="Nie">Nie</button>
    </form>
</section>

<jsp:include page="../fragments/footer.jsp"/>
