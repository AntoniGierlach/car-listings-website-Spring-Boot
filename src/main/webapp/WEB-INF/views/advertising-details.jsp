<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="fragments/header.jsp"/>

<style>
    .icon-link > .bi {
        margin-top: .125rem;
        margin-left: .125rem;
        fill: currentcolor;
        transition: transform .25s ease-in-out;
    }

    .icon-link:hover > .bi {
        transform: translate(.25rem);
    }

    .feature-icon-small {
        width: 3rem;
        height: 3rem;
    }

    img, svg {
        box-shadow: 2px 2px 5px black;
    }
</style>

<div class="container px-4 py-5">
    <h2 class="pb-2 border-bottom"><c:out value="${item.title}"/></h2>

    <div class="row row-cols-1 row-cols-md-2 align-items-md-center g-5 py-5">
        <div>
            <c:if test="${not empty item.image}">
                <c:url var="imageUrl" value="/images/${item.image}"/>
                <img src="<c:out value="${imageUrl}"/>"
                     class="bd-placeholder-img card-img-top image-background"
                     xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail"
                     preserveAspectRatio="xMidYMid slice" focusable="false"/>
            </c:if>
            <c:if test="${empty item.image}">
                <svg class="bd-placeholder-img card-img-top" width="100%" height="225"
                     xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail"
                     preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title>
                    <rect width="100%" height="100%" fill="#55595c"/>
                    <text x="42%" y="50%" fill="#eceeef" dy=".3em">Brak zdjęcia</text>
                </svg>
            </c:if>
        </div>

        <div class="row row-cols-1 row-cols-sm-2 g-4">
            <div class="d-flex flex-column gap-2">
                <div
                        class="feature-icon-small d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-4 rounded-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor"
                         class="bi bi-car-front-fill" viewBox="0 0 16 16">
                        <path fill-rule="evenodd"
                              d="M2.52 3.515A2.5 2.5 0 0 1 4.82 2h6.362c1 0 1.904.596 2.298 1.515l.792 1.848c.075.175.21.319.38.404.5.25.855.715.965 1.262l.335 1.679c.033.161.049.325.049.49v.413c0 .814-.39 1.543-1 1.997V13.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1.338c-1.292.048-2.745.088-4 .088s-2.708-.04-4-.088V13.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1.892c-.61-.454-1-1.183-1-1.997v-.413a2.5 2.5 0 0 1 .049-.49l.335-1.68c.11-.546.465-1.012.964-1.261a.807.807 0 0 0 .381-.404l.792-1.848ZM3 10a1 1 0 1 0 0-2 1 1 0 0 0 0 2Zm10 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2ZM6 8a1 1 0 0 0 0 2h4a1 1 0 1 0 0-2H6ZM2.906 5.189l.956-1.913A.5.5 0 0 1 4.309 3h7.382a.5.5 0 0 1 .447.276l.956 1.913a.51.51 0 0 1-.497.731c-.91-.073-3.35-.17-4.597-.17-1.247 0-3.688.097-4.597.17a.51.51 0 0 1-.497-.731Z"/>
                    </svg>
                </div>
                <h5 class="fw-semibold mb-0"><c:out value="${item.brand.name}"/></h5>
                <p class="text-muted">Marka pojazdu</p>
            </div>

            <div class="d-flex flex-column gap-2">
                <div
                        class="feature-icon-small d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-4 rounded-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor"
                         class="bi bi-collection" viewBox="0 0 16 16">
                        <path d="M2.5 3.5a.5.5 0 0 1 0-1h11a.5.5 0 0 1 0 1h-11zm2-2a.5.5 0 0 1 0-1h7a.5.5 0 0 1 0 1h-7zM0 13a1.5 1.5 0 0 0 1.5 1.5h13A1.5 1.5 0 0 0 16 13V6a1.5 1.5 0 0 0-1.5-1.5h-13A1.5 1.5 0 0 0 0 6v7zm1.5.5A.5.5 0 0 1 1 13V6a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5h-13z"/>
                    </svg>
                </div>
                <h5 class="fw-semibold mb-0"><c:out value="${item.category.name}"/></h5>
                <p class="text-muted">Kategoria pojazdu</p>
            </div>

            <div class="d-flex flex-column gap-2">
                <div
                        class="feature-icon-small d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-4 rounded-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor"
                         class="bi bi-cash-coin" viewBox="0 0 16 16">
                        <path fill-rule="evenodd"
                              d="M11 15a4 4 0 1 0 0-8 4 4 0 0 0 0 8zm5-4a5 5 0 1 1-10 0 5 5 0 0 1 10 0z"/>
                        <path d="M9.438 11.944c.047.596.518 1.06 1.363 1.116v.44h.375v-.443c.875-.061 1.386-.529 1.386-1.207 0-.618-.39-.936-1.09-1.1l-.296-.07v-1.2c.376.043.614.248.671.532h.658c-.047-.575-.54-1.024-1.329-1.073V8.5h-.375v.45c-.747.073-1.255.522-1.255 1.158 0 .562.378.92 1.007 1.066l.248.061v1.272c-.384-.058-.639-.27-.696-.563h-.668zm1.36-1.354c-.369-.085-.569-.26-.569-.522 0-.294.216-.514.572-.578v1.1h-.003zm.432.746c.449.104.655.272.655.569 0 .339-.257.571-.709.614v-1.195l.054.012z"/>
                        <path d="M1 0a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h4.083c.058-.344.145-.678.258-1H3a2 2 0 0 0-2-2V3a2 2 0 0 0 2-2h10a2 2 0 0 0 2 2v3.528c.38.34.717.728 1 1.154V1a1 1 0 0 0-1-1H1z"/>
                        <path d="M9.998 5.083 10 5a2 2 0 1 0-3.132 1.65 5.982 5.982 0 0 1 3.13-1.567z"/>
                    </svg>
                </div>
                <h5 class="fw-semibold mb-0"><c:out value="${item.price}"/> zł</h5>
                <p class="text-muted">Cena</p>
            </div>

            <div class="d-flex flex-column gap-2">
                <div
                        class="feature-icon-small d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-4 rounded-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor"
                         class="bi bi-calendar-event" viewBox="0 0 16 16">
                        <path d="M11 6.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1z"/>
                        <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
                    </svg>
                </div>
                <h5 class="fw-semibold mb-0"><c:out value="${item.year_of_production}"/> r.</h5>
                <p class="text-muted">Rocznik wyprodukowania pojazdu</p>
            </div>

            <div class="d-flex flex-column gap-2">
                <div
                        class="feature-icon-small d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-4 rounded-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor"
                         class="bi bi-speedometer" viewBox="0 0 16 16">
                        <path d="M8 2a.5.5 0 0 1 .5.5V4a.5.5 0 0 1-1 0V2.5A.5.5 0 0 1 8 2zM3.732 3.732a.5.5 0 0 1 .707 0l.915.914a.5.5 0 1 1-.708.708l-.914-.915a.5.5 0 0 1 0-.707zM2 8a.5.5 0 0 1 .5-.5h1.586a.5.5 0 0 1 0 1H2.5A.5.5 0 0 1 2 8zm9.5 0a.5.5 0 0 1 .5-.5h1.5a.5.5 0 0 1 0 1H12a.5.5 0 0 1-.5-.5zm.754-4.246a.389.389 0 0 0-.527-.02L7.547 7.31A.91.91 0 1 0 8.85 8.569l3.434-4.297a.389.389 0 0 0-.029-.518z"/>
                        <path fill-rule="evenodd"
                              d="M6.664 15.889A8 8 0 1 1 9.336.11a8 8 0 0 1-2.672 15.78zm-4.665-4.283A11.945 11.945 0 0 1 8 10c2.186 0 4.236.585 6.001 1.606a7 7 0 1 0-12.002 0z"/>
                    </svg>
                </div>
                <h5 class="fw-semibold mb-0"><c:out value="${item.mileage}"/> km</h5>
                <p class="text-muted">Przebieg pojazdu</p>
            </div>

            <div class="d-flex flex-column gap-2">
                <div
                        class="feature-icon-small d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-4 rounded-3">
                    <svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor"
                         class="bi bi-telephone-fill" viewBox="0 0 16 16">
                        <path fill-rule="evenodd"
                              d="M1.885.511a1.745 1.745 0 0 1 2.61.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511z"/>
                    </svg>
                </div>
                <h5 class="fw-semibold mb-0"><c:out value="${item.phone_number}"/></h5>
                <p class="text-muted">Numer telefonu właściciela</p>
            </div>
        </div>
        <div class="d-flex flex-column align-items-start gap-2">
            <p class="text-muted"><c:out value="${item.description}"/></p>
        </div>
    </div>
</div>

<jsp:include page="fragments/footer.jsp"/>