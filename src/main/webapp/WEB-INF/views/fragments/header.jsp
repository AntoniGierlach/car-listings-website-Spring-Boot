<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="pl">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="ApexWheels — wyselekcjonowane samochody na sprzedaż">
    <title>ApexWheels — samochody z charakterem</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

    <style>
        :root {
            --ink: #17212b;
            --muted: #74808a;
            --line: #e6e9ec;
            --canvas: #f7f8f6;
            --surface: #ffffff;
            --navy: #102a43;
            --orange: #e27d45;
            --orange-soft: #fff1e8;
            --shadow: 0 16px 36px rgba(16, 42, 67, .08);
        }

        * { box-sizing: border-box; }
        html { min-height: 100%; }
        body {
            min-height: 100vh;
            margin: 0;
            background: var(--canvas);
            color: var(--ink);
            font-family: "DM Sans", sans-serif;
            -webkit-font-smoothing: antialiased;
        }
        h1, h2, h3, h4, h5, .brand-name { font-family: "Manrope", sans-serif; }
        a { color: inherit; }
        .topbar {
            position: sticky;
            top: 0;
            z-index: 20;
            background: rgba(16, 42, 67, .97);
            color: #fff;
            border-bottom: 1px solid rgba(255,255,255,.08);
        }
        .topbar-inner {
            max-width: 1440px;
            min-height: 76px;
            margin: 0 auto;
            padding: 0 32px;
            display: flex;
            align-items: center;
            gap: 34px;
        }
        .brand {
            display: inline-flex;
            align-items: center;
            gap: 11px;
            color: #fff;
            text-decoration: none;
            white-space: nowrap;
        }
        .brand-mark {
            width: 35px;
            height: 35px;
            display: grid;
            place-items: center;
            border: 1px solid rgba(255,255,255,.45);
            border-radius: 50%;
            color: var(--orange);
        }
        .brand-name { font-size: 1.14rem; letter-spacing: -.03em; }
        .brand-name span { color: var(--orange); }
        .primary-nav { display: flex; align-items: center; gap: 8px; margin-right: auto; }
        .primary-nav a {
            padding: 9px 13px;
            color: rgba(255,255,255,.66);
            text-decoration: none;
            font-size: .88rem;
            border-radius: 8px;
            transition: color .2s ease, background .2s ease;
        }
        .primary-nav a:hover, .primary-nav a:focus-visible { color: #fff; background: rgba(255,255,255,.1); }
        .header-actions { display: flex; align-items: center; gap: 10px; }
        .btn-apex {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 42px;
            padding: 0 17px;
            border: 0;
            border-radius: 8px;
            background: var(--orange);
            color: #fff;
            font-weight: 700;
            font-size: .84rem;
            text-decoration: none;
            transition: transform .2s ease, background .2s ease;
        }
        .btn-apex:hover, .btn-apex:focus-visible { color: #fff; background: #d66b34; transform: translateY(-1px); }
        .btn-quiet {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 42px;
            padding: 0 14px;
            border: 1px solid rgba(255,255,255,.25);
            border-radius: 8px;
            background: transparent;
            color: #fff;
            font-size: .84rem;
            text-decoration: none;
        }
        .btn-quiet:hover, .btn-quiet:focus-visible { color: #fff; border-color: #fff; }
        .shell {
            max-width: 1440px;
            min-height: calc(100vh - 76px);
            margin: 0 auto;
            display: grid;
            grid-template-columns: 248px minmax(0, 1fr);
        }
        .sidebar {
            padding: 30px 20px;
            border-right: 1px solid var(--line);
            background: #fbfcfa;
        }
        .sidebar-heading {
            margin: 0 0 22px;
            color: var(--muted);
            font-size: .68rem;
            font-weight: 700;
            letter-spacing: .15em;
            text-transform: uppercase;
        }
        .filter-section { padding: 18px 0; border-top: 1px solid var(--line); }
        .filter-section:first-of-type { padding-top: 0; border-top: 0; }
        .filter-label {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 12px;
            color: var(--ink);
            font-size: .82rem;
            font-weight: 700;
        }
        .filter-label svg { color: var(--orange); }
        .filter-links { display: flex; flex-direction: column; gap: 7px; }
        .filter-links a {
            padding: 5px 0;
            color: var(--muted);
            text-decoration: none;
            font-size: .82rem;
            transition: color .2s ease, padding .2s ease;
        }
        .filter-links a:hover, .filter-links a:focus-visible { padding-left: 4px; color: var(--orange); }
        .range-form { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; }
        .range-form input {
            min-width: 0;
            padding: 9px 10px;
            border: 1px solid var(--line);
            border-radius: 7px;
            background: #fff;
            font-size: .78rem;
        }
        .range-form button {
            grid-column: 1 / -1;
            min-height: 36px;
            border: 0;
            border-radius: 7px;
            background: var(--navy);
            color: #fff;
            font-size: .76rem;
            font-weight: 700;
        }
        .content { min-width: 0; padding: 42px clamp(22px, 4vw, 64px) 60px; }
        :focus-visible { outline: 3px solid rgba(226,125,69,.45); outline-offset: 3px; }
        @media (max-width: 900px) {
            .topbar-inner { padding: 14px 20px; gap: 12px 16px; flex-wrap: wrap; }
            .primary-nav { order: 3; flex-basis: 100%; overflow-x: auto; margin: 0; padding-bottom: 2px; }
            .primary-nav a { flex: 0 0 auto; padding: 6px 10px; }
            .shell { display: block; }
            .sidebar { padding: 22px 20px 16px; border-right: 0; border-bottom: 1px solid var(--line); }
            .sidebar-heading { margin-bottom: 14px; }
            .filter-section { display: inline-block; vertical-align: top; width: 49%; padding: 10px 14px 10px 0; border-top: 0; }
            .filter-section:first-of-type { padding-top: 10px; }
            .filter-links { max-height: 96px; overflow-y: auto; }
            .content { padding: 28px 20px 46px; }
        }
        @media (max-width: 520px) {
            .topbar-inner { min-height: 68px; }
            .header-actions { margin-left: auto; }
            .brand-name { font-size: 1rem; }
            .btn-apex { min-height: 38px; padding: 0 11px; font-size: .76rem; }
            .btn-quiet { min-height: 38px; padding: 0 10px; font-size: .76rem; }
            .filter-section { display: block; width: 100%; padding-right: 0; }
        }
        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after { scroll-behavior: auto !important; transition-duration: .01ms !important; }
        }
    </style>
</head>
<body>
<header class="topbar">
    <div class="topbar-inner">
        <a href="<c:url value="/"/>" class="brand" aria-label="ApexWheels — strona główna">
            <span class="brand-mark" aria-hidden="true">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
                    <path d="M5 15.5 7.3 9h9.4l2.3 6.5M4 15.5h16M7 18.5h.01M17 18.5h.01M6 15.5v2a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1v-2"/>
                </svg>
            </span>
            <span class="brand-name">APEX<span>WHEELS</span></span>
        </a>
        <nav class="primary-nav" aria-label="Główna nawigacja">
            <a href="<c:url value="/"/>">Samochody</a>
            <a href="<c:url value="/placeholder"/>">Finansowanie</a>
            <a href="<c:url value="/placeholder"/>">O nas</a>
            <a href="<c:url value="/placeholder"/>">Kontakt</a>
        </nav>
        <div class="header-actions">
            <c:if test="${!pageContext.request.isUserInRole('USER') && !pageContext.request.isUserInRole('ADMIN')}">
                <a href="<c:url value="/login"/>" class="btn-quiet">Zaloguj</a>
                <a href="<c:url value="/register"/>" class="btn-apex">Załóż konto</a>
            </c:if>
            <c:if test="${pageContext.request.isUserInRole('USER')}">
                <a href="<c:url value="/user/advertising/create"/>" class="btn-apex">+ Dodaj ogłoszenie</a>
                <form action="<c:url value="/user/logout"/>" method="post" class="d-inline">
                    <input class="btn-quiet" type="submit" value="Wyloguj">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
            </c:if>
            <c:if test="${pageContext.request.isUserInRole('ADMIN')}">
                <a href="<c:url value="/admin/users/list"/>" class="btn-quiet">Panel</a>
                <form action="<c:url value="/user/logout"/>" method="post" class="d-inline">
                    <input class="btn-apex" type="submit" value="Wyloguj">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
            </c:if>
        </div>
    </div>
</header>

<main class="shell">
    <aside class="sidebar" aria-label="Filtry wyszukiwania">
        <p class="sidebar-heading">Znajdź swój samochód</p>
        <section class="filter-section">
            <div class="filter-label">
                <span>Kategoria</span>
                <span aria-hidden="true">⌄</span>
            </div>
            <div class="filter-links">
                <c:forEach items="${category}" var="category">
                    <a href="/advertising/category/${category.id}"><c:out value="${category.name}"/></a>
                </c:forEach>
            </div>
        </section>
        <section class="filter-section">
            <div class="filter-label"><span>Marka</span><span aria-hidden="true">⌄</span></div>
            <div class="filter-links">
                <c:forEach items="${brand}" var="brand">
                    <a href="/advertising/brand/${brand.id}"><c:out value="${brand.name}"/></a>
                </c:forEach>
            </div>
        </section>
        <section class="filter-section">
            <div class="filter-label"><span>Przebieg <span class="text-muted fw-normal">(km)</span></span></div>
            <form action="/advertising/mileage" method="GET" class="range-form">
                <input type="number" name="min" id="minMileage" placeholder="Od" aria-label="Minimalny przebieg" required>
                <input type="number" name="max" id="maxMileage" placeholder="Do" aria-label="Maksymalny przebieg" required>
                <button type="submit">Zastosuj filtr</button>
            </form>
        </section>
        <section class="filter-section">
            <div class="filter-label"><span>Cena <span class="text-muted fw-normal">(zł)</span></span></div>
            <form action="/advertising/price" method="GET" class="range-form">
                <input type="number" name="min" id="minPrice" placeholder="Od" aria-label="Minimalna cena" required>
                <input type="number" name="max" id="maxPrice" placeholder="Do" aria-label="Maksymalna cena" required>
                <button type="submit">Zastosuj filtr</button>
            </form>
        </section>
    </aside>
    <section class="content">
