<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="fragments/header.jsp"/>

<style>
    .favorites-grid {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 28px;
    }

    .favorite-card {
        position: relative;
        overflow: hidden;
        min-width: 0;
        border: 1px solid var(--line);
        border-radius: 16px;
        background: var(--surface);
        cursor: pointer;
        box-shadow: 0 8px 24px rgba(16, 42, 67, .06);
        transition: transform .24s ease, box-shadow .24s ease;
    }

    .favorite-card:hover {
        transform: translateY(-4px);
        box-shadow: var(--shadow);
    }

    .favorite-card-link {
        position: absolute;
        z-index: 1;
        inset: 0;
        pointer-events: none;
        border-radius: inherit;
    }

    .favorite-card-link:focus-visible {
        outline: 3px solid var(--orange);
        outline-offset: -3px;
    }

    .favorite-card__image,
    .favorite-card__body {
        position: relative;
        z-index: 0;
    }

    .favorite-card__image {
        width: 100%;
        height: 280px;
        overflow: hidden;
        background: #dce1e2;
    }

    .favorite-card__image img {
        display: block;
        width: 100%;
        height: 100%;
        object-fit: cover;
        object-position: center;
    }

    .favorite-card__body {
        padding: 22px;
    }

    .favorite-card__body h2 {
        margin: 0 0 10px;
        color: var(--navy);
        font-size: 1.35rem;
    }

    .favorite-card__meta {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        margin-bottom: 20px;
        color: var(--muted);
        font-size: .88rem;
    }

    .favorite-card__meta span {
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }

    .favorite-card__meta svg {
        width: 14px;
        height: 14px;
        color: #8b969c;
    }

    .favorite-card__footer {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 16px;
        padding-top: 16px;
        border-top: 1px solid var(--line);
    }

    .favorite-card__body form,
    .favorite-card__body button {
        position: relative;
        z-index: 2;
    }

    @media (max-width: 700px) {
        .favorites-grid {
            grid-template-columns: 1fr;
        }

        .favorite-card__image {
            height: 230px;
        }
    }
</style>

<div class="listing-intro">
    <div><p class="eyebrow">ApexWheels / ulubione</p><h1>Twoje <em>ulubione</em> oferty.</h1></div>
</div>

<c:if test="${not empty favoriteError}">
    <div class="alert alert-danger" role="alert"><c:out value="${favoriteError}"/></div>
</c:if>

<c:choose>
    <c:when test="${not empty favoriteItems}">
        <div class="favorites-grid">
            <c:forEach items="${favoriteItems}" var="item">
                <article class="favorite-card js-listing-card"
                         data-details-url="<c:url value="/advertising/details/${item.id}"/>">
                    <a class="favorite-card-link"
                       href="<c:url value="/advertising/details/${item.id}"/>"
                       aria-label="Zobacz ogłoszenie: <c:out value="${item.title}"/>"></a>
                    <div class="favorite-card__image">
                        <c:if test="${not empty item.image}">
                            <c:url var="imageUrl" value="/images/thumbs/${item.image}"/>
                            <img src="<c:out value="${imageUrl}"/>"
                                 alt="<c:out value="${item.title}"/>"
                                 loading="lazy" decoding="async" width="800" height="500">
                        </c:if>
                        <c:if test="${empty item.image}">
                            <div class="no-image">Brak zdjęcia</div>
                        </c:if>
                    </div>
                    <div class="favorite-card__body">
                        <h2><c:out value="${item.title}"/></h2>
                        <div class="favorite-card__meta">
                            <span><i data-lucide="calendar-days" aria-hidden="true"></i><c:out value="${item.year_of_production}"/> r.</span>
                            <span><i data-lucide="road" aria-hidden="true"></i><fmt:formatNumber value="${item.mileage}" groupingUsed="true"/> km</span>
                            <span><i data-lucide="gauge" aria-hidden="true"></i><c:out value="${item.power}"/> KM</span>
                            <c:if test="${not empty item.fuelType}"><span><i data-lucide="fuel" aria-hidden="true"></i><c:out value="${item.fuelType}"/></span></c:if>
                        </div>
                        <div class="favorite-card__footer">
                            <span class="listing-price"><fmt:formatNumber value="${item.price}" groupingUsed="true"/> zł</span>
                            <form action="<c:url value="/user/favorites/${item.id}"/>" method="post">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                <button type="submit" class="btn btn-sm btn-outline-danger js-favorite"
                                        data-listing-id="${item.id}" aria-label="Usuń z ulubionych">
                                    <i data-lucide="heart-off" aria-hidden="true"></i> Usuń
                                </button>
                            </form>
                        </div>
                    </div>
                </article>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <div class="empty-state">
            <h2>Nie masz jeszcze ulubionych samochodów.</h2>
            <p>Przeglądaj ogłoszenia i zapisuj oferty, do których chcesz wrócić.</p>
            <a class="btn-apex" href="<c:url value="/advertising"/>">Przeglądaj ogłoszenia</a>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="fragments/footer.jsp"/>
