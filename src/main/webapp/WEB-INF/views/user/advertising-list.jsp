<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../fragments/header.jsp"/>

<style>
    .btn-color {
        color: #b42318;
    }

    .btn-color:hover {
        color: #fff;
        background-color: #b42318;
    }

    .image-background {
        background: #000;
        width: 100%;
        height: 190px;
        object-fit: cover;
    }

    img {
        display: block;
        width: 100%;
        height: 100%;
    }

</style>

<div class="page-container">
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
        <c:forEach items="${items}" var="item">
            <div class="col">

                <div class="listing-card h-100">
                    <c:if test="${not empty item.image}">
                    <c:url var="imageUrl" value="/images/thumbs/${item.image}"/>
                    <img src="<c:out value="${imageUrl}"/>"
                         class="listing-image image-background"
                         role="img" alt="<c:out value="${item.title}"/>"
                         loading="lazy" decoding="async" width="800" height="500"/>
                    </c:if>
                    <c:if test="${empty item.image}">
                        <div class="details-image d-flex align-items-center justify-content-center" role="img" aria-label="Brak zdjęcia"><i data-lucide="image-off" class="lucide-icon" aria-hidden="true"></i></div>
                    </c:if>

                    <div class="listing-body">
                        <h3><c:out value="${item.title}"/> • <c:out value="${item.price}"/> zł</h3>
                        <p class="card-text"><c:out value="${item.brand.name}"/> • Rok produkcji: <c:out value="${item.year_of_production}"/></p>
                        <p class="card-text">Przebieg: <c:out value="${item.mileage}"/> km</p>
                        <div class="listing-footer">
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
