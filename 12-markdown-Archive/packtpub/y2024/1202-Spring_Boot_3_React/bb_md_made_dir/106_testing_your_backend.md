
| ≪ [ 105 Securing Your Backend ](/books/packtpub/2024/1202-Spring_Boot_3_React/105) | 106 Testing Your Backend | [ 207 Setting Up the Environment and Tools ](/books/packtpub/2024/1202-Spring_Boot_3_React/207) ≫ |
|:----:|:----:|:----:|

# 106 Testing Your Backend

This chapter explains how to test your Spring Boot backend. The backend of an application is responsible for handling business logic and data storage. Proper testing of the backend ensures that the application works as intended, is secure, and is easier to maintain. We will create some unit and integration tests in relation to our backend, using the database application that we created earlier as a starting point.

In this chapter, we will cover the following topics:

Testing in Spring Boot
Creating test cases
Test-driven development
Technical requirements
The Spring Boot application that we created in the previous chapters is required.

The following GitHub link will also be required: https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-3-and-React-Fourth-Edition/tree/main/Chapter06.

Testing in Spring Boot
The Spring Boot test starter package is automatically added to the build.gradle file by Spring Initializr when we create our project. The test starter dependency can be seen in the following snippet:

testImplementation 'org.springframework.boot:spring-boot-starter-test'

Copy

Explain
The Spring Boot test starter provides lots of handy libraries for testing, such as JUnit, Mockito, and AssertJ. Mockito is a mocking framework that is often used alongside testing frameworks like JUnit. AssertJ is a popular library for writing assertions in Java testing. In this book, we will use JUnit 5. The JUnit Jupiter module is part of JUnit 5 and provides annotations for more flexible testing.

If you take a look at your project structure, you’ll see that it already has its own package created for test classes:

­
Figure 6.1: Test classes

By default, Spring Boot uses an in-memory database for testing. We are using MariaDB at this point in the book, but we can use H2 for testing if we add the following dependency to the build.gradle file:

testRuntimeOnly 'com.h2database:h2'

Copy

Explain
This specifies that the H2 database will only be used to run tests; otherwise, the application will use the MariaDB database.

Remember to refresh your Gradle project in Eclipse after you have updated the build.gradle file.

Now, we can start to create test cases for our application.

Creating test cases
There are many different types of software tests, and each has its own specific objectives. Some of the most important test types are:

Unit tests: Unit tests focus on the smallest component of software. This could be, for example, a function, and a unit test will ensure that it works correctly in isolation. Mocking is often used in unit testing to replace the dependencies of the unit that is being tested.
Integration tests: Integration tests focus on the interaction between individual components, ensuring that individual components work together as expected.
Functional tests: Functional testing focuses on business scenarios that are defined in functional specifications. Test cases are designed to verify that software meets the specified requirements.
Regression tests: Regression tests are designed to verify that new code or code updates do not break existing functionality.
Usability tests: Usability tests verify that software is user-friendly, intuitive, and easy to use from an end-user perspective. Usability tests focus more on the frontend and user experience.
For unit and integration testing, we are using JUnit, a popular Java-based unit testing library. Spring Boot has built-in support for JUnit, making it easy to write tests for your application.

The following source code shows an example skeleton for the Spring Boot test class. The @SpringBootTest annotation specifies that the class is a regular test class that runs Spring Boot-based tests. The @Test annotation before the method specifies to JUnit that the method can be run as a test case:

@SpringBootTest
public class MyTestsClass {
    @Test
    public void testMethod() {
        // Test case code
    }
}

Copy

Explain
Assertions in unit testing are statements that can be used to verify whether the actual output of a code unit matches the expected output. In our case, the assertions are implemented using the AssertJ library that the spring-boot-starter-test artifact automatically includes. The AssertJ library provides an assertThat() method that you can use to write assertions. You pass an object or a value to the method, allowing you to compare values with the actual assertions. The AssertJ library contains multiple assertions for different data types. The next sample demonstrates some example assertions:

// String assertion
assertThat("Learn Spring Boot").startsWith("Learn");
// Object assertion
assertThat(myObject).isNotNull();
// Number assertion
assertThat(myNumberVariable).isEqualTo(3);
// Boolean assertion
assertThat(myBooleanVariable).isTrue();

Copy

Explain
You can find all the different assertions in the AssertJ documentation: https://assertj.github.io/doc.

We will now create our initial unit test case, which checks that our controller instance is correctly instantiated and is not null. Proceed as follows:

Open the CardatabaseApplicationTests test class that has already been made for your application by the Spring Initializr starter project. There is one test method called contextLoads in here, and this is where we will add the test. Write the following test, which checks that the instance of the controller was created and injected successfully. We use an AssertJ assertion to test that the injected controller instance is not null:
package com.packt.cardatabase;
import static org.assertj.core.api.Assertions.assertThat;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import com.packt.cardatabase.web.CarController;
@SpringBootTest
class CardatabaseApplicationTests {
    @Autowired
    private CarController controller;
    @Test
    void contextLoads() {
        assertThat(controller).isNotNull();
    }
}

Copy

