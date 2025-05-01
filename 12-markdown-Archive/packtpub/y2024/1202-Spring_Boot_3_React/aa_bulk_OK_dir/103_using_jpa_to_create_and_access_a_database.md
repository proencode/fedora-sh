
| ≪ [ 102 Understanding Dependency Injection ](/books/packtpub/2024/1202-Spring_Boot_3_React/102_Understanding_Dependency_Injection) | 103 Using JPA to Create and Access a Database | [ 104 Creating a RESTful Web Service with Spring Boot ](/books/packtpub/2024/1202-Spring_Boot_3_React/104_Creating_a_RESTful_Web_Service_with_Spring_Boot) ≫ |
|:----:|:----:|:----:|

# 103 Using JPA to Create and Access a Database

This chapter covers how to use Jakarta Persistence API (JPA) with Spring Boot and how to define a database by using entity classes. In the first phase, we will be using the H2 database. H2 is an in-memory SQL database that is good for fast development or demonstration purposes. In the second phase, we will move from H2 to MariaDB. This chapter also describes the creation of CRUD repositories and a one-to-many connection between database tables.

In this chapter, we will cover the following topics:

Basics of ORM, JPA, and Hibernate
Creating the entity classes
Creating CRUD repositories
Adding relationships between tables
Setting up the MariaDB database
Technical requirements
The Spring Boot application we created in previous chapters is required.

A MariaDB installation is necessary to create the database application: https://downloads.mariadb.org/. We went through the installation steps in Chapter 1.

The code for this chapter can be found at the following GitHub link: https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-3-and-React-Fourth-Edition/tree/main/Chapter03.

Basics of ORM, JPA, and Hibernate
ORM and JPA are widely used techniques in software development for handling relational databases. You don’t have to write complex SQL queries; instead, you can work with objects, which is more natural for Java developers. In this way, ORM and JPA can speed up your development process by reducing the time you spend writing and debugging SQL code. Many JPA implementations can also generate a database schema automatically based on your Java entity classes. In brief:

Object-Relational Mapping (ORM) is a technique that allows you to fetch from and manipulate a database by using an object-oriented programming paradigm. ORM is really good for programmers because it relies on object-oriented concepts rather than database structures. It also makes development much faster and reduces the amount of source code. ORM is mostly independent of databases, and developers don’t have to worry about vendor-specific SQL statements.
Jakarta Persistence API (JPA, formerly Java Persistence API) provides object-relational mapping for Java developers. The JPA entity is a Java class that represents the structure of a database table. The fields of an entity class represent the columns of the database tables.
Hibernate is the most popular Java-based JPA implementation and is used in Spring Boot by default. Hibernate is a mature product and is widely used in large-scale applications.
Next, we will start to implement our first entity class using the H2 database.

Creating the entity classes
An entity class is a simple Java class that is annotated with JPA’s @Entity annotation. Entity classes use the standard JavaBean naming convention and have proper getter and setter methods. The class fields have private visibility.

JPA creates a database table with the same name as the class when the application is initialized. If you want to use some other name for the database table, you can use the @Table annotation in your entity class.

At the beginning of this chapter, we will use the H2 database (https://www.h2database.com/), which is an embedded in-memory database. To be able to use JPA and the H2 database, we have to add the following dependencies to the build.gradle file:

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    developmentOnly 'org.springframework.boot:spring-boot-devtools'
    runtimeOnly 'com.h2database:h2'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}

Copy

Explain
After you have updated the build.gradle file, you should update your dependencies by selecting the project in Eclipse’s Project Explorer and right-clicking to open the context menu. Then, select Gradle | Refresh Gradle Project, as shown in the next screenshot:


Figure 3.1: Refresh Gradle Project

You can also enable automatic project refresh by opening the Window | Preferences menu. Go to the Gradle settings and there is an Automatic Project Synchronization checkbox that you can check. Then, your project will be synchronized automatically if you make changes to your build script file. This is recommended and means you don’t have to manually refresh the project when you update your build script:


Figure 3.2: Gradle wrapper settings

You can find the project dependencies from the Project and External Dependencies folder in the Eclipse Project Explorer. Now, you should find spring-boot-starter-data-jpa and h2 dependencies there:


Figure 3.3: Project dependencies

Let’s look at the following steps to create entity classes:

