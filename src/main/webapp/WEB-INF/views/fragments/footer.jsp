<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
</section>
</main>
<footer class="site-footer">
    <span>&copy; 2026 ApexWheels</span>
    <span class="site-footer-links">
        <a href="<c:url value="/help"/>">Centrum pomocy</a> ·
        <a href="<c:url value="/safety"/>">Bezpieczeństwo</a> ·
        <a href="<c:url value="/contact"/>">Kontakt</a>
    </span>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
        crossorigin="anonymous"></script>
<script src="https://unpkg.com/lucide@latest"></script>
<style>
    .js-favorite,
    .js-compare {
        transition: color .2s ease, border-color .2s ease, background-color .2s ease, transform .2s ease;
    }

    .js-favorite.active {
        color: #d92d20;
        border-color: #d92d20;
        background-color: #fff1f0;
    }

    .js-compare.active {
        color: #1769e0;
        border-color: #1769e0;
        background-color: #eef5ff;
    }

    .js-favorite.is-bouncing,
    .js-compare.is-bouncing {
        animation: listing-action-pop .35s ease;
    }

    @keyframes listing-action-pop {
        0% { transform: scale(1); }
        45% { transform: scale(1.18); }
        100% { transform: scale(1); }
    }

    @media (prefers-reduced-motion: reduce) {
        .js-favorite.is-bouncing,
        .js-compare.is-bouncing {
            animation: none;
        }
    }
</style>
<script>
    (function () {
        const storageKeys = {favorites: "apexwheels.favorites", compare: "apexwheels.compare"};
        const read = (key) => {
            try {
                const value = JSON.parse(localStorage.getItem(key) || "[]");
                return Array.isArray(value) ? value.map(String) : [];
            } catch (error) {
                return [];
            }
        };
        const write = (key, values) => localStorage.setItem(key, JSON.stringify(values));
        const hasServerFavoriteState = Array.isArray(window.apexwheelsFavoriteIds);
        const serverFavoriteIds = hasServerFavoriteState
            ? window.apexwheelsFavoriteIds.map(String)
            : [];
        if (hasServerFavoriteState) {
            write(storageKeys.favorites, serverFavoriteIds);
        }

        function toggle(button, key, limit) {
            const id = String(button.dataset.listingId);
            const values = read(storageKeys[key]);
            const index = values.indexOf(id);
            if (index >= 0) {
                values.splice(index, 1);
            } else {
                if (values.length >= limit) {
                    window.alert(key === "compare" ? "Możesz porównać maksymalnie 4 samochody." : "Nie można dodać więcej ofert.");
                    return false;
                }
                values.push(id);
            }
            write(storageKeys[key], values);
            updateButtons();
            document.dispatchEvent(new CustomEvent("apexwheels:saved-listings-changed"));
            return true;
        }

        function restoreFavoriteState(values) {
            write(storageKeys.favorites, values.map(String));
            updateButtons();
            document.dispatchEvent(new CustomEvent("apexwheels:saved-listings-changed"));
        }

        function updateButtons() {
            document.querySelectorAll(".js-favorite").forEach((button) => {
                const active = read(storageKeys.favorites).includes(String(button.dataset.listingId));
                button.classList.toggle("active", active);
                const label = button.closest(".listing-card") ? "" : (active ? " Usuń z ulubionych" : " Ulubione");
                button.innerHTML = active
                    ? '<i data-lucide="heart" aria-hidden="true"></i>' + label
                    : '<i data-lucide="heart" aria-hidden="true"></i>' + label;
                button.setAttribute("aria-label", active ? "Usuń z ulubionych" : "Dodaj do ulubionych");
            });
            document.querySelectorAll(".js-compare").forEach((button) => {
                const active = read(storageKeys.compare).includes(String(button.dataset.listingId));
                button.classList.toggle("active", active);
                const isRemoveButton = button.classList.contains("compare-remove");
                const label = button.closest(".listing-card") || isRemoveButton
                    ? ""
                    : (active ? " Usuń z porównania" : " Porównaj");
                button.innerHTML = isRemoveButton
                    ? '<i data-lucide="trash-2" aria-hidden="true"></i>'
                    : (active
                        ? '<i data-lucide="check" aria-hidden="true"></i>' + label
                        : '<i data-lucide="arrow-left-right" aria-hidden="true"></i>' + label);
                button.setAttribute("aria-label", active ? "Usuń z porównania" : "Dodaj do porównania");
            });
            lucide.createIcons();
        }

        document.addEventListener("click", (event) => {
            const favorite = event.target.closest(".js-favorite");
            const compare = event.target.closest(".js-compare");
            const favoriteCard = event.target.closest(".favorite-card");
            const listingCard = event.target.closest(".js-listing-card");
            if (listingCard
                && !event.target.closest("a, button, form, input, select, textarea")
                && !event.defaultPrevented) {
                const detailsUrl = listingCard.dataset.detailsUrl;
                if (detailsUrl) {
                    window.location.assign(detailsUrl);
                }
                return;
            }
            if (favoriteCard
                && !event.target.closest("a, button, form, input, select, textarea")
                && !event.defaultPrevented) {
                const detailsLink = favoriteCard.querySelector(".favorite-card-link");
                if (detailsLink) {
                    window.location.assign(detailsLink.href);
                }
                return;
            }
            if (favorite) {
                event.preventDefault();
                event.stopPropagation();
                const form = favorite.closest("form");
                if (form) {
                    const changed = toggle(favorite, "favorites", 100);
                    if (!changed) return;
                    fetch(form.action, {
                        method: "POST",
                        body: new URLSearchParams(new FormData(form)),
                        credentials: "same-origin",
                        headers: {"X-Requested-With": "XMLHttpRequest"}
                    }).then((response) => {
                        if (!response.ok) throw new Error("Favorite update failed");
                        return response.json();
                    }).then((data) => {
                        if (!Array.isArray(data.favoriteListingIds)) {
                            throw new Error("Favorite response is invalid");
                        }
                        restoreFavoriteState(data.favoriteListingIds);
                        const favoriteCard = favorite.closest(".favorite-card");
                        if (favoriteCard && !read(storageKeys.favorites).includes(String(favorite.dataset.listingId))) {
                            favoriteCard.remove();
                        }
                    }).catch(() => {
                        const values = read(storageKeys.favorites);
                        const id = String(favorite.dataset.listingId);
                        const index = values.indexOf(id);
                        if (index >= 0) {
                            values.splice(index, 1);
                        } else {
                            values.push(id);
                        }
                        restoreFavoriteState(values);
                    });
                } else {
                    toggle(favorite, "favorites", 100);
                }
                favorite.classList.remove("is-bouncing");
                void favorite.offsetWidth;
                favorite.classList.add("is-bouncing");
            }
            if (compare) {
                event.preventDefault();
                event.stopPropagation();
                toggle(compare, "compare", 4);
                compare.classList.remove("is-bouncing");
                void compare.offsetWidth;
                compare.classList.add("is-bouncing");
            }
        });
        window.addEventListener("storage", (event) => {
            if (event.key === storageKeys.favorites || event.key === storageKeys.compare) {
                updateButtons();
            }
        });
        updateButtons();
    }());
</script>

</body>
</html>
