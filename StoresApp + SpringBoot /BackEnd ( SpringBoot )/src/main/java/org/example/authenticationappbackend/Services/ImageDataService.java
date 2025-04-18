package org.example.authenticationappbackend.Services;

import org.example.authenticationappbackend.Entity.ImageData;
import org.example.authenticationappbackend.Entity.Customer;
import org.example.authenticationappbackend.Repository.ImageDataRepo;
import org.example.authenticationappbackend.Repository.CustomerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Service
public class ImageDataService {
    @Autowired
    private ImageDataRepo imageDataRepo;

    @Autowired
    private CustomerRepo customerRepo;

    public String uploadImage(MultipartFile file, int studentId) throws IOException {

        ImageData imageData = new ImageData(
                file.getOriginalFilename(),
                file.getContentType(),
                file.getBytes()
        );
        if (imageData != null) {
            imageDataRepo.save(imageData);
            Customer student = customerRepo.findById(studentId).orElse(null);
            customerRepo.updateCustomerById(studentId, imageData);
            if (student.getImageData() != null){
                imageDataRepo.deleteImageById(student.getImageData().getId());
            }


            return "file uploaded successfully : " + file.getOriginalFilename();
        }
        return null;
    }

    public void deleteImage(int customerID) {
        Customer customer = customerRepo.findById(customerID).orElse(null);
        if (customer != null && customer.getImageData() != null) {
            // Set the image_data_id in customer to null before deleting image data
            int imageID= customer.getImageData().getId();
            customer.setImageData(null);
            customerRepo.save(customer); // Save the customer with the updated image data reference

            // Now, delete the image data
            imageDataRepo.deleteImageById(imageID);
        }
    }




    public ImageData getImageData(Customer student) {
        return imageDataRepo.findById(student.getImageData().getId()).orElse(null);
    }


    public byte[] downloadImage(Customer student) {
        if (student != null) {
            ImageData dbImageData = imageDataRepo.findById(student.getImageData().getId()).orElse(null);
            if (dbImageData != null) {
                return dbImageData.getImageData(); // only the data
            }
        }
        return null;
    }

//    public void deleteImage(Student student) {
//        ImageData imageData = student.getImageData();
//        if (imageData != null) {
//            customerRepo.deleteStudentImageById(student.getId());
//            imageDataRepo.delete(imageData);
//        }
//    }
}
