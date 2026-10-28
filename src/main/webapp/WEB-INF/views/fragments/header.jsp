<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>Final Project</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/headers/">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

    <style>
        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

        .b-example-divider {
            height: 3rem;
            background-color: rgba(0, 0, 0, .1);
            border: solid rgba(0, 0, 0, .15);
            border-width: 1px 0;
            box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
        }

        .b-example-vr {
            flex-shrink: 0;
            width: 1.5rem;
            height: 100vh;
        }

        .bi {
            vertical-align: -.125em;
            fill: currentColor;
        }

        .nav-scroller .nav {
            display: flex;
            flex-wrap: nowrap;
            padding-bottom: 1rem;
            margin-top: -1px;
            overflow-x: auto;
            text-align: center;
            white-space: nowrap;
            -webkit-overflow-scrolling: touch;
        }

        body {
            min-height: 100vh;
            min-height: -webkit-fill-available;
        }

        html {
            height: -webkit-fill-available;
        }

        main {
            height: 100vh;
            height: -webkit-fill-available;
            max-height: 100vh;
            overflow-x: auto;
            overflow-y: hidden;
        }

        .btn-toggle {
            padding: .25rem .5rem;
            font-weight: 600;
            color: rgba(0, 0, 0, .65);
            background-color: transparent;
        }

        .btn-toggle:hover,
        .btn-toggle:focus {
            color: rgba(0, 0, 0, .85);
            background-color: #d2f4ea;
        }

        .btn-toggle::before {
            width: 1.25em;
            line-height: 0;
            content: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='rgba%280,0,0,.5%29' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M5 14l6-6-6-6'/%3e%3c/svg%3e");
            transition: transform .35s ease;
            transform-origin: .5em 50%;
        }

        .btn-toggle[aria-expanded="true"] {
            color: rgba(0, 0, 0, .85);
        }

        .btn-toggle[aria-expanded="true"]::before {
            transform: rotate(90deg);
        }

        .btn-toggle-nav a {
            padding: .1875rem .5rem;
            margin-top: .125rem;
            margin-left: 1.25rem;
        }

        .btn-toggle-nav a:hover,
        .btn-toggle-nav a:focus {
            background-color: #d2f4ea;
        }

        .d-flex {
            max-height: 62em;
        }

        .flex-shrink-0 {
            overflow: auto;
        }

    </style>
</head>
<body>
<header class="p-3 text-bg-dark">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
            <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
                <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-alexa"
                     viewBox="0 0 16 16">
                    <path d="M7.996 0A7.998 7.998 0 0 0 0 8a8 8 0 0 0 6.93 7.93v-1.613a1.06 1.06 0 0 0-.717-1.008A5.602 5.602 0 0 1 2.4 7.865 5.579 5.579 0 0 1 8.054 2.4a5.599 5.599 0 0 1 5.535 5.81l-.002.046a6.116 6.116 0 0 1-.012.192l-.005.061a4.85 4.85 0 0 1-.033.284l-.01.068c-.685 4.516-6.564 7.054-6.596 7.068A7.998 7.998 0 0 0 15.992 8 7.998 7.998 0 0 0 7.996.001Z"/>
                </svg>
            </a>

            <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                <li><a href="/" class="nav-link px-2 text-secondary">Strona Główna</a></li>
                <li><a href="/placeholder" class="nav-link px-2 text-white">Finansowanie</a></li>
                <li><a href="/placeholder" class="nav-link px-2 text-white">FAQs</a></li>
                <li><a href="/placeholder" class="nav-link px-2 text-white">Kontakt</a></li>
                <li><a href="/placeholder" class="nav-link px-2 text-white">O nas</a></li>
            </ul>
            <c:if test="${!pageContext.request.isUserInRole('USER') && !pageContext.request.isUserInRole('ADMIN')}">
                <div class="text-end">
                    <a href="<c:url value="/login"/>" class="btn btn-outline-light me-2">Zaloguj</a>
                    <a href="<c:url value="/register"/>" class="btn btn-warning">Zarejestruj</a>
                </div>
            </c:if>
            <c:if test="${pageContext.request.isUserInRole('USER')}">
                <div class="text-end">
                    <form action="<c:url value="/user/logout"/>" method="post">
                        <a href="<c:url value="/user/advertising/list"/>" class="btn btn-outline-light me-2">Twoje
                            ogłoszenia</a>
                        <a href="<c:url value="/user/advertising/create"/>" class="btn btn-outline-light me-2">Dodaj
                            ogłoszenie</a>
                        <a href="<c:url value="/user/changePassword"/>" class="btn btn-outline-light me-2">Zmień
                            hasło</a>
                        <input class="btn btn-warning" type="submit" value="Wyloguj">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>
                </div>
            </c:if>
            <c:if test="${pageContext.request.isUserInRole('ADMIN')}">
                <div class="text-end">
                    <form action="<c:url value="/user/logout"/>" method="post">
                        <a href="<c:url value="/admin/users/list"/>" class="btn btn-outline-light me-2">Lista
                            użytkowników</a>
                        <input class="btn btn-warning" type="submit" value="Wyloguj">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>
                </div>
            </c:if>
        </div>
    </div>
