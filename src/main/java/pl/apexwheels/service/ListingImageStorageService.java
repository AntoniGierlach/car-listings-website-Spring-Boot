package pl.apexwheels.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.unit.DataSize;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageInputStream;
import javax.imageio.stream.ImageOutputStream;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.Iterator;
import java.util.Locale;
import java.util.UUID;

@Service
public class ListingImageStorageService {

    private static final long MAX_IMAGE_PIXELS = 16_000_000L;
    private static final int OPTIMIZED_MAX_WIDTH = 1600;
    private static final int OPTIMIZED_MAX_HEIGHT = 1200;
    private static final int THUMBNAIL_MAX_WIDTH = 480;
    private static final int THUMBNAIL_MAX_HEIGHT = 300;
    private static final float JPEG_QUALITY = 0.82f;

    private final Path uploadDirectory;
    private final long maxFileSizeBytes;

    public ListingImageStorageService(
            @Value("${app.images.upload-dir:./data/uploads}") String uploadDirectory,
            @Value("${app.images.max-file-size:5MB}") DataSize maxFileSize) {
        this.uploadDirectory = Path.of(uploadDirectory).toAbsolutePath().normalize();
        this.maxFileSizeBytes = maxFileSize.toBytes();
    }

    public String store(MultipartFile file) {
        if (file.getSize() > maxFileSizeBytes) {
            throw new InvalidListingImageException("advertising.image.size");
        }

        BufferedImage decodedImage = decode(file);
        String filename = "upload-" + UUID.randomUUID() + ".jpg";
        Path optimizedFile = getOptimizedDirectory().resolve(filename);
        Path thumbnailFile = getThumbnailDirectory().resolve(filename);

        try {
            Files.createDirectories(optimizedFile.getParent());
            Files.createDirectories(thumbnailFile.getParent());
            Files.write(optimizedFile, encodeJpeg(resize(decodedImage, OPTIMIZED_MAX_WIDTH,
                    OPTIMIZED_MAX_HEIGHT)), StandardOpenOption.CREATE_NEW, StandardOpenOption.WRITE);
            Files.write(thumbnailFile, encodeJpeg(resize(decodedImage, THUMBNAIL_MAX_WIDTH,
                    THUMBNAIL_MAX_HEIGHT)), StandardOpenOption.CREATE_NEW, StandardOpenOption.WRITE);
        } catch (IOException exception) {
            cleanupAfterFailedWrite(optimizedFile, thumbnailFile, exception);
            throw new ListingImageStorageException("Could not store listing image", exception);
        }

        return filename;
    }

    public Path getOptimizedDirectory() {
        return uploadDirectory.resolve("optimized");
    }

    public Path getThumbnailDirectory() {
        return uploadDirectory.resolve("thumbs");
    }

    public boolean isUploadedImage(String filename) {
        return filename != null && filename.matches("upload-[0-9a-fA-F-]{36}\\.jpg");
    }

    public void deleteUploadedImage(String filename) {
        if (!isUploadedImage(filename)) {
            return;
        }

        try {
            Files.deleteIfExists(getOptimizedDirectory().resolve(filename));
            Files.deleteIfExists(getThumbnailDirectory().resolve(filename));
        } catch (IOException exception) {
            throw new ListingImageStorageException("Could not remove listing image " + filename, exception);
        }
    }

    private BufferedImage decode(MultipartFile file) {
        try (ImageInputStream input = ImageIO.createImageInputStream(file.getInputStream())) {
            if (input == null) {
                throw invalidImage();
            }

            Iterator<ImageReader> readers = ImageIO.getImageReaders(input);
            if (!readers.hasNext()) {
                throw invalidImage();
            }

            ImageReader reader = readers.next();
            try {
                reader.setInput(input, true, true);
                String format = reader.getFormatName().toLowerCase(Locale.ROOT);
                if (!format.equals("jpeg") && !format.equals("jpg") && !format.equals("png")) {
                    throw new InvalidListingImageException("advertising.image.format");
                }

                int width = reader.getWidth(0);
                int height = reader.getHeight(0);
                if (width <= 0 || height <= 0 || (long) width * height > MAX_IMAGE_PIXELS) {
                    throw new InvalidListingImageException("advertising.image.dimensions");
                }

                BufferedImage image = reader.read(0);
                if (image == null) {
                    throw invalidImage();
                }
                return image;
            } finally {
                reader.dispose();
            }
        } catch (IOException exception) {
            throw new InvalidListingImageException("advertising.image.invalid", exception);
        }
    }

    private byte[] encodeJpeg(BufferedImage image) throws IOException {
        Iterator<ImageWriter> writers = ImageIO.getImageWritersByFormatName("jpeg");
        if (!writers.hasNext()) {
            throw new IOException("No JPEG image writer is available");
        }

        ImageWriter writer = writers.next();
        try (ByteArrayOutputStream output = new ByteArrayOutputStream();
             ImageOutputStream imageOutput = ImageIO.createImageOutputStream(output)) {
            if (imageOutput == null) {
                throw new IOException("Could not create image output stream");
            }

            writer.setOutput(imageOutput);
            ImageWriteParam parameters = writer.getDefaultWriteParam();
            parameters.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
            parameters.setCompressionQuality(JPEG_QUALITY);
            writer.write(null, new IIOImage(image, null, null), parameters);
            imageOutput.flush();
            return output.toByteArray();
        } finally {
            writer.dispose();
        }
    }

    private BufferedImage resize(BufferedImage source, int maxWidth, int maxHeight) {
        double scale = Math.min(1.0, Math.min(maxWidth / (double) source.getWidth(),
                maxHeight / (double) source.getHeight()));
        int width = Math.max(1, (int) Math.round(source.getWidth() * scale));
        int height = Math.max(1, (int) Math.round(source.getHeight() * scale));

        BufferedImage resized = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D graphics = resized.createGraphics();
        try {
            graphics.setColor(Color.WHITE);
            graphics.fillRect(0, 0, width, height);
            graphics.setRenderingHint(RenderingHints.KEY_INTERPOLATION,
                    RenderingHints.VALUE_INTERPOLATION_BILINEAR);
            graphics.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
            graphics.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
            graphics.drawImage(source, 0, 0, width, height, null);
        } finally {
            graphics.dispose();
        }
        return resized;
    }

    private InvalidListingImageException invalidImage() {
        return new InvalidListingImageException("advertising.image.invalid");
    }

    private void cleanupAfterFailedWrite(Path optimizedFile, Path thumbnailFile, IOException originalFailure) {
        deleteAfterFailure(optimizedFile, originalFailure);
        deleteAfterFailure(thumbnailFile, originalFailure);
    }

    private void deleteAfterFailure(Path path, IOException originalFailure) {
        try {
            Files.deleteIfExists(path);
        } catch (IOException cleanupFailure) {
            originalFailure.addSuppressed(cleanupFailure);
        }
    }
}
