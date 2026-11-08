<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../fragments/header.jsp"/>

<div class="page-container listing-editor">
    <p class="eyebrow">Panel sprzedającego / ogłoszenia</p>
    <h1><c:choose><c:when test="${not empty advertising.id}">Edytuj ogłoszenie</c:when><c:otherwise>Dodaj ogłoszenie</c:otherwise></c:choose></h1>
    <p class="lead listing-editor__intro">Uzupełnij informacje o samochodzie. Im dokładniejszy opis, tym łatwiej zainteresowanym ocenić ofertę.</p>

    <c:if test="${not empty uploadError}">
        <div class="alert alert-danger" role="alert"><c:out value="${uploadError}"/></div>
    </c:if>

    <div class="listing-editor__layout">
        <form:form method="post" modelAttribute="advertising" enctype="multipart/form-data"
                   cssClass="listing-editor__form" novalidate="true">
            <form:hidden path="id"/>

            <c:if test="${hasValidationErrors}">
                <div class="listing-editor__error-summary" role="alert" aria-live="polite">
                    <strong>Nie udało się zapisać ogłoszenia.</strong>
                    <span>Popraw pola oznaczone poniżej i spróbuj ponownie.</span>
                </div>
            </c:if>

            <section class="surface-card surface-card--padded listing-editor__section" aria-labelledby="vehicle-heading">
                <div class="listing-editor__section-heading">
                    <span class="listing-editor__step" aria-hidden="true">01</span>
                    <div>
                        <h2 id="vehicle-heading">Samochód</h2>
                        <p>Podstawowe informacje i parametry pojazdu.</p>
                    </div>
                </div>
                <div class="row g-3">
                    <div class="col-12">
                        <form:label cssClass="form-label" path="title">Tytuł ogłoszenia</form:label>
                        <form:input cssClass="form-control" cssErrorClass="form-control is-invalid"
                                    path="title" maxlength="120" aria-describedby="title-error"/>
                        <div id="title-error"><form:errors path="title" cssClass="listing-editor__field-error" element="div"/></div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="brand-search">Marka</label>
                        <div class="search-select listing-editor__custom-select" data-listing-select
                             data-empty-message="Brak pasujących marek">
                            <input type="text" class="search-select-input${brandHasErrors ? ' is-invalid' : ''}"
                                   id="brand-search" placeholder="Wybierz lub wpisz markę"
                                   role="combobox" aria-autocomplete="list" aria-haspopup="listbox"
                                   aria-expanded="false" aria-controls="brand-options"
                                   aria-describedby="brand-error"
                                   aria-invalid="${brandHasErrors ? 'true' : 'false'}" autocomplete="off">
                            <button type="button" class="search-select-toggle" aria-label="Pokaż marki"
                                    aria-controls="brand-options" tabindex="-1">
                                <i data-lucide="chevron-down" aria-hidden="true"></i>
                            </button>
                            <div class="search-select-options" id="brand-options" role="listbox" aria-label="Marki">
                                <span class="search-select-empty">Brak pasujących marek</span>
                            </div>
                        </div>
                        <form:select id="brand-select" cssClass="listing-editor__native-select" path="brand.id"
                                     aria-hidden="true" tabindex="-1">
                            <form:option value="" label="Wybierz markę"/>
                            <form:options items="${brand}" itemLabel="name" itemValue="id"/>
                        </form:select>
                        <div id="brand-error">
                            <form:errors path="brand" cssClass="listing-editor__field-error" element="div"/>
                            <form:errors path="brand.id" cssClass="listing-editor__field-error" element="div"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="category-search">Typ nadwozia</label>
                        <div class="search-select listing-editor__custom-select" data-listing-select
                             data-empty-message="Brak pasujących kategorii">
                            <input type="text" class="search-select-input${categoryHasErrors ? ' is-invalid' : ''}"
                                   id="category-search" placeholder="Wybierz lub wpisz kategorię"
                                   role="combobox" aria-autocomplete="list" aria-haspopup="listbox"
                                   aria-expanded="false" aria-controls="category-options"
                                   aria-describedby="category-error"
                                   aria-invalid="${categoryHasErrors ? 'true' : 'false'}" autocomplete="off">
                            <button type="button" class="search-select-toggle" aria-label="Pokaż typy nadwozia"
                                    aria-controls="category-options" tabindex="-1">
                                <i data-lucide="chevron-down" aria-hidden="true"></i>
                            </button>
                            <div class="search-select-options" id="category-options" role="listbox"
                                 aria-label="Typy nadwozia">
                                <span class="search-select-empty">Brak pasujących kategorii</span>
                            </div>
                        </div>
                        <form:select id="category-select" cssClass="listing-editor__native-select" path="category.id"
                                     aria-hidden="true" tabindex="-1">
                            <form:option value="" label="Wybierz typ nadwozia"/>
                            <form:options items="${category}" itemLabel="name" itemValue="id"/>
                        </form:select>
                        <div id="category-error">
                            <form:errors path="category" cssClass="listing-editor__field-error" element="div"/>
                            <form:errors path="category.id" cssClass="listing-editor__field-error" element="div"/>
                        </div>
                    </div>
                    <div class="col-12">
                        <form:label cssClass="form-label" path="description">Opis samochodu</form:label>
                        <form:textarea cssClass="form-control listing-editor__textarea"
                                       cssErrorClass="form-control listing-editor__textarea is-invalid"
                                       path="description" rows="5" maxlength="1000"
                                       aria-describedby="description-help description-error"/>
                        <div class="form-text" id="description-help">Opisz stan samochodu, jego historię i najważniejsze wyposażenie.</div>
                        <div id="description-error"><form:errors path="description" cssClass="listing-editor__field-error" element="div"/></div>
                    </div>
                    <div class="col-sm-6">
                        <form:label cssClass="form-label" path="year_of_production">Rok produkcji</form:label>
                        <form:input cssClass="form-control" cssErrorClass="form-control is-invalid"
                                    path="year_of_production" type="number" min="1900" max="${maxProductionYear}"
                                    aria-describedby="year_of_production-error"/>
                        <div id="year_of_production-error"><form:errors path="year_of_production" cssClass="listing-editor__field-error" element="div"/></div>
                    </div>
                    <div class="col-sm-6">
                        <form:label cssClass="form-label" path="mileage">Przebieg <span class="text-muted">(km)</span></form:label>
                        <form:input cssClass="form-control" cssErrorClass="form-control is-invalid"
                                    path="mileage" type="number" min="1" max="2000000"
                                    aria-describedby="mileage-error"/>
                        <div id="mileage-error"><form:errors path="mileage" cssClass="listing-editor__field-error" element="div"/></div>
                    </div>
                    <div class="col-sm-6">
                        <form:label cssClass="form-label" path="power">Moc silnika <span class="text-muted">(KM)</span></form:label>
                        <form:input cssClass="form-control" cssErrorClass="form-control is-invalid"
                                    path="power" type="number" min="1" max="2000"
                                    aria-describedby="power-error"/>
                        <div id="power-error"><form:errors path="power" cssClass="listing-editor__field-error" element="div"/></div>
                    </div>
                    <div class="col-sm-6">
                        <label class="form-label" for="fuelType-search">Rodzaj paliwa</label>
                        <div class="search-select listing-editor__custom-select" data-listing-select
                             data-empty-message="Brak pasujących rodzajów paliwa">
                            <input type="text" class="search-select-input${fuelTypeHasErrors ? ' is-invalid' : ''}"
                                   id="fuelType-search" placeholder="Wybierz rodzaj paliwa"
                                   role="combobox" aria-autocomplete="list" aria-haspopup="listbox"
                                   aria-expanded="false" aria-controls="fuelType-options"
                                   aria-describedby="fuelType-error"
                                   aria-invalid="${fuelTypeHasErrors ? 'true' : 'false'}" autocomplete="off">
                            <button type="button" class="search-select-toggle" aria-label="Pokaż rodzaje paliwa"
                                    aria-controls="fuelType-options" tabindex="-1">
                                <i data-lucide="chevron-down" aria-hidden="true"></i>
                            </button>
                            <div class="search-select-options" id="fuelType-options" role="listbox" aria-label="Rodzaje paliwa">
                                <span class="search-select-empty">Brak pasujących rodzajów paliwa</span>
                            </div>
                        </div>
                        <form:select id="fuelType-select" cssClass="listing-editor__native-select" path="fuelType"
                                     aria-hidden="true" tabindex="-1">
                            <form:option value="" label="Wybierz rodzaj paliwa"/>
                            <form:option value="Benzyna" label="Benzyna"/>
                            <form:option value="Diesel" label="Diesel"/>
                            <form:option value="Hybryda" label="Hybryda"/>
                            <form:option value="Elektryczny" label="Elektryczny"/>
                            <form:option value="LPG" label="LPG"/>
                        </form:select>
                        <div id="fuelType-error"><form:errors path="fuelType" cssClass="listing-editor__field-error" element="div"/></div>
                    </div>
                    <div class="col-sm-6">
                        <label class="form-label" for="vehicleCondition-search">Stan pojazdu</label>
                        <div class="search-select listing-editor__custom-select" data-listing-select
                             data-empty-message="Brak pasujących stanów">
                            <input type="text" class="search-select-input${vehicleConditionHasErrors ? ' is-invalid' : ''}"
                                   id="vehicleCondition-search" placeholder="Wybierz stan"
                                   role="combobox" aria-autocomplete="list" aria-haspopup="listbox"
                                   aria-expanded="false" aria-controls="vehicleCondition-options"
                                   aria-describedby="vehicleCondition-error"
                                   aria-invalid="${vehicleConditionHasErrors ? 'true' : 'false'}" autocomplete="off">
                            <button type="button" class="search-select-toggle" aria-label="Pokaż stany pojazdu"
                                    aria-controls="vehicleCondition-options" tabindex="-1">
                                <i data-lucide="chevron-down" aria-hidden="true"></i>
                            </button>
                            <div class="search-select-options" id="vehicleCondition-options" role="listbox" aria-label="Stany pojazdu">
                                <span class="search-select-empty">Brak pasujących stanów</span>
                            </div>
                        </div>
                        <form:select id="vehicleCondition-select" cssClass="listing-editor__native-select" path="vehicleCondition"
                                     aria-hidden="true" tabindex="-1">
                            <form:option value="" label="Wybierz stan"/>
                            <form:option value="Nowy" label="Nowy"/>
                            <form:option value="Używany" label="Używany"/>
                        </form:select>
                        <div id="vehicleCondition-error"><form:errors path="vehicleCondition" cssClass="listing-editor__field-error" element="div"/></div>
                    </div>
                    <div class="col-sm-6">
                        <label class="form-label" for="damageStatus-search">Stan uszkodzeń</label>
                        <div class="search-select listing-editor__custom-select" data-listing-select
                             data-empty-message="Brak pasujących stanów uszkodzeń">
                            <input type="text" class="search-select-input${damageStatusHasErrors ? ' is-invalid' : ''}"
                                   id="damageStatus-search" placeholder="Wybierz stan uszkodzeń"
                                   role="combobox" aria-autocomplete="list" aria-haspopup="listbox"
                                   aria-expanded="false" aria-controls="damageStatus-options"
                                   aria-describedby="damageStatus-error"
                                   aria-invalid="${damageStatusHasErrors ? 'true' : 'false'}" autocomplete="off">
                            <button type="button" class="search-select-toggle" aria-label="Pokaż stany uszkodzeń"
                                    aria-controls="damageStatus-options" tabindex="-1">
                                <i data-lucide="chevron-down" aria-hidden="true"></i>
                            </button>
                            <div class="search-select-options" id="damageStatus-options" role="listbox" aria-label="Stany uszkodzeń">
                                <span class="search-select-empty">Brak pasujących stanów uszkodzeń</span>
                            </div>
                        </div>
                        <form:select id="damageStatus-select" cssClass="listing-editor__native-select" path="damageStatus"
                                     aria-hidden="true" tabindex="-1">
                            <form:option value="" label="Wybierz stan"/>
                            <form:option value="Nieuszkodzony" label="Nieuszkodzony"/>
                            <form:option value="Uszkodzony" label="Uszkodzony"/>
                        </form:select>
                        <div id="damageStatus-error"><form:errors path="damageStatus" cssClass="listing-editor__field-error" element="div"/></div>
                    </div>
                </div>
            </section>

            <section class="surface-card surface-card--padded listing-editor__section" aria-labelledby="price-heading">
                <div class="listing-editor__section-heading">
                    <span class="listing-editor__step" aria-hidden="true">02</span>
                    <div>
                        <h2 id="price-heading">Cena i kontakt</h2>
                        <p>Podaj cenę i numer telefonu, pod którym można zapytać o ofertę.</p>
                    </div>
                </div>
                <div class="row g-3">
                    <div class="col-md-6">
                        <form:label cssClass="form-label" path="price">Cena <span class="text-muted">(zł)</span></form:label>
                        <form:input cssClass="form-control" cssErrorClass="form-control is-invalid"
                                    path="price" type="number" min="1" max="100000000"
                                    aria-describedby="price-error"/>
                        <div id="price-error"><form:errors path="price" cssClass="listing-editor__field-error" element="div"/></div>
                    </div>
                    <div class="col-md-6">
                        <form:label cssClass="form-label" path="phone_number">Numer telefonu</form:label>
                        <form:input cssClass="form-control" cssErrorClass="form-control is-invalid"
                                    path="phone_number" type="tel" inputmode="numeric" maxlength="9"
                                    aria-describedby="phone_number-help phone_number-error"/>
                        <div class="form-text" id="phone_number-help">Wpisz 9 cyfr, bez kierunkowego kraju.</div>
                        <div id="phone_number-error"><form:errors path="phone_number" cssClass="listing-editor__field-error" element="div"/></div>
                    </div>
                </div>
            </section>

            <section class="surface-card surface-card--padded listing-editor__section" aria-labelledby="photo-heading">
                <div class="listing-editor__section-heading">
                    <span class="listing-editor__step" aria-hidden="true">03</span>
                    <div>
                        <h2 id="photo-heading">Zdjęcie</h2>
                        <p>Dodaj jedno wyraźne zdjęcie samochodu. Plik nie może przekraczać 5 MB.</p>
                    </div>
                </div>
                <label class="listing-editor__upload" for="imageFile">
                    <span class="listing-editor__upload-icon" aria-hidden="true">+</span>
                    <span><strong>Wybierz zdjęcie</strong><small>JPG lub PNG, maksymalnie 5 MB</small></span>
                    <input class="form-control" id="imageFile" name="imageFile" type="file"
                           accept="image/jpeg,image/png" aria-describedby="image-error">
                </label>
                <div class="listing-editor__field-error" id="image-error" role="status" aria-live="polite">
                    <form:errors path="image"/>
                </div>
                <c:if test="${not empty advertising.image}">
                    <div class="listing-editor__current-image">
                        <c:url var="currentImageUrl" value="/images/optimized/${advertising.image}"/>
                        <img src="<c:out value="${currentImageUrl}"/>" alt="Obecne zdjęcie samochodu w ogłoszeniu">
                        <p>Obecne zdjęcie. Wybierz nowy plik, aby je zastąpić.</p>
                    </div>
                </c:if>
            </section>

            <div class="listing-editor__actions">
                <a class="btn btn-outline-secondary" href="<c:url value="/user/advertising/list"/>">Anuluj</a>
                <button class="btn btn-apex listing-editor__submit" type="submit">
                    <c:choose><c:when test="${not empty advertising.id}">Zapisz zmiany</c:when><c:otherwise>Opublikuj ogłoszenie</c:otherwise></c:choose>
                </button>
            </div>
        </form:form>

        <aside class="listing-editor__aside">
            <div class="surface-card surface-card--padded listing-editor__tip">
                <span class="listing-editor__tip-label">Wskazówka</span>
                <h2>Kompletna oferta budzi zaufanie</h2>
                <p>Uzupełnij dane zgodnie ze stanem samochodu. Rzetelny opis i aktualne zdjęcie ułatwiają kupującym podjęcie decyzji.</p>
            </div>
            <div class="listing-editor__note">
                <strong>Twoje dane pozostaną w formularzu</strong>
                <p>Jeśli któryś wpis wymaga poprawy, zobaczysz wskazówkę przy odpowiednim polu.</p>
            </div>
        </aside>
    </div>
