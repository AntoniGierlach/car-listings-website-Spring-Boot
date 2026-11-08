package pl.apexwheels.service;

import org.junit.jupiter.api.Test;
import org.springframework.http.MediaType;
import org.springframework.test.web.client.MockRestServiceServer;
import org.springframework.web.client.RestClient;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.springframework.test.web.client.match.MockRestRequestMatchers.requestTo;
import static org.springframework.test.web.client.response.MockRestResponseCreators.withSuccess;

class CarApiMakesClientTest {

    @Test
    void fetchesDistinctMakeNamesFromCarApiEnvelope() {
        RestClient.Builder builder = RestClient.builder();
        MockRestServiceServer server = MockRestServiceServer.bindTo(builder).build();
        server.expect(requestTo("https://carapi.example/api/makes/v2"))
                .andRespond(withSuccess("""
                        {"collection":{"count":3},"data":[
                          {"id":1,"name":"Acura"},
                          {"id":2,"name":"BMW"},
                          {"id":3,"name":" acura "}
                        ]}
                        """, MediaType.APPLICATION_JSON));
        CarApiMakesClient client = new CarApiMakesClient(
                builder.baseUrl("https://carapi.example/api/makes/v2").build());

        assertThat(client.fetchMakeNames()).containsExactly("Acura", "BMW");
        server.verify();
    }

    @Test
    void rejectsResponseWithoutMakesArray() {
        RestClient.Builder builder = RestClient.builder();
        MockRestServiceServer server = MockRestServiceServer.bindTo(builder).build();
        server.expect(requestTo("https://carapi.example/api/makes/v2"))
                .andRespond(withSuccess("{\"data\":{}}", MediaType.APPLICATION_JSON));
        CarApiMakesClient client = new CarApiMakesClient(
                builder.baseUrl("https://carapi.example/api/makes/v2").build());

        assertThatThrownBy(client::fetchMakeNames)
                .isInstanceOf(IllegalStateException.class)
                .hasMessage("CarAPI response does not contain a makes data array");
        server.verify();
    }
}
