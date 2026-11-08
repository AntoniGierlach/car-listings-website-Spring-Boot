<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../fragments/header.jsp"/>

<style>
    .admin-shell {
        overflow: hidden;
        border: 1px solid var(--line);
        border-radius: 18px;
        background: var(--surface);
        box-shadow: 0 12px 32px rgba(13, 30, 50, .07);
    }

    .admin-tabs {
        display: flex;
        gap: 8px;
        padding: 10px;
        border-bottom: 1px solid var(--line);
        background: #f7f9fb;
    }

    .admin-tab {
        flex: 1 1 0;
        border: 0;
        border-radius: 10px;
        padding: 12px 16px;
        color: var(--muted);
        background: transparent;
        font-weight: 700;
        transition: color .2s ease, background-color .2s ease;
    }

    .admin-tab:hover,
    .admin-tab:focus-visible {
        color: var(--navy);
        background: #e9eef3;
    }

    .admin-tab.is-active {
        color: #fff;
        background: var(--navy);
    }

    .admin-slider {
        overflow: hidden;
    }

    .admin-track {
        display: flex;
        width: 300%;
        transition: transform .35s ease;
    }

    .admin-panel {
        flex: 0 0 33.333333%;
        min-width: 0;
        padding: 28px;
    }

    .admin-panel__heading {
        display: flex;
        align-items: flex-start;
        justify-content: space-between;
        gap: 16px;
        margin-bottom: 22px;
    }

    .admin-panel__heading h2 {
        margin: 0;
    }

    .admin-table,
    .admin-message {
        border: 1px solid var(--line);
        border-radius: 12px;
        background: #fff;
    }

    .admin-table {
        overflow: hidden;
    }

    .admin-table table {
        margin-bottom: 0;
    }

    .admin-table th {
        color: var(--muted);
        font-size: .78rem;
        letter-spacing: .04em;
        text-transform: uppercase;
        white-space: nowrap;
    }

    .admin-message {
        padding: 18px;
    }

    .admin-message + .admin-message {
        margin-top: 12px;
    }

    .admin-empty {
        padding: 32px 20px;
        border: 1px dashed var(--orange);
        border-radius: 12px;
        color: var(--muted);
        text-align: center;
    }

    @media (max-width: 767.98px) {
        .admin-dashboard {
            padding-top: 28px;
        }

        .admin-tabs {
            overflow-x: auto;
        }

        .admin-tab {
            flex: 0 0 auto;
            white-space: nowrap;
        }

        .admin-panel {
            padding: 20px 16px;
        }

        .admin-panel__heading {
            display: block;
        }

        .admin-panel__heading .btn {
            margin-top: 12px;
        }
    }
</style>

