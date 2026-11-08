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

    .text-shadow-1 {
        text-shadow: 0 .125rem .25rem rgba(0, 0, 0, .25);
    }

    .card-cover {
        background-repeat: no-repeat;
        background-position: center center;
        background-size: cover;
    }

</style>

<div class="container px-4 py-5" id="custom-cards">
    <h2 class="pb-2 border-bottom">Lorem Ipsum</h2>

    <div class="row row-cols-1 row-cols-lg-3 align-items-stretch g-4 py-5">
        <div class="col">
            <div class="card card-cover h-100 overflow-hidden text-bg-dark rounded-4 shadow-lg"
                 style="background-image: url('unsplash-photo-1.jpg');">
                <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
                    <h3 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">Lorem ipsum dolor sit amet, consectetur adipiscing
                        elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</h3>
                    <ul class="d-flex list-unstyled mt-auto">
                        <li class="me-auto">
                            <img src="https://github.com/twbs.png" alt="Bootstrap" width="32" height="32"
                                 class="rounded-circle border border-white">
                        </li>
                        <li class="d-flex align-items-center me-3">
                            <i data-lucide="map-pin" class="lucide-icon" aria-hidden="true"></i>
                            <small>Lorem</small>
                        </li>
                        <li class="d-flex align-items-center">
                            <i data-lucide="calendar-days" class="lucide-icon" aria-hidden="true"></i>
                            <small>3d</small>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="card card-cover h-100 overflow-hidden text-bg-dark rounded-4 shadow-lg"
                 style="background-image: url('unsplash-photo-2.jpg');">
                <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
                    <h3 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">Ut enim ad minim veniam, quis nostrud exercitation
                        ullamco laboris nisi ut aliquip ex ea commodo consequat.</h3>
                    <ul class="d-flex list-unstyled mt-auto">
                        <li class="me-auto">
                            <img src="https://github.com/twbs.png" alt="Bootstrap" width="32" height="32"
                                 class="rounded-circle border border-white">
                        </li>
                        <li class="d-flex align-items-center me-3">
                            <i data-lucide="map-pin" class="lucide-icon" aria-hidden="true"></i>
                            <small>Lorem</small>
                        </li>
                        <li class="d-flex align-items-center">
                            <i data-lucide="calendar-days" class="lucide-icon" aria-hidden="true"></i>
                            <small>4d</small>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="card card-cover h-100 overflow-hidden text-bg-dark rounded-4 shadow-lg"
                 style="background-image: url('unsplash-photo-3.jpg');">
                <div class="d-flex flex-column h-100 p-5 pb-3 text-shadow-1">
                    <h3 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">Duis aute irure dolor in reprehenderit in
                        voluptate velit esse cillum dolore eu fugiat nulla pariatur.</h3>
                    <ul class="d-flex list-unstyled mt-auto">
                        <li class="me-auto">
                            <img src="https://github.com/twbs.png" alt="Bootstrap" width="32" height="32"
                                 class="rounded-circle border border-white">
                        </li>
                        <li class="d-flex align-items-center me-3">
                            <i data-lucide="map-pin" class="lucide-icon" aria-hidden="true"></i>
                            <small>Lorem</small>
                        </li>
                        <li class="d-flex align-items-center">
                            <i data-lucide="calendar-days" class="lucide-icon" aria-hidden="true"></i>
                            <small>5d</small>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="fragments/footer.jsp"/>
