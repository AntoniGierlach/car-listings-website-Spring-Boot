<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="fragments/header.jsp"/>

<style>
    .compare-table {
        overflow: hidden;
        border: 1px solid var(--line);
        border-radius: 16px;
        background: var(--surface);
    }

    .compare-table table {
        min-width: 720px;
        margin-bottom: 0;
    }

    .compare-table th,
    .compare-table td {
        border-color: var(--line);
        vertical-align: middle;
    }

    .compare-table thead th {
        min-width: 170px;
        color: var(--navy);
        background: #f7f9fb;
        text-align: center;
    }

    .compare-table thead th:first-child {
        min-width: 130px;
        text-align: left;
    }

    .compare-photo {
        display: block;
        width: 220px;
        height: 138px;
        margin: 0 auto 12px;
        overflow: hidden;
        border-radius: 10px;
        background: #dce1e2;
    }

    .compare-photo-wrap {
        position: relative;
        width: 220px;
        margin: 0 auto 12px;
    }

    .compare-photo img {
        display: block;
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .compare-remove {
        position: absolute;
        z-index: 1;
        top: 8px;
        right: 8px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 34px;
        height: 34px;
        padding: 0;
        color: var(--ink);
        border-color: rgba(255, 255, 255, .9);
        background: rgba(255, 255, 255, .92);
    }

    .compare-remove:hover,
    .compare-remove:focus-visible {
        color: var(--orange);
        border-color: var(--orange);
        background: #fff;
    }

    .compare-title {
        display: block;
        color: var(--navy);
        font-weight: 800;
    }

    .compare-different {
        color: #16803c !important;
        font-weight: 800;
    }

    .compare-label {
        color: var(--muted);
        font-weight: 700;
    }
</style>

<div class="listing-intro">
    <div><p class="eyebrow">ApexWheels / porównywarka</p><h1>Porównaj wybrane <em>samochody.</em></h1></div>
    <p class="listing-note">Wybierz maksymalnie cztery oferty. Różnice między parametrami są zaznaczone.</p>
</div>

<div id="compare-empty" class="empty-state d-none">
    <p class="eyebrow">Brak samochodów</p>
    <h2>Dodaj oferty do porównania z listy ogłoszeń.</h2>
    <a class="btn-apex" href="<c:url value="/advertising"/>">Przeglądaj ogłoszenia</a>
</div>

<div class="table-responsive compare-table" id="compare-table-wrap">
    <table class="table align-middle">
        <thead>
        <tr>
            <th>Parametr</th>
            <c:forEach items="${items}" var="item">
                <th class="compare-column d-none" data-listing-id="${item.id}">
                    <div class="compare-photo-wrap">
                        <a class="compare-photo" href="<c:url value="/advertising/details/${item.id}"/>"
                           aria-label="Zobacz ogłoszenie: <c:out value="${item.title}"/>">
                            <c:if test="${not empty item.image}">
                                <c:url var="imageUrl" value="/images/thumbs/${item.image}"/>
                                <img src="<c:out value="${imageUrl}"/>" alt="<c:out value="${item.title}"/>"
                                     loading="lazy" decoding="async" width="800" height="500">
                            </c:if>
                            <c:if test="${empty item.image}"><span class="no-image">Brak zdjęcia</span></c:if>
                        </a>
                        <button type="button" class="btn btn-sm btn-outline-secondary compare-remove js-compare"
                                data-listing-id="${item.id}" 
                                >
                            <i data-lucide="trash-2" aria-hidden="true"></i>
                        </button>
                    </div>
                    <span class="compare-title"><c:out value="${item.title}"/></span>
                </th>
            </c:forEach>
        </tr>
        </thead>
        <tbody>
        <tr class="compare-row" data-compare-row>
            <th class="compare-label">Cena</th>
            <c:forEach items="${items}" var="item"><td class="compare-column d-none" data-listing-id="${item.id}" data-value="${item.price}"><fmt:formatNumber value="${item.price}" groupingUsed="true"/> zł</td></c:forEach>
        </tr>
        <tr class="compare-row" data-compare-row>
            <th class="compare-label">Rok</th>
            <c:forEach items="${items}" var="item"><td class="compare-column d-none" data-listing-id="${item.id}" data-value="${item.year_of_production}"><c:out value="${item.year_of_production}"/></td></c:forEach>
        </tr>
        <tr class="compare-row" data-compare-row>
            <th class="compare-label">Przebieg</th>
            <c:forEach items="${items}" var="item"><td class="compare-column d-none" data-listing-id="${item.id}" data-value="${item.mileage}"><fmt:formatNumber value="${item.mileage}" groupingUsed="true"/> km</td></c:forEach>
        </tr>
        <tr class="compare-row" data-compare-row>
            <th class="compare-label">Marka</th>
            <c:forEach items="${items}" var="item"><td class="compare-column d-none" data-listing-id="${item.id}" data-value="<c:out value="${item.brand.name}"/>"><c:out value="${item.brand.name}"/></td></c:forEach>
        </tr>
        <tr class="compare-row" data-compare-row>
            <th class="compare-label">Kategoria</th>
            <c:forEach items="${items}" var="item"><td class="compare-column d-none" data-listing-id="${item.id}" data-value="<c:out value="${item.category.name}"/>"><c:out value="${item.category.name}"/></td></c:forEach>
        </tr>
        </tbody>
    </table>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        function renderCompare() {
            const columns = Array.from(document.querySelectorAll(".compare-column"));
            const renderedIds = new Set(columns.map(function (cell) { return String(cell.dataset.listingId); }));
            let storedIds = [];
            try {
                storedIds = JSON.parse(localStorage.getItem("apexwheels.compare") || "[]");
            } catch (error) {
                storedIds = [];
            }
            const ids = storedIds.map(String).filter(function (id, index, values) {
                return renderedIds.has(id) && values.indexOf(id) === index;
            });
            localStorage.setItem("apexwheels.compare", JSON.stringify(ids));
            columns.forEach(function (cell) {
                cell.classList.toggle("d-none", !ids.includes(String(cell.dataset.listingId)));
            });

            document.querySelectorAll("[data-compare-row]").forEach(function (row) {
                const visibleCells = Array.from(row.querySelectorAll("td:not(.d-none)"));
                const values = new Set(visibleCells.map(function (cell) { return cell.dataset.value || cell.textContent.trim(); }));
                visibleCells.forEach(function (cell) {
                    cell.classList.toggle("compare-different", values.size > 1);
                });
            });

            document.getElementById("compare-empty").classList.toggle("d-none", ids.length > 0);
            document.getElementById("compare-table-wrap").classList.toggle("d-none", ids.length === 0);
        }

        renderCompare();
        document.addEventListener("apexwheels:saved-listings-changed", renderCompare);
    });
</script>

<jsp:include page="fragments/footer.jsp"/>