<main class="page-container admin-dashboard">
    <p class="eyebrow">Panel administratora</p>
    <h1>Zarządzanie serwisem</h1>
    <p class="lead">Użytkownicy, ogłoszenia i wiadomości kontaktowe w jednym miejscu.</p>

    <div class="admin-shell mt-4" data-admin-dashboard data-active-tab="${activeTab}">
        <div class="admin-tabs" role="tablist" aria-label="Sekcje panelu administratora">
            <button type="button" class="admin-tab" role="tab" aria-controls="admin-panel-users"
                    data-admin-tab="users">Użytkownicy</button>
            <button type="button" class="admin-tab" role="tab" aria-controls="admin-panel-advertising"
                    data-admin-tab="advertising">Ogłoszenia</button>
            <button type="button" class="admin-tab" role="tab" aria-controls="admin-panel-messages"
                    data-admin-tab="messages">Wiadomości</button>
        </div>

        <div class="admin-slider">
            <div class="admin-track" data-admin-track>
                <section id="admin-panel-users" class="admin-panel" role="tabpanel">
                    <div class="admin-panel__heading">
                        <div>
                            <h2>Użytkownicy</h2>
                            <p class="text-muted mb-0">Blokuj konta lub usuń użytkownika wraz z jego ogłoszeniami.</p>
                        </div>
                    </div>
                    <c:if test="${not empty param.error}">
                        <div class="alert alert-warning" role="alert"><c:out value="${param.error}"/></div>
                    </c:if>
                    <c:choose>
                        <c:when test="${not empty users}">
                            <div class="admin-table table-responsive">
                                <table class="table align-middle">
                                    <thead>
                                    <tr><th>Użytkownik</th><th>Status</th><th class="text-end">Akcje</th></tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${users}" var="user">
                                        <tr>
                                            <td>
                                                <strong><c:out value="${user.name}"/></strong>
                                                <div class="small text-muted"><c:out value="${user.username}"/></div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.enabled == 1}"><span class="badge text-bg-success">Aktywne</span></c:when>
                                                    <c:otherwise><span class="badge text-bg-secondary">Zablokowane</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-end">
                                                <div class="d-inline-flex flex-wrap justify-content-end gap-2">
                                                    <c:if test="${user.enabled == 1}">
                                                        <form method="post" action="<c:url value="/admin/users/${user.id}/status"/>">
                                                            <input type="hidden" name="enabled" value="0">
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                            <button type="submit" class="btn btn-sm btn-outline-warning">Zablokuj</button>
                                                        </form>
                                                    </c:if>
                                                    <c:if test="${user.enabled == 0}">
                                                        <form method="post" action="<c:url value="/admin/users/${user.id}/status"/>">
                                                            <input type="hidden" name="enabled" value="1">
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                            <button type="submit" class="btn btn-sm btn-outline-secondary">Odblokuj</button>
                                                        </form>
                                                    </c:if>
                                                    <button type="button" class="btn btn-sm btn-outline-danger"
                                                            data-delete-action="<c:url value="/admin/users/remove/${user.id}"/>"
                                                            data-delete-label="konto użytkownika wraz z jego ogłoszeniami: <c:out value="${user.username}"/>">Usuń</button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise><div class="admin-empty">Brak użytkowników do wyświetlenia.</div></c:otherwise>
                    </c:choose>
                </section>

                <section id="admin-panel-advertising" class="admin-panel" role="tabpanel">
                    <div class="admin-panel__heading">
                        <div>
                            <h2>Ogłoszenia</h2>
                            <p class="text-muted mb-0">Usuń dowolne ogłoszenie, niezależnie od jego właściciela.</p>
                        </div>
                    </div>
                    <c:choose>
                        <c:when test="${not empty items}">
                            <div class="admin-table table-responsive">
                                <table class="table align-middle">
                                    <thead><tr><th>Ogłoszenie</th><th>Właściciel</th><th>Cena</th><th class="text-end">Akcja</th></tr></thead>
                                    <tbody>
                                    <c:forEach items="${items}" var="item">
                                        <tr>
                                            <td><a href="<c:url value="/advertising/details/${item.id}"/>"><c:out value="${item.title}"/></a></td>
                                            <td><c:out value="${item.user.username}"/></td>
                                            <td><fmt:formatNumber value="${item.price}" groupingUsed="true"/> zł</td>
                                            <td class="text-end">
                                                <button type="button" class="btn btn-sm btn-outline-danger"
                                                        data-delete-action="<c:url value="/admin/advertising/remove/${item.id}"/>"
                                                        data-delete-label="ogłoszenie: <c:out value="${item.title}"/>">Usuń</button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise><div class="admin-empty">Brak ogłoszeń do wyświetlenia.</div></c:otherwise>
                    </c:choose>
                </section>

                <section id="admin-panel-messages" class="admin-panel" role="tabpanel">
                    <div class="admin-panel__heading">
                        <div>
                            <h2>Wiadomości kontaktowe</h2>
                            <p class="text-muted mb-0">Wiadomości wysłane za pomocą formularza kontaktowego.</p>
                        </div>
                    </div>
                    <c:choose>
                        <c:when test="${not empty messages}">
                            <c:forEach items="${messages}" var="message">
                                <article class="admin-message">
                                    <div class="d-flex flex-wrap justify-content-between gap-2">
                                        <h3 class="h5 mb-0"><c:out value="${message.name}"/> — <c:out value="${message.email}"/></h3>
                                        <time class="text-muted" datetime="<c:out value="${message.createdAt}"/>">
                                            <c:out value="${message.formattedCreatedAt}"/>
                                        </time>
                                    </div>
                                    <p class="mt-3 mb-0" style="white-space: pre-wrap;"><c:out value="${message.message}"/></p>
                                </article>
                            </c:forEach>
                        </c:when>
                        <c:otherwise><div class="admin-empty">Brak wiadomości kontaktowych.</div></c:otherwise>
                    </c:choose>
                </section>
            </div>
        </div>
    </div>
</main>

<jsp:include page="../fragments/confirm-delete-dialog.jsp"/>

<script>
    (function () {
        var dashboard = document.querySelector('[data-admin-dashboard]');
        if (!dashboard) return;

        var track = dashboard.querySelector('[data-admin-track]');
        var tabs = Array.prototype.slice.call(dashboard.querySelectorAll('[data-admin-tab]'));
        var tabNames = tabs.map(function (tab) { return tab.getAttribute('data-admin-tab'); });
        var initialTab = dashboard.getAttribute('data-active-tab');

        function selectTab(name, updateUrl) {
            var index = tabNames.indexOf(name);
            if (index < 0) index = 0;
            tabs.forEach(function (tab, tabIndex) {
                var active = tabIndex === index;
                tab.classList.toggle('is-active', active);
                tab.setAttribute('aria-selected', active ? 'true' : 'false');
            });
            track.style.transform = 'translateX(-' + (index * 33.333333) + '%)';
            if (updateUrl) {
                var url = new URL(window.location.href);
                url.searchParams.set('tab', tabNames[index]);
                window.history.replaceState({}, '', url);
            }
        }

        tabs.forEach(function (tab) {
            tab.addEventListener('click', function () {
                selectTab(tab.getAttribute('data-admin-tab'), true);
            });
        });

        selectTab(initialTab, false);

    }());
</script>

<jsp:include page="../fragments/footer.jsp"/>
