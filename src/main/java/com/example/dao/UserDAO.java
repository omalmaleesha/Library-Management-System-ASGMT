package com.example.dao;

import com.example.model.User;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private String filePath;

    public UserDAO(String filePath) {
        this.filePath = filePath;
    }

    public synchronized List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 4) {
                    int userId = Integer.parseInt(parts[0]);
                    String username = parts[1];
                    String password = parts[2];
                    String email = parts[3];
                    users.add(new User(userId, username, password, email));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return users;
    }

    public synchronized User getUserByUsername(String username) {
        List<User> users = getAllUsers();
        for (User user : users) {
            if (user.getUsername().equals(username)) {
                return user;
            }
        }
        return null;
    }

    public synchronized User getUserById(int userId) {
        List<User> users = getAllUsers();
        for (User user : users) {
            if (user.getUserId() == userId) {
                return user;
            }
        }
        return null;
    }

    public synchronized void addUser(User user) {
        List<User> users = getAllUsers();
        int maxId = 0;
        for (User u : users) {
            if (u.getUserId() > maxId) {
                maxId = u.getUserId();
            }
        }
        user.setUserId(maxId + 1);
        users.add(user);
        writeUsers(users);
    }

    public synchronized void updateUser(User updatedUser) {
        List<User> users = getAllUsers();
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getUserId() == updatedUser.getUserId()) {
                users.set(i, updatedUser);
                break;
            }
        }
        writeUsers(users);
    }

    public synchronized void deleteUser(int userId) {
        List<User> users = getAllUsers();
        users.removeIf(user -> user.getUserId() == userId);
        writeUsers(users);
    }

    private void writeUsers(List<User> users) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath))) {
            for (User user : users) {
                bw.write(user.getUserId() + "," + user.getUsername() + "," + user.getPassword() + "," + user.getEmail());
                bw.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}