
| ≪ [ 103 Using JPA to Create and Access a Database ](/books/packtpub/2024/1202-Spring_Boot_3_React/103) | 104 Creating a RESTful Web Service with Spring Boot | [ 105 Securing Your Backend ](/books/packtpub/2024/1202-Spring_Boot_3_React/105) ≫ |
|:----:|:----:|:----:|

# 104 Creating a RESTful Web Service with Spring Boot

Web services are applications that communicate over the internet using the HTTP protocol. There are many different types of web service architectures, but the principal idea across all designs is the same. In this book, we will create a RESTful web service: nowadays, a really popular design.

In this chapter, we will first create a RESTful web service using a controller class. Then, we will use Spring Data REST to create a RESTful web service that also provides all CRUD functionalities automatically, and document it with OpenAPI 3. After you have created a RESTful API for your application, you can implement the frontend using a JavaScript library such as React. We will be using the database application that we created in the previous chapter as a starting point.

In this chapter, we will cover the following topics:

Basics of REST
Creating a RESTful web service with Spring Boot
Using Spring Data REST
Documenting a RESTful API
Technical requirements
The Spring Boot application created in the previous chapters is required.

You will also need Postman, cURL, or another suitable tool for transferring data using various HTTP methods.

The following GitHub link will be required: https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-3-and-React-Fourth-Edition/tree/main/Chapter04.

Basics of REST
Representational State Transfer (REST) is an architectural style for creating web services. REST is neither language- nor platform-dependent; different clients like mobile apps, browsers, and other services can communicate with each other. RESTful services can be scaled easily to fulfill increased demand.

REST is not a standard but a set of constraints, defined by Roy Fielding. The constraints are as follows:

Stateless: The server shouldn’t hold any information about the client state.
Client-server independence: The client and server should act independently. The server should not send any information without a request from the client.
Cacheable: Many clients often request the same resources; therefore, caching should be applied to resources in order to improve performance.
Uniform interface: Requests from different clients should look the same. Clients may include, for example, a browser, a Java application, and a mobile application.
Layered system: Components can be added or modified without affecting the entire service. This constraint affects scalability.
Code on demand: This is an optional constraint. Most of the time, the server sends static content in the form of JSON or XML. This constraint allows the server to send executable code if needed.
The uniform interface constraint is important, and it means that every REST architecture should have the following elements:

Identification of resources: Resources should be identified by unique identifiers, for example, URIs in web-based REST services. REST resources should expose easily understood directory structure URIs. Therefore, a good resource-naming strategy is very important.
Resource manipulation through representation: When making a request to a resource, the server should respond with a representation of the resource. Typically, the format of the representation is JSON or XML.
Self-descriptive messages: Messages should contain enough information that the server knows how to process them.
Hypermedia as the Engine of Application State (HATEOAS): Responses should contain links to other areas of the service.
The RESTful web service that we are going to develop in the next sections follows the REST architectural principles above.

Creating a RESTful web service with Spring Boot
In Spring Boot, all HTTP requests are handled by controller classes. To be able to create a RESTful web service, first, we have to create a controller class. We will create our own Java package for the controller:

Activate the root package in the Eclipse Project Explorer and right-click. Select New | Package from the menu. We will name our new package com.packt.cardatabase.web:

Figure 4.1: New Java package

Next, we will create a new controller class in a new web package. Activate the com.packt.cardatabase.web package in the Eclipse Project Explorer. Right-click and select New | Class from the menu; we will name our class CarController:

Figure 4.2: New Java class

Now, your project structure should look like the following screenshot:

Figure 4.3: Project structure

If you create classes in the wrong package accidentally, you can drag and drop the files between packages in the Project Explorer. Sometimes, the Project Explorer view might not be rendered correctly when you make some changes. Refreshing the Project Explorer helps (activate the Project Explorer and press F5).

Open your controller class in the editor window and add the @RestController annotation before the class definition. Refer to the following source code. The @RestController annotation identifies that this class will be the controller for the RESTful web service:
package com.packt.cardatabase.web;
import org.springframework.web.bind.annotation.RestController;
@RestController
public class CarController {
}

Copy

