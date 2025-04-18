package org.example.authenticationappbackend.Services;

import org.example.authenticationappbackend.Entity.Customer;
import org.example.authenticationappbackend.Entity.Store;
import org.example.authenticationappbackend.Repository.CustomerRepo;
import org.example.authenticationappbackend.Repository.StoreRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class StoreService {
    //return all stores

    @Autowired
    private StoreRepo storeRepo;


    public List<Store> getAllStores(){
        return storeRepo.findAll();
    }


    public void saveDetails(Store store){
        storeRepo.save(store);
    }

}
