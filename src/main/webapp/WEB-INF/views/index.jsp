<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="fragments/header.jsp"/>

<style>
    .padding {
        padding-top: 10px;
        overflow: auto;
    }

    .padding-bot {
        padding-bottom: 10px;
    }

    .btn-color {
        color: red;
    }

    .btn-color:hover {
        background-color: red;
    }
</style>

<div class="container padding">

    <button class="padding-bot btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
            data-bs-toggle="collapse" data-bs-target="#sort-collapse" aria-expanded="false">
        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-filter-left"
             viewBox="0 0 16 16">
            <path d="M2 10.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5z"/>
        </svg> &nbsp; Sortuj
    </button>
    <div class="collapse" id="sort-collapse">
        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
            <li><a href="/advertising/sort/date"
                   class="link-dark d-inline-flex text-decoration-none rounded">Najnowsze</a></li>
            <li><a href="/advertising/sort/priceMin" class="link-dark d-inline-flex text-decoration-none rounded">Cena:
                od najniższej</a></li>
            <li><a href="/advertising/sort/priceMax" class="link-dark d-inline-flex text-decoration-none rounded">Cena:
                od najwyższej</a></li>
            <li><a href="/advertising/sort/mileageMin" class="link-dark d-inline-flex text-decoration-none rounded">Najniższy
                przebieg</a></li>
            <li><a href="/advertising/sort/mileageMax" class="link-dark d-inline-flex text-decoration-none rounded">Najwyższy
                przebieg</a></li>
        </ul>
    </div>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
        <c:forEach items="${items}" var="item">
            <div class="col">
                <div class="card shadow-sm">
                    <c:if test="${not empty item.image}">
                        <c:url var="imageUrl" value="../../../resources/images/${item.image}"/>
                        <img src="<c:out value="${imageUrl}"/>"
                             class="bd-placeholder-img card-img-top image-background"
                             xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail"
                             preserveAspectRatio="xMidYMid slice" focusable="false"/>
                    </c:if>
                    <c:if test="${empty item.image}">
                        <svg class="bd-placeholder-img card-img-top" width="100%" height="225"
                             xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail"
                             preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title>
                            <rect width="100%" height="100%" fill="#55595c"/>
                            <text x="42%" y="50%" fill="#eceeef" dy=".3em">Brak zdjęcia</text>
                        </svg>
                    </c:if>

                    <div class="card-body">
                        <h3><c:out value="${item.title}"/> • <c:out value="${item.price}"/> zł</h3>
                        <p class="card-text"><c:out value="${item.brand.name}"/> • Rok produkcji: <c:out value="${item.year_of_production}"/></p>
                        <p class="card-text">Przebieg: <c:out value="${item.mileage}"/> km</p>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="btn-group">
                                <a href="<c:url value="/advertising/details/${item.id}"/>"
                                   class="btn btn-sm btn-outline-secondary">Szczegóły</a>
                                <c:if test="${pageContext.request.isUserInRole('ADMIN')}">
                                    <a href="<c:url value="admin/advertising/remove/${item.id}"/>"
                                       class="btn btn-color btn-sm btn-outline-secondary">Usuń</a>
                                </c:if>
                            </div>
                            <c:if test="${not empty item.updatedAt}">
                                <small class="text-muted">Aktualizowano: <c:out value="${item.updatedAt}"/></small>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="fragments/footer.jsp"/>