Explain
Next, we add a new method inside our controller class. The method is annotated with the @GetMapping annotation, which defines the endpoint that the method is mapped to. In the following code snippet, you can see the sample source code. In this example, when a user makes a GET request to the /cars endpoint, the getCars() method is executed:
package com.packt.cardatabase.web;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import com.packt.cardatabase.domain.Car;
@RestController
public class CarController {
    @GetMapping("/cars")
    public Iterable<Car> getCars() {
//Fetch and return cars
    }
}

Copy

Explain
The getCars() method returns all the car objects, which are then marshaled to JSON objects automatically by the Jackson library (https://github.com/FasterXML/jackson).

Now, the getCars() method handles only GET requests from the /cars endpoint because we are using the @GetMapping annotation. There are other annotations for the different HTTP methods, such as @GetMapping, @PostMapping, @DeleteMapping, and so on.

To be able to return cars from the database, we have to inject CarRepository into the controller. Then, we can use the findAll() method that the repository provides to fetch all cars. Due to the @RestController annotation, the data is now serialized to JSON format in the response. The following source code shows the controller code:
package com.packt.cardatabase.web;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import com.packt.cardatabase.domain.Car;
import com.packt.cardatabase.domain.CarRepository;
@RestController
public class CarController {
    private final CarRepository repository;
    public CarController(CarRepository repository) {
        this.repository = repository;
    }
    @GetMapping("/cars")
    public Iterable<Car> getCars() {
        return repository.findAll();
    }
}

Copy

Explain
Now, we are ready to run our application and navigate to localhost:8080/cars. We can see that there is something wrong, and the application seems to be in an infinite loop. This happens on account of our one-to-many relationship between the car and owner tables. So, what happens in practice? First, the car is serialized, and it contains an owner who is then serialized, and that, in turn, contains cars that are then serialized, and so on. There are different solutions for avoiding this. One way is to use the @JsonIgnore annotation on the cars field in the Owner class, which ignores the cars field in the serialization process. You can also solve this by avoiding bidirectional mapping if it is not needed. We will also use the @JsonIgnoreProperties annotation to ignore fields that are generated by Hibernate:
// Owner.java
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer","handler"})
public class Owner {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private long ownerid;
    private String firstname, lastname;
    public Owner() {}
    public Owner(String firstname, String lastname) {
        super();
        this.firstname = firstname;
        this.lastname = lastname;
    }
    @JsonIgnore
    @OneToMany(cascade=CascadeType.ALL, mappedBy="owner")
    private List<Car> cars;

Copy

Explain
Now, when you run the application and navigate to localhost:8080/cars, everything should go as expected and you will get all the cars from the database in JSON format, as shown in the following screenshot:

Figure 4.4: GET request to http://localhost:8080/cars

Your output might differ from the screenshot due to browser differences. In this book, we are using the Chrome browser and the JSON Viewer extension, which makes JSON output more readable. JSON Viewer can be downloaded from the Chrome Web Store for free.

We have written our first RESTful web service. By leveraging the capabilities of Spring Boot, we were able to quickly implement a service that returns all the cars in our database. However, this is just the beginning of what Spring Boot has to offer for creating robust and efficient RESTful web services, and we will continue to explore its capabilities in the next section.

Using Spring Data REST
Spring Data REST (https://spring.io/projects/spring-data-rest) is part of the Spring Data project. It offers an easy and fast way to implement RESTful web services with Spring. Spring Data REST provides HATEOAS (Hypermedia as the Engine of Application State) support, an architectural principle that allows clients to navigate the REST API dynamically using hypermedia links. Spring Data REST also provides events that you can use to customize the business logic of your REST API endpoints.

You can read more about events in the Spring Data REST documentation: https://docs.spring.io/spring-data/rest/docs/current/reference/html/#events.

To start using Spring Data REST, you have to add the following dependency to the build.gradle file:

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    implementation 'org.springframework.boot:spring-boot-starter-data-rest'
    developmentOnly 'org.springframework.boot:spring-boot-devtools'
    runtimeOnly 'org.mariadb.jdbc:mariadb-java-client'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}

Copy

Explain
Refresh your Gradle project from Eclipse after you have modified the build.gradle file. Select the project in Eclipse’s Project Explorer and right-click to open the context menu. Then, select Gradle | Refresh Gradle Project.

By default, Spring Data REST finds all public repositories from the application and creates RESTful web services for your entities automatically. In our case, we have two repositories: CarRepository and OwnerRepository; therefore, Spring Data REST creates RESTful web services automatically for those repositories.

You can define the endpoint of the service in your application.properties file as follows. You might need to restart your application for the changes to take effect:

spring.data.rest.basePath=/api

Copy

Explain
Now, you can access the RESTful web service from the localhost:8080/api endpoint. By calling the root endpoint of the service, it returns the resources that are available. Spring Data REST returns JSON data in the Hypertext Application Language (HAL) format. The HAL format provides a set of conventions for expressing hyperlinks in JSON and it makes your RESTful web service easier to use for frontend developers:


Figure 4.5: Spring Boot Data REST resources

We can see that there are links to the car and owner entity services. The Spring Data REST service path name is derived from the entity class name. The name will then be pluralized and uncapitalized. For example, the entity Car service path name will become cars. The profile link is generated by Spring Data REST and contains application-specific metadata. If you want to use different path naming, you can use the @RepositoryRestResource annotation in your repository class, as shown in the next example:

package com.packt.cardatabase.domain;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
@RepositoryRestResource(path="vehicles")
public interface CarRepository extends CrudRepository<Car, Long> {
}

Copy

Explain
Now, if you call the endpoint localhost:8080/api, you can see that the endpoint has been changed from /cars to /vehicles.


Figure 4.6: Spring Boot Data REST resources

You can remove the different naming, and we will continue with the default endpoint name, /cars.

Now, we’ll start to examine different services more carefully. There are multiple tools available for testing and consuming RESTful web services. In this book, we are using the Postman (https://www.postman.com/downloads/) desktop app, but you can use tools that you are familiar with, such as cURL. Postman can be acquired as a desktop application or as a browser plugin. cURL is also available for Windows by using Windows Ubuntu Bash (Windows Subsystem for Linux, WSL).

If you make a request to the /cars endpoint (http://localhost:8080/api/cars) using the GET method (note: you can use a web browser for GET requests), you will get a list of all the cars, as shown in the following screenshot:


Figure 4.7: Fetch cars

In the JSON response, you can see that there is an array of cars, and each car contains car-specific data. All the cars also have the _links attribute, which is a collection of links, and with these links, you can access the car itself or get the owner of the car. To access one specific car, the path will be http://localhost:8080/api/cars/{id}.

The GET request to http://localhost:8080/api/cars/3/owner returns the owner of the car with id 3. The response now contains owner data, a link to the owner, and links to the owner’s other cars.

The Spring Data REST service provides all CRUD operations. The following table shows which HTTP methods you can use for different CRUD operations:

HTTP method

CRUD

GET

Read

POST

Create

PUT/PATCH

Update

DELETE

Delete

Table 4.1: Spring Data REST operations

Next, we will look at how to delete a car from the database by using our RESTful web service. In a delete operation, you have to use the DELETE method and the link to the car that will be deleted (http://localhost:8080/api/cars/{id}).

The following screenshot shows how you can delete one car with id 3 by using the Postman desktop app. In Postman, you have to select the correct HTTP method from the drop-down list, enter the request URL, and then click the Send button:


Figure 4.8: DELETE request to delete car

If everything goes correctly, you will see the response status 200 OK in Postman. After the successful DELETE request, you will also see that there are now two cars left in the database if you make a GET request to the http://localhost:8080/api/cars/ endpoint. If you got the 404 Not Found status in the DELETE response, check that you are using a car ID that exists in the database.

When we want to add a new car to the database, we have to use the POST method, and the request URL is http://localhost:8080/api/cars. The header must contain the Content-Type field with the value application/json, and the new car object will be embedded in the request body in JSON format.

Here is one car example:

{
  "brand":"Toyota",
  "model":"Corolla",
  "color":"silver",
  "registrationNumber":"BBA-3122",
  "modelYear":2023,
  "price":38000
}

Copy

Explain
If you click the Body tab and select raw in Postman, you can type a new car JSON string under the Body tab. Also select JSON from the drop-down list, as shown in the following screenshot:


Figure 4.9: POST request to add a new car

You also have to set a header by clicking the Headers tab in Postman, as shown in the following screenshot. Postman adds some headers automatically based on your request selections. Check that the Content-Type header is in the list and the value is correct (application/json). If it doesn’t exist, you should add it manually. Automatically added headers might be hidden by default, but you can see these by clicking the hidden button. Finally, you can press the Send button:


Figure 4.10: POST request headers

The response will send a newly created car object back and the status of the response will be 201 Created if everything went correctly. Now, if you make a GET request again to the http://localhost:8080/api/cars path, you will see that the new car exists in the database.

To update entities, we can use the PATCH method and the link to the car that we want to update (http://localhost:8080/api/cars/{id}). The header must contain the Content-Type field with the value application/json, and the car object with edited data will be given inside the request body.

If you are using PATCH, you have to send only fields that are updated. If you are using PUT, you have to include all fields in the request body.

Let’s edit the car that we created in the previous example, changing the color to white. We are using PATCH, so the payload contains only the color property:

{
  "color": "white"
}

Copy

Explain
The Postman request is shown in the following screenshot (note: we set the header as in the POST example and use the car id in the URL):


Figure 4.11: PATCH request to update existing car

If the update succeeded, the response status is 200 OK. If you now fetch the updated car using a GET request, you will see that the color has been updated.

Next, we will add an owner to the new car that we just created. We can use the PUT method and the http://localhost:8080/api/cars/{id}/owner path. In this example, the ID of the new car is 4, so the link is http://localhost:8080/api/cars/4/owner. The content of the body is now linked to an owner, for example, http://localhost:8080/api/owners/1.


Figure 4.12: PUT request to update owner

The Content-Type value of the headers should be text/uri-list in this case. If you can’t modify the automatically added header, you can disable it by unchecking it. Then, add a new one, like shown in the next image, and press the Send button:


Figure 4.13: PUT request headers

Finally, you can make a GET request for the car’s owner, and you should now see that the owner is linked to the car.

In the previous chapter, we created queries for our repository. These queries can also be included in our service. To include queries, you have to add the @RepositoryRestResource annotation to the repository class. Query parameters are annotated with the @Param annotation. The following source code shows CarRepository with these annotations:

package com.packt.cardatabase.domain;
import java.util.List;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation RepositoryRestResource;
@RepositoryRestResource
public interface CarRepository extends CrudRepository<Car, Long> {
    // Fetch cars by brand
    List<Car> findByBrand(@Param("brand") String brand);
    // Fetch cars by color
    List<Car> findByColor(@Param("color") String color);
}

Copy

Explain
Now, when you make a GET request to the http://localhost:8080/api/cars path, you can see that there is a new endpoint called /search. Calling the http://localhost:8080/api/cars/search path returns the following response:


Figure 4.14: REST queries

From the response, you can see that both queries are now available in our service. The following URL demonstrates how to fetch cars by brand: http://localhost:8080/api/cars/search/findByBrand?brand=Ford. The output will only contain cars with the brand Ford.

At the beginning of this chapter, we introduced the REST principles, and we can see that our RESTful API fulfills several aspects of the REST specification. It is stateless and requests from different clients look the same (uniform interface). The response contains links that can be used to navigate between related resources. Our RESTful API provides a URI structure that reflects the data model and relationship between resources.

We have now created the RESTful API for our backend, and we will consume it later with our React frontend.

Documenting a RESTful API
A RESTful API should be properly documented so that developers who are consuming it understand its functionality and behavior. The documentation should include what endpoints are available, what data formats are accepted, and how to interact with the API.

In this book, we will use the OpenAPI 3 library for Spring Boot (https://springdoc.org) to generate documentation automatically. The OpenAPI Specification (formerly Swagger Specification) is an API description format for RESTful APIs. There are other alternatives, such as RAML (https://raml.org/), that can be used as well. You can also document your REST API using some other documentation tools, which provide flexibility but require more manual work. The use of the OpenAPI library automates this work, allowing you to focus on development.

The following steps demonstrate how you can generate documentation for your RESTful API:

First, we have to add the OpenAPI library to our Spring Boot application. Add the following dependency to your build.gradle file:
implementation group: 'org.springdoc', name: 'springdoc-openapi-starter-webmvc-ui', version: '2.0.2'

Copy

Explain
Next, we create a configuration class for our documentation. Create a new class called OpenApiConfig in the com.packt.cardatabase package of your application. Below is the code for the configuration class where we can configure, for example, the REST API title, description, and version. We can use the info() method to define these values:
package com.packt.cardatabase;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
@Configuration
public class OpenApiConfig {
    @Bean
    public OpenAPI carDatabaseOpenAPI() {
        return new OpenAPI()
            .info(new Info()
            .title("Car REST API")
            .description("My car stock")
            .version("1.0"));
    }
}

Copy

Explain
In the application.properties file, we can define the path for our documentation. We can also enable Swagger UI, a user-friendly tool for visualizing RESTful APIs that are documented using the OpenAPI Specification (https://swagger.io/tools/swagger-ui/). Add the following settings to your application.properties file:
springdoc.api-docs.path=/api-docs
springdoc.swagger-ui.path=/swagger-ui.html
springdoc.swagger-ui.enabled=true

Copy

Explain
Now, we are ready to run our project. When your application is running, navigate to http://localhost:8080/swagger-ui.html and you will see the documentation in Swagger UI, as shown in the following screenshot:

Figure 4.15: Car RESTful API documentation

You can see all the endpoints that are available in your RESTful API. If you open any of the endpoints, you can even try them out by pressing the Try it out button. The documentation is also available in JSON format at http://localhost:8080/api-docs.

Now that you have provided documentation for your RESTful API, it is much easier for developers to consume it.

In the next chapter, we will secure our RESTful API, which will break access to Swagger UI. You can allow access again by modifying your security configuration (allow the "/api-docs/**" and "/swagger-ui/**" paths). You can also use Spring Profiles, but that is out of scope for this book.

Summary
In this chapter, we created a RESTful web service with Spring Boot. First, we created a controller and one method that returns all cars in JSON format. Next, we used Spring Data REST to get a fully functional web service with all CRUD functionalities. We covered different types of requests that are needed to use the CRUD functionalities of the service that we created. We also included our queries in the RESTful web service. Finally, we learned how to document our API properly with OpenAPI 3.

We will use this RESTful web service with our frontend later in this book, and now you can also easily implement a REST API for your own needs.

In the next chapter, we will secure our backend using Spring Security. We will learn how to secure our data by implementing authentication. Then, only authenticated users will be able to access the RESTful API’s resources.

Questions
What is REST?
How can you create a RESTful web service with Spring Boot?
How can you fetch items using our RESTful web service?
How can you delete items using our RESTful web service?
How can you add items using our RESTful web service?
How can you update items using our RESTful web service?
How can you use queries with our RESTful web service?
What is the OpenAPI Specification?
What is Swagger UI?
Further reading
Packt has other resources available for learning about Spring Boot RESTful web services:

Postman Tutorial: Getting Started with API Testing [Video] by Praveenkumar Bouna (https://www.packtpub.com/product/postman-tutorial-getting-started-with-api-testing-video/9781803243351)
Hands-On RESTful API Design Patterns and Best Practices by Harihara Subramanian J and Pethuru Raj (https://www.packtpub.com/product/hands-on-restful-api-design-patterns-and-best-practices/9781788992664)
Learn more on Discord
To join the Discord community for this book – where you can share feedback, ask the author questions, and learn about new releases – follow the QR code below:

https://packt.link/FullStackSpringBootReact4e




| ≪ [ 103 Using JPA to Create and Access a Database ](/books/packtpub/2024/1202-Spring_Boot_3_React/103) | 104 Creating a RESTful Web Service with Spring Boot | [ 105 Securing Your Backend ](/books/packtpub/2024/1202-Spring_Boot_3_React/105) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 104 Creating a RESTful Web Service with Spring Boot
> (2) Short Description: Spring Boot 3 React
> (3) Path: books/packtpub/2024/1202-Spring_Boot_3_React/104
> Book Jemok: Full Stack Development with Spring Boot 3 and React 4Ed
> AuthorDate: Juha Hinkula / Oct 2023 / 454 pages 4Ed
> Link: https://subscription.packtpub.com/book/web-development/9781805122463/pref
> create: 2024-12-02 월 14:31:21
> .md Name: 104_creating_a_restful_web_service_with_spring_boot.md

