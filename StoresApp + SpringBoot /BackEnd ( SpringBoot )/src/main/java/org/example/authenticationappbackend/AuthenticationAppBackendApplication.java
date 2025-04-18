package org.example.authenticationappbackend;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.example.authenticationappbackend.Entity.ImageDataStore;
import org.example.authenticationappbackend.Entity.Store;
import org.example.authenticationappbackend.Repository.ImageDataStoreRepo;
import org.example.authenticationappbackend.Repository.StoreRepo;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.nio.file.Files;

@SpringBootApplication
public class AuthenticationAppBackendApplication {

	public static void main(String[] args) {
		SpringApplication.run(AuthenticationAppBackendApplication.class, args);
	}

	@Bean
	CommandLineRunner runner(StoreSeeder seeder) {
		return args -> seeder.seed();
	}
}

@Component
class StoreSeeder {

	private final StoreRepo storeRepository;
	private final ImageDataStoreRepo imageDataStoreRepo;
	private final EntityManager entityManager;

	public StoreSeeder(StoreRepo storeRepository, ImageDataStoreRepo imageDataStoreRepo, EntityManager entityManager) {
		this.storeRepository = storeRepository;
		this.imageDataStoreRepo = imageDataStoreRepo;
		this.entityManager = entityManager;
	}

	// favroite : store id
	// I Want to delete a store

	@Transactional
	public void seed() throws IOException {
		// No deletion or resetting IDs

		addStoreIfNotExists("Bazooka", "Famous Egyptian food chain", 4.5,
				30.0561, 31.3301, "bazooka.png", "image/png");

		addStoreIfNotExists("Cilantro", "Popular coffee shop with cozy atmosphere", 4.3,
				30.0647, 31.2156, "cilantro.png", "image/png");

		addStoreIfNotExists("H&M", "Fashion and accessories", 4.6,
				30.0306, 31.4086, "H&M.png", "image/png");

		addStoreIfNotExists("Kheir Zaman", "Well-known supermarket chain", 4.2,
				30.0546, 31.3360, "kheir zaman.png", "image/png");

		addStoreIfNotExists("McDonald's", "Global fast-food chain", 4.1,
				30.0444, 31.2357, "mcDonalds.png", "image/png");

		addStoreIfNotExists("Koshary Abou Tarek", "Renowned Egyptian restaurant specializing in koshary...", 4.7,
				30.0444, 31.2357, "aboutarek.png", "image/png");

		addStoreIfNotExists("Mall of Egypt", "One of Egypt's largest shopping malls...", 4.6,
				29.9721, 31.0161, "MallOfEgypt.png", "image/png");

		addStoreIfNotExists("City Stars Mall", "A multi-level shopping center in Heliopolis...", 4.7,
				30.0733, 31.3457, "CityStars.png", "image/png");

		addStoreIfNotExists("Mall of Arabia", "A large shopping mall in 6th of October City...", 4.5,
				29.9721, 31.0161, "MallOfArabia.png", "image/png");

		addStoreIfNotExists("El-Fishawy Café", "A historic café located in Khan El Khalili market...", 4.8,
				30.0460, 31.2350, "fishawy.png", "image/png");

		addStoreIfNotExists("Zooba", "A modern eatery offering traditional Egyptian street food...", 4.6,
				30.0420, 31.2270, "zooba.png", "image/png");
	}

	private void addStoreIfNotExists(String name, String description, double rating, double latitude, double longitude, String fileName, String contentType) throws IOException {
		if (storeRepository.findByName(name).isEmpty()) {
			ImageDataStore image = createImage(fileName, contentType);
			storeRepository.save(new Store(null, name, description, rating, latitude, longitude, image));
		}
	}

	private ImageDataStore createImage(String fileName, String contentType) throws IOException {
		ClassPathResource imgFile = new ClassPathResource("StoreImages/" + fileName);
		byte[] data = Files.readAllBytes(imgFile.getFile().toPath());
		return new ImageDataStore(fileName, contentType, data);
	}
}


