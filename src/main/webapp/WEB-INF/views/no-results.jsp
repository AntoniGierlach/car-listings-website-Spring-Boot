<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="fragments/header.jsp"/>

<section class="empty-state">
    <div class="row py-lg-5">
        <div class="col-lg-6 col-md-8 mx-auto">
            <h1 class="fw-light">Brak elementów</h1>
            <p class="lead text-muted">Nie znaleziono ogłoszeń o podanych kryteriach</p>
            <p>
                <a href="<c:url value="/advertising"/>" class="btn btn-primary my-2">Wróć do ogłoszeń</a>
                <a href="<c:url value="/"/>" class="btn btn-secondary my-2">Strona główna</a>
            </p>
        </div>
    </div>
</section>

<jsp:include page="fragments/footer.jsp"/>