To create an entity class in Spring Boot, we must create a package for entities. The package should be created under the root package. To begin this process, activate the root package in Eclipse’s Project Explorer and right-click to make a context menu appear.
From this menu, select New | Package. The following screenshot shows how to create a package for entity classes:

Figure 3.4: New package

We will name our package com.packt.cardatabase.domain:

Figure 3.5: New Java package

Next, we will create our entity class. Activate the new com.packt.cardatabase.domain package, right-click it, and select New | Class from the menu.
Because we are going to create a car database, the name of the entity class will be Car. Type Car into the Name field and then press the Finish button, as shown in the following screenshot:

Figure 3.6: New Java class

Open the Car class file in the editor by double-clicking it in the Project Explorer. First, we must annotate the class with the @Entity annotation. The @Entity annotation is imported from the jakarta.persistence package:
package com.packt.cardatabase.domain;
import jakarta.persistence.Entity;
@Entity
public class Car {
}

Copy

Explain
You can use the Ctrl + Shift + O shortcut in the Eclipse IDE to import missing packages automatically. In some cases, there might be multiple packages that contain the same identifier, so you have to be careful to select the correct import. For example, in the next step, Id can be found in multiple packages, but you should select jakarta.persistence.Id.

Next, we must add some fields to our class. The entity class fields are mapped to database table columns. The entity class must also contain a unique ID that is used as a primary key in the database:
package com.packt.cardatabase.domain;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
@Entity
public class Car {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;
    private String brand, model, color, registrationNumber;
    private int modelYear, price;
}

Copy

Explain
The primary key is defined by using the @Id annotation. The @GeneratedValue annotation defines that the ID is automatically generated by the database. We can also define our key generation strategy; the AUTO type means that the JPA provider selects the best strategy for a particular database and it is also the default generation type. You can create a composite primary key by annotating multiple attributes with the @Id annotation.

The database columns are named according to class field naming conventions by default. If you want to use some other naming convention, you can use the @Column annotation. With the @Column annotation, you can define the column’s length and whether the column is nullable. The following code shows an example of using the @Column annotation. With this definition, the column’s name in the database is explanation, the length of the column is 512, and it is not nullable:

@Column(name="explanation", nullable=false, length=512)
private String description

Copy

Explain
Finally, we must add getters, setters, a default constructor, and constructors with attributes to the entity class. We don’t need an ID field in our constructor due to automatic ID generation. The source code of the Car entity class constructors is as follows:
Eclipse provides the automatic addition of getters, setters, and constructors. Activate your cursor in the place where you want to add the code and right-click. From the menu, select Source | Generate Getters and Setters... or Source | Generate Constructor using Fields....

// Car.java constructors
public Car() {
}
public Car(String brand, String model, String color,
    String registrationNumber, int modelYear, int price) {
        super();
        this.brand = brand;
        this.model = model;
        this.color = color;
        this.registrationNumber = registrationNumber;
        this.modelYear = modelYear;
        this.price = price;
}

Copy

Explain
The following is the source code for the Car entity class’s getters and setters:

    public Long getId() {
            return id;
    }
    public String getBrand() {
            return brand;
    }
    public void setBrand(String brand) {
            this.brand = brand;
    }
    public String getModel() {
            return model;
    }
    public void setModel(String model) {
            this.model = model;
    }
// Rest of the setters and getters. See the whole source code from GitHub

Copy

Explain
We also have to add new properties to the application.properties file. This allows us to log the SQL statements to the console. We also have to define the data source URL. Open the application.properties file and add the following two lines to the file:
spring.datasource.url=jdbc:h2:mem:testdb
spring.jpa.show-sql=true

Copy

Explain
When you are editing the application.properties file, you have to make sure that there are no extra spaces at the end of the lines. Otherwise, the settings won’t work. This might happen when you copy/paste settings.

Now, the car table will be created in the database when we run the application. At this point, we can see the table creation statements in the console:

Figure 3.7: Car table SQL statements

If spring.datasource.url is not defined in the application.properties file, Spring Boot creates a random data source URL that can be seen in the console when you run the application; for example, H2 console available at '/h2-console'. Database available at 'jdbc:h2:mem:b92ad05e-8af4-4c33-b22d-ccbf9ffe491e'.

