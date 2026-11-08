<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="fragments/header.jsp"/>
<div class="page-container">
    <p class="eyebrow">ApexWheels / kontakt</p>
    <h1>W czym możemy pomóc?</h1>
    <p class="lead">Skorzystaj z formularza w sprawach technicznych, konta, publikowania ofert lub podejrzanych ogłoszeń.</p>
    <c:if test="${sent}"><div class="alert alert-success" role="status">Formularz został przyjęty w tej wersji demonstracyjnej. Zgłoszenie nie jest wysyłane e-mailem, ponieważ skrzynka obsługi nie została skonfigurowana.</div></c:if>
    <c:if test="${not empty error}"><div class="alert alert-danger" role="alert"><c:out value="${error}"/></div></c:if>
    <form method="post" class="surface-card surface-card--padded mt-3" action="<c:url value="/contact"/>">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div class="row g-3">
            <div class="col-md-6"><label class="form-label" for="name">Imię</label><input class="form-control" id="name" name="name" required></div>
            <div class="col-md-6"><label class="form-label" for="email">E-mail</label><input class="form-control" id="email" name="email" type="email" required></div>
            <div class="col-12"><label class="form-label" for="message">Wiadomość</label><textarea class="form-control" id="message" name="message" rows="6" required></textarea></div>
            <div class="col-12"><button class="btn-apex" type="submit">Wyślij formularz</button></div>
        </div>
    </form>
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
