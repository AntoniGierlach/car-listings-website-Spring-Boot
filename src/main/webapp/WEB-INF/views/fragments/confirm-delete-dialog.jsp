<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<dialog class="confirm-delete-dialog" data-confirm-delete-dialog
        aria-labelledby="confirm-delete-title" aria-describedby="confirm-delete-message">
    <div class="confirm-delete-dialog__content">
        <p class="eyebrow">Potwierdzenie</p>
        <h2 id="confirm-delete-title">Usunąć ten element?</h2>
        <p id="confirm-delete-message" data-confirm-delete-message></p>
        <form method="post" data-confirm-delete-form>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            <input type="hidden" name="remove" value="Tak">
            <div class="confirm-delete-dialog__actions">
                <button type="button" class="btn btn-outline-secondary" data-confirm-delete-cancel>Anuluj</button>
                <button type="submit" class="btn btn-danger">Tak, usuń</button>
            </div>
        </form>
    </div>
</dialog>

<style>
    .confirm-delete-dialog:not([open]) {
        display: none;
    }

    .confirm-delete-dialog {
        width: min(460px, calc(100% - 32px));
        max-width: none;
        padding: 0;
        overflow: visible;
        border: 0;
        border-radius: 16px;
        color: var(--ink);
        background: transparent;
    }

    .confirm-delete-dialog::backdrop {
        background: rgba(8, 20, 34, .68);
        backdrop-filter: blur(2px);
    }

    .confirm-delete-dialog__content {
        padding: clamp(22px, 5vw, 32px);
        border: 1px solid var(--line);
        border-radius: inherit;
        background: var(--surface);
        box-shadow: 0 24px 70px rgba(0, 0, 0, .25);
    }

    .confirm-delete-dialog__content h2 {
        margin: 0 0 10px;
        color: var(--navy);
        font-size: 1.35rem;
    }

    .confirm-delete-dialog__content > p:not(.eyebrow) {
        margin: 0;
        color: var(--muted);
        line-height: 1.6;
        overflow-wrap: anywhere;
    }

    .confirm-delete-dialog__actions {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        margin-top: 24px;
    }

    .confirm-delete-dialog__actions .btn {
        min-height: 44px;
    }

    .confirm-delete-dialog button:focus-visible {
        outline: 3px solid rgba(226, 125, 69, .5);
        outline-offset: 2px;
    }

    @media (max-width: 420px) {
        .confirm-delete-dialog__actions {
            flex-direction: column-reverse;
        }

        .confirm-delete-dialog__actions .btn {
            width: 100%;
        }
    }
</style>

<script>
    (() => {
        const dialog = document.querySelector("[data-confirm-delete-dialog]");
        if (!dialog) {
            return;
        }

        const form = dialog.querySelector("[data-confirm-delete-form]");
        const message = dialog.querySelector("[data-confirm-delete-message]");
        const cancel = dialog.querySelector("[data-confirm-delete-cancel]");
        const supportsModalDialog = typeof dialog.showModal === "function";

        if (!supportsModalDialog) {
            document.querySelectorAll("[data-delete-action]").forEach(button => {
                button.addEventListener("click", () => {
                    form.action = button.dataset.deleteAction;
                    message.textContent = "Czy na pewno chcesz usunąć " + button.dataset.deleteLabel + "?";
                    if (window.confirm(message.textContent)) {
                        form.submit();
                    }
                });
            });
            return;
        }

        let trigger = null;

        document.querySelectorAll("[data-delete-action]").forEach(button => {
            button.addEventListener("click", () => {
                trigger = button;
                form.action = button.dataset.deleteAction;
                message.textContent = "Czy na pewno chcesz usunąć " + button.dataset.deleteLabel + "?";
                dialog.showModal();
                cancel.focus();
            });
        });

        cancel.addEventListener("click", () => dialog.close());
        dialog.addEventListener("close", () => {
            if (trigger && trigger.isConnected) {
                trigger.focus();
            }
        });
        dialog.addEventListener("click", event => {
            const bounds = dialog.getBoundingClientRect();
            const outside = event.clientX < bounds.left || event.clientX > bounds.right
                || event.clientY < bounds.top || event.clientY > bounds.bottom;
            if (outside) {
                dialog.close();
            }
        });
    })();
</script>
