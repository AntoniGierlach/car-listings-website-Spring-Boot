package pl.apexwheels.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

@ControllerAdvice
public class UploadExceptionHandler {

    private final MessageSource messageSource;

    public UploadExceptionHandler(MessageSource messageSource) {
        this.messageSource = messageSource;
    }

    @ExceptionHandler(MultipartException.class)
    public RedirectView handleMultipartFailure(HttpServletRequest request,
                                               RedirectAttributes redirectAttributes,
                                               MultipartException exception) {
        String path = request.getRequestURI().substring(request.getContextPath().length());
        redirectAttributes.addFlashAttribute("uploadError", messageSource.getMessage(
                "advertising.image.request", null,
                "Zdjęcie jest za duże lub ma nieprawidłowy format. Wybierz plik JPEG albo PNG o rozmiarze do 5 MB.",
                LocaleContextHolder.getLocale()));
        RedirectView redirectView = new RedirectView(path);
        redirectView.setContextRelative(true);
        return redirectView;
    }
}
