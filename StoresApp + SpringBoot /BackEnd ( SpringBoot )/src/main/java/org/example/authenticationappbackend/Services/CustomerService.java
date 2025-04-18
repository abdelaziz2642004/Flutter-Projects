package org.example.authenticationappbackend.Services;

import org.example.authenticationappbackend.Entity.Customer;
import org.example.authenticationappbackend.Repository.CustomerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CustomerService {
    @Autowired
    private CustomerRepo customerRepo;

    public Customer saveDetails(Customer cust){
        return customerRepo.save(cust);
    }

       public boolean checkID(int id){
         return customerRepo.idExists(id)>=1;

    }

    public Customer isLogedIn(Map<String, Object> body){
        int id = (int)body.get("id");
        String password = (String)body.get("password");
        Customer cust = customerRepo.findById(id).orElse(null);
        if(cust != null && cust.getPassword().equals(password)){
            return cust;
        }
        return null;
    }

    public Customer getStudent(int studentId){
        Customer student = customerRepo.findById(studentId).orElse(null);
        return student;
    }

    public List<Customer> getAllCustomers(){
        return customerRepo.findAll();
    }

    public List<Integer> getAllCustomersIds(){
        return customerRepo.getAllCustomersId();
    }

    public void deleteCustomer(Map<String, Object> body){
        int id = (int)body.get("id");
        Customer student = customerRepo.findById(id).orElse(null);
        customerRepo.delete(student);
    }

    public void deleteAllCustomer(){
        customerRepo.deleteAll();
    }


    public void editCustomer(Map<String, Object> body) {
        // name , gender , level , password
        String name= (String)body.get("name");
        String gender= (String)body.get("gender");
        int level= (int)body.get("level");
        int id= (int)body.get("id");


        customerRepo.updateCustomer(id, level, gender, name);




    }


    public void changePassword(Map<String, Object> body) {
        int id= (int)body.get("id");
        String password= (String)body.get("password");


            customerRepo.changePassword(id,password);




    }


    }