The H2 database provides a web-based console that can be used to explore a database and execute SQL statements. To enable the console, we have to add the following lines to the application.properties file. The first setting enables the H2 console, while the second defines its path:
spring.h2.console.enabled=true
spring.h2.console.path=/h2-console

Copy

Explain
You can access the H2 console by starting your application and navigating to localhost:8080/h2-console using your web browser. Use jdbc:h2:mem:testdb as the JDBC URL and leave the Password field empty in the Login window. Press the Connect button to log in to the console, as shown in the following screenshot:

Figure 3.8: H2 console login

You can also change the H2 database username and password by using the following settings in the application.properties file: spring.datasource.username and spring.datasource.password.

Now, you can see our CAR table in the database. You may notice that the registration number and model year have an underscore between the words. The reason for the underscore is the camel case naming of the attribute (registrationNumber):


Figure 3.9: H2 console

Now, we have created our first entity class and learned how JPA generates a database table from the entity class. Next, we will create a repository class that provides CRUD operations.

Creating CRUD repositories
The Spring Boot Data JPA provides a CrudRepository interface for Create, Read, Update, and Delete (CRUD) operations. It provides CRUD functionalities to our entity class.

Let’s create our repository in the domain package, as follows:

Create a new interface called CarRepository in the com.packt.cardatabase.domain package and modify the file according to the following code snippet:
package com.packt.cardatabase.domain;
import org.springframework.data.repository.CrudRepository;
public interface CarRepository extends CrudRepository<Car,Long> {
}

Copy

Explain
CarRepository now extends the Spring Boot JPA CrudRepository interface. The <Car, Long> type arguments define that this is the repository for the Car entity class and that the type of the ID field is Long.

The CrudRepository interface provides multiple CRUD methods that we can now start to use. The following table lists the most commonly used methods:

Method

Description

long count()

Returns the number of entities

Iterable<T> findAll()

Returns all items of a given type

Optional<T> findById(ID Id)

Returns one item by ID

void delete(T entity)

Deletes an entity

void deleteAll()

Deletes all the entities in the repository

<S extends T> save(S entity)

Saves an entity

List<S> saveAll(Iterable<S> entities)

Saves multiple entities

Table 3.1: CRUD methods

If the method returns only one item, Optional<T> is returned instead of T. The Optional class was introduced in Java 8 SE and is a type of single-value container that either contains a value or doesn’t. If there is a value, the isPresent() method returns true and you can get it by using the get() method; otherwise, it returns false. By using Optional, we can prevent null pointer exceptions. Null pointers can lead to unexpected and often undesirable behavior in Java programs.

After adding the CarRepository class, your project structure should look as follows:


Figure 3.10: Project structure

Now, we are ready to add some demonstration data to our H2 database. For that, we will use the Spring Boot CommandLineRunner interface. The CommandLineRunner interface allows us to execute additional code before the application has fully started. Therefore, it is a good point to add demo data to your database. Your Spring Boot application’s main class implements the CommandLineRunner interface. Therefore, we should implement the run method, as shown in the following CardatabaseApplication.java code:
package com.packt.cardatabase;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
@SpringBootApplication
public class CardatabaseApplication implements CommandLineRunner {
    public static void main(String[] args) {
        SpringApplication.run
            (CardatabaseApplication.class, args);
    }
    @Override
    public void run(String... args) throws Exception {
        // Place your code here
    }
}

Copy

Explain
Next, we have to inject our car repository into the main class to be able to save new car objects to the database. We use constructor injection to inject CarRepository. We will also add a logger to our main class (the code for which we saw in Chapter 1):
package com.packt.cardatabase;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.packt.cardatabase.domain.Car;
import com.packt.cardatabase.domain.CarRepository;
@SpringBootApplication
public class CardatabaseApplication implements CommandLineRunner {
    private static final Logger logger =
        LoggerFactory.getLogger(
            CardatabaseApplication.class
        );
    private final CarRepository repository;
    public CardatabaseApplication(CarRepository repository) {
        this.repository = repository;
    }
    public static void main(String[] args) {
        SpringApplication.run
            (CardatabaseApplication.class, args);
    }
    @Override
    public void run(String... args) throws Exception {
      // Place your code here
    }
}

Copy

