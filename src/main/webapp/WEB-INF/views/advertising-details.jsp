<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="fragments/header.jsp"/>

<style>
    .icon-link > .bi {
        margin-top: .125rem;
        margin-left: .125rem;
        fill: currentcolor;
        transition: transform .25s ease-in-out;
    }

    .icon-link:hover > .bi {
        transform: translate(.25rem);
    }

    .feature-icon-small {
        width: 3rem;
        height: 3rem;
    }

    .details-image {
        width: 100%;
        aspect-ratio: 16 / 10;
        max-height: 420px;
        object-fit: cover;
        object-position: center top;
        border-radius: 12px;
        background: #dce1e2;
    }

    .details-description {
        margin-top: 18px;
        color: #111;
        line-height: 1.65;
        white-space: pre-line;
    }
</style>

<div class="page-container">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 border-bottom pb-3">
        <div>
            <p class="eyebrow mb-2">ApexWheels / ogłoszenie #<c:out value="${item.id}"/></p>
            <h1 class="mb-0"><c:out value="${item.title}"/></h1>
        </div>
        <div class="d-flex gap-2">
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
                <c:otherwise><a href="<c:url value="/login"/>" class="btn btn-outline-secondary">Zaloguj, aby zapisać</a></c:otherwise>
            </c:choose>
            <button type="button" class="btn btn-outline-secondary js-compare" data-listing-id="${item.id}"><i data-lucide="arrow-left-right" aria-hidden="true"></i> Porównaj</button>
        </div>
    </div>

    <div class="row row-cols-1 row-cols-md-2 align-items-start g-5 py-5">
        <div>
            <c:if test="${not empty item.image}">
                <c:url var="imageUrl" value="/images/optimized/${item.image}"/>
                <img src="<c:out value="${imageUrl}"/>"
                     class="details-image"
                     alt="<c:out value="${item.title}"/>"
                     loading="lazy"
                     role="img"/>
            </c:if>
            <c:if test="${empty item.image}">
                <div class="details-image d-flex align-items-center justify-content-center" role="img" aria-label="Brak zdjęcia"><i data-lucide="image-off" class="lucide-icon" aria-hidden="true"></i></div>
            </c:if>
            <p class="details-description"><c:out value="${item.description}"/></p>
        </div>

        <div class="row row-cols-1 row-cols-sm-2 g-4">
            <div class="d-flex flex-column gap-2">
                <div
                        class="feature-icon-small d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-4 rounded-3">
                    <i data-lucide="car-front" class="lucide-icon" aria-hidden="true"></i>
                </div>
                <h5 class="fw-semibold mb-0"><c:out value="${item.brand.name}"/></h5>
                <p class="text-muted">Marka pojazdu</p>
            </div>

            <div class="d-flex flex-column gap-2">
                <div
                        class="feature-icon-small d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-4 rounded-3">
                    <i data-lucide="layers" class="lucide-icon" aria-hidden="true"></i>
                </div>
                <h5 class="fw-semibold mb-0"><c:out value="${item.category.name}"/></h5>
                <p class="text-muted">Kategoria pojazdu</p>
            </div>

            <div class="d-flex flex-column gap-2">
                <div
                        class="feature-icon-small d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-4 rounded-3">
                    <i data-lucide="circle-dollar-sign" class="lucide-icon" aria-hidden="true"></i>
                </div>
                <h5 class="fw-semibold mb-0"><fmt:formatNumber value="${item.price}" groupingUsed="true"/> zł</h5>
                <p class="text-muted">Cena</p>
            </div>

            <div class="d-flex flex-column gap-2">
                <div
                        class="feature-icon-small d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-4 rounded-3">
                    <i data-lucide="calendar-days" class="lucide-icon" aria-hidden="true"></i>
                </div>
                <h5 class="fw-semibold mb-0"><c:out value="${item.year_of_production}"/> r.</h5>
                <p class="text-muted">Rocznik wyprodukowania pojazdu</p>
            </div>

            <div class="d-flex flex-column gap-2">
                <div
                        class="feature-icon-small d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-4 rounded-3">
                    <i data-lucide="gauge" class="lucide-icon" aria-hidden="true"></i>
                </div>
                <h5 class="fw-semibold mb-0"><fmt:formatNumber value="${item.mileage}" groupingUsed="true"/> km</h5>
                <p class="text-muted">Przebieg pojazdu</p>
            </div>
            <div class="d-flex flex-column gap-2">
                <div
                        class="feature-icon-small d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-4 rounded-3">
                    <i data-lucide="fuel" class="lucide-icon" aria-hidden="true"></i>
                </div>
                <h5 class="fw-semibold mb-0"><c:out value="${item.fuelType}"/></h5>
                <p class="text-muted">Rodzaj paliwa</p>
            </div>
            <div class="d-flex flex-column gap-2">
                <div
                        class="feature-icon-small d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-4 rounded-3">
                    <i data-lucide="car-front" class="lucide-icon" aria-hidden="true"></i>
                </div>
                <h5 class="fw-semibold mb-0"><c:out value="${item.vehicleCondition}"/></h5>
                <p class="text-muted">Stan pojazdu</p>
            </div>
            <div class="d-flex flex-column gap-2">
                <div
                        class="feature-icon-small d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-4 rounded-3">
                    <i data-lucide="triangle-alert" class="lucide-icon" aria-hidden="true"></i>
                </div>
                <h5 class="fw-semibold mb-0"><c:out value="${item.damageStatus}"/></h5>
                <p class="text-muted">Stan uszkodzeń</p>
            </div>

            <div class="d-flex flex-column gap-2">
                <div
                        class="feature-icon-small d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-4 rounded-3">
                    <i data-lucide="phone" class="lucide-icon" aria-hidden="true"></i>
                </div>
                <h5 class="fw-semibold mb-0"><c:out value="${item.phone_number}"/></h5>
                <p class="text-muted">Numer telefonu właściciela</p>
            </div>
            <div class="surface-card surface-card--padded mt-4">
                <h2 class="h4">Kontakt ze sprzedającym</h2>
                <p class="text-muted">Przed zakupem umów oględziny, sprawdź dokumenty i nie wysyłaj zaliczki bez weryfikacji pojazdu.</p>
                <a class="btn btn-primary" href="tel:<c:out value="${item.phone_number}"/>">Zadzwoń: <c:out value="${item.phone_number}"/></a>
                <a class="btn btn-link" href="<c:url value="/contact"/>">Zgłoś problem z ofertą</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="fragments/footer.jsp"/>
