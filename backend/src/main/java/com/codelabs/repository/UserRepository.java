package com.codelabs.repository;

import com.codelabs.entity.User;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    // Find a user by their exact email address (used during Login)
    Optional<User> findByEmail(String email);

    // Check if an email is already registered (used during Registration)
    boolean existsByEmail(String email);
}