Explain
Once we have injected the repository class, we can use the CRUD methods it provides in the run method. The following sample code shows how to insert a few cars into the database using the save method. We will also use the repository’s findAll() method to fetch all the cars from the database and print them to the console using the logger:
    // CardataseApplication.java run method
    @Override
    public void run(String... args) throws Exception {
        repository.save(new Car("Ford", "Mustang", "Red",
                  "ADF-1121", 2023, 59000));
        repository.save(new Car("Nissan", "Leaf", "White",
                  "SSJ-3002", 2020, 29000));
        repository.save(new Car("Toyota", "Prius",
                  "Silver", "KKO-0212", 2022, 39000));
        // Fetch all cars and log to console
        for (Car car : repository.findAll()) {
            logger.info("brand: {}, model: {}",
                car.getBrand(), car.getModel());
        }
    }

Copy

Explain
The insert statements and cars we logged can be seen in the Eclipse console once the application has been executed:


Figure 3.11: Insert statements

You can now use the H2 console to fetch cars from the database, as shown in the following screenshot:


Figure 3.12: H2 console: Select cars

You can define queries in the Spring Data repositories. A query must start with a prefix, for example, findBy. After the prefix, you must define the entity class fields that are used in the query. The following is some sample code for three simple queries:

package com.packt.cardatabase.domain;
import java.util.List;
import org.springframework.data.repository.CrudRepository;
public interface CarRepository extends CrudRepository <Car, Long> {
    // Fetch cars by brand
    List<Car> findByBrand(String brand);
    // Fetch cars by color
    List<Car> findByColor(String color);
    // Fetch cars by model year
    List<Car> findByModelYear(int modelYear);
}

Copy

Explain
There can be multiple fields after the By keyword, concatenated with the And and Or keywords:

package com.packt.cardatabase.domain;
import java.util.List;
import org.springframework.data.repository.CrudRepository;
public interface CarRepository extends CrudRepository <Car, Long> {
    // Fetch cars by brand and model
    List<Car> findByBrandAndModel(String brand, String model);
    // Fetch cars by brand or color
    List<Car> findByBrandOrColor(String brand, String color);
}

Copy

Explain
Queries can be sorted by using the OrderBy keyword in the query method:

package com.packt.cardatabase.domain;
import java.util.List;
import org.springframework.data.repository.CrudRepository;
public interface CarRepository extends CrudRepository <Car, Long> {
    // Fetch cars by brand and sort by year
    List<Car> findByBrandOrderByModelYearAsc(String brand);
}

Copy

Explain
You can also create queries by using SQL statements via the @Query annotation. The following example shows the usage of a SQL query in CrudRepository:

package com.packt.cardatabase.domain;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
public interface CarRepository extends CrudRepository <Car, Long> {
    // Fetch cars by brand using SQL
    @Query("select c from Car c where c.brand = ?1")
    List<Car> findByBrand(String brand);
}

Copy

Explain
With the @Query annotation, you can use more advanced expressions, such as like. The following example shows the usage of the like query in CrudRepository:

package com.packt.cardatabase.domain;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
public interface CarRepository extends CrudRepository <Car, Long> {
    // Fetch cars by brand using SQL
    @Query("select c from Car c where c.brand like %?1")
    List<Car> findByBrandEndsWith(String brand);
}

Copy

Explain
If you use the @Query annotation and write SQL queries in your code, your application might be less portable across different database systems.

Spring Data JPA also provides PagingAndSortingRepository, which extends CrudRepository. This offers methods to fetch entities using pagination and sorting. This is a good option if you are dealing with larger amounts of data because you don’t have to return everything from a large result set. You can also sort your data into some meaningful order. PagingAndSortingRepository can be created in a similar way to how we created CrudRepository:

package com.packt.cardatabase.domain;
import org.springframework.data.repository.PagingAndSortingRepository;
public interface CarRepository extends
    PagingAndSortingRepository <Car, Long> {
    }

Copy

Explain
In this case, you now have the two new additional methods that the repository provides:

Method

Description

Iterable<T> findAll(Sort sort)

Returns all entities sorted by the given options

Page<T> findAll(Pageable pageable)

Returns all entities according to the given paging options

Table 3.2: PagingAndSortingRepository methods

At this point, we have completed our first database table and we are ready to add relationships between the database tables.

Adding relationships between tables
We will create a new table called owner that has a one-to-many relationship with the car table. In this case, a one-to-many relationship means that the owner can own multiple cars, but a car can only have one owner.

