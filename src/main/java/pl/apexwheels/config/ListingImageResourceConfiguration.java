package pl.apexwheels.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import pl.apexwheels.service.ListingImageStorageService;

import java.nio.file.Path;

@Configuration
public class ListingImageResourceConfiguration implements WebMvcConfigurer {

    private final ListingImageStorageService imageStorageService;

    public ListingImageResourceConfiguration(ListingImageStorageService imageStorageService) {
        this.imageStorageService = imageStorageService;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/images/optimized/**")
                .addResourceLocations("classpath:/static/images/optimized/",
                        resourceLocation(imageStorageService.getOptimizedDirectory()));
        registry.addResourceHandler("/images/thumbs/**")
                .addResourceLocations("classpath:/static/images/thumbs/",
                        resourceLocation(imageStorageService.getThumbnailDirectory()));
    }

    private String resourceLocation(Path directory) {
        String location = directory.toUri().toString();
        return location.endsWith("/") ? location : location + "/";
    }
}
