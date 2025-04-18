package org.example.authenticationappbackend.Controller;

import org.example.authenticationappbackend.Entity.Customer;
import org.example.authenticationappbackend.Entity.Store;
import org.example.authenticationappbackend.Services.CustomerService;
import org.example.authenticationappbackend.Services.FavoriteService;
import org.example.authenticationappbackend.Services.StoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/{customerId}")

public class favoriteController {

    @Autowired
    private FavoriteService favoriteService;


    @GetMapping("/getFavorites")
    public List<Store> getAllStores( @PathVariable int customerId){
        return favoriteService.getFavoriteStores(customerId);
    }

    @PostMapping("/toggleFavorite")
    public void toggleFavorite(@RequestBody int storeID, @PathVariable int customerId){
        favoriteService.toggleFavorite(customerId,storeID);
    }







}
