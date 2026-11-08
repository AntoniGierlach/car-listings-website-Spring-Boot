package pl.apexwheels.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.client.JdkClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;
import tools.jackson.databind.JsonNode;

import java.net.http.HttpClient;
import java.time.Duration;
import java.util.List;
import java.util.Locale;
import java.util.TreeMap;

@Component
public class CarApiMakesClient {

    private final RestClient restClient;

    @Autowired
    public CarApiMakesClient(
            @Value("${app.carapi.makes-url:https://carapi.app/api/makes/v2}") String makesUrl) {
        HttpClient httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(3))
                .build();
        JdkClientHttpRequestFactory requestFactory = new JdkClientHttpRequestFactory(httpClient);
        requestFactory.setReadTimeout(Duration.ofSeconds(5));
        this.restClient = RestClient.builder()
                .requestFactory(requestFactory)
                .baseUrl(makesUrl)
                .build();
    }

    CarApiMakesClient(RestClient restClient) {
        this.restClient = restClient;
    }

    public List<String> fetchMakeNames() {
        JsonNode response = restClient.get()
                .retrieve()
                .body(JsonNode.class);
        JsonNode data = response == null ? null : response.get("data");
        if (data == null || !data.isArray()) {
            throw new IllegalStateException("CarAPI response does not contain a makes data array");
        }

        TreeMap<String, String> uniqueNames = new TreeMap<>(String.CASE_INSENSITIVE_ORDER);
        for (JsonNode make : data) {
            JsonNode name = make.get("name");
            if (name != null && name.isTextual() && !name.asText().isBlank()) {
                String normalizedName = name.asText().trim();
                uniqueNames.putIfAbsent(normalizedName.toLowerCase(Locale.ROOT), normalizedName);
            }
        }
        if (uniqueNames.isEmpty()) {
            throw new IllegalStateException("CarAPI returned no valid make names");
        }
        return List.copyOf(uniqueNames.values());
    }
}