The following Unified Modeling Language (UML) diagram shows the relationship between the tables:


Figure 3.13: One-to-many relationship

The following are the steps to create a new table:

First, we must create the Owner entity and repository classes in the com.packt.cardatabase.domain package. The Owner entity and repository are created in a similar way to the Car class.
The following is the source code for the Owner entity class:

// Owner.java
package com.packt.cardatabase.domain;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
@Entity
public class Owner {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long ownerid;
    private String firstname, lastname;
    public Owner() {
    }
    public Owner(String firstname, String lastname) {
        super();
        this.firstname = firstname;
        this.lastname = lastname;
    }
    public Long getOwnerid() {
        return ownerid;
    }
    public String getFirstname() {
        return firstname;
    }
    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }
    public String getLastname() {
        return lastname;
    }
    public void setLastname(String lastname) {
        this.lastname = lastname;
    }
}

Copy

Explain
The following is the source code for OwnerRepository:

// OwnerRepository.java
package com.packt.cardatabase.domain;
import org.springframework.data.repository.CrudRepository;
public interface OwnerRepository extends 
    CrudRepository<Owner, Long> {
    }

Copy

Explain
Now, we should check that everything is working. Run the project and check that both database tables have been created and that there are no errors in the console. The following screenshot shows the console messages when the tables are created:

Figure 3.14: The car and owner tables

Now, our domain package contains two entity classes and repositories:


Figure 3.15: The Project Explorer

The one-to-many relationship can be added by using the @ManyToOne and @OneToMany annotations (jakarta.persistence). In the car entity class, which contains a foreign key, you must define the relationship with the @ManyToOne annotation. You should also add the getter and setter for the owner field. It is recommended that you use FetchType.LAZY for all associations. For the toMany relationships, that is the default value, but for the toOne relationships, you should define it. FetchType defines the strategy for fetching data from the database. The value can be either EAGER or LAZY. In our case, the LAZY strategy means that when the owner is fetched from the database, the cars associated with the owner will be fetched when needed. EAGER means that the cars will be fetched immediately by the owner. The following source code shows how to define a one-to-many relationship in the Car class:
// Car.java
@ManyToOne(fetch=FetchType.LAZY)
@JoinColumn(name="owner")
private Owner owner;
// Getter and setter
public Owner getOwner() {
    return owner;
}
public void setOwner(Owner owner) {
    this.owner = owner;
}

Copy

Explain
On the owner entity site, the relationship is defined with the @OneToMany annotation. The type of field is List<Car> because an owner may have multiple cars. Add the getter and setter for this, as follows:
// Owner.java
@OneToMany(cascade=CascadeType.ALL, mappedBy="owner")
private List<Car> cars;
    
public List<Car> getCars() {
    return cars;
}
public void setCars(List<Car> cars) {
    this.cars = cars;
}

Copy

Explain
The @OneToMany annotation has two attributes that we are using. The cascade attribute defines how cascading affects the entities in the case of deletions or updates. The ALL attribute setting means that all operations are cascaded. For example, if the owner is deleted, the cars that are linked to that owner are deleted as well. The mappedBy="owner" attribute setting tells us that the Car class has the owner field, which is the foreign key for this relationship.

When you run the project, by looking in the console, you will see that the relationship has been created:


Figure 3.16: Console

Now, we can add some owners to the database with CommandLineRunner. Let’s also modify the Car entity class constructor and add an owner object there:
// Car.java constructor
public Car(String brand, String model, String color, 
           String registrationNumber, int modelYear, int price,
           Owner owner) 
{
    super();
    this.brand = brand;
    this.model = model;
    this.color = color;
    this.registrationNumber = registrationNumber;
    this.modelYear = modelYear;
    this.price = price;
    this.owner = owner;
}

Copy

Explain
First, we will create two owner objects and save these to the database using the repository’s saveAll method, which we can use to save multiple entities at once. To save the owners, we have to inject OwnerRepository into the main class. Then, we must connect the owners to the cars by using the Car constructor. First, let’s modify the CardatabaseApplication class by adding the following imports:
// CardatabaseApplication.java
import com.packt.cardatabase.domain.Owner;
import com.packt.cardatabase.domain.OwnerRepository;

Copy

