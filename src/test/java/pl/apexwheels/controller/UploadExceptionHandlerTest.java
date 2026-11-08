package pl.apexwheels.controller;

import org.junit.jupiter.api.Test;
import org.springframework.context.support.StaticMessageSource;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;
import org.springframework.web.servlet.view.RedirectView;

import java.util.Locale;

import static org.assertj.core.api.Assertions.assertThat;

class UploadExceptionHandlerTest {

    @Test
    void redirectsMultipartFailuresToListingFormWithImageError() {
        StaticMessageSource messages = new StaticMessageSource();
        messages.addMessage("advertising.image.request", Locale.forLanguageTag("pl-PL"),
                "Wybierz prawidłowe zdjęcie do 5 MB.");
        UploadExceptionHandler handler = new UploadExceptionHandler(messages);
        MockHttpServletRequest request = new MockHttpServletRequest("POST", "/user/advertising/create");
        RedirectAttributesModelMap redirectAttributes = new RedirectAttributesModelMap();

        RedirectView response = handler.handleMultipartFailure(
                request, redirectAttributes, new MultipartException("Multipart parse failed"));

        assertThat(response.getUrl()).isEqualTo("/user/advertising/create");
        assertThat(redirectAttributes.getFlashAttributes().get("uploadError"))
                .isEqualTo("Zdjęcie jest za duże lub ma nieprawidłowy format. "
                        + "Wybierz plik JPEG albo PNG o rozmiarze do 5 MB.");
    }

    @Test
    void preservesContextPathWhenRedirectingAfterMultipartFailure() {
        StaticMessageSource messages = new StaticMessageSource();
        messages.addMessage("advertising.image.request", Locale.forLanguageTag("pl-PL"),
                "Wybierz prawidłowe zdjęcie do 5 MB.");
        UploadExceptionHandler handler = new UploadExceptionHandler(messages);
        MockHttpServletRequest request = new MockHttpServletRequest(
                "POST", "/cars/user/advertising/update/42");
        request.setContextPath("/cars");

        RedirectView response = handler.handleMultipartFailure(
                request, new RedirectAttributesModelMap(), new MultipartException("Upload failed"));
        assertThat(response.getUrl()).isEqualTo("/user/advertising/update/42");
        assertThat(response.getUrl()).isEqualTo("/user/advertising/update/42");
    }
}