</div>

<style>
    .listing-editor { padding-bottom: 48px; }
    .listing-editor__intro { margin-bottom: 28px; }
    .listing-editor__layout { display: grid; grid-template-columns: minmax(0, 1fr) 280px; gap: 24px; align-items: start; }
    .listing-editor__form { display: grid; gap: 18px; min-width: 0; }
    .listing-editor__section { min-width: 0; }
    .listing-editor__section-heading { display: flex; align-items: flex-start; gap: 14px; margin-bottom: 22px; }
    .listing-editor__section-heading h2 { margin: 0 0 4px; color: var(--navy); font-size: 1.08rem; font-weight: 800; }
    .listing-editor__section-heading p { margin: 0; color: var(--muted); font-size: .85rem; line-height: 1.5; }
    .listing-editor__step { display: grid; flex: 0 0 38px; width: 38px; height: 38px; place-items: center; border-radius: 10px; background: var(--orange-soft); color: var(--orange); font-size: .76rem; font-weight: 800; }
    .listing-editor .form-label { margin-bottom: 7px; color: var(--navy); font-size: .84rem; font-weight: 700; }
    .listing-editor__custom-select { margin: 0; }
    .listing-editor__custom-select .search-select-input {
        min-height: 46px;
        padding: 11px 38px 11px 12px;
        border-color: var(--line);
        border-radius: 8px;
        background-color: var(--surface);
        color: var(--ink);
        font: inherit;
        font-size: 1rem;
    }
    .listing-editor__custom-select .search-select-input:focus {
        border-color: var(--orange);
        box-shadow: 0 0 0 3px rgba(226,125,69,.15);
    }
    .listing-editor__custom-select .search-select-toggle { width: 40px; height: 46px; }
    .listing-editor__custom-select .search-select-options { max-height: 190px; }
    .listing-editor__custom-select .search-select-option { padding: 9px 10px; font-size: .9rem; }
    .listing-editor__custom-select .search-select-option.is-active,
    .listing-editor__custom-select .search-select-option:hover,
    .listing-editor__custom-select .search-select-option:focus-visible {
        background: var(--orange-soft);
        color: var(--navy);
    }
    .listing-editor__native-select {
        position: absolute;
        width: 1px;
        height: 1px;
        overflow: hidden;
        clip-path: inset(50%);
        white-space: nowrap;
    }
    .listing-editor__textarea { min-height: 128px; resize: vertical; }
    .listing-editor .form-text { color: var(--muted); font-size: .76rem; }
    .listing-editor__field-error { margin-top: 6px; color: #b42318; font-size: .8rem; line-height: 1.45; }
    .listing-editor .is-invalid { border-color: #b42318; }
    .listing-editor .is-invalid:focus { border-color: #b42318; box-shadow: 0 0 0 3px rgba(180,35,24,.12); }
    .listing-editor__error-summary { display: grid; gap: 3px; padding: 14px 16px; border: 1px solid #f1b8b5; border-radius: 10px; background: #fff5f4; color: #8f1d18; font-size: .86rem; }
    .listing-editor__upload { display: flex; align-items: center; gap: 13px; min-height: 82px; padding: 16px; border: 1px var(--orange) #c8d0d4; border-radius: 10px; background: #fbfcfb; cursor: pointer; }
    .listing-editor__upload:focus-within { outline: 3px solid rgba(226,125,69,.22); border-color: var(--orange); }
    .listing-editor__upload-icon { display: grid; flex: 0 0 40px; width: 40px; height: 40px; place-items: center; border-radius: 10px; background: var(--orange-soft); color: var(--orange); font-size: 1.5rem; }
    .listing-editor__upload strong, .listing-editor__upload small { display: block; }
    .listing-editor__upload strong { color: var(--navy); font-size: .86rem; }
    .listing-editor__upload small { margin-top: 3px; color: var(--muted); font-size: .76rem; }
    .listing-editor__upload input { min-width: 0; margin-left: auto; max-width: 58%; font-size: .78rem; }
    .listing-editor__current-image { display: flex; align-items: center; gap: 14px; margin-top: 16px; }
    .listing-editor__current-image img { width: 96px; height: 72px; border-radius: 8px; object-fit: cover; }
    .listing-editor__current-image p { margin: 0; color: var(--muted); font-size: .8rem; }
    .listing-editor__actions { display: flex; justify-content: flex-end; gap: 10px; }
    .listing-editor__actions .btn { min-height: 46px; padding: 10px 18px; border-radius: 8px; font-weight: 700; }
    .listing-editor__submit { min-width: 190px; }
    .listing-editor__aside { position: sticky; top: 100px; display: grid; gap: 14px; }
    .listing-editor__tip { background: var(--navy); color: #fff; }
    .listing-editor__tip-label { color: #f3a777; font-size: .7rem; font-weight: 800; letter-spacing: .12em; text-transform: uppercase; }
    .listing-editor__tip h2 { margin: 12px 0 8px; font-size: 1.12rem; font-weight: 800; line-height: 1.35; }
    .listing-editor__tip p, .listing-editor__note p { margin: 0; color: inherit; font-size: .82rem; line-height: 1.65; opacity: .76; }
    .listing-editor__note { padding: 16px; border-left: 3px solid var(--orange); color: var(--navy); }
    .listing-editor__note strong { display: block; margin-bottom: 5px; font-size: .83rem; }
    @media (max-width: 900px) {
        .listing-editor__layout { grid-template-columns: minmax(0, 1fr); }
        .listing-editor__aside { position: static; grid-template-columns: repeat(2, minmax(0, 1fr)); }
    }
    @media (max-width: 575px) {
        .listing-editor__aside { grid-template-columns: minmax(0, 1fr); }
        .listing-editor__upload { align-items: flex-start; flex-wrap: wrap; }
        .listing-editor__upload input { width: 100%; max-width: none; margin: 0; }
        .listing-editor__actions { flex-direction: column-reverse; }
        .listing-editor__actions .btn { width: 100%; }
        .listing-editor__step { flex-basis: 34px; width: 34px; height: 34px; }
    }
</style>

<script>
    (() => {
        const form = document.querySelector(".listing-editor__form");
        const imageInput = document.getElementById("imageFile");
        const imageError = document.getElementById("image-error");
        const maxFileSize = 5 * 1024 * 1024;
        const acceptedTypes = ["image/jpeg", "image/png"];

        if (!form || !imageInput || !imageError) {
            return;
        }

        const validateImage = () => {
            imageError.textContent = "";
            imageInput.removeAttribute("aria-invalid");

            const file = imageInput.files && imageInput.files[0];
            if (!file) {
                return true;
            }
            const extension = file.name.toLowerCase().split(".").pop();
            if ((file.type && !acceptedTypes.includes(file.type))
                    || (!file.type && !["jpg", "jpeg", "png"].includes(extension))) {
                imageError.textContent = "Wybierz zdjęcie w formacie JPG lub PNG.";
            } else if (file.size > maxFileSize) {
                imageError.textContent = "Zdjęcie nie może być większe niż 5 MB.";
            }

            if (imageError.textContent) {
                imageInput.setAttribute("aria-invalid", "true");
                return false;
            }
            return true;
        };

        imageInput.addEventListener("change", validateImage);
        form.addEventListener("submit", event => {
            if (!validateImage()) {
                event.preventDefault();
                imageInput.focus();
            }
        });
    })();

    document.querySelectorAll("[data-listing-select]").forEach(picker => {
        const input = picker.querySelector(".search-select-input");
        const toggle = picker.querySelector(".search-select-toggle");
        const optionsList = picker.querySelector(".search-select-options");
        const empty = picker.querySelector(".search-select-empty");
        const nativeSelect = picker.nextElementSibling;
        const options = Array.from(nativeSelect.options)
            .filter(option => option.value)
            .map((nativeOption, index) => {
                const option = document.createElement("button");
                option.type = "button";
                option.className = "search-select-option";
                option.id = nativeSelect.id + "-option-" + index;
                option.setAttribute("role", "option");
                option.setAttribute("aria-selected", String(nativeOption.value === nativeSelect.value));
                option.dataset.value = nativeOption.value;
                option.textContent = nativeOption.textContent.trim();
                optionsList.insertBefore(option, empty);
                return option;
            });
        let activeIndex = -1;

        const close = () => {
            picker.classList.remove("is-open");
            input.setAttribute("aria-expanded", "false");
            input.removeAttribute("aria-activedescendant");
            activeIndex = -1;
            options.forEach(option => option.classList.remove("is-active"));
            const selected = options.find(option => option.dataset.value === nativeSelect.value);
            input.value = selected ? selected.textContent.trim() : "";
        };

        const filterOptions = () => {
            const query = input.value.trim().toLocaleLowerCase("pl");
            let visibleCount = 0;
            activeIndex = -1;
            input.removeAttribute("aria-activedescendant");
            options.forEach(option => option.classList.remove("is-active"));
            options.forEach(option => {
                const matches = option.textContent.trim().toLocaleLowerCase("pl").includes(query);
                option.hidden = !matches;
                option.setAttribute("aria-selected", String(option.dataset.value === nativeSelect.value));
                if (matches) {
                    visibleCount += 1;
                }
            });
            empty.textContent = picker.dataset.emptyMessage;
            empty.style.display = visibleCount ? "none" : "block";
            picker.classList.add("is-open");
            input.setAttribute("aria-expanded", "true");
        };

        const choose = option => {
            input.value = option.textContent.trim();
            nativeSelect.value = option.dataset.value;
            nativeSelect.dispatchEvent(new Event("change", { bubbles: true }));
            close();
        };

        const selectedOption = options.find(option => option.dataset.value === nativeSelect.value);
        if (selectedOption) {
            input.value = selectedOption.textContent.trim();
        }

        input.addEventListener("focus", () => {
            if (!picker.classList.contains("is-open")) {
                input.value = "";
                filterOptions();
            }
        });
        input.addEventListener("input", () => {
            const query = input.value.trim().toLocaleLowerCase("pl");
            const matchingOption = options.find(option =>
                option.textContent.trim().toLocaleLowerCase("pl") === query);
            nativeSelect.value = matchingOption ? matchingOption.dataset.value : "";
            filterOptions();
        });
        toggle.addEventListener("click", () => {
            if (picker.classList.contains("is-open")) {
                close();
            } else {
                filterOptions();
            }
            input.focus();
        });
        toggle.addEventListener("mousedown", event => event.preventDefault());

        options.forEach(option => option.addEventListener("click", () => choose(option)));

        input.addEventListener("keydown", event => {
            if (event.key === "Escape") {
                close();
                return;
            }
            if (event.key === "ArrowDown" || event.key === "ArrowUp") {
                event.preventDefault();
                if (!picker.classList.contains("is-open")) {
                    filterOptions();
                }
                const visibleOptions = options.filter(option => !option.hidden);
                if (!visibleOptions.length) {
                    return;
                }
                const direction = event.key === "ArrowDown" ? 1 : -1;
                activeIndex = activeIndex < 0
                    ? (direction === 1 ? 0 : visibleOptions.length - 1)
                    : (activeIndex + direction + visibleOptions.length) % visibleOptions.length;
                const activeOption = visibleOptions[activeIndex];
                options.forEach(option => option.classList.remove("is-active"));
                activeOption.classList.add("is-active");
                input.setAttribute("aria-activedescendant", activeOption.id);
                activeOption.scrollIntoView({ block: "nearest" });
                return;
            }
            if (event.key === "Enter" && picker.classList.contains("is-open")) {
                const activeOption = options.filter(option => !option.hidden)[activeIndex];
                if (activeOption) {
                    event.preventDefault();
                    choose(activeOption);
                }
            }
        });

        input.addEventListener("blur", () => {
            window.setTimeout(() => {
                if (!picker.contains(document.activeElement)) {
                    close();
                }
            }, 0);
        });

        document.addEventListener("click", event => {
            if (!picker.contains(event.target)) {
                close();
            }
        });
    });
</script>

<jsp:include page="../fragments/footer.jsp"/>
