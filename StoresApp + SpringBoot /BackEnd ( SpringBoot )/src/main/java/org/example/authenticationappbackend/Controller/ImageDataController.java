package org.example.authenticationappbackend.Controller;

import org.example.authenticationappbackend.Entity.ImageData;
import org.example.authenticationappbackend.Entity.Customer;
import org.example.authenticationappbackend.Services.ImageDataService;
import org.example.authenticationappbackend.Services.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@RequestMapping("/{customerId}")
public class ImageDataController {

    @Autowired
    private ImageDataService imageDataService;

    @Autowired
    private CustomerService studentService;

    @PostMapping("/addImage")
    public ResponseEntity<?> uploadImage(@RequestParam("image") MultipartFile file, @PathVariable int customerId) throws IOException {
        String upload = imageDataService.uploadImage(file, customerId);
        return ResponseEntity.status(HttpStatus.OK).body(upload);
    }

    @GetMapping("/getImage")
    public ResponseEntity<?> downloadImage(@PathVariable int customerId){
        Customer student = studentService.getStudent(customerId);
        ImageData imageData = imageDataService.getImageData(student); // consists of 3 things
        byte[] imageFile = imageDataService.downloadImage(student);
        return ResponseEntity.status(HttpStatus.OK).contentType(MediaType.valueOf(imageData.getImageType())).body(imageFile);

    }

    @GetMapping("/delImage")
    public void deleteImage (@PathVariable int customerId){
        imageDataService.deleteImage(customerId);
    }




}
