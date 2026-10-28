<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../fragments/header.jsp"/>

<style>
    .padding {
        padding-top: 10px;
        overflow: auto;
    }

    .btn-color {
        color: red;
    }

    .btn-color:hover {
        background-color: red;
    }

    .image-background {
        background: #000;
        display: table;
        width: 100%;
        height: 100%;
        position: relative;
    }

    img {
        display: block;
        max-height: 100%;
        max-width: 100%;
        margin: auto;
    }

</style>

<div class="container padding">
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
                                <a href="<c:url value="/user/advertising/update/${item.id}"/>"
                                   class="btn btn-sm btn-outline-secondary">Edytuj</a>
                                <a href="<c:url value="/user/advertising/remove/${item.id}"/>"
                                   class="btn btn-color btn-sm btn-outline-secondary">Usuń</a>

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

<jsp:include page="../fragments/footer.jsp"/>