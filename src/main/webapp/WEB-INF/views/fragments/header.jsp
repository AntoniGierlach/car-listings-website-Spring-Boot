<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="pl">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="ApexWheels — wyselekcjonowane samochody na sprzedaż">
    <title>ApexWheels</title>
    <link rel="icon" href="${pageContext.request.contextPath}/icons/tire.png" type="image/png">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

    <style>
        .lucide { width: 1em; height: 1em; stroke-width: 2; vertical-align: -.125em; }
        .brand-icon { width: 2rem; height: 2rem; color: var(--orange); stroke-width: 2.2; }

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
        html {
            min-height: 100%;
            overflow-y: scroll;
            scrollbar-gutter: stable;
        }
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
            min-height: calc(100vh - 76px - 74px);
            margin: 0 auto;
            display: grid;
            grid-template-columns: 300px minmax(0, 1fr);
        }
        .shell--no-sidebar { grid-template-columns: minmax(0, 1fr); }
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
            color: var(--ink);
            font-size: .78rem;
        }
        .range-form input:focus {
            outline: 0;
            border-color: var(--orange);
            box-shadow: 0 0 0 3px rgba(226,125,69,.15);
        }
        .range-form > button[type="submit"] {
            grid-column: 1 / -1;
            min-height: 36px;
            border: 0;
            border-radius: 7px;
            background: var(--navy);
            color: #fff;
            font-size: .76rem;
            font-weight: 700;
        }
        .search-text-field {
            display: grid;
            grid-column: 1 / -1;
            gap: 6px;
            margin-top: 4px;
        }
        .search-text-field .filter-label { margin-bottom: 0; }
        .search-text-field input { width: 100%; }
        .range-group { grid-column: 1 / -1; display: grid; grid-template-columns: 1fr 1fr; gap: 8px; }
        .range-group .filter-label { grid-column: 1 / -1; margin-bottom: 0; }
        .search-select { position: relative; grid-column: 1 / -1; }
        .search-select-input {
            width: 100%;
            min-height: 38px;
            padding: 8px 34px 8px 10px;
            border: 1px solid var(--line);
            border-radius: 7px;
            background: #fff;
            color: var(--ink);
            font: inherit;
            font-size: .78rem;
        }
        .search-select-input:focus { outline: 0; border-color: var(--orange); box-shadow: 0 0 0 3px rgba(226,125,69,.15); }
        .search-error {
            grid-column: 1 / -1;
            padding: 10px 12px;
            border: 1px solid #dc3545;
            border-radius: 8px;
            background: #fff1f2;
            color: #b42332;
            font-size: .76rem;
            line-height: 1.45;
        }
        .search-invalid {
            border-color: #dc3545 !important;
            background: #fff1f2 !important;
            box-shadow: 0 0 0 3px rgba(220, 53, 69, .12);
        }
        .search-select-toggle {
            position: absolute;
            top: 0;
            right: 0;
            width: 34px;
            height: 38px;
            border: 0;
            background: transparent;
            color: var(--muted);
            cursor: pointer;
        }
        .search-select-toggle svg { width: 15px; height: 15px; color: inherit; }
        .search-select-options {
            position: absolute;
            top: calc(100% + 4px);
            right: 0;
            left: 0;
            z-index: 30;
            display: none;
            max-height: 190px;
            overflow-y: auto;
            padding: 4px;
            border: 1px solid var(--line);
            border-radius: 8px;
            background: #fff;
            box-shadow: 0 10px 24px rgba(16, 42, 67, .14);
        }
        .search-select.is-open .search-select-options { display: block; }
        .search-select-option {
            display: block;
            width: 100%;
            padding: 9px 10px;
            border: 0;
            border-radius: 5px;
            background: transparent;
            color: var(--ink);
            text-align: left;
            font: inherit;
            font-size: .78rem;
            cursor: pointer;
        }
        .search-select-option:hover, .search-select-option:focus-visible { background: var(--orange-soft); color: var(--navy); }
        .search-select-empty { display: none; padding: 9px 10px; color: var(--muted); font-size: .76rem; }
        .filter-choice-group { display: flex; flex-wrap: wrap; gap: 6px; grid-column: 1 / -1; }
        .filter-choice { position: absolute; opacity: 0; pointer-events: none; }
        .filter-choice + label {
            display: inline-flex; align-items: center; min-height: 32px; padding: 5px 9px;
            border: 1px solid var(--line); border-radius: 999px; background: #fff;
            color: var(--muted); font-size: .73rem; cursor: pointer;
        }
        .filter-choice:checked + label { border-color: var(--orange); background: var(--orange-soft); color: var(--navy); font-weight: 700; }
        .filter-choice:focus-visible + label { outline: 3px solid rgba(226,125,69,.45); outline-offset: 2px; }
        .content {
            display: flex;
            min-width: 0;
            flex-direction: column;
            align-items: center;
            padding: 42px clamp(22px, 4vw, 64px) 60px;
        }
        .content > * { width: 100%; max-width: 1120px; }
        .page-container { width: 100%; max-width: 1120px; margin: 0 auto; }
        .site-body:not(.site-body--excluded) .content .eyebrow {
            margin: 0 0 12px;
            color: var(--orange);
            font-size: .72rem;
            font-weight: 700;
            letter-spacing: .16em;
            line-height: 1.3;
            text-transform: uppercase;
        }
        .site-body:not(.site-body--excluded) .content h1 {
            margin: 0 0 20px;
            color: var(--navy);
            font-family: "Manrope", sans-serif;
            font-size: clamp(2rem, 3.5vw, 3rem);
            font-weight: 800;
            line-height: 1.08;
            letter-spacing: -.05em;
        }
        .site-body:not(.site-body--excluded) .content h1 em {
            color: var(--orange);
            font-style: normal;
        }
        .page-container > h1 { margin: 0 0 14px; color: var(--navy); font-size: clamp(2rem, 3.5vw, 3rem); letter-spacing: -.05em; }
        .page-container > .lead { max-width: 760px; color: var(--muted); line-height: 1.65; }
        .surface-card {
            border: 1px solid var(--line);
            border-radius: 12px;
            background: var(--surface);
            box-shadow: 0 4px 16px rgba(16, 42, 67, .03);
        }
        .surface-card--padded { padding: clamp(20px, 3vw, 32px); }
        .section-heading { margin: 0 0 12px; color: var(--navy); font-size: 1.2rem; }
        .page-container .form-control,
        .page-container .form-select,
        .sort-select {
            min-height: 46px;
            border: 1px solid var(--line);
            border-radius: 8px;
            background-color: var(--surface);
            color: var(--ink);
            font: inherit;
        }
        .page-container .form-control { padding: 11px 12px; }
        .page-container .form-select,
        .sort-select {
            padding: 11px 38px 11px 12px;
            background-position: right 12px center;
        }
        .sort-select {
            appearance: none;
            -webkit-appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%2374808a' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='m6 9 6 6 6-6'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-size: 16px;
        }
        .sort-select option {
            padding: 10px 12px;
            background: var(--surface);
            color: var(--ink);
        }
        .page-container .form-control:focus,
        .page-container .form-select:focus,
        .sort-select:focus {
            border-color: var(--orange);
            box-shadow: 0 0 0 3px rgba(226,125,69,.15);
        }
        .page-container .form-select:hover,
        .sort-select:hover { border-color: #c8d0d4; }
        .page-container .btn-primary,
        .page-container .btn-apex { border: 0; background: var(--orange); }
        .page-container .btn-primary:hover,
        .page-container .btn-apex:hover { background: #d66b34; }
        .page-container .accordion { --bs-accordion-border-color: var(--line); --bs-accordion-btn-focus-box-shadow: 0 0 0 3px rgba(226,125,69,.15); }
        .page-container .accordion-item { background: var(--surface); }
        .page-container .accordion-button { color: var(--navy); font-weight: 700; }
        .page-container .accordion-button:not(.collapsed) { background: var(--orange-soft); color: var(--navy); }
        .site-footer {
            max-width: 1440px;
            margin: 0 auto;
            padding: 22px 32px 30px;
            color: var(--muted);
            font-size: .75rem;
            border-top: 1px solid var(--line);
        }
        .site-footer-links { float: right; display: flex; gap: 12px; }
        .site-footer a { color: var(--muted); text-decoration: none; }
        .site-footer a:hover, .site-footer a:focus-visible { color: var(--orange); }
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
            .page-container { max-width: none; }
            .site-footer { padding: 20px; }
        }
        @media (max-width: 520px) {
            .topbar-inner { min-height: 68px; }
            .header-actions { margin-left: auto; }
            .brand-name { font-size: 1rem; }
            .btn-apex { min-height: 38px; padding: 0 11px; font-size: .76rem; }
            .btn-quiet { min-height: 38px; padding: 0 10px; font-size: .76rem; }
            .filter-section { display: block; width: 100%; padding-right: 0; }
            .site-footer-links { float: none; margin-top: 10px; flex-wrap: wrap; }
        }
        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after { scroll-behavior: auto !important; transition-duration: .01ms !important; }
        }
    </style>
