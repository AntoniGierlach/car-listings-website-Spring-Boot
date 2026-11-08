<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../fragments/header.jsp"/>

<section class="page-container">
    <p class="eyebrow">Panel administratora</p>
    <h1>Ogłoszenia</h1>
    <p class="lead">Administrator może usunąć dowolne ogłoszenie, niezależnie od jego właściciela.</p>
    <div class="table-responsive surface-card mt-4">
        <table class="table align-middle mb-0">
            <thead><tr><th>Ogłoszenie</th><th>Właściciel</th><th>Cena</th><th>Akcja</th></tr></thead>
            <tbody>
            <c:forEach items="${items}" var="item">
                <tr>
                    <td><a href="<c:url value="/advertising/details/${item.id}"/>"><c:out value="${item.title}"/></a></td>
                    <td><c:out value="${item.user.username}"/></td>
                    <td><fmt:formatNumber value="${item.price}" groupingUsed="true"/> zł</td>
                    <td><button type="button" class="btn btn-sm btn-outline-danger"
                                data-delete-action="<c:url value="/admin/advertising/remove/${item.id}"/>"
                                data-delete-label="ogłoszenie: <c:out value="${item.title}"/>">Usuń</button></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</section>

<jsp:include page="../fragments/confirm-delete-dialog.jsp"/>
<jsp:include page="../fragments/footer.jsp"/>
