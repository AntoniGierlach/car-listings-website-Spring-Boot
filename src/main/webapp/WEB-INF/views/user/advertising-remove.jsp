<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../fragments/header.jsp"/>

<section class="py-5 text-center container">
    <div class="row py-lg-5">
        <div class="col-lg-6 col-md-8 mx-auto">
            <h1 class="fw-light">Usuń ogłoszenie</h1>
            <form:form method="post" modelAttribute="advertising">
                <form:hidden path="id"/>
                <p class="lead text-muted">Czy na pewno chcesz usunąć to ogłoszenie?</p>
                <h3><c:out value="${advertising.title}"/></h3>
                <h5><c:out value="${advertising.description}"/></h5>
                <p>
                    <input type="submit" class="btn btn-primary my-2" name="remove" value="Tak">
                    <input type="submit" class="btn btn-secondary my-2" name="remove" value="Nie">
                </p>
            </form:form>
        </div>
    </div>
</section>

<jsp:include page="../fragments/footer.jsp"/>