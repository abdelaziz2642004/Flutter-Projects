package org.example.authenticationappbackend.Services;

import org.example.authenticationappbackend.Entity.Customer;
import org.example.authenticationappbackend.Entity.Favorite;
import org.example.authenticationappbackend.Entity.Store;
import org.example.authenticationappbackend.Repository.CustomerRepo;
import org.example.authenticationappbackend.Repository.FavoriteRepo;
import org.example.authenticationappbackend.Repository.StoreRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

@Service
public class FavoriteService {
    //return all stores

    @Autowired
    private FavoriteRepo favoriteRepo;

    @Autowired
    private CustomerRepo customerRepo;

    @Autowired
    private StoreRepo storeRepo;


    public List<Store> getFavoriteStores(int customerID){
        return favoriteRepo.getFavoritedStores(customerID);
    }
    public void toggleFavorite(int customerID, int storeID) {



        Integer favoriteId = favoriteRepo.findFavoriteIdByCustomerAndStore(customerID, storeID);

        if (favoriteId != null) {
            // Favorite exists -> remove it
            favoriteRepo.deleteById(favoriteId);
        } else {
            // Favorite doesn't exist -> add it
            Customer customer = customerRepo.findById(customerID)
                    .orElseThrow(() -> new RuntimeException("Customer not found with ID: " + customerID));
            Store store = storeRepo.findById(storeID)
                    .orElseThrow(() -> new RuntimeException("Store not found with ID: " + storeID));

            Favorite favorite = new Favorite();
            favorite.setCustomer(customer);
            favorite.setStore(store);

            favoriteRepo.save(favorite);
        }
    }






}
