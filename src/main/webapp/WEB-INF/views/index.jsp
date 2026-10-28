<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        height: 190px;
        overflow: hidden;
        background: #dce1e2;
    }
    .listing-image img { width: 100%; height: 100%; object-fit: cover; transition: transform .5s ease; }
    .listing-card:hover .listing-image img { transform: scale(1.04); }
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
        <select id="sort-links" class="sort-select" onchange="if(this.value) window.location.href=this.value">
            <option value="/advertising/sort/date">Najnowsze</option>
            <option value="/advertising/sort/priceMin">Cena: rosnąco</option>
            <option value="/advertising/sort/priceMax">Cena: malejąco</option>
            <option value="/advertising/sort/mileageMin">Najniższy przebieg</option>
            <option value="/advertising/sort/mileageMax">Najwyższy przebieg</option>
        </select>
    </div>
</div>

<c:choose>
    <c:when test="${not empty items}">
        <div class="listing-grid">
            <c:forEach items="${items}" var="item">
                <article class="listing-card">
                    <div class="listing-image">
                        <c:if test="${not empty item.image}">
                            <c:url var="imageUrl" value="/images/${item.image}"/>
                            <img src="<c:out value="${imageUrl}"/>" alt="<c:out value="${item.title}"/>">
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
                            <span><c:out value="${item.mileage}"/> km</span>
                        </div>
                        <div class="listing-footer">
                            <span class="listing-price"><c:out value="${item.price}"/> zł</span>
                            <a class="listing-link" href="<c:url value="/advertising/details/${item.id}"/>">Zobacz szczegóły&nbsp; →</a>
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
