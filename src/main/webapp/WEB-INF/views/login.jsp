<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="pl">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Zaloguj się do swojego konta ApexWheels.">
    <title>Zaloguj się | ApexWheels</title>
    <link rel="icon" href="${pageContext.request.contextPath}/icons/tire.png" type="image/png">
    <script src="https://unpkg.com/lucide@latest"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --ink: #17212b;
            --muted: #74808a;
            --line: #e6e9ec;
            --canvas: #f7f8f6;
            --surface: #fff;
            --navy: #102a43;
            --orange: #e27d45;
            --orange-soft: #fff1e8;
        }
        * { box-sizing: border-box; }
        html, body { min-height: 100%; }
        body {
            margin: 0;
            background: var(--canvas);
            color: var(--ink);
            font-family: "DM Sans", sans-serif;
            -webkit-font-smoothing: antialiased;
        }
        h1, h2, .brand-name { font-family: "Manrope", sans-serif; }
        a { color: inherit; }
        .auth-shell {
            display: grid;
            grid-template-columns: minmax(280px, .85fr) minmax(340px, 1.15fr);
            min-height: 100vh;
        }
        .auth-intro {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: clamp(28px, 5vw, 68px);
            background: var(--navy);
            color: #fff;
        }
        .brand {
            display: inline-flex;
            align-items: center;
            gap: 11px;
            width: fit-content;
            color: #fff;
            text-decoration: none;
        }
        .brand-icon { width: 40px; height: 40px; color: var(--orange); stroke-width: 2.2; }
        .brand-name { font-size: 1.14rem; letter-spacing: -.03em; }
        .brand-name span { color: var(--orange); }
        .intro-copy { max-width: 430px; margin: auto 0; padding: 48px 0; }
        .eyebrow {
            margin: 0 0 16px;
            color: var(--orange);
            font-size: .72rem;
            font-weight: 700;
            letter-spacing: .16em;
            text-transform: uppercase;
        }
        .intro-copy h1 {
            margin: 0 0 18px;
            font-size: clamp(2rem, 4vw, 3.6rem);
            line-height: 1.06;
            letter-spacing: -.06em;
        }
        .intro-copy p { margin: 0; max-width: 370px; color: rgba(255,255,255,.68); line-height: 1.7; }
        .intro-footer { color: rgba(255,255,255,.48); font-size: .78rem; }
        .auth-content {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 32px clamp(20px, 6vw, 96px);
        }
        .auth-card { width: min(100%, 440px); }
        .mobile-brand { display: none; }
        .auth-heading { margin-bottom: 28px; }
        .auth-heading h2 { margin: 0 0 8px; color: var(--navy); font-size: clamp(1.7rem, 3vw, 2.25rem); letter-spacing: -.05em; }
        .auth-heading p { margin: 0; color: var(--muted); line-height: 1.6; }
        .alert {
            padding: 12px 14px;
            margin-bottom: 18px;
            border: 1px solid #f1c2ad;
            border-radius: 8px;
            background: var(--orange-soft);
            color: #8d3e1f;
            font-size: .88rem;
        }
        .field { margin-bottom: 16px; }
        .field label { display: block; margin-bottom: 7px; color: var(--navy); font-size: .82rem; font-weight: 700; }
        .field input {
            display: block;
            width: 100%;
            min-height: 48px;
            padding: 11px 13px;
            border: 1px solid var(--line);
            border-radius: 8px;
            background: var(--surface);
            color: var(--ink);
            font: inherit;
        }
        .field input:focus { outline: 0; border-color: var(--orange); box-shadow: 0 0 0 3px rgba(226,125,69,.15); }
        .field-error { margin-top: 6px; color: #b42318; font-size: .78rem; }
        .auth-submit {
            width: 100%;
            min-height: 48px;
            margin-top: 8px;
            border: 0;
            border-radius: 8px;
            background: var(--orange);
            color: #fff;
            font: inherit;
            font-weight: 700;
            cursor: pointer;
        }
        .auth-submit:hover, .auth-submit:focus-visible { background: #d66b34; }
        .auth-links { display: flex; justify-content: space-between; gap: 16px; margin-top: 22px; color: var(--muted); font-size: .84rem; }
        .auth-links a { color: var(--orange); font-weight: 700; text-decoration: none; }
        .auth-links a:hover, .auth-links a:focus-visible { color: var(--navy); text-decoration: underline; }
        @media (max-width: 760px) {
            .auth-shell { display: block; }
            .auth-intro { display: none; }
            .auth-content { min-height: 100vh; align-items: flex-start; padding: 28px 20px 36px; }
            .mobile-brand { display: inline-flex; margin-bottom: 56px; }
        }
    </style>
</head>
<body>
<main class="auth-shell">
    <section class="auth-intro" aria-label="Informacje o ApexWheels">
        <a class="brand" href="<c:url value="/"/>" aria-label="ApexWheels — strona główna">
            <i data-lucide="gauge" class="brand-icon" aria-hidden="true"></i>
            <span class="brand-name">APEX<span>WHEELS</span></span>
        </a>
        <div class="intro-copy">
            <p class="eyebrow">Twoje konto</p>
            <h1>Wróć do samochodów, które naprawdę Cię interesują.</h1>
            <p>Zaloguj się, aby zarządzać ogłoszeniami, ulubionymi ofertami i porównaniami w jednym miejscu.</p>
        </div>
        <p class="intro-footer">&copy; ApexWheels 2026</p>
    </section>
    <section class="auth-content">
        <div class="auth-card">
            <a class="brand mobile-brand" href="<c:url value="/"/>" aria-label="ApexWheels — strona główna">
                <i data-lucide="gauge" class="brand-icon" aria-hidden="true"></i>
                <span class="brand-name" style="color: var(--navy);">APEX<span>WHEELS</span></span>
            </a>
            <div class="auth-heading">
                <h2>Zaloguj się</h2>
                <p>Wpisz dane, aby przejść do swojego konta.</p>
            </div>
            <c:if test="${not empty param.error}">
                <c:choose>
                    <c:when test="${param.error == 'blocked'}">
                        <div class="alert" role="alert">
                            Konto zostało zablokowane przez administratora.
                            <a href="<c:url value="/contact"/>">Skontaktuj się z nami</a>, aby wyjaśnić sytuację.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert" role="alert">Nie udało się zalogować. Sprawdź nazwę użytkownika i hasło.</div>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <form action="<c:url value="/login"/>" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                <div class="field">
                    <label for="inputUsername">Nazwa użytkownika (login)</label>
                    <input type="text" name="username" id="inputUsername" autocomplete="username" required autofocus>
                    <small style="display:block;margin-top:6px;color:var(--muted);">To login ustawiony podczas rejestracji, a nie imię ani nazwisko.</small>
                </div>
                <div class="field">
                    <label for="inputPassword">Hasło</label>
                    <input type="password" name="password" id="inputPassword" autocomplete="current-password" required>
                </div>
                <button class="auth-submit" type="submit">Zaloguj się</button>
            </form>
            <div class="auth-links">
                <span>Nie masz jeszcze konta?</span>
                <a href="<c:url value="/register"/>">Zarejestruj się</a>
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