Explain
Now, let’s also inject OwnerRepository into the CardatabaseApplication class using constructor injection:
private final CarRepository repository;
private final OwnerRepository orepository;
public CardatabaseApplication(CarRepository repository,
                              OwnerRepository orepository) 
{
    this.repository = repository;
    this.orepository = orepository;
}

Copy

Explain
At this point, we must modify the run method to save owners and link owners and cars:
@Override
public void run(String... args) throws Exception {
    // Add owner objects and save these to db
    Owner owner1 = new Owner("John" , "Johnson");
    Owner owner2 = new Owner("Mary" , "Robinson");
    orepository.saveAll(Arrays.asList(owner1, owner2));
    repository.save(new Car("Ford", "Mustang", "Red",
                            "ADF-1121", 2023, 59000, owner1));
    repository.save(new Car("Nissan", "Leaf", "White",
                            "SSJ-3002", 2020, 29000, owner2));
    repository.save(new Car("Toyota", "Prius", "Silver",
                            "KKO-0212", 2022, 39000, owner2));
    // Fetch all cars and log to console
    for (Car car : repository.findAll()) 
      {
        logger.info("brand: {}, model: {}", car.getBrand(), 
        car.getModel());
      }
}

Copy

Explain
Now, if you run the application and fetch cars from the database, you will see that the owners are now linked to the cars:

Figure 3.17: OneToMany relationship

If you want to create a many-to-many relationship instead, which means, in practice, that an owner can have multiple cars and a car can have multiple owners, you should use the @ManyToMany annotation. In our example application, we will use a one-to-many relationship. The code that you have completed here will be needed in the next chapter.

Next, you will learn how to change the relationship to many-to-many. In a many-to-many relationship, it is recommended that you use Set instead of List with Hibernate:

In the Car entity class’s many-to-many relationship, define the getters and setters in the following way:
// Car.java
@ManyToMany(mappedBy="cars")
private Set<Owner> owners = new HashSet<Owner>();
public Set<Owner> getOwners() {
    return owners;
}
public void setOwners(Set<Owner> owners) {
    this.owners = owners;
}

Copy

Explain
In the Owner entity class, the many-to-many relationship is defined as follows:
// Owner.java
@ManyToMany(cascade=CascadeType.PERSIST)
@JoinTable(name="car_owner",joinColumns = 
        {
        @JoinColumn(name="ownerid") },
        inverseJoinColumns = 
        {
        @JoinColumn(name="id") }
)
private Set<Car> cars = new HashSet<Car>();
public Set<Car> getCars() {
    return cars;
}
public void setCars(Set<Car> cars) {
    this.cars = cars;
}

Copy

Explain
Now, if you run the application, there will be a new join table called car_owner that is created between the car and owner tables. The join table is a special kind of table that manages the many-to-many relationship between two tables.
The join table is defined by using the @JoinTable annotation. With this annotation, we can set the name of the join table and join columns. The following screenshot shows the database structure when using a many-to-many relationship:


Figure 3.18: Many-to-many relationship

Now, the database UML diagram looks as follows:



Figure 3.19: Many-to-many relationship

We have used an in-memory H2 database in the chapter so far. In the next section, we will be using a one-to-many relationship, so change your code back if you followed the previous many-to-many example.

Next, we are going to look at how to use a MariaDB database instead.

Setting up a MariaDB database
Now, we will switch the database we are using from H2 to MariaDB. H2 is a good database for test and demonstration purposes, but MariaDB is a better option for a proper production database when applications require performance, reliability, and scalability.

In this book, we are using MariaDB version 10. The database tables are still created automatically by JPA. However, before we run our application, we have to create a database for it.

In this section, we will be using the one-to-many relationship from the previous section.

The database can be created using HeidiSQL (or DBeaver, if you are using Linux or macOS). Open HeidiSQL and follow these steps:

Activate the top database connection name (Unnamed) and right-click it.
Then, select Create new | Database:

Figure 3.20: Create new database

Let’s name our database cardb. After clicking OK, you should see the new cardb database in the database list:

Figure 3.21: The cardb database

In Spring Boot, add a MariaDB Java client dependency to the build.gradle file and remove the H2 dependency since we don’t need it anymore. Remember to refresh your Gradle project after you have modified your build.gradle file:
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    developmentOnly 'org.springframework.boot:spring-boot-devtools'
    runtimeOnly 'org.mariadb.jdbc:mariadb-java-client'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}

Copy