Explain
We use field injection here, which is well-suited for test classes because you will never instantiate your test classes directly. You can read more about dependency injection of test fixtures in the Spring documentation: https://docs.spring.io/spring-framework/reference/testing/testcontext-framework/fixture-di.html.

To run tests in Eclipse, activate the test class in the Project Explorer and right-click. Select Run As | JUnit test from the menu. You should now see the JUnit tab in the lower part of the Eclipse workbench. The test results are shown in this tab, and the test case has been passed, as illustrated in the following screenshot:

Figure 6.2: JUnit test run

You can use the @DisplayName annotation to give a more descriptive name to your test case. The name defined in the @DisplayName annotation is shown in the JUnit test runner. The code is illustrated in the following snippet:
@Test
@DisplayName("First example test case")
void contextLoads() {
    assertThat(controller).isNotNull();
}

Copy

Explain
Now, we will create integration tests for our owner repository to test create, read, update, and delete (CRUD) operations. This test verifies that our repository interacts correctly with a database. The idea is to simulate database interactions and verify that your repository methods behave as expected:

Create a new class called OwnerRepositoryTest in the root test package. Instead of the @SpringBootTest annotation, the @DataJpaTest annotation can be used if the test is focused on Jakarta Persistence API (JPA) components. When using this annotation, the H2 database and Spring Data are automatically configured for testing. SQL logging is also turned on. The code is illustrated in the following snippet:
package com.packt.cardatabase;
import static org.assertj.core.api.Assertions.assertThat;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import com.packt.cardatabase.domain.Owner;
import com.packt.cardatabase.domain.OwnerRepository;
@DataJpaTest
class OwnerRepositoryTest {
    @Autowired
    private OwnerRepository repository;
}

Copy

Explain
In this example, we use the root package for all test classes and name our classes logically. Alternatively, you can create a similar package structure for your test classes as we did for our application classes.

We will add our first test case to test the addition of a new owner to the database. Add the following query to your OwnerRepository.java file. We will use this query in our test case:
Optional<Owner> findByFirstname(String firstName);

Copy

Explain
A new Owner object is created and saved to the database using the save method. Then, we check that the owner can be found. Add the following test case method code to your OwnerRepositoryTest class:
@Test
void saveOwner() {
    repository.save(new Owner("Lucy", "Smith"));
    assertThat(
        repository.findByFirstname("Lucy").isPresent()
    ).isTrue();
}

Copy

Explain
The second test case will test the deletion of the owner from the database. A new Owner object is created and saved to the database. Then, all owners are deleted from the database, and finally, the count() method should return zero. The following source code shows the test case method. Add the following method code to your OwnerRepositoryTest class:
@Test
void deleteOwners() {
    repository.save(new Owner("Lisa", "Morrison"));
    repository.deleteAll();
    assertThat(repository.count()).isEqualTo(0);
}

Copy

Explain
Run the test cases and check the Eclipse JUnit tab to find out whether the tests passed. The following screenshot shows that they have indeed passed:

Figure 6.3: Repository test cases

Next, we will demonstrate how to test your RESTful web service JWT authentication functionality. We will create an integration test that sends an actual HTTP request to the login endpoint and verifies the response:

Create a new class called CarRestTest in the root test package. To test the controllers or any endpoint that is exposed, we can use a MockMvc object. By using the MockMvc object, the server is not started, but the tests are performed in the layer where Spring handles HTTP requests, and therefore it mocks the real situation. MockMvc provides the perform method to send these requests. To test authentication, we have to add credentials to the request body. We print request and response details to the console using the andDo() method. Finally, we check that the response status is Ok using the andExpect() method. The code is illustrated in the following snippet:
package com.packt.cardatabase;
import static org.springframework.test.web.servlet.
request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.
servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpHeaders;
import org.springframework.test.web.servlet.MockMvc;
@SpringBootTest
@AutoConfigureMockMvc
class CarRestTest {
    @Autowired
    private MockMvc mockMvc;
    @Test
    public void testAuthentication() throws Exception {
    // Testing authentication with correct credentials
        this.mockMvc
            .perform(post("/login")
            .content("{\"username\":\"admin\",\"password\""
                     +":\"admin\"}")
            .header(HttpHeaders.CONTENT_TYPE,"application/json"))
            .andDo(print()).andExpect(status().isOk());
    }
}

Copy

Explain
Now, when we run the authentication tests, we will see that the test passes, as the following screenshot confirms:

Figure 6.4: Login test

You can run all tests at once by selecting the test package from the Project Explorer and running the JUnit tests (Run As | JUnit test). In the image below, you can see the result when all test cases have been passed:

Figure 6.5: Running tests

Testing with Gradle
All tests run automatically when you build your project using Gradle. We will go into more detail about building and deployment later in this book. In this section, we will only cover some basics:

You can run different predefined Gradle tasks using Eclipse. Open the Window | Show View | Other… Menu. That opens the Show View window, where you should select Gradle Tasks:

Figure 6.6: Gradle tasks

You should see the list of Gradle tasks, as shown in the following image. Open the build folder and double-click the build task to run it:

