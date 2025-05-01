
| ≪ [ 101 Setting Up the Environment and Tools ](/books/packtpub/2024/1202-Spring_Boot_3_React/101) | 102 Understanding Dependency Injection | [ 103 Using JPA to Create and Access a Database ](/books/packtpub/2024/1202-Spring_Boot_3_React/103) ≫ |
|:----:|:----:|:----:|

# 102 Understanding Dependency Injection

In this chapter, we will learn what **dependency injection (DI)** is and how we can use it with the Spring Boot framework. The Spring Boot framework provides DI; therefore, it is good to understand the basics. DI allows for loose coupling between components, making your code more flexible, maintainable, and testable.

In this chapter, we will look into the following:

- Introducing dependency injection
- Using dependency injection in Spring Boot

# Technical requirements

All of the code for this chapter can be found at the following GitHub link: https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-3-and-React-Fourth-Edition/tree/main/Chapter02.

# Introducing dependency injection

Dependency injection is a software development technique whereby we can create objects that depend on other objects. DI helps with interaction between classes, but at the same time keeps the classes independent.

There are three types of classes in DI:

- A **service** is a class that can be used (this is the dependency).
- The **client** is a class that uses the dependency.
- The **injector** passes the dependency (the service) to the dependent class (the client).

The three types of classes in DI are shown in the following diagram:

![ 2.1 DI classes ](/packtpub/2024/1202/2.1-di_classes.webp)

Figure 2.1: DI classes

DI makes classes loosely coupled. This means that the creation of client dependencies is separated from the client’s behavior, which makes unit testing easier.

Let’s take a look at a simplified example of DI using Java code. In the following code, we don’t have DI, because the `Car` client class is creating an object of the service class:

```
public class Car {
    private Owner owner;
  
    public Car() {
        owner = new Owner();
    }
}
```

In the following code, the service object is not directly created in the client class. It is passed as a parameter in the class constructor:

```
public class Car {
    private Owner owner;
  
    public Car(Owner owner) {
        this.owner = owner;
    }
}
```

The service class can also be an abstract class; we can then use any implementation of that in our client class and use mocks when testing.

There are different types of dependency injection; let’s take a look at two of them here:

> - **Constructor injection**: Dependencies are passed to a client class constructor. An example of constructor injection was already shown in the preceding `Car` code. Constructor injection is recommended to use for mandatory dependencies. All dependencies are provided using the class constructor and an object cannot be created without its required dependencies.
> - **Setter injection**: Dependencies are provided through setters. The following code shows an example of setter injection:

```
public class Car {
    private Owner owner;
  
    public void setOwner(Owner owner) {
        this.owner = owner;
    }
}
```

Here, the dependency is now passed in the setter as an argument. Setter injection is more flexible because objects can be created without all their dependencies. This approach allows for optional dependencies.

The DI reduces dependencies in your code and makes your code more reusable. It also improves the testability of your code. We have now learned the basics of DI. Next, we will look at how DI is used in Spring Boot.

# Using dependency injection in Spring Boot

In the Spring Framework, dependency injection is achieved through the Spring `ApplicationContext`. `ApplicationContext` is responsible for creating and managing objects – **beans** – and their dependencies.

Spring Boot scans your application classes and registers classes with certain annotations (`@Service`, `@Repository`, `@Controller`, and so on) as Spring beans. These beans can then be injected using dependency injection.

Spring Boot supports several dependency injection mechanisms, and the most common ones are:

> - **Constructor injection**: Dependencies are injected through a constructor. This is the most recommended way because it ensures that all required dependencies are available when the object is created. A fairly common situation is when we need database access for some operations. In Spring Boot, we use repository classes for that. In this situation, we can inject the repository class using constructor injection and start using its methods, as shown in the code example below:

> 
> ```
> // Constructor injection
> public class Car {
>     private final CarRepository carRepository;
>     public Car(CarRepository carRepository) {
>         this.carRepository = carRepository;
>     }
>   
>     // Fetch all cars from db 
>     carRepository.findAll();
> }
> ```

If you have multiple constructors in your class, you have to use the `@Autowired` annotation to define which constructor is used for dependency injection:

> ```
> // Constructor to used for dependency injection
> @Autowired
> public Car(CarRepository carRepository) {
>     this.carRepository = carRepository;
> }
> ```

> - **Setter injection**: Dependencies are injected through setter methods. Setter injection is useful if you have optional dependencies or if you want to modify dependencies at runtime. Below is an example of setter injection:

> ```
> // Setter injection
> @Service
> public class AppUserService {
>     private AppUserRepository userRepository;
> @Autowired
>     public void setAppUserRepository(
>         AppUserRepository userRepository) {
>             this.userRepository = userRepository;
>         }
>     // Other methods that use userRepository
> }
> ```
>
> - **Field injection**: Dependencies are injected directly into fields. The benefit of field injection is its simplicity, but it has some drawbacks. It can cause runtime errors if the dependency is not available. It is also harder to test your class because you can’t mock the dependencies for testing. Here is an example:

```
// Field injection
@Service
public class CarDatabaseService implements CarService {
// Car database services
}
public class CarController {
    @Autowired
    private CarDatabaseService carDatabaseService;
//...
}
```

You can read more about Spring Boot injection in the Spring documentation: https://spring.io/guides.

# Summary

In this chapter, we learned what dependency injection is and how to use it in the Spring Boot framework, which we are using in our backend.

In the next chapter, we will look at how we can use the **Java Persistent API (JPA)** with Spring Boot and how to set up a MariaDB database. We will also learn about the creation of CRUD repositories and the one-to-many connection between database tables.

# Questions

1. What is dependency injection?
1. How does the `@Autowired` annotation work in Spring Boot?
1. How do you inject resources in Spring Boot?

# Further reading

Packt has some video resources for learning about Spring Boot:

> - Learn Spring Core Framework the Easy Way, by Karthikeya T. (https://www.packtpub.com/product/learn-spring-core-framework-the-easy-way-video/9781801071680)
> - Mastering Spring Framework Fundamentals, by Matthew Speake (https://www.packtpub.com/product/mastering-spring-framework-fundamentals-video/9781801079525)

## Learn more on Discord

To join the Discord community for this book – where you can share feedback, ask the author questions, and learn about new releases – follow the QR code below:

https://packt.link/FullStackSpringBootReact4e



| ≪ [ 101 Setting Up the Environment and Tools ](/books/packtpub/2024/1202-Spring_Boot_3_React/101) | 102 Understanding Dependency Injection | [ 103 Using JPA to Create and Access a Database ](/books/packtpub/2024/1202-Spring_Boot_3_React/103) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 102 Understanding Dependency Injection
> (2) Short Description: Spring Boot 3 React
> (3) Path: books/packtpub/2024/1202-Spring_Boot_3_React/102
> Book Jemok: Full Stack Development with Spring Boot 3 and React 4Ed
> AuthorDate: Juha Hinkula / Oct 2023 / 454 pages 4Ed
> Link: https://subscription.packtpub.com/book/web-development/9781805122463/pref
> create: 2024-12-02 월 14:31:21
> .md Name: 102_understanding_dependency_injection.md

