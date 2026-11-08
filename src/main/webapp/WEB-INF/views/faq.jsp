<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="fragments/header.jsp"/>
<div class="page-container">
    <p class="eyebrow">ApexWheels / FAQ</p>
    <h1>Najczęstsze pytania</h1>
    <p class="lead mb-4">Konkretne odpowiedzi dotyczące przeglądania ofert, publikowania ogłoszeń i bezpieczeństwa.</p>
    <div class="accordion" id="faq">
        <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button" data-bs-toggle="collapse" data-bs-target="#q1">Jak znaleźć samochód w określonym budżecie?</button></h2><div id="q1" class="accordion-collapse collapse show" data-bs-parent="#faq"><div class="accordion-body">Użyj pól ceny w panelu wyszukiwania. Podaj minimum, maksimum lub oba zakresy i wybierz „Szukaj”.</div></div></div>
        <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#q2">Jak filtrować ogłoszenia według marki i modelu?</button></h2><div id="q2" class="accordion-collapse collapse" data-bs-parent="#faq"><div class="accordion-body">Wybierz markę albo kategorię w panelu po lewej stronie. Wyniki są pobierane z bazy ogłoszeń.</div></div></div>
        <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#q3">Co zrobić, gdy ogłoszenie nie zawiera wszystkich parametrów?</button></h2><div id="q3" class="accordion-collapse collapse" data-bs-parent="#faq"><div class="accordion-body">Zapytaj sprzedającego przed oględzinami. Nie zakładaj, że brak informacji oznacza konkretny stan pojazdu.</div></div></div>
        <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#q4">Jak skontaktować się ze sprzedającym?</button></h2><div id="q4" class="accordion-collapse collapse" data-bs-parent="#faq"><div class="accordion-body">Otwórz szczegóły oferty. Jeśli numer telefonu został podany przez sprzedającego, zobaczysz go w sekcji kontaktu.</div></div></div>
        <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#q5">Jak dodać ogłoszenie?</button></h2><div id="q5" class="accordion-collapse collapse" data-bs-parent="#faq"><div class="accordion-body">Zaloguj się, wybierz „Dodaj ogłoszenie” i uzupełnij wymagane pola. Formularz sprawdza tytuł, opis, cenę, przebieg, rok, markę i kategorię.</div></div></div>
        <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#q6">Jak edytować lub usunąć własną ofertę?</button></h2><div id="q6" class="accordion-collapse collapse" data-bs-parent="#faq"><div class="accordion-body">W panelu „Moje ogłoszenia” wybierz odpowiednią akcję. Dostęp do zmian jest ograniczony do właściciela oferty i administratora.</div></div></div>
        <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#q7">Jak bezpiecznie kupić samochód?</button></h2><div id="q7" class="accordion-collapse collapse" data-bs-parent="#faq"><div class="accordion-body">Obejrzyj auto osobiście, sprawdź dokumenty i numer VIN, wykonaj jazdę próbną oraz nie wysyłaj zaliczki przed weryfikacją sprzedającego.</div></div></div>
        <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#q8">Czy ApexWheels gwarantuje stan pojazdu?</button></h2><div id="q8" class="accordion-collapse collapse" data-bs-parent="#faq"><div class="accordion-body">Nie. Serwis udostępnia narzędzie do publikacji i przeglądania ofert, ale nie jest rzeczoznawcą ani stroną transakcji.</div></div></div>
        <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#q9">Czy publikowanie ogłoszeń jest płatne?</button></h2><div id="q9" class="accordion-collapse collapse" data-bs-parent="#faq"><div class="accordion-body">Aktualna wersja aplikacji nie ma modułu płatności. Nie wysyłaj pieniędzy za publikację osobom kontaktującym się poza oficjalnym serwisem.</div></div></div>
        <div class="accordion-item"><h2 class="accordion-header"><button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#q10">Co zrobić, jeśli ogłoszenie wygląda podejrzanie?</button></h2><div id="q10" class="accordion-collapse collapse" data-bs-parent="#faq"><div class="accordion-body">Nie wpłacaj zaliczki, zachowaj korespondencję i opisz sprawę przez stronę Kontakt. W razie podejrzenia oszustwa skontaktuj się również z odpowiednimi służbami.</div></div></div>
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
