package pl.apexwheels.service;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.util.unit.DataSize;

import javax.imageio.ImageIO;
import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.Locale;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

class ListingImageStorageServiceTest {

    @TempDir
    Path temporaryDirectory;

    @Test
    void resolvesListingImageErrorsWhenBrowserLocaleIsNotPolish() {
        ResourceBundleMessageSource messages = new ResourceBundleMessageSource();
        messages.setBasenames("messages");
        messages.setDefaultEncoding("UTF-8");
        Locale browserLocale = Locale.forLanguageTag("en-PL");

        assertThat(messages.getMessage("advertising.image.dimensions", null, browserLocale))
                .isEqualTo("Zdjęcie ma zbyt duże wymiary. Wybierz plik o rozdzielczości do 16 megapikseli.");
        assertThat(List.of("invalid", "format", "size", "multiple", "storage"))
                .allSatisfy(error -> assertThat(messages.getMessage(
                        "advertising.image." + error, null, browserLocale)).isNotBlank());
    }

    @Test
    void storesOptimizedImageAndThumbnailAsJpeg() throws IOException {
        ListingImageStorageService service = new ListingImageStorageService(
                temporaryDirectory.toString(), DataSize.ofMegabytes(5));
        MockMultipartFile file = new MockMultipartFile("imageFile", "car.png", "image/png",
                pngImage(2000, 1000));

        String filename = service.store(file);

        assertThat(filename).matches("upload-[0-9a-fA-F-]{36}\\.jpg");
        BufferedImage optimized = ImageIO.read(service.getOptimizedDirectory().resolve(filename).toFile());
        BufferedImage thumbnail = ImageIO.read(service.getThumbnailDirectory().resolve(filename).toFile());
        assertThat(optimized.getWidth()).isEqualTo(1600);
        assertThat(optimized.getHeight()).isEqualTo(800);
        assertThat(thumbnail.getWidth()).isEqualTo(480);
        assertThat(thumbnail.getHeight()).isEqualTo(240);
    }

    @Test
    void rejectsFilesOverConfiguredSize() {
        ListingImageStorageService service = new ListingImageStorageService(
                temporaryDirectory.toString(), DataSize.ofBytes(3));
        MockMultipartFile file = new MockMultipartFile("imageFile", "car.png", "image/png",
                new byte[]{1, 2, 3, 4});

        assertThatThrownBy(() -> service.store(file))
                .isInstanceOf(InvalidListingImageException.class)
                .hasMessage("advertising.image.size");
    }

    @Test
    void rejectsFilesThatAreNotSupportedImages() {
        ListingImageStorageService service = new ListingImageStorageService(
                temporaryDirectory.toString(), DataSize.ofMegabytes(5));
        MockMultipartFile file = new MockMultipartFile("imageFile", "car.txt", "image/jpeg",
                "not an image".getBytes());

        assertThatThrownBy(() -> service.store(file))
                .isInstanceOf(InvalidListingImageException.class)
                .hasMessage("advertising.image.invalid");
    }

    private byte[] pngImage(int width, int height) throws IOException {
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        image.setRGB(0, 0, Color.BLUE.getRGB());
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        ImageIO.write(image, "png", output);
        return output.toByteArray();
    }
}