</header>

<main class="d-flex flex-nowrap">

    <div class="b-example-divider b-example-vr"></div>

    <div class="flex-shrink-0 p-3 bg-white" style="width: 280px;">
        <a href="/" class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search"
                 viewBox="0 0 16 16">
                <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
            </svg>
            <span class="fs-5 fw-semibold"> &nbsp; Wyszukiwanie</span>
        </a>
        <ul class="list-unstyled ps-0">
            <li class="mb-1">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                     class="bi bi-collection" viewBox="0 0 16 16">
                    <path d="M2.5 3.5a.5.5 0 0 1 0-1h11a.5.5 0 0 1 0 1h-11zm2-2a.5.5 0 0 1 0-1h7a.5.5 0 0 1 0 1h-7zM0 13a1.5 1.5 0 0 0 1.5 1.5h13A1.5 1.5 0 0 0 16 13V6a1.5 1.5 0 0 0-1.5-1.5h-13A1.5 1.5 0 0 0 0 6v7zm1.5.5A.5.5 0 0 1 1 13V6a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5h-13z"/>
                </svg>
                <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#home-collapse" aria-expanded="true">
                    Kategoria
                </button>
                <div class="collapse" id="home-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                        <c:forEach items="${category}" var="category">
                            <li><a href="/advertising/category/${category.id}"
                                   class="link-dark d-inline-flex text-decoration-none rounded"> <c:out value="${category.name}"/></a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </li>
            <li class="border-top my-3"></li>
            <li class="mb-1">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                     class="bi bi-car-front-fill" viewBox="0 0 16 16">
                    <path fill-rule="evenodd"
                          d="M2.52 3.515A2.5 2.5 0 0 1 4.82 2h6.362c1 0 1.904.596 2.298 1.515l.792 1.848c.075.175.21.319.38.404.5.25.855.715.965 1.262l.335 1.679c.033.161.049.325.049.49v.413c0 .814-.39 1.543-1 1.997V13.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1.338c-1.292.048-2.745.088-4 .088s-2.708-.04-4-.088V13.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1.892c-.61-.454-1-1.183-1-1.997v-.413a2.5 2.5 0 0 1 .049-.49l.335-1.68c.11-.546.465-1.012.964-1.261a.807.807 0 0 0 .381-.404l.792-1.848ZM3 10a1 1 0 1 0 0-2 1 1 0 0 0 0 2Zm10 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2ZM6 8a1 1 0 0 0 0 2h4a1 1 0 1 0 0-2H6ZM2.906 5.189l.956-1.913A.5.5 0 0 1 4.309 3h7.382a.5.5 0 0 1 .447.276l.956 1.913a.51.51 0 0 1-.497.731c-.91-.073-3.35-.17-4.597-.17-1.247 0-3.688.097-4.597.17a.51.51 0 0 1-.497-.731Z"/>
                </svg>
                <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#dashboard-collapse" aria-expanded="false">
                    Marka
                </button>
                <div class="collapse" id="dashboard-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                        <c:forEach items="${brand}" var="brand">
                            <li><a href="/advertising/brand/${brand.id}"
                                   class="link-dark d-inline-flex text-decoration-none rounded"> <c:out value="${brand.name}"/></a></li>
                        </c:forEach>
                    </ul>
                </div>
            </li>
            <li class="border-top my-3"></li>
            <li class="mb-1">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                     class="bi bi-speedometer" viewBox="0 0 16 16">
                    <path d="M8 2a.5.5 0 0 1 .5.5V4a.5.5 0 0 1-1 0V2.5A.5.5 0 0 1 8 2zM3.732 3.732a.5.5 0 0 1 .707 0l.915.914a.5.5 0 1 1-.708.708l-.914-.915a.5.5 0 0 1 0-.707zM2 8a.5.5 0 0 1 .5-.5h1.586a.5.5 0 0 1 0 1H2.5A.5.5 0 0 1 2 8zm9.5 0a.5.5 0 0 1 .5-.5h1.5a.5.5 0 0 1 0 1H12a.5.5 0 0 1-.5-.5zm.754-4.246a.389.389 0 0 0-.527-.02L7.547 7.31A.91.91 0 1 0 8.85 8.569l3.434-4.297a.389.389 0 0 0-.029-.518z"/>
                    <path fill-rule="evenodd"
                          d="M6.664 15.889A8 8 0 1 1 9.336.11a8 8 0 0 1-2.672 15.78zm-4.665-4.283A11.945 11.945 0 0 1 8 10c2.186 0 4.236.585 6.001 1.606a7 7 0 1 0-12.002 0z"/>
                </svg>
                <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#orders-collapse" aria-expanded="false">
                    Przebieg
                </button>
                <div class="collapse" id="orders-collapse">
                    <form action="/advertising/mileage" method="GET">
                        <div>
                            <input type="number" name="min" id="minMileage" class="form-control" placeholder="Od"
                                   required="required" autofocus="autofocus">
                            <label for="minMileage"></label>
                            <input type="number" name="max" id="maxMileage" class="form-control" placeholder="Do"
                                   required="required" autofocus="autofocus">
                            <label for="maxMileage"></label>
                        </div>
                        <button class="btn btn-primary" type="submit">Szukaj</button>
                    </form>
                </div>
            </li>
            <li class="border-top my-3"></li>
            <li class="mb-1">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                     class="bi bi-cash-coin" viewBox="0 0 16 16">
                    <path fill-rule="evenodd"
                          d="M11 15a4 4 0 1 0 0-8 4 4 0 0 0 0 8zm5-4a5 5 0 1 1-10 0 5 5 0 0 1 10 0z"/>
                    <path d="M9.438 11.944c.047.596.518 1.06 1.363 1.116v.44h.375v-.443c.875-.061 1.386-.529 1.386-1.207 0-.618-.39-.936-1.09-1.1l-.296-.07v-1.2c.376.043.614.248.671.532h.658c-.047-.575-.54-1.024-1.329-1.073V8.5h-.375v.45c-.747.073-1.255.522-1.255 1.158 0 .562.378.92 1.007 1.066l.248.061v1.272c-.384-.058-.639-.27-.696-.563h-.668zm1.36-1.354c-.369-.085-.569-.26-.569-.522 0-.294.216-.514.572-.578v1.1h-.003zm.432.746c.449.104.655.272.655.569 0 .339-.257.571-.709.614v-1.195l.054.012z"/>
                    <path d="M1 0a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h4.083c.058-.344.145-.678.258-1H3a2 2 0 0 0-2-2V3a2 2 0 0 0 2-2h10a2 2 0 0 0 2 2v3.528c.38.34.717.728 1 1.154V1a1 1 0 0 0-1-1H1z"/>
                    <path d="M9.998 5.083 10 5a2 2 0 1 0-3.132 1.65 5.982 5.982 0 0 1 3.13-1.567z"/>
                </svg>
                <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#account-collapse" aria-expanded="false">
                    Cena
                </button>
                <div class="collapse" id="account-collapse">
                    <form action="/advertising/price" method="GET">
                        <div>
                            <input type="number" name="min" id="minPrice" class="form-control" placeholder="Od"
                                   required="required" autofocus="autofocus">
                            <label for="minPrice"></label>
                            <input type="number" name="max" id="maxPrice" class="form-control" placeholder="Do"
                                   required="required" autofocus="autofocus">
                            <label for="maxPrice"></label>
                        </div>
                        <button class="btn btn-primary" type="submit">Szukaj</button>
                    </form>
                </div>
            </li>
        </ul>
    </div>

    <div class="b-example-divider b-example-vr"></div>