</head>
<c:choose>
    <c:when test="${pageContext.request.servletPath == '/' || pageContext.request.servletPath == '/login' || pageContext.request.servletPath == '/register'}">
        <c:set var="bodyClass" value="site-body site-body--excluded"/>
    </c:when>
    <c:otherwise>
        <c:set var="bodyClass" value="site-body"/>
    </c:otherwise>
</c:choose>
<body class="<c:out value="${bodyClass}"/>">
<header class="topbar">
    <div class="topbar-inner">
        <a href="<c:url value="/"/>" class="brand" aria-label="ApexWheels — strona główna">
            <i data-lucide="gauge" class="brand-icon" aria-hidden="true"></i>
            <span class="brand-name">APEX<span>WHEELS</span></span>
        </a>
        <nav class="primary-nav" aria-label="Główna nawigacja">
            <a href="<c:url value="/advertising"/>">Samochody</a>
            <c:if test="${pageContext.request.isUserInRole('USER') || pageContext.request.isUserInRole('ADMIN')}">
                <a href="<c:url value="/favorites"/>">Ulubione</a>
            </c:if>
            <a href="<c:url value="/compare"/>">Porównaj</a>
            <a href="<c:url value="/about"/>">O serwisie</a>
            <a href="<c:url value="/faq"/>">FAQ</a>
            <a href="<c:url value="/contact"/>">Kontakt</a>
        </nav>
        <div class="header-actions">
            <c:if test="${!pageContext.request.isUserInRole('USER') && !pageContext.request.isUserInRole('ADMIN')}">
                <a href="<c:url value="/login"/>" class="btn-quiet">Zaloguj</a>
                <a href="<c:url value="/register"/>" class="btn-apex">Załóż konto</a>
            </c:if>
            <c:if test="${pageContext.request.isUserInRole('USER') || pageContext.request.isUserInRole('ADMIN')}">
                <a href="<c:url value="/user/advertising/create"/>" class="btn-apex">+ Dodaj ogłoszenie</a>
                <a href="<c:url value="/user/advertising/list"/>" class="btn-quiet">Moje ogłoszenia</a>
            </c:if>
            <c:if test="${pageContext.request.isUserInRole('ADMIN')}">
                <a href="<c:url value="/admin/users/list"/>" class="btn-quiet">Panel administratora</a>
            </c:if>
            <c:if test="${pageContext.request.isUserInRole('USER')}">
                <form action="<c:url value="/user/logout"/>" method="post" class="d-inline">
                    <input class="btn-quiet" type="submit" value="Wyloguj">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
            </c:if>
        </div>
    </div>
