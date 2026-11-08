<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="fragments/header.jsp"/>
<div class="page-container">
    <p class="eyebrow">ApexWheels / o serwisie</p>
    <h1>Prościej znaleźć samochód, który naprawdę pasuje.</h1>
    <div class="row g-4 mt-2">
        <div class="col-lg-8">
            <p class="lead">ApexWheels to katalog ogłoszeń samochodowych, który porządkuje najważniejsze informacje w jednym miejscu.</p>
            <p>Możesz przeglądać oferty według marki, kategorii, ceny i przebiegu, a następnie skontaktować się bezpośrednio ze sprzedającym. Dane prezentowane w ogłoszeniu pochodzą od osoby, która je opublikowała.</p>
            <h2 class="h4 mt-4">Jak to działa?</h2>
            <ol>
                <li>Użyj filtrów, aby zawęzić listę do interesujących Cię samochodów.</li>
                <li>Otwórz szczegóły i sprawdź opis, parametry oraz dane kontaktowe.</li>
                <li>Przed zakupem samodzielnie zweryfikuj stan pojazdu i dokumenty.</li>
            </ol>
        </div>
        <div class="col-lg-4">
            <div class="surface-card surface-card--padded">
                <h2 class="h5">Ważne</h2>
                <p class="mb-0 text-muted">Serwis nie jest stroną umowy sprzedaży i nie potwierdza stanu technicznego pojazdów. Szczegóły transakcji ustal z właścicielem.</p>
            </div>
        </div>
    </div>
</div>
<jsp:include page="fragments/footer.jsp"/>
<style>
    .eyebrow {
        margin: 0 0 12px;
        color: var(--orange);
        font-size: .72rem;
        font-weight: 700;
        letter-spacing: .16em;
        text-transform: uppercase;
    }
</style>
