<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.104.2">
    <title>Zmień hasło</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/sign-in/">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">


    <style>
        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
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
            height: 100%;
        }

        body {
            display: flex;
            align-items: center;
            padding-top: 40px;
            padding-bottom: 40px;
            background-color: #f5f5f5;
        }

        .form-signin {
            max-width: 330px;
            padding: 15px;
        }

        .form-signin .form-floating:focus-within {
            z-index: 2;
        }

        .form-signin input[type="password"] {
            margin-bottom: 10px;
            border-top-left-radius: 0;
            border-top-right-radius: 0;
        }
    </style>
</head>
<body class="text-center">

<main class="form-signin w-100 m-auto">
    <form:form method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <script src="https://unpkg.com/lucide@latest"></script>
        <i data-lucide="lock-keyhole" width="50" height="50" aria-hidden="true"></i>
        <h1 class="h3 mb-3 fw-normal">Zmień hasło</h1>

        <div class="form-floating">
            <input type="password" id="inputPassword" name="password" class="form-control" placeholder="Password"
                   required="required">
            <label for="inputPassword">Hasło</label>
            <form:errors path="password"/>
        </div>

        <div class="form-floating">
            <input type="password" id="confirmPassword" name="confirm_password" class="form-control"
                   placeholder="Confirm password" required="required">
            <label for="confirmPassword">Potwierdź hasło</label>
            <form:errors path="confirm_password"/>
        </div>
        <button class="w-100 btn btn-lg btn-primary" type="submit">Zmień hasło</button>
    </form:form>
    <div class="text-center">
        <a class="d-block small mt-3" href="<c:url value="/"/>">Strona główna</a>
        <p class="mt-5 mb-3 text-muted">&copy; ApexWheels 2026</p>
    </div>
</main>
<script>lucide.createIcons();</script>
</body>
</html>
