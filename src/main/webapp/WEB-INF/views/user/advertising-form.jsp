<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../fragments/header.jsp"/>

<div class="page-container">
    <div class="row g-5">
        <div class="col-md-8">
            <div class="surface-card surface-card--padded">
                <h1 class="h3 mb-4">Dane ogłoszenia</h1>
                <form:form method="post" modelAttribute="advertising">
                <form:hidden path="id"/>
                <div class="row g-3">
                    <div class="col-sm-12">
                        <form:label cssClass="form-label" path="title">Tytuł ogłoszenia</form:label>
                        <form:input cssClass="form-control" path="title"/>
                        <form:errors path="title" cssStyle="color: red"/>
                    </div>

                    <div class="col-12">
                        <form:label cssClass="form-label" path="description">Opis ogłoszenia</form:label>
                        <form:textarea cssClass="form-control" path="description"/>
                        <form:errors path="description" cssStyle="color: red"/>

                    </div>

                    <div class="col-6">
                        <form:label cssClass="form-label" path="mileage">Przebieg pojazdu <span
                                class="text-muted">(km)</span></form:label>
                        <form:input cssClass="form-control" path="mileage" type="number" min="1"/>
                        <form:errors path="mileage" cssStyle="color: red"/>
                    </div>

                    <div class="col-6">
                        <form:label cssClass="form-label" path="power">Moc silnika <span
                                class="text-muted">(KM)</span></form:label>
                        <form:input cssClass="form-control" path="power" type="number" min="1"/>
                        <form:errors path="power" cssStyle="color: red"/>
                    </div>

                    <div class="col-6">
                        <form:label cssClass="form-label" path="price">Cena <span
                                class="text-muted">(zł)</span></form:label>
                        <form:input cssClass="form-control" path="price" type="number" min="1"/>
                        <form:errors path="price" cssStyle="color: red"/>
                    </div>

                    <div class="col-6">
                        <form:label cssClass="form-label" path="year_of_production">Rok produkcji pojazdu</form:label>
                        <form:input cssClass="form-control" path="year_of_production" type="number" min="1900"/>
                        <form:errors path="year_of_production" cssStyle="color: red"/>
                    </div>

                    <div class="col-6">
                        <form:label cssClass="form-label" path="phone_number">Nr telefonu właściciela</form:label>
                        <form:input cssClass="form-control" path="phone_number" type="tel" inputmode="numeric"/>
                        <form:errors path="phone_number" cssStyle="color: red"/>
                    </div>
                    <div class="col-md-4">
                        <form:label cssClass="form-label" path="fuelType">Rodzaj paliwa</form:label>
                        <form:select cssClass="form-select" path="fuelType">
                            <form:option value="" label="Wybierz"/>
                            <form:option value="Benzyna" label="Benzyna"/>
                            <form:option value="Diesel" label="Diesel"/>
                            <form:option value="Hybryda" label="Hybryda"/>
                            <form:option value="Elektryczny" label="Elektryczny"/>
                            <form:option value="LPG" label="LPG"/>
                        </form:select>
                    </div>
                    <div class="col-md-4">
                        <form:label cssClass="form-label" path="vehicleCondition">Stan pojazdu</form:label>
                        <form:select cssClass="form-select" path="vehicleCondition">
                            <form:option value="" label="Wybierz"/>
                            <form:option value="Nowy" label="Nowy"/>
                            <form:option value="Używany" label="Używany"/>
                        </form:select>
                    </div>
                    <div class="col-md-4">
                        <form:label cssClass="form-label" path="damageStatus">Stan uszkodzeń</form:label>
                        <form:select cssClass="form-select" path="damageStatus">
                            <form:option value="" label="Wybierz"/>
                            <form:option value="Nieuszkodzony" label="Nieuszkodzony"/>
                            <form:option value="Uszkodzony" label="Uszkodzony"/>
                        </form:select>
                    </div>

                    <div class="col-md-5">
                        <form:label cssClass="form-label" path="category.id">Kategoria</form:label>
                        <form:select cssClass="form-select" path="category.id" items="${category}" itemLabel="name" itemValue="id"/>
                        <form:errors path="category.id" cssStyle="color: red"/>
                    </div>

                    <div class="col-md-4">
                        <form:label cssClass="form-label" path="brand.id">Marka</form:label>
                        <form:select cssClass="form-select" path="brand.id" items="${brand}" itemLabel="name" itemValue="id"/>
                        <form:errors path="brand.id" cssStyle="color: red"/>
                    </div>
                    <div class="col-12">
                        <form:label cssClass="form-label" path="image">Nazwa obrazu (opcjonalnie)</form:label>
                        <form:input cssClass="form-control" path="image" placeholder="np. samochod.svg"/>
                        <div class="form-text">Użyj nazwy pliku znajdującego się w publicznym katalogu obrazów.</div>
                        <form:errors path="image" cssStyle="color: red"/>
                    </div>
                    <hr class="my-4">
                    <form:button class="w-100 btn btn-apex btn-lg">Zapisz</form:button>
                    </form:form>
                </div>
            </div>
    </div>
</div>

<jsp:include page="../fragments/footer.jsp"/>
