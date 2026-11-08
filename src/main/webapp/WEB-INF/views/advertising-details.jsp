<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="fragments/header.jsp"/>

<style>
    .details-page {
        display: grid;
        gap: 24px;
    }

    .details-header {
        display: flex;
        align-items: flex-end;
        justify-content: space-between;
        gap: 24px;
        padding-bottom: 22px;
        border-bottom: 1px solid var(--line);
    }

    .details-title {
        margin: 0;
        color: var(--navy);
        font-size: clamp(2rem, 4vw, 3.2rem);
        line-height: 1.05;
        letter-spacing: -.06em;
    }

    .details-id {
        margin: 0 0 10px;
        color: var(--orange);
        font-size: .72rem;
        font-weight: 700;
        letter-spacing: .16em;
        text-transform: uppercase;
    }

    .details-actions {
        display: flex;
        flex-wrap: wrap;
        justify-content: flex-end;
        gap: 8px;
    }

    .details-actions .btn,
    .details-contact .btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 7px;
        min-height: 42px;
        border-radius: 8px;
        font-size: .82rem;
        font-weight: 700;
    }

    .details-main {
        display: grid;
        grid-template-columns: minmax(0, 1.08fr) minmax(360px, .92fr);
        gap: 24px;
        align-items: start;
    }

    .details-panel {
        border: 1px solid var(--line);
        border-radius: 14px;
        background: var(--surface);
        box-shadow: 0 8px 24px rgba(16, 42, 67, .05);
    }

    .details-media {
        overflow: hidden;
        padding: 10px;
    }

    .details-image {
        display: block;
        width: 100%;
        aspect-ratio: 16 / 10;
        max-height: 480px;
        border-radius: 9px;
        object-fit: cover;
        object-position: center;
        background: #dce1e2;
    }

    .details-empty-image {
        display: grid;
        place-items: center;
        color: var(--muted);
        font-size: 2rem;
    }

    .details-description {
        margin: 0;
        padding: 20px 22px 22px;
        color: var(--muted);
        font-size: .92rem;
        line-height: 1.7;
        white-space: pre-line;
    }

    .details-side {
        display: grid;
        gap: 16px;
    }

    .details-price-card {
        padding: 22px;
        background: var(--navy);
        color: #fff;
    }

    .details-price-label {
        margin: 0 0 6px;
        color: rgba(255,255,255,.66);
        font-size: .76rem;
    }

    .details-price {
        margin: 0;
        font-family: "Manrope", sans-serif;
        font-size: clamp(1.7rem, 3vw, 2.35rem);
        font-weight: 800;
        letter-spacing: -.05em;
    }

    .details-specs {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 1px;
        overflow: hidden;
        border: 1px solid var(--line);
        border-radius: 14px;
        background: var(--line);
    }

    .details-spec {
        display: grid;
        grid-template-columns: 28px minmax(0, 1fr);
        gap: 10px;
        min-width: 0;
        padding: 15px;
        background: var(--surface);
    }

    .details-spec svg {
        width: 18px;
        height: 18px;
        margin-top: 2px;
        color: var(--orange);
    }

    .details-spec-value {
        overflow: hidden;
        color: var(--navy);
        font-family: "Manrope", sans-serif;
        font-size: .9rem;
        font-weight: 800;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .details-spec-label {
        margin: 3px 0 0;
        color: var(--muted);
        font-size: .72rem;
        line-height: 1.3;
    }

    .details-contact {
        padding: 20px 22px;
    }

    .details-contact h2 {
        margin: 0 0 8px;
        color: var(--navy);
        font-size: 1.1rem;
    }

    .details-contact p {
        margin: 0 0 16px;
        color: var(--muted);
        font-size: .82rem;
        line-height: 1.55;
    }

    .details-contact-actions {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
    }

    @media (max-width: 850px) {
        .details-main { grid-template-columns: 1fr; }
        .details-side { grid-template-columns: repeat(2, minmax(0, 1fr)); }
        .details-price-card,
        .details-contact { grid-column: 1 / -1; }
    }

    @media (max-width: 620px) {
        .details-header {
            display: block;
        }
        .details-actions {
            justify-content: flex-start;
            margin-top: 18px;
        }
        .details-side { grid-template-columns: 1fr; }
        .details-spec { padding: 13px; }
    }
</style>

<div class="page-container details-page">
    <header class="details-header">
        <div>
            <p class="details-id">ApexWheels / ogłoszenie #<c:out value="${item.id}"/></p>
            <h1 class="details-title"><c:out value="${item.title}"/></h1>
        </div>
        <div class="details-actions">
            <a href="<c:url value="/advertising"/>" class="btn btn-outline-secondary" data-history-back>
                <i data-lucide="chevron-left" aria-hidden="true"></i> Wróć
            </a>
            <c:choose>
                <c:when test="${pageContext.request.isUserInRole('USER') || pageContext.request.isUserInRole('ADMIN')}">
                    <form action="<c:url value="/user/favorites/${item.id}"/>" method="post" class="d-inline">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <button type="submit" class="btn btn-outline-secondary js-favorite"
                                data-listing-id="${item.id}" aria-label="Dodaj do ulubionych">
                            <i data-lucide="heart" aria-hidden="true"></i> Ulubione
                        </button>
                    </form>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value="/login"/>" class="btn btn-outline-secondary">Zaloguj, aby zapisać</a>
                </c:otherwise>
            </c:choose>
            <button type="button" class="btn btn-outline-secondary js-compare" data-listing-id="${item.id}">
                <i data-lucide="arrow-left-right" aria-hidden="true"></i> Porównaj
            </button>
        </div>
    </header>

    <div class="details-main">
        <section class="details-panel details-media" aria-label="Zdjęcie i opis ogłoszenia">
            <c:if test="${not empty item.image}">
                <c:url var="imageUrl" value="/images/optimized/${item.image}"/>
                <img src="<c:out value="${imageUrl}"/>" class="details-image"
                     alt="<c:out value="${item.title}"/>" loading="lazy" decoding="async">
            </c:if>
            <c:if test="${empty item.image}">
                <div class="details-image details-empty-image" role="img" aria-label="Brak zdjęcia">
                    <i data-lucide="image-off" aria-hidden="true"></i>
                </div>
            </c:if>
            <p class="details-description"><c:out value="${item.description}"/></p>
        </section>

        <aside class="details-side" aria-label="Informacje o pojeździe">
            <section class="details-panel details-price-card">
                <p class="details-price-label">Cena ogłoszenia</p>
                <p class="details-price"><fmt:formatNumber value="${item.price}" groupingUsed="true"/> zł</p>
            </section>

            <section class="details-specs" aria-label="Parametry samochodu">
                <div class="details-spec"><i data-lucide="car-front" aria-hidden="true"></i><div><div class="details-spec-value"><c:out value="${item.brand.name}"/></div><p class="details-spec-label">Marka</p></div></div>
                <div class="details-spec"><i data-lucide="layers" aria-hidden="true"></i><div><div class="details-spec-value"><c:out value="${item.category.name}"/></div><p class="details-spec-label">Kategoria</p></div></div>
                <div class="details-spec"><i data-lucide="calendar-days" aria-hidden="true"></i><div><div class="details-spec-value"><c:out value="${item.year_of_production}"/> r.</div><p class="details-spec-label">Rok produkcji</p></div></div>
                <div class="details-spec"><i data-lucide="road" aria-hidden="true"></i><div><div class="details-spec-value"><fmt:formatNumber value="${item.mileage}" groupingUsed="true"/> km</div><p class="details-spec-label">Przebieg</p></div></div>
                <div class="details-spec"><i data-lucide="gauge" aria-hidden="true"></i><div><div class="details-spec-value"><c:out value="${item.power}"/> KM</div><p class="details-spec-label">Moc silnika</p></div></div>
                <div class="details-spec"><i data-lucide="fuel" aria-hidden="true"></i><div><div class="details-spec-value"><c:out value="${item.fuelType}"/></div><p class="details-spec-label">Rodzaj paliwa</p></div></div>
                <div class="details-spec"><i data-lucide="car-front" aria-hidden="true"></i><div><div class="details-spec-value"><c:out value="${item.vehicleCondition}"/></div><p class="details-spec-label">Stan pojazdu</p></div></div>
                <div class="details-spec"><i data-lucide="triangle-alert" aria-hidden="true"></i><div><div class="details-spec-value"><c:out value="${item.damageStatus}"/></div><p class="details-spec-label">Stan uszkodzeń</p></div></div>
                <div class="details-spec"><i data-lucide="phone" aria-hidden="true"></i><div><div class="details-spec-value"><c:out value="${item.phone_number}"/></div><p class="details-spec-label">Telefon sprzedającego</p></div></div>
            </section>

            <section class="details-panel details-contact">
                <h2>Kontakt ze sprzedającym</h2>
                <p>Przed zakupem umów oględziny, sprawdź dokumenty i nie wysyłaj zaliczki bez weryfikacji pojazdu.</p>
                <div class="details-contact-actions">
                    <a class="btn btn-apex" href="tel:<c:out value="${item.phone_number}"/>"><i data-lucide="phone" aria-hidden="true"></i> Zadzwoń</a>
                    <a class="btn btn-outline-secondary" href="<c:url value="/contact"/>">Zgłoś problem</a>
                </div>
            </section>
        </aside>
    </div>
</div>

<script>
    document.querySelectorAll("[data-history-back]").forEach(link => {
        link.addEventListener("click", event => {
            if (window.history.length > 1) {
                event.preventDefault();
                window.history.back();
            }
        });
    });
</script>

<jsp:include page="fragments/footer.jsp"/>
