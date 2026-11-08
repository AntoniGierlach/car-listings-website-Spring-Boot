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
    .listing-note { max-width: 350px; margin: 0; color: var(--muted); font-size: .9rem; line-height: 1.6; }
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
    .listing-layout-toggle {
        display: inline-flex;
        align-items: center;
        gap: 4px;
        padding: 3px;
        border: 1px solid var(--line);
        border-radius: 8px;
        background: var(--surface);
    }
    .listing-layout-toggle button {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 36px;
        height: 36px;
        padding: 0;
        border: 0;
        border-radius: 6px;
        background: transparent;
        color: var(--muted);
        cursor: pointer;
    }
    .listing-layout-toggle button:hover,
    .listing-layout-toggle button:focus-visible,
    .listing-layout-toggle button.is-active {
        background: var(--orange-soft);
        color: var(--navy);
    }
    .listing-layout-toggle svg { width: 16px; height: 16px; }
    .sort-select {
        position: relative;
        min-width: 165px;
        min-height: 46px;
        padding: 0;
        border: 1px solid var(--line);
        border-radius: 8px;
        background-color: var(--surface);
        color: var(--ink);
        background-image: none;
        transition: border-color .2s ease, box-shadow .2s ease;
    }
    .sort-select.is-open,
    .sort-select:focus-within {
        border-color: var(--orange);
        box-shadow: 0 0 0 3px rgba(226,125,69,.15);
    }
    .sort-select-toggle {
        display: flex;
        align-items: center;
        justify-content: space-between;
        width: 100%;
        min-height: 44px;
        padding: 10px 12px;
        border: 0;
        border-radius: inherit;
        background: transparent;
        color: var(--ink);
        font: inherit;
        font-size: .78rem;
        text-align: left;
        cursor: pointer;
    }
    .sort-select-toggle svg {
        width: 16px;
        height: 16px;
        color: var(--muted);
        transition: transform .2s ease;
    }
    .sort-select.is-open .sort-select-toggle svg {
        transform: rotate(180deg);
    }
    .sort-select-options {
        position: absolute;
        top: calc(100% + 4px);
        right: -1px;
        left: -1px;
        z-index: 30;
        display: none;
        padding: 4px;
        border: 1px solid var(--line);
        border-radius: 8px;
        background: var(--surface);
        box-shadow: 0 10px 24px rgba(16, 42, 67, .14);
    }
    .sort-select.is-open .sort-select-options {
        display: block;
    }
    .sort-select-option {
        display: block;
        width: 100%;
        padding: 9px 10px;
        border: 0;
        border-radius: 5px;
        background: transparent;
        color: var(--ink);
        font: inherit;
        font-size: .78rem;
        text-align: left;
        cursor: pointer;
    }
    .sort-select-option:hover,
    .sort-select-option:focus-visible,
    .sort-select-option.is-selected {
        background: var(--orange-soft);
        color: var(--navy);
        outline: 0;
    }
    .sort-select-option.is-selected {
        font-weight: 700;
    }
    .sort-links { display: none; }
    .listing-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(245px, 1fr)); gap: 20px; }
    .listing-grid--list {
        grid-template-columns: 1fr;
        gap: 14px;
    }
    .listing-grid--list .listing-card {
        display: grid;
        grid-template-columns: 322px minmax(0, 1fr);
        min-height: 190px;
    }
    .listing-grid--list .listing-image {
        height: 100%;
        min-height: 190px;
    }
    .listing-grid--list .listing-body {
        display: flex;
        min-width: 0;
        flex-direction: column;
        padding: 17px 17px 15px;
    }
    .listing-grid--list .listing-footer {
        margin-top: auto;
    }
    .listing-list-details {
        display: none;
        margin: 2px 0 16px;
        color: #78838a;
        font-size: .75rem;
        line-height: 1.5;
    }
    .listing-grid--list .listing-list-details {
        display: block;
    }
    .listing-list-facts {
        display: flex;
        flex-wrap: wrap;
        gap: 5px 16px;
        margin-bottom: 8px;
    }
    .listing-list-fact strong {
        color: #66737b;
        font-weight: 600;
    }
    .listing-list-description {
        display: -webkit-box;
        overflow: hidden;
        margin: 0;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 2;
        line-clamp: 2;
        font-size: .78rem;
    }
    .listing-card {
        position: relative;
        min-width: 0;
        overflow: hidden;
        border: 1px solid var(--line);
        border-radius: 12px;
        background: var(--surface);
        cursor: pointer;
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
        z-index: 1;
        inset: 0;
        pointer-events: none;
        border-radius: inherit;
    }
    .listing-card-link:focus-visible {
        outline: 3px solid var(--orange);
        outline-offset: -3px;
    }
    .listing-card > .listing-image,
    .listing-card > .listing-body {
        position: relative;
        z-index: 0;
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
    .listing-body { padding: 10px 10px 15px; }
    .listing-body h2 { margin: 0 0 6px; color: var(--navy); font-size: 1.1rem; letter-spacing: -.035em; }
    .listing-meta {
        display: grid;
        grid-auto-flow: column;
        gap: 8px 10px;
        justify-items: center;
        margin-bottom: 8px;
        color: var(--muted);
        font-size: .78rem;
    }
    .listing-meta span {
        display: inline-flex;
        min-width: 0;
        align-items: center;
        justify-content: center;
        gap: 5px;
        width: 100%;
        overflow: hidden;
        white-space: nowrap;
    }
    .listing-meta span > :last-child {
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .listing-meta svg { width: 16px; height: 16px; color: #8b969c; }
    .listing-grid--list .listing-meta {
        display: flex;
        justify-items: initial;
        gap: 8px;
        margin-bottom: 5px;
    }
    .listing-grid--list .listing-meta span {
        justify-content: initial;
        width: auto;
        overflow: visible;
    }
    .listing-grid--list .listing-meta span > :last-child {
        overflow: visible;
        text-overflow: clip;
    }
    .listing-meta-conditions {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
        margin-bottom: 10px;
        color: var(--muted);
        font-size: .70rem;
    }
    .listing-footer { display: flex; align-items: center; justify-content: space-between; gap: 12px; padding-top: 13px; border-top: 1px solid var(--line); }
    .listing-price { color: var(--ink); font-family: "Manrope", sans-serif; font-size: 1.02rem; font-weight: 800; white-space: nowrap; }
    .listing-link { color: var(--orange); font-size: .78rem; font-weight: 700; text-decoration: none; }
    .listing-link:hover { color: var(--navy); }
    .empty-state { padding: 72px 24px; text-align: center; border: 1px dashed var(--orange); border-radius: 12px; background: #fff;}
    .empty-state h2 { color: var(--navy); font-size: 1.4rem; }
    .empty-state p { color: var(--muted); }
    @media (max-width: 650px) {
        .listing-intro { display: block; margin-bottom: 24px; }
        .listing-note { margin-top: 15px; }
        .listing-toolbar { align-items: flex-start; flex-direction: column; }
        .sort-wrap { width: 100%; justify-content: space-between; }
        .sort-select { flex: 1; }
        .listing-layout-toggle button { width: 34px; }
    }
    @media (max-width: 560px) {
        .listing-grid--list .listing-card {
            display: block;
        }
        .listing-grid--list .listing-image {
            height: 190px;
        }
    }
</style>

<div class="listing-intro">
    <div>
        <p class="eyebrow">ApexWheels / kolekcja</p>
        <h1>Samochód, który<br><em>pasuje do Ciebie.</em></h1>
    </div>

    <p class="listing-note">Pomagamy znaleźć samochód bez niepotrzebnego chaosu. Przejrzyste ogłoszenia, konkretne informacje i oferty warte uwagi.</p>
</div>

<div class="listing-toolbar">
    <span class="result-count"><strong><c:out value="${items.size()}"/></strong> dostępnych ogłoszeń</span>
    <div class="sort-wrap">
        <label for="sort-links-toggle">Sortuj:</label>
        <div id="sort-links" class="sort-select" data-sort-select>
            <button type="button" id="sort-links-toggle" class="sort-select-toggle" aria-haspopup="listbox"
                    aria-expanded="false" aria-controls="sort-options">
                <span data-sort-label>
                    <c:choose>
                        <c:when test="${param.sort == 'price-asc'}">Cena: rosnąco</c:when>
                        <c:when test="${param.sort == 'price-desc'}">Cena: malejąco</c:when>
                        <c:when test="${param.sort == 'mileage-asc'}">Najniższy przebieg</c:when>
                        <c:when test="${param.sort == 'mileage-desc'}">Najwyższy przebieg</c:when>
                        <c:otherwise>Najnowsze</c:otherwise>
                    </c:choose>
                </span>
                <i data-lucide="chevron-down" aria-hidden="true"></i>
            </button>
            <div id="sort-options" class="sort-select-options" role="listbox" aria-label="Sortowanie ogłoszeń">
                <button type="button" class="sort-select-option ${empty param.sort || param.sort == 'date' ? 'is-selected' : ''}"
                        role="option" data-sort-value="date"
                        aria-selected="${empty param.sort || param.sort == 'date'}">Najnowsze</button>
                <button type="button" class="sort-select-option ${param.sort == 'price-asc' ? 'is-selected' : ''}"
                        role="option" data-sort-value="price-asc"
                        aria-selected="${param.sort == 'price-asc'}">Cena: rosnąco</button>
                <button type="button" class="sort-select-option ${param.sort == 'price-desc' ? 'is-selected' : ''}"
                        role="option" data-sort-value="price-desc"
                        aria-selected="${param.sort == 'price-desc'}">Cena: malejąco</button>
                <button type="button" class="sort-select-option ${param.sort == 'mileage-asc' ? 'is-selected' : ''}"
                        role="option" data-sort-value="mileage-asc"
                        aria-selected="${param.sort == 'mileage-asc'}">Najniższy przebieg</button>
                <button type="button" class="sort-select-option ${param.sort == 'mileage-desc' ? 'is-selected' : ''}"
                        role="option" data-sort-value="mileage-desc"
                        aria-selected="${param.sort == 'mileage-desc'}">Najwyższy przebieg</button>
            </div>
        </div>
        <div class="listing-layout-toggle" role="group" aria-label="Widok ogłoszeń">
            <button type="button" class="${empty param.layout || param.layout == 'grid' ? 'is-active' : ''}"
                    data-layout="grid"
                    aria-label="Widok kafelków"
                    aria-pressed="${empty param.layout || param.layout == 'grid'}">
                <i data-lucide="grid-2x2" aria-hidden="true"></i>
            </button>
            <button type="button" class="${param.layout == 'list' ? 'is-active' : ''}"
                    data-layout="list"
                    aria-label="Widok listy"
                    aria-pressed="${param.layout == 'list'}">
                <i data-lucide="list" aria-hidden="true"></i>
            </button>
        </div>
    </div>
</div>

<script>
    function applySort(sort) {
        const params = new URLSearchParams(window.location.search);
        params.set("sort", sort);
        window.location.href = '<c:url value="/advertising/search"/>' + "?" + params.toString();
    }

    (function () {
        const select = document.querySelector("[data-sort-select]");
        if (!select) return;
        const toggle = select.querySelector(".sort-select-toggle");
        const options = Array.from(select.querySelectorAll(".sort-select-option"));

        function close() {
            select.classList.remove("is-open");
            toggle.setAttribute("aria-expanded", "false");
        }

        toggle.addEventListener("click", function () {
            const isOpen = select.classList.toggle("is-open");
            toggle.setAttribute("aria-expanded", String(isOpen));
        });

        options.forEach(function (option) {
            option.addEventListener("click", function () {
                applySort(option.dataset.sortValue);
            });
        });

        document.addEventListener("click", function (event) {
            if (!select.contains(event.target)) close();
        });

        toggle.addEventListener("keydown", function (event) {
            if (event.key === "ArrowDown" || event.key === "Enter" || event.key === " ") {
                event.preventDefault();
                select.classList.add("is-open");
                toggle.setAttribute("aria-expanded", "true");
                options[0].focus();
            }
        });

        options.forEach(function (option, index) {
            option.addEventListener("keydown", function (event) {
                if (event.key === "Escape") {
                    close();
                    toggle.focus();
                } else if (event.key === "ArrowDown") {
                    event.preventDefault();
                    options[(index + 1) % options.length].focus();
                } else if (event.key === "ArrowUp") {
                    event.preventDefault();
                    options[(index - 1 + options.length) % options.length].focus();
                }
            });
        });
    }());

    (function () {
        const toggle = document.querySelector(".listing-layout-toggle");
        if (!toggle) return;
        toggle.querySelectorAll("[data-layout]").forEach(function (button) {
            button.addEventListener("click", function () {
                const params = new URLSearchParams(window.location.search);
                params.set("layout", button.dataset.layout);
                const path = window.location.pathname === '<c:url value="/advertising"/>'
                    ? window.location.pathname
                    : '<c:url value="/advertising/search"/>';
                window.location.href = path + (params.toString() ? "?" + params.toString() : "");
            });
        });
    }());
</script>

<c:choose>
    <c:when test="${not empty items}">
        <div class="listing-grid ${param.layout == 'list' ? 'listing-grid--list' : ''}">
            <c:forEach items="${items}" var="item">
                <article class="listing-card js-listing-card"
                         data-details-url="<c:url value="/advertising/details/${item.id}"/>">
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
                            <span><i data-lucide="calendar-days" aria-hidden="true"></i><c:out value="${item.year_of_production}"/> r.</span>
                            <span><i data-lucide="road" aria-hidden="true"></i><fmt:formatNumber value="${item.mileage}" groupingUsed="true"/> km</span>
                            <span><i data-lucide="gauge" aria-hidden="true"></i><c:out value="${item.power}"/> KM</span>
                            <c:if test="${not empty item.fuelType}"><span><i data-lucide="fuel" aria-hidden="true"></i><c:out value="${item.fuelType}"/></span></c:if>
                        </div>
                        <div class="listing-meta-conditions">
                            <span><c:out value="${item.vehicleCondition}"/>  |</span>
                            <span><c:out value="${item.damageStatus}"/></span>
                        </div>
                        <div class="listing-list-details">
                            <c:if test="${not empty item.description}">
                                <p class="listing-list-description"><c:out value="${item.description}"/></p>
                            </c:if>
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
            <h2>Nie znaleźliśmy ofert dla tych filtrów.</h2>
            <p>Spróbuj zmienić zakres ceny, przebiegu albo wybrać inną kategorię.</p>
            <a href="<c:url value="/"/>" class="btn-apex">Wyczyść filtry</a>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="fragments/footer.jsp"/>
