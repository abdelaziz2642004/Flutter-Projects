package org.example.authenticationappbackend.Repository;

import org.example.authenticationappbackend.Entity.Store;
import org.example.authenticationappbackend.Entity.Favorite;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface FavoriteRepo extends JpaRepository<Favorite, Integer> {

       // Custom query to fetch all stores favorited by a customer
       @Query("SELECT f.store FROM Favorite f WHERE f.customer.id = :customerId")
       List<Store> getFavoritedStores(@Param("customerId") int customerId);

    @Query("SELECT f.id FROM Favorite f WHERE f.customer.id = :customerId AND f.store.id = :storeId")
    Integer findFavoriteIdByCustomerAndStore(@Param("customerId") int customerId, @Param("storeId") int storeId);



}