Explain
In the application.properties file, you must define the database connection for MariaDB. In this phase, you should remove the old H2 database settings. First, you must define the database’s URL, username, password (defined in Chapter 1), and database driver class:
spring.datasource.url=jdbc:mariadb://localhost:3306/cardb
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD
spring.datasource.driver-class-name=org.mariadb.jdbc.Driver

Copy

Explain
In this example, we are using the database root user, but in production, you should create a user for your database that doesn’t have all root database rights.

Add the spring.jpa.generate-ddl setting, which defines whether JPA should initialize the database (true/false). Also add the spring.jpa.hibernate.ddl-auto setting, which defines the behavior of the database initialization:
spring.datasource.url=jdbc:mariadb://localhost:3306/cardb
spring.datasource.username=root
spring.datasource.password=YOUR_PASSWORD
spring.datasource.driver-class-name=org.mariadb.jdbc.Driver
spring.jpa.generate-ddl=true
spring.jpa.hibernate.ddl-auto=create-drop

Copy

Explain
The possible values for spring.jpa.hibernate.ddl-auto are none, validate, update, create, and create-drop. The default value depends on your database. If you are using an embedded database such as H2, the default value is create-drop; otherwise, the default value is none. create-drop means that the database is created when an application starts, and it is dropped when the application is stopped. The create value only creates the database when the application is started. The update value creates the database and updates the schema if it has changed.

Check that the MariaDB database server is running and restart your Spring Boot application. After running the application, you should see the tables in MariaDB. You might have to refresh the database tree in HeidiSQL first by pressing the F5 key. The following screenshot shows the HeidiSQL user interface once the database has been created:

Figure 3.22: MariaDB cardb You can also run SQL queries in HeidiSQL.

Now, your application is ready to use with MariaDB.

Summary
In this chapter, we used JPA to create our Spring Boot application database. First, we created entity classes, which are mapped to database tables.

Then, we created a CrudRepository for our entity class, which provides CRUD operations for the entity. After that, we managed to add some demo data to our database by using CommandLineRunner. We also created one-to-many relationships between two entities. At the beginning of this chapter, we used the H2 in-memory database, and we switched the database to MariaDB at the end.

In the next chapter, we will create a RESTful web service for our backend. We will also look at testing the RESTful web service with the cURL command-line tool and the Postman GUI.

Questions
What are ORM, JPA, and Hibernate?
How can you create an entity class?
How can you create a CrudRepository?
What does a CrudRepository provide for your application?
How can you create a one-to-many relationship between tables?
How can you add demo data to a database with Spring Boot?
How can you access the H2 console?
How can you connect your Spring Boot application to MariaDB?
Further reading
Packt has other resources for learning more about MariaDB, Hibernate, and JPA:

Getting Started with MariaDB, by Daniel Bartholomew (https://www.packtpub.com/product/getting-started-with-mariadb/9781785284120)
Master Hibernate and JPA with Spring Boot in 100 Steps [Video], by In28Minutes Official (https://www.packtpub.com/product/master-hibernate-and-jpa-with-spring-boot-in-100-steps-video/9781788995320)
Learn more on Discord
To join the Discord community for this book – where you can share feedback, ask the author questions, and learn about new releases – follow the QR code below:

https://packt.link/FullStackSpringBootReact4e



| ≪ [ 102 Understanding Dependency Injection ](/books/packtpub/2024/1202-Spring_Boot_3_React/102_Understanding_Dependency_Injection) | 103 Using JPA to Create and Access a Database | [ 104 Creating a RESTful Web Service with Spring Boot ](/books/packtpub/2024/1202-Spring_Boot_3_React/104_Creating_a_RESTful_Web_Service_with_Spring_Boot) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 103 Using JPA to Create and Access a Database
> (2) Short Description: Spring Boot 3 React
> (3) Path: books/packtpub/2024/1202-Spring_Boot_3_React/103_Using_JPA_to_Create_and_Access_a_Database
> Book Jemok: Full Stack Development with Spring Boot 3 and React 4Ed
> AuthorDate: Juha Hinkula / Oct 2023 / 454 pages 4Ed
> Link: https://subscription.packtpub.com/book/web-development/9781805122463/pref
> create: 2024-12-02 월 14:31:21
> .md Name: 103_using_jpa_to_create_and_access_a_database.md

