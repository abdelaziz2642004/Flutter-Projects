package org.example.authenticationappbackend.Repository;

import org.example.authenticationappbackend.Entity.ImageData;
import org.example.authenticationappbackend.Entity.ImageDataStore;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface ImageDataStoreRepo extends JpaRepository<ImageDataStore, Integer> {
/// /

}