Figure 6.7: Build task

The Gradle build task creates a build folder in your project, where your Spring Boot project is built. The build process runs all the tests from your project. If any of the tests fail, the build process also fails. The build process creates a test summary report (an index.html file), which you can find in the build\reports\tests\test folder. If any of your tests fail, you can find the reason from the summary report. In the image below, you can see an example of a test summary report:


Figure 6.8: Test summary

The build task creates an executable jar file in the \build\libs folder. You can now run your built Spring Boot application using the following command in the \build\libs folder (you should have the JDK installed):
java -jar .\cardatabase-0.0.1-SNAPSHOT.jar

Copy

Explain
Now, you can write unit and integration tests for your Spring Boot application. You have also learned how to run tests using the Eclipse IDE.

Test-driven development
Test-driven development (TDD) is a practice in software development where you write tests before writing the actual code. The idea is to ensure that your code meets the criteria or requirements that are set. Let’s see one example of how TDD works in practice.

Our goal is to implement a service class that manages messages in our application. You can see the common steps of TDD below:

The following code is not fully functioning. It is just an example for you to get a better idea of the TDD process.

The first functionality to be implemented is a service that can be used to add new messages. Therefore, in TDD, we will create a test for adding new messages to a list of messages. In the test code, we first create an instance of the message service class. Then, we create a test message that we want to add to the list. We call the addMsg method of the messageService instance, passing the msg as an argument. This method is responsible for adding messages to a list. Finally, the assertion checks if the message added to the list matches the expected message, "Hello world":
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.assertEquals;
@SpringBootTest
public class MessageServiceTest {
    @Test
    public void testAddMessage() {
        MessageService messageService = new MessageService();
        String msg = "Hello world";
        Message newMsg = messageService.addMsg(msg);
        assertEquals(msg, newMsg.getMessage());
    }
}

Copy

Explain
Now, we can run the test. It should fail because we haven’t implemented our service yet.
Next, we will implement the MessageService, which should contain the addMsg() function that we are testing in our test case:
@Service
public class MessageService {
    private List<Message> messages = new ArrayList<>();
    public Message addMsg(String msg) {
        Message newMsg = new Message(msg);
        messages.add(newMSg);
        return newMsg;
    }
}

Copy

Explain
Now, if you run the test again, it should pass if your code works as expected.
If the test does not pass, you should refactor your code until it does.
Repeat these steps for each new feature.
TDD is an iterative process that helps to ensure that your code works and that new features don’t break other parts of the software. This is also called regression testing. By writing a test before implementing the functionality, we can catch bugs early in the development phase. Developers should understand feature requirements and expected outcomes before actual development.

At this point, we have covered the basics of testing in Spring Boot applications, and you have gained the knowledge you need to implement more test cases for your applications.

Summary
In this chapter, we focused on testing the Spring Boot backend. We used JUnit for testing and implemented test cases for JPA and RESTful web service authentication. We created one test case for our owner repository to verify that repository methods behave as expected. We also tested the authentication process by using our RESTful API. Remember that testing is an ongoing process throughout the development life cycle. You should update and add tests to cover new features and changes when your application evolves. Test-driven development is one way of doing this.

In the next chapter, we will set up the environment and tools related to frontend development.

Questions
How can you create unit tests with Spring Boot?
What is the difference between unit and integration tests?
How can you run and check the results of unit tests?
What is TDD?
Further reading
There are many other good resources available to learn about Spring Security and testing. A few are listed here:

JUnit and Mockito Unit Testing for Java Developers, by Matthew Speake (https://www.packtpub.com/product/junit-and-mockito-unit-testing-for-java-developers-video/9781801078337)
Mastering Software Testing with JUnit 5, by Boni García (https://www.packtpub.com/product/mastering-software-testing-with-junit-5/9781787285736)
Java Programming MOOC: Introduction to testing, by the University of Helsinki (https://java-programming.mooc.fi/part-6/3-introduction-to-testing)
Master Java Unit Testing with Spring Boot and Mockito, by In28Minutes Official (https://www.packtpub.com/product/master-java-unit-testing-with-spring-boot-and-mockito-video/9781789346077)
Learn more on Discord
To join the Discord community for this book – where you can share feedback, ask the author questions, and learn about new releases – follow the QR code below:

https://packt.link/FullStackSpringBootReact4e



| ≪ [ 105 Securing Your Backend ](/books/packtpub/2024/1202-Spring_Boot_3_React/105) | 106 Testing Your Backend | [ 207 Setting Up the Environment and Tools ](/books/packtpub/2024/1202-Spring_Boot_3_React/207) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 106 Testing Your Backend
> (2) Short Description: Spring Boot 3 React
> (3) Path: books/packtpub/2024/1202-Spring_Boot_3_React/106
> Book Jemok: Full Stack Development with Spring Boot 3 and React 4Ed
> AuthorDate: Juha Hinkula / Oct 2023 / 454 pages 4Ed
> Link: https://subscription.packtpub.com/book/web-development/9781805122463/pref
> create: 2024-12-02 월 14:31:21
> .md Name: 106_testing_your_backend.md

