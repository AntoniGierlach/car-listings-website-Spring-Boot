<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../fragments/header.jsp"/>

<section class="page-container">
    <p class="eyebrow">Panel administratora</p>
    <h1>Wiadomości kontaktowe</h1>
    <c:choose>
        <c:when test="${not empty messages}">
            <div class="d-grid gap-3 mt-4">
                <c:forEach items="${messages}" var="message">
                    <article class="surface-card surface-card--padded">
                        <div class="d-flex flex-wrap justify-content-between gap-2">
                            <h2 class="h5 mb-0"><c:out value="${message.name}"/> — <c:out value="${message.email}"/></h2>
                            <time class="text-muted" datetime="<c:out value="${message.createdAt}"/>">
                                <c:out value="${message.formattedCreatedAt}"/>
                            </time>
                        </div>
                        <p class="mt-3 mb-0" style="white-space: pre-wrap;"><c:out value="${message.message}"/></p>
                    </article>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise><div class="empty-state mt-4"><h2>Brak wiadomości</h2><p>Wiadomości wysłane z formularza kontaktowego pojawią się tutaj.</p></div></c:otherwise>
    </c:choose>
</section>

<jsp:include page="../fragments/footer.jsp"/>
