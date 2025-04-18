package org.example.authenticationappbackend.Repository;

import org.example.authenticationappbackend.Entity.ImageData;
import org.example.authenticationappbackend.Entity.Store;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

public interface StoreRepo extends JpaRepository<Store, Integer> {
    @Query("SELECT s FROM Store s WHERE s.name = :name")
    Optional<Store> findByName(@Param("name") String name);
}
