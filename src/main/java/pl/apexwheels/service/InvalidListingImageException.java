package pl.apexwheels.service;

public class InvalidListingImageException extends RuntimeException {

    private final String messageKey;

    public InvalidListingImageException(String messageKey) {
        super(messageKey);
        this.messageKey = messageKey;
    }

    public InvalidListingImageException(String messageKey, Throwable cause) {
        super(messageKey, cause);
        this.messageKey = messageKey;
    }

    public String getMessageKey() {
        return messageKey;
    }
}
