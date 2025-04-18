package org.example.authenticationappbackend.Repository;

import org.example.authenticationappbackend.Entity.ImageData;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface ImageDataRepo extends JpaRepository<ImageData, Integer> {
//    ImageData findByName(String imageName);

    @Transactional
    @Modifying
    @Query("DELETE FROM ImageData i WHERE i.id = :imageId")
    void deleteImageById(int imageId);


}
