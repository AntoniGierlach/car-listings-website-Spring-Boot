<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../fragments/header.jsp"/>

<style>
    .my-listings-intro {
        display: flex;
        align-items: flex-end;
        justify-content: space-between;
        gap: 24px;
        margin-bottom: 28px;
    }

    .my-listings-intro h1 {
        margin: 0;
        color: var(--navy);
        font-size: clamp(2rem, 3.5vw, 3rem);
        letter-spacing: -.05em;
    }

    .my-listings-intro h1 em {
        color: var(--orange);
        font-style: normal;
    }

    .my-listings-note {
        max-width: 420px;
        margin: 0;
        color: var(--muted);
        line-height: 1.6;
        text-align: right;
    }

    .my-listings-toolbar {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 16px;
        margin-bottom: 18px;
        padding-bottom: 14px;
        border-bottom: 1px solid var(--line);
    }

    .my-listings-count {
        color: var(--muted);
        font-size: .82rem;
    }

    .my-listings-count strong {
        color: var(--ink);
        font-family: "Manrope", sans-serif;
        font-size: 1rem;
    }

    .my-listings-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(245px, 1fr));
        gap: 20px;
    }

    .my-listing-card {
        position: relative;
        display: flex;
        min-width: 0;
        flex-direction: column;
        overflow: hidden;
        border: 1px solid var(--line);
        border-radius: 12px;
        background: var(--surface);
        cursor: pointer;
        box-shadow: 0 4px 16px rgba(16, 42, 67, .03);
        transition: transform .24s ease, box-shadow .24s ease;
    }

    .my-listing-card-link {
        position: absolute;
        z-index: 1;
        inset: 0;
        pointer-events: none;
        border-radius: inherit;
    }

    .my-listing-card-link:focus-visible {
        outline: 3px solid var(--orange);
        outline-offset: -3px;
    }

    .my-listing-card > .my-listing-image,
    .my-listing-card > .my-listing-body {
        position: relative;
        z-index: 0;
    }

    .my-listing-card .my-listing-actions a,
    .my-listing-card .my-listing-actions button {
        position: relative;
        z-index: 2;
    }

    .my-listing-card:hover {
        transform: translateY(-4px);
        box-shadow: var(--shadow);
    }

    .my-listing-image {
        position: relative;
        width: 100%;
        height: 190px;
        overflow: hidden;
        background: #dce1e2;
    }

    .my-listing-tag {
        position: absolute;
        top: 12px;
        left: 12px;
        z-index: 1;
        max-width: calc(100% - 24px);
        overflow: hidden;
        padding: 5px 8px;
        border-radius: 5px;
        background: rgba(255, 255, 255, .92);
        color: var(--navy);
        font-size: .68rem;
        font-weight: 700;
        line-height: 1.25;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .my-listing-image img {
        display: block;
        width: 100%;
        height: 100%;
        object-fit: cover;
        object-position: center;
        transition: transform .5s ease;
    }

    .my-listing-card:hover .my-listing-image img {
        transform: scale(1.04);
    }

    .my-listing-body {
        display: flex;
        flex: 1;
        flex-direction: column;
        padding: 17px 17px 15px;
    }

    .my-listing-body h2 {
        margin: 0 0 7px;
        overflow: hidden;
        color: var(--navy);
        font-size: 1.1rem;
        letter-spacing: -.035em;
        line-height: 1.28;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 2;
    }

    .my-listing-meta {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 8px 10px;
        justify-items: center;
        margin-bottom: 8px;
        color: var(--muted);
        font-size: .78rem;
    }

    .my-listing-meta span {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 5px;
        width: 100%;
        text-align: center;
        min-width: 0;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .my-listing-meta svg {
        width: 16px;
        height: 16px;
        flex: 0 0 auto;
        color: #8b969c;
    }

    .my-listing-footer {
        display: block;
        margin-top: auto;
        padding-top: 13px;
        border-top: 1px solid var(--line);
    }

    .my-listing-actions {
        display: flex;
        flex-wrap: nowrap;
        justify-content: flex-start;
        gap: 6px;
        margin-top: 12px;
    }

    .my-listing-actions .btn {
        flex: 1 1 0;
        min-width: 0;
        padding-right: 8px;
        padding-left: 8px;
        border-radius: 7px;
        font-size: .75rem;
        white-space: nowrap;
    }

    .my-listing-actions .btn-outline-danger {
        color: #b42318;
        border-color: #e7b6b1;
    }

    .my-listing-actions .btn-outline-danger:hover,
    .my-listing-actions .btn-outline-danger:focus-visible {
        color: #fff;
        border-color: #b42318;
        background: #b42318;
    }

    .my-listing-updated {
        display: block;
        margin-top: 5px;
        color: var(--muted);
        font-size: .68rem;
        line-height: 1.35;
    }

    @media (max-width: 700px) {
        .my-listings-intro {
            display: block;
        }

        .my-listings-note {
            margin-top: 14px;
            text-align: left;
        }

        .my-listings-toolbar {
            align-items: flex-start;
            flex-direction: column;
        }
    }

    @media (max-width: 360px) {
        .my-listing-actions {
            flex-wrap: wrap;
        }

        .my-listing-actions .btn {
            flex: 1 1 auto;
        }
    }
</style>

<div class="page-container">
    <div class="my-listings-intro">
        <div>
            <p class="eyebrow">ApexWheels / konto</p>
            <h1>Moje <em>ogłoszenia.</em></h1>
        </div>
        <p class="my-listings-note">Zarządzaj swoimi ofertami, sprawdzaj ich szczegóły i szybko aktualizuj dane samochodów.</p>
    </div>

    <div class="my-listings-toolbar">
        <span class="my-listings-count"><strong><c:out value="${items.size()}"/></strong> aktywnych ogłoszeń</span>
        <a href="<c:url value="/user/advertising/create"/>" class="btn-apex">
            <i data-lucide="plus" aria-hidden="true"></i> Dodaj ogłoszenie
        </a>
    </div>

    <div class="my-listings-grid">
        <c:forEach items="${items}" var="item">
            <article class="my-listing-card js-listing-card"
                     data-details-url="<c:url value="/advertising/details/${item.id}"/>">
                <a class="my-listing-card-link"
                   href="<c:url value="/advertising/details/${item.id}"/>"
                   aria-label="Zobacz ogłoszenie: <c:out value="${item.title}"/>"></a>
                <div class="my-listing-image">
                    <c:if test="${not empty item.image}">
                        <c:url var="imageUrl" value="/images/thumbs/${item.image}"/>
                        <img src="<c:out value="${imageUrl}"/>"
                             alt="<c:out value="${item.title}"/>"
                             loading="lazy" decoding="async" width="800" height="500">
                    </c:if>
                    <c:if test="${empty item.image}">
                        <div class="no-image" role="img" aria-label="Brak zdjęcia">
                            <i data-lucide="image-off" aria-hidden="true"></i>
                        </div>
                    </c:if>
                    <span class="my-listing-tag"><c:out value="${item.brand.name}"/></span>
                </div>
                <div class="my-listing-body">
                    <h2><c:out value="${item.title}"/></h2>
                    <div class="my-listing-meta">
                        <span><i data-lucide="calendar-days" aria-hidden="true"></i><c:out value="${item.year_of_production}"/> r.</span>
                        <span><i data-lucide="road" aria-hidden="true"></i><fmt:formatNumber value="${item.mileage}" groupingUsed="true"/> km</span>
                        <span><i data-lucide="gauge" aria-hidden="true"></i><c:out value="${item.power}"/> KM</span>
                        <c:if test="${not empty item.fuelType}">
                            <span><i data-lucide="fuel" aria-hidden="true"></i><c:out value="${item.fuelType}"/></span>
                        </c:if>
                    </div>
                    <div class="my-listing-footer">
                        <div>
                            <span class="listing-price"><fmt:formatNumber value="${item.price}" groupingUsed="true"/> zł</span>
                            <c:if test="${not empty item.updatedAt}">
                                <small class="my-listing-updated">Aktualizowano: <c:out value="${item.updatedAt}"/></small>
                            </c:if>
                        </div>
                        <div class="my-listing-actions">
                            <a href="<c:url value="/advertising/details/${item.id}"/>"
                               class="btn btn-sm btn-outline-secondary">Szczegóły</a>
                            <a href="<c:url value="/user/advertising/update/${item.id}"/>"
                               class="btn btn-sm btn-outline-secondary">Edytuj</a>
                            <a href="<c:url value="/user/advertising/remove/${item.id}"/>"
                               class="btn btn-sm btn-outline-danger">Usuń</a>
                        </div>
                    </div>
                </div>
            </article>
        </c:forEach>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>
