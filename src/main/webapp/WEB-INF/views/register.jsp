<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="pl">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Utwórz konto ApexWheels i zarządzaj swoimi ogłoszeniami.">
    <title>Utwórz konto | ApexWheels</title>
    <link rel="icon" href="${pageContext.request.contextPath}/icons/tire.png" type="image/png">
    <script src="https://unpkg.com/lucide@latest"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@600;700;800&display=swap" rel="stylesheet">
    <style>
        :root { --ink:#17212b; --muted:#74808a; --line:#e6e9ec; --canvas:#f7f8f6; --surface:#fff; --navy:#102a43; --orange:#e27d45; --orange-soft:#fff1e8; }
        * { box-sizing: border-box; }
        html, body { min-height: 100%; }
        body { margin:0; background:var(--canvas); color:var(--ink); font-family:"DM Sans",sans-serif; -webkit-font-smoothing:antialiased; }
        h1, h2, .brand-name { font-family:"Manrope",sans-serif; }
        a { color:inherit; }
        .auth-shell { display:grid; grid-template-columns:minmax(280px,.85fr) minmax(340px,1.15fr); min-height:100vh; }
        .auth-intro { display:flex; flex-direction:column; justify-content:space-between; padding:clamp(28px,5vw,68px); background:var(--navy); color:#fff; }
        .brand { display:inline-flex; align-items:center; gap:11px; width:fit-content; color:#fff; text-decoration:none; }
        .brand-icon { width:40px; height:40px; color:var(--orange); stroke-width:2.2; }
        .brand-name { font-size:1.14rem; letter-spacing:-.03em; }
        .brand-name span { color:var(--orange); }
        .intro-copy { max-width:430px; margin:auto 0; padding:48px 0; }
        .eyebrow { margin:0 0 16px; color:var(--orange); font-size:.72rem; font-weight:700; letter-spacing:.16em; text-transform:uppercase; }
        .intro-copy h1 { margin:0 0 18px; font-size:clamp(2rem,4vw,3.6rem); line-height:1.06; letter-spacing:-.06em; }
        .intro-copy p { margin:0; max-width:370px; color:rgba(255,255,255,.68); line-height:1.7; }
        .intro-footer { color:rgba(255,255,255,.48); font-size:.78rem; }
        .auth-content { display:flex; align-items:center; justify-content:center; padding:32px clamp(20px,6vw,96px); }
        .auth-card { width:min(100%,440px); }
        .mobile-brand { display:none; }
        .auth-heading { margin-bottom:26px; }
        .auth-heading h2 { margin:0 0 8px; color:var(--navy); font-size:clamp(1.7rem,3vw,2.25rem); letter-spacing:-.05em; }
        .auth-heading p { margin:0; color:var(--muted); line-height:1.6; }
        .field { margin-bottom:15px; }
        .field label { display:block; margin-bottom:7px; color:var(--navy); font-size:.82rem; font-weight:700; }
        .field input { display:block; width:100%; min-height:46px; padding:10px 13px; border:1px solid var(--line); border-radius:8px; background:var(--surface); color:var(--ink); font:inherit; }
        .field input:focus { outline:0; border-color:var(--orange); box-shadow:0 0 0 3px rgba(226,125,69,.15); }
        .field-error { margin-top:6px; color:#b42318; font-size:.78rem; }
        .auth-note { margin:18px 0 0; color:var(--muted); font-size:.78rem; line-height:1.55; }
        .auth-submit { width:100%; min-height:48px; margin-top:10px; border:0; border-radius:8px; background:var(--orange); color:#fff; font:inherit; font-weight:700; cursor:pointer; }
        .auth-submit:hover, .auth-submit:focus-visible { background:#d66b34; }
        .auth-links { display:flex; justify-content:space-between; gap:16px; margin-top:22px; color:var(--muted); font-size:.84rem; }
        .auth-links a { color:var(--orange); font-weight:700; text-decoration:none; }
        .auth-links a:hover, .auth-links a:focus-visible { color:var(--navy); text-decoration:underline; }
        @media (max-width:760px) {
            .auth-shell { display:block; }
            .auth-intro { display:none; }
            .auth-content { min-height:100vh; align-items:flex-start; padding:28px 20px 36px; }
            .mobile-brand { display:inline-flex; margin-bottom:56px; }
        }
    </style>
</head>
<body>
<main class="auth-shell">
    <section class="auth-intro" aria-label="Informacje o ApexWheels">
        <a class="brand" href="<c:url value="/"/>" aria-label="ApexWheels — strona główna">
            <i data-lucide="car-front" class="brand-icon" aria-hidden="true"></i>
            <span class="brand-name">APEX<span>WHEELS</span></span>
        </a>
        <div class="intro-copy">
            <p class="eyebrow">Dołącz do ApexWheels</p>
            <h1>Znajdź swój następny samochód bez zbędnego szumu.</h1>
            <p>Jedno konto wystarczy, aby zapisywać oferty, porównywać samochody i publikować własne ogłoszenia.</p>
        </div>
        <p class="intro-footer">&copy; ApexWheels 2026</p>
    </section>
    <section class="auth-content">
        <div class="auth-card">
            <a class="brand mobile-brand" href="<c:url value="/"/>" aria-label="ApexWheels — strona główna">
                <i data-lucide="car-front" class="brand-icon" aria-hidden="true"></i>
                <span class="brand-name" style="color:var(--navy);">APEX<span>WHEELS</span></span>
            </a>
            <div class="auth-heading">
                <h2>Utwórz konto</h2>
                <p>Zacznij wygodniej zarządzać swoimi ofertami i ulubionymi samochodami.</p>
            </div>
            <form:form method="post" modelAttribute="registerDto">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                <div class="field">
                    <label for="firstName">Imię</label>
                    <input type="text" id="firstName" name="name" autocomplete="given-name" value="<c:out value="${registerDto.name}"/>" required autofocus>
                    <form:errors path="name" cssClass="field-error" element="div"/>
                </div>
                <div class="field">
                    <label for="lastName">Nazwisko</label>
                    <input type="text" id="lastName" name="lastName" autocomplete="family-name" value="<c:out value="${registerDto.lastName}"/>" required>
                    <form:errors path="lastName" cssClass="field-error" element="div"/>
                </div>
                <div class="field">
                    <label for="inputUsername">Nazwa użytkownika (login)</label>
                    <input type="text" id="inputUsername" name="username" autocomplete="username" value="<c:out value="${registerDto.username}"/>" required>
                    <form:errors path="username" cssClass="field-error" element="div"/>
                </div>
                <div class="field">
                    <label for="inputPassword">Hasło <span>(min. 6 znaków)</span></label>
                    <input type="password" id="inputPassword" name="password" autocomplete="new-password" minlength="6" required>
                    <form:errors path="password" cssClass="field-error" element="div"/>
                </div>
                <div class="field">
                    <label for="confirmPassword">Potwierdź hasło</label>
                    <input type="password" id="confirmPassword" name="confirm_password" autocomplete="new-password" minlength="6" required>
                    <form:errors path="confirm_password" cssClass="field-error" element="div"/>
                </div>
                <form:errors path="passwordConfirmed" cssClass="field-error" element="div"/>
                <p class="auth-note">Podając dane, tworzysz konto potrzebne do korzystania z funkcji dostępnych dla użytkowników.</p>
                <button class="auth-submit" type="submit">Utwórz konto</button>
            </form:form>
            <div class="auth-links">
                <span>Masz już konto?</span>
                <a href="<c:url value="/login"/>">Zaloguj się</a>
            </div>
            <div class="auth-links">
                <a href="<c:url value="/"/>"><i data-lucide="arrow-left" aria-hidden="true"></i> Wróć na stronę główną</a>
            </div>
        </div>
    </section>
</main>
<script>lucide.createIcons();</script>
</body>
</html>
