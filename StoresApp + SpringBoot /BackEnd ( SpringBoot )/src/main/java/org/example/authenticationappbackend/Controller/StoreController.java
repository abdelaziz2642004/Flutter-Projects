package org.example.authenticationappbackend.Controller;

import org.example.authenticationappbackend.Entity.Customer;
import org.example.authenticationappbackend.Entity.Store;
import org.example.authenticationappbackend.Services.CustomerService;
import org.example.authenticationappbackend.Services.StoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping()
public class StoreController {

    @Autowired
    private StoreService storeService;


    @GetMapping("/getStores")
    public List<Store> getAllStores(){
        return storeService.getAllStores();
    }

    @PostMapping("/addStore")
    public void addStore(@RequestBody Store store){
         storeService.saveDetails(store);
    }







}
