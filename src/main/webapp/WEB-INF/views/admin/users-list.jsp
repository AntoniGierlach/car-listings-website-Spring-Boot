<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../fragments/header.jsp"/>

<style>
    .spacing {
        width: 100%;
        padding-top: 50px;
        overflow: auto;
    }

    .col-width {
        width: 100%;
    }

    .btn-color {
        color: red;
    }

    .btn-color:hover {
        background-color: red;
    }
</style>

<div class="spacing">
    <div class="container">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
            <c:forEach items="${users}" var="user">
                <div class="col col-width">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h4>Imię: <c:out value="${user.name}"/></h4>
                            <h4>Nazwa użytkownika: <c:out value="${user.username}"/></h4>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <c:if test="${user.enabled == 1}">
                                    <a href="<c:url value="#"/>"
                                       class="btn btn-sm btn-color btn-outline-secondary">Zablokuj</a>
                                    </c:if>
                                    <c:if test="${user.enabled == 0}">
                                        <a href="<c:url value="#"/>"
                                           class="btn btn-sm btn-outline-secondary">Odblokuj</a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>