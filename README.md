# ApexWheels
## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)

## General info
This project is a web application that is used to advertise all kinds of cars for sale.
It is based on Spring Boot, uses Spring Security to login and verify users and administrators. It uses a database MySQL, includes relations, comprehensive support all CRUD operations including logging and registration.
Frontend based on Bootstrap communicating with Java through both JSP and JSTL interfaces.

## Local setup

The application expects a MySQL database named `apexwheels` on `localhost:3306`.
Set the database password before starting the application:

```powershell
$env:DB_PASSWORD = "your-database-password"
.\mvnw.cmd spring-boot:run
```

Optional variables: `DB_URL` and `DB_USERNAME`.

## Demo data

The demo seed is opt-in and adds an admin account, brands, categories, eight realistic car listings and local preview artwork. It only runs when the database has no listings.

```powershell
$env:DB_PASSWORD = "your-database-password"
.\mvnw.cmd spring-boot:run "-Dspring-boot.run.profiles=demo"
```

Demo login: `admin` / `admin`.
	
## Technologies
Project is created with:
* Java version: 21
* Bootstrap version: 5.0
* Spring Boot version: 4.1.2
* Hibernate ORM managed by Spring Boot
