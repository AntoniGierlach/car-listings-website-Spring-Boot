<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="fragments/header.jsp"/>
<div class="page-container">
    <p class="eyebrow">ApexWheels / bezpieczeństwo</p>
    <h1>Bezpieczne oglądanie i zakup</h1>
    <div class="surface-card surface-card--padded mt-3">
        <h2 class="h5">Przed spotkaniem</h2>
        <ul><li>Porównaj opis, zdjęcia i numer VIN z dokumentami.</li><li>Ustal dokładne miejsce oględzin i poinformuj bliską osobę.</li><li>Nie wysyłaj skanu dokumentu ani pieniędzy przed weryfikacją.</li></ul>
        <h2 class="h5 mt-4">Podczas oględzin</h2>
        <ul><li>Poproś o dowód rejestracyjny, historię serwisową i jazdę próbną.</li><li>Rozważ niezależne badanie w stacji kontroli lub warsztacie.</li><li>Umowę podpisz dopiero po sprawdzeniu danych stron i pojazdu.</li></ul>
        <h2 class="h5 mt-4">Podejrzane oferty</h2>
        <p class="mb-0">Presja czasu, wyjątkowo niska cena, prośba o przelew przed spotkaniem lub odmowa weryfikacji to sygnały ostrzegawcze. Przerwij kontakt i zgłoś sprawę przez <a href="/contact">>Kontakt<</a></p>
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
