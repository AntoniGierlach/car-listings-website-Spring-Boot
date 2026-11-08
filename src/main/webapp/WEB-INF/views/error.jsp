<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Błąd ${status} — ApexWheels</title>
    <style>
        :root { color-scheme: light; font-family: system-ui, sans-serif; background: #f7f8f6; color: #17212b; }
        body { min-height: 100vh; display: grid; place-items: center; margin: 0; }
        main { width: min(620px, calc(100% - 40px)); padding: 48px 32px; text-align: center; background: #fff; border: 1px solid #e6e9ec; border-radius: 16px; box-shadow: 0 16px 36px rgba(16,42,67,.08); }
        .code { color: #e27d45; font-size: 4rem; font-weight: 800; line-height: 1; }
        h1 { color: #102a43; }
        p { color: #74808a; line-height: 1.6; }
        a { display: inline-block; margin: 8px; padding: 12px 18px; border-radius: 8px; color: #fff; background: #e27d45; text-decoration: none; font-weight: 700; }
        a.secondary { color: #102a43; background: #eef1f2; }
        a:focus-visible { outline: 3px solid #102a43; outline-offset: 3px; }
    </style>
</head>
<body>
<main role="main">
    <div class="code" aria-hidden="true">${empty status ? '500' : status}</div>
    <h1>${status == 404 ? 'Nie znaleziono strony' : 'Wystąpił problem'}</h1>
    <p>${status == 404 ? 'Adres, którego szukasz, nie istnieje albo oferta została usunięta.' : 'Nie udało się dokończyć żądania. Spróbuj ponownie lub wróć na stronę główną.'}</p>
    <a href="${pageContext.request.contextPath}/">Strona główna</a>
    <a class="secondary" href="${pageContext.request.contextPath}/advertising">Przeglądaj ogłoszenia</a>
</main>
</body>
</html>