</header>

<script>
    window.apexwheelsFavoriteIds = [
        <c:forEach items="${favoriteListingIds}" var="favoriteId" varStatus="status">
            "<c:out value="${favoriteId}"/>"<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
</script>

<main class="shell ${showSearchSidebar ? '' : 'shell--no-sidebar'}">
    <c:if test="${showSearchSidebar}">
    <aside class="sidebar" aria-label="Filtry wyszukiwania">
        <p class="sidebar-heading">Znajdź swój samochód</p>
        <section class="filter-section">
            <form action="<c:url value="/advertising/search"/>" method="GET" class="range-form" id="search-form">
                <c:if test="${not empty searchError}">
                    <div class="search-error" role="alert"><c:out value="${searchError}"/></div>
                </c:if>
                <input type="hidden" name="sort" value="<c:out value="${param.sort}"/>">
                <input type="hidden" name="layout" value="<c:out value="${param.layout}"/>">
                <div class="search-select" data-search-select>
                    <div class="filter-label"><span>Marka</span></div>
                    <input type="text" class="search-select-input ${invalidBrand ? 'search-invalid' : ''}" name="brandLabel"
                           value="<c:out value="${invalidBrand ? '' : selectedBrand.name}"/>"
                           placeholder="Wybierz lub wpisz markę"
                           aria-label="Marka" aria-autocomplete="list" aria-expanded="false" autocomplete="off">
                    <button type="button" class="search-select-toggle" aria-label="Pokaż marki"><i data-lucide="chevron-down" aria-hidden="true"></i></button>
                    <div class="search-select-options" role="listbox">
                        <c:forEach items="${brand}" var="searchBrand">
                            <button type="button" class="search-select-option" role="option" data-value="${searchBrand.id}">
                                <c:out value="${searchBrand.name}"/>
                            </button>
                        </c:forEach>
                        <span class="search-select-empty">Brak pasujących marek</span>
                    </div>
                </div>
                <input type="hidden" name="brandId" id="search-brand-id" value="<c:out value="${invalidBrand ? '' : param.brandId}"/>">
                <div class="search-select" data-search-select>
                    <div class="filter-label"><span>Kategoria</span></div>
                    <input type="text" class="search-select-input ${invalidCategory ? 'search-invalid' : ''}" name="categoryLabel"
                           value="<c:out value="${invalidCategory ? '' : selectedCategory.name}"/>"
                           placeholder="Wybierz lub wpisz kategorię"
                           aria-label="Kategoria" aria-autocomplete="list" aria-expanded="false" autocomplete="off">
                    <button type="button" class="search-select-toggle" aria-label="Pokaż kategorie"><i data-lucide="chevron-down" aria-hidden="true"></i></button>
                    <div class="search-select-options" role="listbox">
                        <c:forEach items="${category}" var="searchCategory">
                            <button type="button" class="search-select-option" role="option" data-value="${searchCategory.id}">
                                <c:out value="${searchCategory.name}"/>
                            </button>
                        </c:forEach>
                        <span class="search-select-empty">Brak pasujących kategorii</span>
                    </div>
                </div>
                <input type="hidden" name="categoryId" id="search-category-id" value="<c:out value="${invalidCategory ? '' : param.categoryId}"/>">
                <div class="range-group">
                    <div class="filter-label"><span>Cena <span class="text-muted fw-normal">(zł)</span></span></div>
                    <input type="number" name="minPrice" class="${invalidMinPrice ? 'search-invalid' : ''}"
                           value="<c:out value="${invalidMinPrice ? '' : param.minPrice}"/>" placeholder="Cena od" aria-label="Minimalna cena">
                    <input type="number" name="maxPrice" class="${invalidMaxPrice ? 'search-invalid' : ''}"
                           value="<c:out value="${invalidMaxPrice ? '' : param.maxPrice}"/>" placeholder="Cena do" aria-label="Maksymalna cena">
                </div>
                <div class="range-group">
                    <div class="filter-label"><span>Przebieg <span class="text-muted fw-normal">(km)</span></span></div>
                    <input type="number" name="minMileage" class="${invalidMinMileage ? 'search-invalid' : ''}"
                           value="<c:out value="${invalidMinMileage ? '' : param.minMileage}"/>" placeholder="Przebieg od" aria-label="Minimalny przebieg">
                    <input type="number" name="maxMileage" class="${invalidMaxMileage ? 'search-invalid' : ''}"
                           value="<c:out value="${invalidMaxMileage ? '' : param.maxMileage}"/>" placeholder="Przebieg do" aria-label="Maksymalny przebieg">
                </div>
                <div class="filter-label" style="grid-column:1 / -1;margin:4px 0 0;">Rodzaj paliwa</div>
                <div class="filter-choice-group">
                    <input class="filter-choice" type="radio" name="fuelType" id="fuel-any" value="" ${empty param.fuelType ? 'checked' : ''}><label for="fuel-any">Dowolny</label>
                    <input class="filter-choice" type="radio" name="fuelType" id="fuel-petrol" value="Benzyna" ${param.fuelType == 'Benzyna' ? 'checked' : ''}><label for="fuel-petrol">Benzyna</label>
                    <input class="filter-choice" type="radio" name="fuelType" id="fuel-diesel" value="Diesel" ${param.fuelType == 'Diesel' ? 'checked' : ''}><label for="fuel-diesel">Diesel</label>
                    <input class="filter-choice" type="radio" name="fuelType" id="fuel-hybrid" value="Hybryda" ${param.fuelType == 'Hybryda' ? 'checked' : ''}><label for="fuel-hybrid">Hybryda</label>
                    <input class="filter-choice" type="radio" name="fuelType" id="fuel-electric" value="Elektryczny" ${param.fuelType == 'Elektryczny' ? 'checked' : ''}><label for="fuel-electric">Elektryczny</label>
                    <input class="filter-choice" type="radio" name="fuelType" id="fuel-lpg" value="LPG" ${param.fuelType == 'LPG' ? 'checked' : ''}><label for="fuel-lpg">LPG</label>
                </div>
                <div class="filter-label" style="grid-column:1 / -1;margin:4px 0 0;">Stan pojazdu</div>
                <div class="filter-choice-group">
                    <input class="filter-choice" type="radio" name="vehicleCondition" id="condition-any" value="" ${empty param.vehicleCondition ? 'checked' : ''}><label for="condition-any">Dowolny</label>
                    <input class="filter-choice" type="radio" name="vehicleCondition" id="condition-new" value="Nowy" ${param.vehicleCondition == 'Nowy' ? 'checked' : ''}><label for="condition-new">Nowy</label>
                    <input class="filter-choice" type="radio" name="vehicleCondition" id="condition-used" value="Używany" ${param.vehicleCondition == 'Używany' ? 'checked' : ''}><label for="condition-used">Używany</label>
                </div>
                <div class="filter-label" style="grid-column:1 / -1;margin:4px 0 0;">Stan uszkodzeń</div>
                <div class="filter-choice-group">
                    <input class="filter-choice" type="radio" name="damageStatus" id="damage-any" value="" ${empty param.damageStatus ? 'checked' : ''}><label for="damage-any">Dowolny</label>
                    <input class="filter-choice" type="radio" name="damageStatus" id="damage-none" value="Nieuszkodzony" ${param.damageStatus == 'Nieuszkodzony' ? 'checked' : ''}><label for="damage-none">Nieuszkodzony</label>
                    <input class="filter-choice" type="radio" name="damageStatus" id="damage-present" value="Uszkodzony" ${param.damageStatus == 'Uszkodzony' ? 'checked' : ''}><label for="damage-present">Uszkodzony</label>
                </div>
                <div class="search-text-field">
                    <div class="filter-label"><span>Szukaj w treści ogłoszenia</span></div>
                    <input type="search" name="searchText" value="<c:out value="${param.searchText}"/>"
                           placeholder="Np. Audi, SUV, 2019, automat..."
                           aria-label="Szukaj w tytule, opisie i parametrach ogłoszenia"
                           autocomplete="off">
                </div>
                <button type="submit">Szukaj</button>
            </form>
        </section>
    </aside>
    </c:if>
    <c:if test="${showSearchSidebar}">
    <script>
        document.querySelectorAll("[data-search-select]").forEach(function (select) {
            var input = select.querySelector(".search-select-input");
            var options = Array.from(select.querySelectorAll(".search-select-option"));
            var empty = select.querySelector(".search-select-empty");
            var hidden = select.nextElementSibling;
            function close() {
                select.classList.remove("is-open");
                input.setAttribute("aria-expanded", "false");
            }
            function filter() {
                var query = input.value.trim().toLowerCase();
                var visible = options.filter(function (option) {
                    var match = option.textContent.trim().toLowerCase().includes(query);
                    option.hidden = !match;
                    return match;
                });
                empty.style.display = visible.length ? "none" : "block";
                select.classList.add("is-open");
                input.setAttribute("aria-expanded", "true");
                hidden.value = "";
            }
            input.addEventListener("focus", filter);
            input.addEventListener("input", filter);
            select.querySelector(".search-select-toggle").addEventListener("click", function () {
                if (select.classList.contains("is-open")) close(); else filter();
                input.focus();
            });
            options.forEach(function (option) {
                option.addEventListener("click", function () {
                    input.value = option.textContent.trim();
                    hidden.value = option.dataset.value;
                    close();
                });
            });
            input.closest("form").addEventListener("submit", function (event) {
                if (input.value.trim() && !hidden.value) {
                    hidden.value = "0";
                }
            });
            document.addEventListener("click", function (event) {
                if (!select.contains(event.target)) close();
            });
        });
    </script>
    </c:if>
    <section class="content">
