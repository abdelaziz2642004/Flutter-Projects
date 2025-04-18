package org.example.authenticationappbackend.Controller;

import org.example.authenticationappbackend.Entity.Customer;
import org.example.authenticationappbackend.Services.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping()
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @PostMapping("/IDexists")
    public boolean checkID(@RequestBody Map<String, Object> body) {
        int id = (int) body.get("id");
        return customerService.checkID(id);
    }

    @PostMapping("/addCustomer")
    public Customer addStudent(@RequestBody Customer student){
        return customerService.saveDetails(student);
    }

    @PostMapping("/getCustomer")
    public Customer checkLogedin(@RequestBody Map<String, Object> body){
        return customerService.isLogedIn(body);
    }

    @GetMapping("/getCustomers")
    public List<Customer> getAllStudent(){
        return customerService.getAllCustomers();
    }


    @GetMapping("")
   public void tryConnection(){

    }

    @GetMapping("/getCustomersIds")
    public List<Integer> getAllStudentIds(){
        return customerService.getAllCustomersIds();
    }

    @PostMapping("/deleteCustomer")
    public void deleteStudent(@RequestBody Map<String, Object> body){
        customerService.deleteCustomer(body);
    }
    @GetMapping("/deleteCustomers")
    public void deleteAllStudent(){
        customerService.deleteAllCustomer();
    }




    @PostMapping("/editCustomer")
    public void editStudent(@RequestBody Map<String, Object> body){
        customerService.editCustomer(body);
    }



    @PostMapping("/changePassword")
    public void changePassword(@RequestBody Map<String, Object> body){
        customerService.changePassword(body);
    }


}
