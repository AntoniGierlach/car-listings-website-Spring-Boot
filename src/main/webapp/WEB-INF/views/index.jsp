<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="fragments/header.jsp"/>

<style>
    .eyebrow {
        margin: 0 0 12px;
        color: var(--orange);
        font-size: .72rem;
        font-weight: 700;
        letter-spacing: .16em;
        text-transform: uppercase;
    }
    .listing-intro {
        display: flex;
        align-items: flex-end;
        justify-content: space-between;
        gap: 24px;
        margin-bottom: 32px;
    }
    .listing-intro h1 {
        max-width: 680px;
        margin: 0;
        color: var(--navy);
        font-size: clamp(2.15rem, 4vw, 3.8rem);
        line-height: 1.06;
        letter-spacing: -.06em;
    }
    .listing-intro h1 em { color: var(--orange); font-style: normal; }
    .listing-note { max-width: 280px; margin: 0; color: var(--muted); font-size: .9rem; line-height: 1.6; }
    .listing-toolbar {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 16px;
        padding: 14px 0;
        margin-bottom: 22px;
        border-top: 1px solid var(--line);
        border-bottom: 1px solid var(--line);
    }
    .result-count { color: var(--muted); font-size: .8rem; }
    .result-count strong { color: var(--ink); }
    .sort-wrap { display: flex; align-items: center; gap: 10px; }
    .sort-wrap label { color: var(--muted); font-size: .76rem; }
    .sort-select {
        min-width: 165px;
        padding: 8px 30px 8px 10px;
        border: 1px solid var(--line);
        border-radius: 7px;
        background: var(--surface);
        color: var(--ink);
        font: inherit;
        font-size: .78rem;
    }
    .sort-links { display: none; }
    .listing-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(245px, 1fr)); gap: 20px; }
    .listing-card {
        position: relative;
        min-width: 0;
        overflow: hidden;
        border: 1px solid var(--line);
        border-radius: 12px;
        background: var(--surface);
        box-shadow: 0 4px 16px rgba(16, 42, 67, .03);
        transition: transform .24s ease, box-shadow .24s ease;
    }
    .listing-card:hover { transform: translateY(-4px); box-shadow: var(--shadow); }
    .listing-image {
        position: relative;
        width: 100%;
        height: 190px;
        overflow: hidden;
        background: #dce1e2;
    }
    .listing-image img {
        display: block;
        width: 100%;
        height: 100%;
        object-fit: cover;
        object-position: center;
        transition: transform .5s ease;
    }
    .listing-card:hover .listing-image img { transform: scale(1.04); }
    .listing-card-link {
        position: absolute;
        z-index: 0;
        inset: 0;
        border-radius: inherit;
    }
    .listing-card-link:focus-visible {
        outline: 3px solid var(--orange);
        outline-offset: -3px;
    }
    .listing-card > .listing-image,
    .listing-card > .listing-body {
        position: relative;
        z-index: 1;
    }
    .listing-card .listing-body form,
    .listing-card .listing-body button,
    .listing-card .listing-body a:not(.listing-card-link) {
        position: relative;
        z-index: 2;
    }
    .no-image {
        width: 100%; height: 100%; display: grid; place-items: center;
        color: #78838a; font-size: .8rem; letter-spacing: .05em; text-transform: uppercase;
        background: linear-gradient(135deg, #dce1e2, #c8d0d1);
    }
    .listing-tag {
        position: absolute; top: 12px; left: 12px; padding: 5px 8px;
        border-radius: 5px; background: rgba(255,255,255,.92); color: var(--navy);
        font-size: .68rem; font-weight: 700;
    }
    .listing-body { padding: 17px 17px 15px; }
    .listing-body h2 { margin: 0 0 6px; color: var(--navy); font-size: 1.1rem; letter-spacing: -.035em; }
    .listing-meta { display: flex; gap: 8px; flex-wrap: wrap; margin-bottom: 17px; color: var(--muted); font-size: .78rem; }
    .listing-meta span + span::before { content: "·"; padding-right: 8px; color: #b6bec2; }
    .listing-footer { display: flex; align-items: center; justify-content: space-between; gap: 12px; padding-top: 13px; border-top: 1px solid var(--line); }
    .listing-price { color: var(--ink); font-family: "Manrope", sans-serif; font-size: 1.02rem; font-weight: 800; white-space: nowrap; }
    .listing-link { color: var(--orange); font-size: .78rem; font-weight: 700; text-decoration: none; }
    .listing-link:hover { color: var(--navy); }
    .empty-state { padding: 72px 24px; text-align: center; border: 1px dashed #cbd2d4; border-radius: 12px; background: #fff; }
    .empty-state h2 { color: var(--navy); font-size: 1.4rem; }
    .empty-state p { color: var(--muted); }
    @media (max-width: 650px) {
        .listing-intro { display: block; margin-bottom: 24px; }
        .listing-note { margin-top: 15px; }
        .listing-toolbar { align-items: flex-start; flex-direction: column; }
        .sort-wrap { width: 100%; justify-content: space-between; }
        .sort-select { flex: 1; }
    }
</style>

<div class="listing-intro">
    <div>
        <p class="eyebrow">ApexWheels / kolekcja</p>
        <h1>Samochód, który<br><em>pasuje do Ciebie.</em></h1>
    </div>

    <p class="listing-note">Wyselekcjonowane ogłoszenia. Przejrzyste dane. Bez zbędnego szumu — tylko dobre samochody.</p>
</div>

<div class="listing-toolbar">
    <span class="result-count"><strong><c:out value="${items.size()}"/></strong> dostępnych ogłoszeń</span>
    <div class="sort-wrap">
        <label for="sort-links">Sortuj:</label>
        <select id="sort-links" class="sort-select" onchange="applySort(this.value)">
            <option value="date" ${empty param.sort || param.sort == 'date' ? 'selected' : ''}>Najnowsze</option>
            <option value="price-asc" ${param.sort == 'price-asc' ? 'selected' : ''}>Cena: rosnąco</option>
            <option value="price-desc" ${param.sort == 'price-desc' ? 'selected' : ''}>Cena: malejąco</option>
            <option value="mileage-asc" ${param.sort == 'mileage-asc' ? 'selected' : ''}>Najniższy przebieg</option>
            <option value="mileage-desc" ${param.sort == 'mileage-desc' ? 'selected' : ''}>Najwyższy przebieg</option>
        </select>
    </div>
</div>

<script>
    function applySort(sort) {
        const params = new URLSearchParams(window.location.search);
        params.set("sort", sort);
        window.location.href = "<c:url value="/advertising/search"/>" + "?" + params.toString();
    }
</script>

<c:choose>
    <c:when test="${not empty items}">
        <div class="listing-grid">
            <c:forEach items="${items}" var="item">
                <article class="listing-card">
                    <a class="listing-card-link"
                       href="<c:url value="/advertising/details/${item.id}"/>"
                       aria-label="Zobacz ogłoszenie: <c:out value="${item.title}"/>"></a>
                    <div class="listing-image">
                        <c:if test="${not empty item.image}">
                            <c:url var="imageUrl" value="/images/thumbs/${item.image}"/>
                            <img src="<c:out value="${imageUrl}"/>" alt="<c:out value="${item.title}"/>" loading="lazy" decoding="async" width="800" height="500">
                        </c:if>
                        <c:if test="${empty item.image}">
                            <div class="no-image">Brak zdjęcia</div>
                        </c:if>
                        <span class="listing-tag"><c:out value="${item.brand.name}"/></span>
                    </div>
                    <div class="listing-body">
                        <h2><c:out value="${item.title}"/></h2>
                        <div class="listing-meta">
                            <span><c:out value="${item.year_of_production}"/> r.</span>
                            <span><fmt:formatNumber value="${item.mileage}" groupingUsed="true"/> km</span>
                            <c:if test="${not empty item.fuelType}"><span><c:out value="${item.fuelType}"/></span></c:if>
                        </div>
                        <div class="listing-footer">
                            <span class="listing-price"><fmt:formatNumber value="${item.price}" groupingUsed="true"/> zł</span>
                            <div class="d-flex align-items-center gap-2">
                                <c:choose>
                                    <c:when test="${pageContext.request.isUserInRole('USER') || pageContext.request.isUserInRole('ADMIN')}">
                                        <form action="<c:url value="/user/favorites/${item.id}"/>" method="post" class="d-inline">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                            <button type="submit" class="btn btn-sm btn-outline-secondary js-favorite"
                                                    data-listing-id="${item.id}" aria-label="Dodaj do ulubionych">
                                                <i data-lucide="heart" aria-hidden="true"></i>
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise><a href="<c:url value="/login"/>" class="btn btn-sm btn-outline-secondary" aria-label="Zaloguj się, aby zapisać"><i data-lucide="heart" aria-hidden="true"></i></a></c:otherwise>
                                </c:choose>
                                <button type="button" class="btn btn-sm btn-outline-secondary js-compare"
                                        data-listing-id="${item.id}" aria-label="Dodaj do porównania"><i data-lucide="arrow-left-right" aria-hidden="true"></i></button>
                            </div>
                        </div>
                    </div>
                </article>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <div class="empty-state">
            <p class="eyebrow">Brak wyników</p>
            <h2>Nie znaleźliśmy ofert dla tych filtrów.</h2>
            <p>Spróbuj zmienić zakres ceny, przebiegu albo wybrać inną kategorię.</p>
            <a href="<c:url value="/"/>" class="btn-apex">Wyczyść filtry</a>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="fragments/footer.jsp"/>
