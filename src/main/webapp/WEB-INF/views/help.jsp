<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="fragments/header.jsp"/>
<div class="page-container">
    <p class="eyebrow">ApexWheels / pomoc</p>
    <h1>Centrum pomocy</h1>
    <p class="lead">Zacznij od <a href="<c:url value="/faq"/>">FAQ</a>, a jeśli nie znajdziesz odpowiedzi, napisz do nas przez <a href="<c:url value="/contact"/>">formularz kontaktowy</a>.</p>
    <div class="row g-4 mt-2">
        <div class="col-md-4"><div class="surface-card surface-card--padded h-100"><h2 class="h5">Kupujący</h2><p class="text-muted mb-0">Sprawdź zakres filtrów, porównuj ceny i przebiegi, a przed decyzją umów oględziny oraz zweryfikuj dokumenty.</p></div></div>
        <div class="col-md-4"><div class="surface-card surface-card--padded h-100"><h2 class="h5">Sprzedający</h2><p class="text-muted mb-0">Dodaj kompletny opis, prawdziwe parametry i aktualny numer kontaktowy. Nie publikuj danych innych osób bez zgody.</p></div></div>
        <div class="col-md-4"><div class="surface-card surface-card--padded h-100"><h2 class="h5">Problem techniczny</h2><p class="text-muted mb-0">W wiadomości podaj adres strony, opis problemu i kroki, które doprowadziły do błędu. Nie przesyłaj haseł.</p></div></div>
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
