package org.example.authenticationappbackend.Repository;

import org.example.authenticationappbackend.Entity.ImageData;
import org.example.authenticationappbackend.Entity.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface CustomerRepo extends JpaRepository<Customer, Integer> {

    @Transactional
    @Modifying
    @Query("UPDATE Customer s SET s.imageData = :imageData WHERE s.id = :studentId")
    int updateCustomerById(int studentId, ImageData imageData);


    @Transactional
    @Modifying
    @Query("UPDATE Customer s SET s.imageData = null WHERE s.id = :studentId")
    int deleteCustomerImageById(int studentId);


    @Query("SELECT s.id FROM Customer s")
    List<Integer> getAllCustomersId();



    @Transactional
    @Modifying
    @Query("UPDATE Customer s SET s.password = :password WHERE s.id = :id")
    int changePassword(@Param("id") int id,

                      @Param("password") String password);


    @Transactional
    @Modifying
    @Query("UPDATE Customer s SET s.name = :name, s.gender = :gender, s.level = :level WHERE s.id = :id")
    int updateCustomer(@Param("id") int id,
                      @Param("level") int level,
                      @Param("gender") String gender,
                      @Param("name") String name);


    @Query("SELECT COUNT(s) FROM Customer s WHERE s.id = :id")
    int idExists(@Param("id") int id);




}
