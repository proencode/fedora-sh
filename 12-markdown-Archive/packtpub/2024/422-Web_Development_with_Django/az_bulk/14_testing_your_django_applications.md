
| ≪ [ 13 Generating CSV, PDF, and Other Binary Files ](/packtpub/2024/422-web_development_with_django_2ed/13_generating_csv,_pdf,_and_other_binary_files) | 14 Testing Your Django Applications | [ 15 Django Third-Party Libraries ](/packtpub/2024/422-web_development_with_django_2ed/15_django_third-party_libraries) ≫ |
|:----:|:----:|:----:|

# 14 Testing Your Django Applications



Book image


Testing Your Django Applications
In the preceding chapters, we focused on building our web application in Django by writing different components such as database models, views, and templates. We did all that to provide our users with an interactive application where they can create a profile and write reviews for the books they have read.

Apart from building and running the application, there is another important aspect of making sure that the application code works the way we expect it to work. This is ensured by a technique called testing. In testing, we run the different parts of the web application and check whether the output of the executed component matches the output we expected. If the output matches, we say that the component was tested successfully, while if the output doesn’t match, we say that the component failed to work as intended.

In this chapter, as we go through the different sections, we will learn why testing is important, the different ways to test a web application, and how we can build a strong testing strategy that will help us ensure that the web application we build is robust.

In this chapter, we will cover the following topics:

Importance of testing
Automation testing
Testing in Django
Testing Django models
Testing Django views
Django request factory
Test case classes in Django
Let’s start our journey by first learning about the importance of testing.

Technical requirements
The complete code files for this chapter can be found at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter14

Importance of testing
Making sure that an application works the way it was designed to work is an important aspect of the development efforts because otherwise, our users might keep on encountering weird behaviors that will usually drive away their engagement from the application.

The efforts we put into testing help us ensure that the different kinds of problems that we intend to solve are indeed being solved correctly. Imagine a case where a developer is building an online event scheduling platform. On this platform, users can schedule events on their calendars as per their local time zone. Now, what if in this platform, users can schedule events as expected, but due to a bug, the events are scheduled in an incorrect time zone? It is such issues that tend to drive many users away.

That’s why a lot of enterprise companies spend a huge amount of money making sure that the applications they are building have undergone thorough testing. That way, they ensure that they do not release a buggy product or a product that is far away from satisfying user requirements.

In brief, testing helps us achieve the following goals:

Ensure that the components of the application work according to specifications
Ensure interoperability on different infrastructure platforms, if an application can be deployed on a different operating system such as Linux or Windows, and more
Helps reduce the probability of introducing a bug while refactoring the application code
Now, a common assumption many people have about testing is that they have to test all the components manually as they are developed to make sure each component works according to its specifications and repeat this exercise every time a change is made or a new component is added to the application. While this is true, this doesn’t provide a complete picture of testing. Testing as a technique has grown very powerful with time and as a developer, you can reduce a huge amount of testing effort by implementing automated test cases. So, what are these automated test cases? Or, in other words, what is automation testing? Let’s find out.

Automation testing
Testing the whole application repeatedly when a single component is modified can turn out to be a challenging task, and even more so if that application consists of a large code base. The size of the code base could be due to the sheer number of features or the complexity of the problem it solves.

As we develop applications, it is important to make sure that the changes being made to these applications can be tested easily so that we can verify whether something is breaking. That’s where the concept of automation testing comes in handy. The focus of automation testing is to write tests as code so that the individual components of an application can be tested in isolation as well as testing their interaction with each other.

In light of this, it is important for us to define the different kinds of automation tests that can be done for the applications.

Automation testing can be broadly categorized into five different types:

Unit testing: In this type of testing, the individual isolated units of code are tested. For example, a unit test can target a single method or a single isolated API. This kind of testing is performed to make sure the basic units of the application work according to their specification.
Integration testing: In this type of testing, the individual isolated units of code are merged to form a logical grouping. Once this grouping is formed, testing is performed on this logical group to make sure that the group works in the way it is expected.
Functional testing: In this kind of testing, the overall functionality of the different components of the application is tested. This may include different APIs, user interfaces, and more.
Smoke testing: In this kind of testing, the stability of the deployed application is tested to make sure that the application continues to remain functional as the users interact with it, without causing a crash.
Regression testing: This kind of testing is done to make sure that the changes being made to the application do not degrade the previously built functionality of the application.
As we can see, testing is a big domain that takes time to master; entire books have been written on this topic. To make sure we highlight the important aspects of testing, we are going to focus on the aspect of unit testing in this chapter.

Testing in Django
Django is a feature-packed framework that aims to make web application development rapid. It also provides a full-featured way of testing applications.

Django provides a well-integrated module that allows application developers to write unit tests for their applications. This module is based on the Python unittest library, which ships with most of the Python distributions pre-packaged.

So, let’s get started by understanding how we can write basic test cases in Django and how to leverage the framework-provided modules to test our application code.

Implementing test cases
While working on implementing mechanisms for testing your code, the first thing you need to understand is how this implementation can be logically grouped so that modules that are closely related to each other are tested in one logical unit.

This can be simplified by implementing a test case. A test case is nothing more than a logical unit that groups together tests that are related so that all the common logic to initialize the environment for the test cases can be combined in the same place, hence avoiding duplication of work while implementing application testing code.

Unit testing in Django
Now that we understand tests, let’s take a look at how we can do unit testing inside Django. In the context of Django, a unit test consists of two major parts:

A TestCase class, which wraps the different test cases that are grouped for a given module
An actual test case that needs to be executed to test the flow of a particular component
The class implementing a unit test should inherit from the TestCase class provided by Django’s test module. By default, Django provides a tests.py file in every application directory, which can be used to store the test cases for the application module.

Once these unit tests have been written, they can be executed easily by running them directly using the provided test command in manage.py, as follows:

python manage.py test

Copy

Explain
Now, let’s look at how assertions can help us build our unit tests and check for the expected behavior.

Utilizing assertions
An important part of writing tests is validating if the test passed or failed. Generally, to implement such decisions inside a testing environment, we utilize something known as assertions.

Assertions are a common concept in software testing. They take in two operands and validate whether the value of the operand on the left-hand side (LHS) matches the value of the operand on the right-hand side (RHS). If the value of the LHS matches the value of the RHS, an assertion is considered to be successful, whereas if the values differ, the assertion is considered to have failed.

An assertion that evaluates to False essentially causes a test case to be evaluated as a failure, which is then reported to the user.

Assertions in Python are quite easy to implement, and they use a simple keyword called assert. For example, the following code snippet shows a very simple assertion:

assert 1 == 1

Copy

Explain
The preceding assertion takes in a single expression, which evaluates to True. If this assertion was part of a test case, the test would have succeeded.

Now, let’s see how we can implement test cases using the Python unittest library. Doing so is quite easy and can be accomplished with some easy-to-follow steps:

Import the unittest module, which allows us to build the test cases:
import unittest

Copy

Explain
Once the module has been imported, we can create a class whose name starts with Test, and which inherits from the TestCase class provided by the unittest module:
class TestMyModule(unittest.TestCase):
    def test_method_a(self):
        assert <expression>

Copy

Explain
Only if the TestMyModule class inherits the TestCase class will Django be able to run it automatically with full integration with the framework. Once the class has been defined, we can implement a new method inside the class named test_method_a(), which validates an assertion. And that’s it.

An important part to note here is the naming scheme for the test cases and test functions. The test cases being implemented should be prefixed with the name Test so that the test execution modules can detect them as valid test cases and execute them. The same rule applies to naming testing methods.

Once the test case has been written, it can be simply executed by running the following command:
python manage.py test

Copy

Explain
With our basic understanding of implementing test cases clarified, let’s write a very simple unit test to get a feel of how the unit testing framework behaves inside Django.

Exercise 14.01 – writing a simple unit test
In this exercise, we will write a simple unit test to understand how the Django unit testing framework works and use this knowledge to implement our first test case that validates a simple expression:

To get started, open the tests.py file under the reviews application of the Bookr project. By default, this file will contain only a single line that imports Django’s TestCase class from the test module:
from django.test import TestCase

Copy

Explain
Add the following lines of code to the tests.py file you just opened:
class TestSimpleComponent(TestCase):
  def test_basic_sum(self):
    assert 1+1 == 2

Copy

Explain
Here, we created a new class named TestSimpleComponent, which inherits from the TestCase class provided by Django’s test module. The assert statement will compare the expression on the LHS (1+1) with the one on the RHS (2).

Once you have written the test case, navigate back to the project folder and run the following command:
python manage.py test

Copy

Explain
The following output should be generated:

% ./manage.py test
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
.
----------------------------------------------------------------------
Ran 1 test in 0.001s
OK
Destroying test database for alias 'default'...

Copy

Explain
The preceding output signifies that Django’s test runner executed 1 test case, which successfully passed the evaluation.

With the test case confirmed to be working and passing, we will now try to add another assertion at the end of the test_basic_sum() method, as shown in the following code snippet:
    assert 1+1 == 3

Copy

Explain
With the assert statement added in step 4, execute the test cases by running the following command from the project folder:
python manage.py test

Copy

Explain
At this point, you will notice Django reporting that the execution of the test cases has failed.

With this, you understand how test cases can be written in Django and how the assertions can be used to validate whether the output generated from your method calls under test is correct or not.

Now that we have basic knowledge of assertions, let’s deep dive into the different types of assertions that are present and their usage.

Types of assertions
In Exercise 14.01 – writing a simple unit test, we briefly encountered assertions when we came across the following assert statement:

assert 1+1 == 2

Copy

Explain
These assertion statements are simple and use the Python assert keyword. A few different types of assertions are possible that can be tested inside a unit test while using the unittest library. Let’s look at those:

assertIsNone: This assertion is used to check whether an expression evaluates to None or not. For example, this type of assertion can be used in cases where a query to a database returns None because no records were found for the specified filtering criteria.
assertIsInstance: This assertion is used to validate if a provided object evaluates to an instance of the provided type. For example, this assertion can be used to validate if the value returned by a method indeed is of a specific type, such as List, Dict, Tuple, and more.
assertEquals: This is a very basic function that takes in two arguments and checks whether the arguments provided to it are equal in value or not. This can be useful when you plan to compare the values of data structures that do not guarantee ordering.
assertRaises: This method is used to validate whether the name of the method provided to it when called raises a specified exception or not. This is helpful when we are writing test cases where a code path that raises an exception needs to be tested. As an example, this kind of assertion can be useful when we want to want to make sure an exception is raised by a method performing a database query if the database connection is not yet established.
These were just a small set of useful assertions that we can make in our test cases. The unittest module on top of which Django’s testing library is built provides a lot more assertions that can be tested for.

Ever wondered what to do when our unit tests require some lists to be pre-populated or databases to be pre-initialized? The next section will cover how to pre-test this setup and how it can help us avoid introducing repetitive code that must be executed before every test case.

Performing pre-test setup and cleanup after every test case run
Sometimes, while writing test cases, we may need to perform some repetitive tasks, such as setting up some variables that will be required for the test. Once the test is over, we will want to clean up all the changes we’ve made to the test variables so that any new test starts with a fresh instance.

Luckily, the unittest library provides us with a useful way to automate our repetitive efforts of setting up the environment before every test case runs and cleaning it up after the test case is finished. This can be achieved using the two methods that we can implement in our TestCase.

The first is the setUp() method. This method is called before the execution of every test method inside the TestCase class. It implements the code required to set up the test case’s environment before the test executes. This method can be a good place to set up any local database instance or test variables that may be required for the test cases.

Important note

The setUp() method is only valid for test cases written inside the TestCase class.

For example, the following example illustrates a simple definition of how the setUp() method is used inside a TestCase class:

class MyTestCase(unittest.TestCase):
    def setUp(self):
        # Do some initialization work
    def test_method_a(self):
        # code for testing method A
    def test_method_b(self):
        # code for testing method B

Copy

Explain
In the preceding example, when we try to execute the test cases, the setUp() method we defined here will be called every time before a test method executes. In other words, the setUp() method will be called before the execution of the test_method_a() call and then it will be called again before the test_method_b() call is called.

The second Is the tearDown() method. This method is called once the test function finishes execution and cleans up the variables and their values once the test case’s execution has finished. This method is executed regardless of whether the test case evaluates to True or False. An example of using the tearDown() method is shown here:

class MyTestCase(unittest.TestCase):
    def setUp(self):
        # Do some initialization work
    def test_method_a(self):
        # code for testing method A
    def test_method_b(self):
        # code for testing method B
    def tearDown(self):
        # perform cleanup

Copy

Explain
In the preceding example, the tearDown() method will be called every time a test method finishes execution – that is, once test_method_a() finishes executing and again once after test_method_b() finishes executing.

Now that we are aware of the different components of writing test cases. let’s look at how we can test the different aspects of a Django application using the provided test framework.

Testing Django models
Models in Django are object-based representations of how data will be stored inside the database of an application. They provide methods that can help us validate the data input provided for a given record, as well as perform any processing on the data before it is inserted into the database.

It is as easy to test models in Django as it is to create them. Now, let’s look at how Django models can be tested using the Django Test framework.

Exercise 14.02 – testing Django models
In this exercise, we will create a new Django model and write test cases for it. The test case will validate whether your model can correctly insert and retrieve the data from the database. These kinds of test cases that work on database models can turn out to be useful in cases where a team of developers is collaborating on a large project and the same database model may be modified by multiple developers over time. Implementing test cases for the database models allows developers to pre-emptively identify potentially breaking changes that they may inadvertently introduce as a part of their work. Let’s get started with the steps:

Create a new application that you will use for the exercises in this chapter. For this, run the following command, which will set up a new application for your use case:
python manage.py startapp bookr_test

Copy

Explain
To make sure the bookr_test application behaves the same way as any other application in the Django project, add this application to our INSTALLED_APPS section of the Bookr project. To do this, open the settings.py file in your Bookr project and append the following code to the INSTALLED_APPS list:
INSTALLED_APPS = [
    ….,
    ….,
    'bookr_test'
]

Copy

Explain
Now, with the application setup complete, create a new database model that you will use for testing purposes. For this exercise, we are going to create a new model named Publisher that will store the details about the book publisher in our database. To create the model, open the models.py file under the bookr_test directory and add the following code to it:
from django.db import models
class Publisher(models.Model):
    """A company that publishes books."""
    name = models.CharField(
        max_length=50, help_text="The name of the
            Publisher.")
    website = models.URLField(
        help_text="The Publisher's website.")
    email = models.EmailField(
        help_text="The Publisher's email address.")
    def __str__(self):
        return self.name

Copy

Explain
In the preceding code snippet, you created a new class named Publisher that inherits from the Model class of the Django’s models module, defining the class as a Django model that will be used to store data about the publisher:

class Publisher(models.Model)

Copy

Explain
Inside this model, we have added three fields, which will act as the properties of the model:

name: The name of the publisher
website: The website belonging to the publisher
email: The email address of the publisher
Once we did this, we created a class method called __str__() that defines what the string representation of the Model class will look like.

Now, with the model created, you need to migrate this model before you can run a test on it. To do this, run the following commands:
python manage.py makemigrations
python manage.py migrate

Copy

Explain
With the model now set up, write the test case with which you are going to test the model you created in step 3. For this, open the tests.py file under the bookr_test directory and add the following code to it:
from django.test import TestCase
from .models import Publisher
class TestPublisherModel(TestCase):
    """Test the publisher model."""
    def setUp(self):
        self.p = Publisher(name='Packt',
            website='www.packt.com',
                email='contact@packt.com')
    def test_create_publisher(self):
        self.assertIsNotNone(self.p, Publisher)
    def test_str_representation(self):
        self.assertEquals(str(self.p), "Packt")

Copy

Explain
In the preceding code snippet, there are a couple of things worth exploring.

At the start, after importing the TestCase class from the Django test module, you imported the Publisher model from the bookr_test directory, which is going to be used for testing.

Once the required libraries have been imported, we must create a new class named TestPublisherModel that inherits the TestCase class and is used for grouping the unit tests related to the Publisher model:

class TestPublisherModel(TestCase):

Copy

Explain
Inside this class, we defined a couple of methods. First, we defined a new method named setUp() and added the Model object creation code to it so that the Model object is created every time a new test method is executed inside this test case. This Model object is stored as a class member so that it can be accessed inside other methods without a problem:

def setUp(self):
    self.p = Publisher(name='Packt',
        website='www.packt.com',
            email='contact@packt.com')

Copy

Explain
The first test case validates whether the Model object for the Publisher model was created successfully or not. To do this, we created a new method named test_create_publisher() inside which we check whether the Model object created points to an object of the Publisher type. If this Model object was not created successfully, your test will fail:

    def test_create_publisher(self):
        self.assertIsInstance(self.p, Publisher)

Copy

Explain
If you check carefully, you will see that we are using the assertIsInstance() method of the unittest library here to assert whether the Model object belongs to the Publisher type or not.

The next test validates whether the string representation of the Model is the same as what we expected it to be. From the code definition, the string representation of the Publisher model should output the name of the publisher. To test this, we created a new method named test_str_representation() and checked whether the generated string representation of the model matches the one we are expecting:

def test_str_representation(self):
    self.assertEquals(str(self.p), "Packt")

Copy

Explain
To perform this validation, we used the assertEquals method of the unittest library, which validates whether the two values provided to it are equal or not.

With the test cases now in place, you can run them to check what happens. To run these test cases, run the following command:
python manage.py test

Copy

Explain
Once the command finishes executing, you will see an output that resembles the one shown here:

% python manage.py test
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
..
----------------------------------------------------------------------
Ran 2 tests in 0.002s
OK
Destroying test database for alias 'default'...

Copy

Explain
As you can see from the preceding output, the test cases are executed successfully, hence validating that the operations, such as creating a new Publisher object and its string representation when fetched, are being done correctly.

With this exercise, we saw how we can write test cases for our Django models easily and validate their functionality by creating objects, retrieving them, and representing them.

Also, notice the following important line in the output from Exercise 14.02 – testing Django models:

"Destroying test database for alias 'default'..."

Copy

Explain
This happens because when there are test cases that require the data to be persisted inside a database, instead of using the production database, Django creates a new empty database for the test cases, which it uses to persist the value for the test case.

Now that we know how to test models in Django, in the next section, we will learn how to test views in Django.

Testing Django views
Views in Django control the rendering of the HTTP response for users based on the URL they visit in a web application. In this section, we will learn how to test views inside Django. Imagine you are working on a website where a lot of application programming interface (API) endpoints are required. An interesting question to ask is, how will you be able to validate every new endpoint? If done manually, you will have to first deploy the application every time a new endpoint is added, then manually visit the endpoint in the browser to validate if it is working fine or not. Such an approach may work out when the number of endpoints is few but may become extremely cumbersome if there are hundreds of endpoints.

Django provides a very comprehensive way of testing application views. This happens by using a testing client class provided by Django’s test module. This class can be used to visit URLs mapped to the views and capture the output generated by visiting the URL endpoint. Then, we can use the captured output to test whether the URLs are generating a correct response or not. This client can be used by importing the Client class from the Django test module and then initializing it, as shown in the following snippet:

from django.test import Client
c = Client()

Copy

Explain
The Client object supports several methods that can be used to simulate the different HTTP calls a user can make – namely, GET, POST, PUT, DELETE, and others. An example of making such a request looks like this:

response = c.get('/welcome')

Copy

Explain
The response generated by the view is then captured by the client and gets exposed as a response object, which can then be queried to validate the output of the view.

With this knowledge, let’s look at how we can write test cases for our Django views.

Exercise 14.03 – writing unit tests for Django views
In this exercise, we will use the Django test client to write a test case for our Django view, which will be mapped to a specific URL. These test cases will help you validate whether your View function generates the correct response when visited using its mapped URL. Let’s get started with the steps:

For this exercise, you are going to use the bookr_test application that was created in step 1 of Exercise 14.02 – testing Django models. To get started, open the views.py file under the bookr_test directory and add the following code to it:
from django.http import HttpResponse
def greeting_view(request):
    """Greet the user."""
    return HttpResponse("Hey there, welcome to Bookr!
        Your one stop place to review books.")

Copy

Explain
Here, you have created a simple Django view that will be used to greet the user with a welcome message whenever they visit an endpoint mapped to the provided view.

Once the view has been created, you need to map this view to a URL endpoint that can then be visited in a browser or a test client. To do this, open the urls.py file under the bookr_test directory and add the highlighted code to the urlpatterns list:
from django.urls import path
from . import views
urlpatterns = [
    path('test/greeting', views.greeting_view,
           name='greeting_view')
]

Copy

Explain
In the preceding code snippet, we mapped greeting_view to the 'test/greeting' endpoint for the application by setting the path in the urlpatterns list.

Once this path has been set up, we need to make sure that it is also identified by our project. For this, we need to add this entry to the Bookr project’s URL mapping. To achieve that, open the urls.py file in the bookr directory and append the following highlighted line to the end of the urlpatterns list:
urlpatterns = [
    ….,
    ….,
    path('', include('bookr_test.urls'))
]

Copy

Explain
Once the view has been set up, validate that it works correctly. Do this by running the following command:
python manage.py runserver localhost:8080

Copy

Explain
Then, visit http://localhost:8080/test/greeting in your web browser. Once the page opens, you should see the following text you added in step 1 to the greeting view being displayed in the browser:

Hey there, welcome to Bookr! Your one stop place to review books.

Copy

Explain
Now, we are ready to write the test cases for greeting_view. For this exercise, we are going to write a test case that checks whether, on visiting the /test/greeting endpoint, you get a successful result or not. To implement this test case, open the tests.py file under the bookr_test directory and add the following code to the end of the file:
from django.test import TestCase, Client
class TestGreetingView(TestCase):
    """Test the greeting view."""
    def setUp(self):
        self.client = Client()
    def test_greeting_view(self):
        response = self.client.get('/test/greeting')
        self.assertEquals(response.status_code, 200)

Copy

Explain
In the preceding code snippet, we defined a test case that helps validate whether the greeting view is working fine or not.

This is done by first importing Django’s test client, which allows you to test views mapped to the URLs by making calls to them and analyzing the generated response:

from django.test import TestCase, Client

Copy

Explain
Once the import has been done, we must create a new class named TestGreetingView that will group the test cases related to the greeting view we created in step 2:

class TestGreetingView(TestCase):

Copy

Explain
Inside this test case, we defined two methods, setUp() and test_greeting_view(). The test_greeting_view() method implements your test case. Inside this, we are first making an HTTP GET call to the URL that is mapped to the greeting view and storing the response generated by the view inside the response object created:

response = self.client.get('/test/greeting')

Copy

Explain
Once this call finishes, you will have its HTTP response code, contents, and headers available inside the response variable. Next, with the following code, we make an assertion, validating whether the status code generated by the call matches the status code for successful HTTP calls (HTTP 200):

self.assertEquals(response.status_code, 200)

Copy

Explain
With this, we are now ready to run the tests.

With the test case written, look at what happens when you run the test case. This can be done by running the following command:
python manage.py test

Copy

Explain
Once the command executes, you can expect to see an output like the one shown in the following snippet:

% python manage.py test
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
...
----------------------------------------------------------------------
Ran 3 tests in 0.006s
OK
Destroying test database for alias 'default'...

Copy

Explain
As you can see from the output, your test cases executed successfully, hence validating that the response generated by the greeting_view() method is as per your expectations.

In this exercise, we learned how we can implement a test case for a Django view function and use Django’s TestClient to assert that the output generated by the view function matches the one the developer should see.

In the next section, we will learn how to test views that have authentication enabled.

Testing views with authentication
In the previous example, we looked at how we can test views inside Django. An important thing to note about this view is that the view we created could be accessed by anyone and is not protected by any authentication or login checks. Now, imagine a case where a view should only be accessible if the user is logged in. For example, consider implementing a view function that renders a profile page of a registered user of our web application. To make sure that only logged-in users can view the profile page for their account, you might want to restrict the view to logged-in users only.

With this, we now have an important question: how can we test views that require authentication?

Luckily, Django’s test client provides this functionality, through which we can log in to our views and then run tests over them. This result can be achieved using Django’s test client login() method. When this method is called, Django’s test client performs an authentication operation against the service. If the authentication succeeds, it stores the login cookie internally, which it can then use for further test runs. The following code snippet shows how you can set up Django’s test client to simulate a logged-in user:

login = self.client.login(username='testuser', password='testpassword')

Copy

Explain
The login method requires a username and password for the test user that we are going to test with, as will be shown in the next exercise. So, let’s take a look at how we can test a flow that requires user authentication.

Exercise 14.04 – writing test cases to validate authenticated users
In this exercise, we will write test cases for views that require the user to be authenticated. As part of this, we will validate the output generated by the view method when a user who is not logged in tries to visit the page and when a user who is logged in tries to visit the page mapped to the view function. Let’s get started with the steps:

For this exercise, we are going to use the bookr_test application that you created in step 1 of Exercise 14.02 – testing Django models. To get started, open the views.py file under the bookr_test application and add the following code to it:
from django.http import HttpResponse
from django.contrib.auth.decorators import
login_required

Copy

Explain
Once the preceding code snippet has been added, create a new function called greeting_view_user() at the end of the file, as shown in the following code snippet:
@login_required
def greeting_view_user(request):
    """Greeting view for the user."""
    user = request.user
    return HttpResponse("Welcome to Bookr!
        {username}".format(username=user))

Copy

Explain
Here, we have created a simple Django view that will be used to greet the logged-in user with a welcome message whenever they visit an endpoint mapped to the provided view.

Once this view has been created, we need to map this view to a URL endpoint that can then be visited in a browser or a test client. To do this, open the urls.py file under the bookr_test directory and add the highlighted code to it:
from django.urls import path
from . import views
urlpatterns = [
    path('test/greet_user', views.greeting_view_user,
          name='greeting_view_user')
]

Copy

Explain
In the preceding code snippet, we mapped greeting_view to the 'test/greet_user' endpoint for the application by setting the path in the urlpatterns list:

path('test/greet_user', views.greeting_view_user,
      name='greeting_view_user')

Copy

Explain
If you have followed the previous exercises, this URL should already be set up for detection in the project and no further steps are required to configure the URL mapping.

Once the view has been set up, the next thing we need to do is validate whether it works correctly. To do this, run the following command:
python manage.py runserver localhost:8080

Copy

Explain
Then, visit http://localhost:8080/test/greet_user in your web browser.

If you are not logged in already, by visiting the preceding URL, you will be redirected to the login page for the project.

Now, write the test cases for greeting_view_user, which check whether, on visiting the /test/greet_user endpoint, you get a successful result or not. To implement this test case, open the tests.py file under the bookr_test directory and add the following code to it:
from django.contrib.auth.models import User
class TestLoggedInGreetingView(TestCase):
    """Test the greeting view for the authenticated
        users."""
    def setUp(self):
        test_user =
            User.objects.create_user(
                username='testuser',
                    password='test@#628password')
        test_user.save()
        self.client = Client()
    def test_user_greeting_not_authenticated(self):
        response = self.client.get('/test/greet_user')
        self.assertEquals(response.status_code, 302)
    def test_user_authenticated(self):
        login = self.client.login(username='testuser',
            password='test@#628password')
        response = self.client.get('/test/greet_user')
        self.assertEquals(response.status_code, 200)

Copy

Explain
In the preceding code snippet, we implemented a test case that checks the views that have authentication enabled before their content can be seen.

Here, first, we imported the required classes and methods that will be used to define the test case and initialize a testing client:

from django.test import TestCase, Client

Copy

Explain
The next thing you require is the User model from Django’s auth module:

from django.contrib.auth.models import User

Copy

Explain
This model is required because, for the test cases requiring authentication, we will need to initialize a new test user. Next up, we created a new class named TestLoggedInGreetingView, which wraps your tests related to the greeting_user view (which requires authentication). Inside this class, you defined three methods called setUp(), test_user_greeting_not_authenticated(), and test_user_authenticated(). The setUp() method is used to initialize a test user that you will use for authentication. This is a required step because a test environment inside Django is a completely isolated environment that doesn’t use data from your production application, so all the required models and objects are to be instantiated separately inside the test environment.

Then, we created the test user and initiated the test client using the following code:

test_user = User.objects.create_user(
    username='testuser', password='test@#628password')
test_user.save()
self.client = Client()

Copy

Explain
Next, we wrote the test case for the greet_user endpoint when the user is not authenticated. Here, you should expect Django to redirect the user to the login endpoint. This redirect can be detected by checking the HTTP status code of the response, which should be set to HTTP 302, indicating a redirect operation:

def test_user_greeting_not_authenticated(self):
    response = self.client.get('/test/greet_user')
    self.assertEquals(response.status_code, 302)

Copy

Explain
Next, we wrote another test case to check whether the greet_user endpoint renders successfully when the user is authenticated. To authenticate the user, you must first call the login() method of the test client and perform authentication by providing the username and password of the test user you created in the setUp() method, as follows:

login = self.client.login(username='testuser',
    password='test@#628password')

Copy

Explain
Once the login has been completed, we must make an HTTP GET request to the greet_user endpoint and validate whether the endpoint generates a correct result or not by checking the HTTP status code of the returned response:

response = self.client.get('/test/greet_user')
self.assertEquals(response.status_code, 200)

Copy

Explain
With the test cases written, it’s time to check how they run. For this, run the following command:
python manage.py test

Copy

Explain
Once the execution finishes, we can expect to see a response that resembles the following one:

% python manage.py test
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
.....
----------------------------------------------------------------------
Ran 5 tests in 0.366s
OK
Destroying test database for alias 'default'...

Copy

Explain
As we can see from the preceding output, our test cases have passed successfully, validating that the view we created generates the desired response of redirecting the user if the user is unauthenticated to the website, and allowing the user to see the page if the user is authenticated.

In this exercise, we implemented a test case where we test what output is generated by a view function based on whether the user is authenticated or not.

In the next section, we will explore how to create requests in Django unit tests without the use of a Django-provided test client, but by providing raw request data.

Django RequestFactory
So far, we have been using Django’s test client to test the views that we have created for our application. The test client class simulates a browser and uses this simulation to make calls to the required APIs. But what if we didn’t want to use the test client and its associated simulation of being a browser, but rather wanted to test the view functions directly bypassing the request parameter? How can we do that?

To help us in such cases, we can leverage the RequestFactory class provided by Django. The RequestFactory class helps us provide the request object that we can pass to our view functions to evaluate whether they are working. The following object for the RequestFactory class can be created by instantiating the class as follows:

factory = RequestFactory()

Copy

Explain
The factory object created only supports HTTP methods such as get(), post(), put(), and others to simulate a call to any URL endpoint. Now, let’s learn how to modify the test case that we wrote in Exercise 14.04 – writing test cases to validate authenticated users, so that it uses RequestFactory.

Exercise 14.05 – using RequestFactory to test views
In this exercise, we will use RequestFactory to test view functions in Django:

For this exercise, we will use the existing greeting_view_user view function that we created earlier in step 1 of Exercise 14.04 – writing test cases to validate authenticated users, which looks like this:
@login_required
def greeting_view_user(request):
    """Greeting view for the user."""
    user = request.user
    return HttpResponse("Welcome to Bookr!
        {username}".format(username=user))

Copy

Explain
Next, modify the existing test case, TestLoggedInGreetingView, defined inside the tests.py file under the bookr_test directory. Open the tests.py file and make the following changes:
First, we need to add the following import to use the RequestFactory class inside the test cases:
from django.test import RequestFactory

Copy

Explain
The next thing we need is an import for the AnonymousUser class from Django’s auth module and the greeting_view_user view method from the views module. This is required to test the view functions with a simulated user who is not logged in. This can be done by adding the following code:
from django.contrib.auth.models import AnonymousUser
from .views import greeting_view_user

Copy

Explain
Once the import statements have been added, modify the setUp() method of the TestLoggedInGreetingView class and change its contents so that it resembles the following:
def setUp(self):
    self.test_user =
        User.objects.create_user(username='testuser',
            password='test@#628password')
        self.test_user.save()
        self.factory = RequestFactory()

Copy

Explain
In this method, we first created a user object and stored it as a class member so that we can use it later in the tests. Once the user object was created, we instantiated a new instance of the RequestFactory class to test our view function.

With the setUp() method now defined, modify the existing tests so that they use the request factory instance. For the test for a non-authenticated call to the view function, modify the test_user_greeting_not_authenticated method so that it has the following contents:
def test_user_greeting_not_authenticated(self):
    request = self.factory.get('/test/greet_user')
    request.user = AnonymousUser()
    response = greeting_view_user(request)
    self.assertEquals(response.status_code, 302)

Copy

Explain
In this method, we first created a request object using the RequestFactory instance we defined in the setUp() method. Once we had done that, we assigned an AnonymousUser() instance to the request.user property. Assigning the AnonymousUser() instance to the property makes the view function think that the user making the request is not logged in:

request.user = AnonymousUser()

Copy

Explain
Once we did this, we made a call to the greeting_view_user() view method and passed to it the request object you created. Once the call is successful, we must capture the output of the method in the response variable using the following code:

response = greeting_view_user(request)

Copy

Explain
For the unauthenticated user, we expect to get a redirect response that can be tested by checking the HTTP status code of the response, as follows:

self.assertEquals(response.status_code, 302)

Copy

Explain
Now, go ahead and modify the other method, test_user_authenticated(), similarly by using the RequestFactory instance, as follows:
def test_user_authenticated(self):
    request = self.factory.get('/test/greet_user')
    request.user = self.test_user
    response = greeting_view_user(request)
    self.assertEquals(response.status_code, 200)

Copy

Explain
As you can see, most of the code resembles what you wrote in the test_user_greeting_not_authenticated method, with a small change – in this method, instead of using AnonymousUser for the request.user property, you use the test_user that you created in the setUp() method:

request.user = self.test_user

Copy

Explain
With the changes done, it’s time to run the tests.

To run the tests and validate whether RequestFactory works as expected or not, run the following command:
python manage.py test

Copy

Explain
Once the command executes, you can expect to see an output that resembles the one shown here:

% python manage.py test
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
......
----------------------------------------------------------------------
Ran 5 tests in 0.229s
OK
Destroying test database for alias 'default'...

Copy

Explain
As we can see from the output, the test cases written by us have passed successfully, thus validating the behavior of the RequestFactory class.

With this exercise, we learned to write test cases for view functions by leveraging RequestFactory and passing the request object directly to the view function, rather than simulating a URL visit using the test client approach, thus allowing for more direct testing.

In the next section, we will test class-based views.

Testing class-based views
In the previous exercise, we saw how we can test views defined as methods. But what about class-based views? How can we test those?

As it turns out, it is quite easy to test class-based views. For example, if we have a class-based view defined with the name ExampleClassView(View), to test the view, all we need to do is to use the following syntax:

response = ExampleClassView.as_view()(request)

Copy

Explain
It is as simple as that.

A Django application generally consists of several different components that can either work in isolation, such as models, and some other components that need to interact with the URL mapping and other parts of the framework to work. Testing these different components may require some steps that are common to only those components. For example, when testing a model, first, we may want to create certain objects of the Model class before we start testing, or for views, we may want to initialize a test client with user credentials first.

As it turns out, Django also provides some other classes based on the TestCase class that can be used to write test cases of specific types about the type of component being used. Let’s look at the different classes provided by Django.

Test case classes in Django
Beyond the base TestCase class provided by Django, which can be used to define a multitude of test cases for different components, Django also provides some specialized classes derived from the TestCase class.

These classes are used for specific types of test cases based on the capabilities they provide to the developer. Let’s look at the different classes provided by Django.

The SimpleTestCase class
This class is derived from the TestCase class provided by Django’s test module and should be used when writing simple test cases that test the view functions. Usually, this class is not preferred when your test case involves making database queries. The class also provides a lot of useful features, such as these:

Ability to check for exceptions raised by a view function
Ability to test form fields
A built-in test client
Ability to verify a redirect by a view function
Can match the equality of two HTML, JSON, or XML outputs generated by the view functions
Now that we have a basic idea of what a SimpleTestCase class is, let’s move on and try to understand another type of test case class that helps in writing test cases about the interaction with databases.

The TransactionTestCase class
This class is derived from the SimpleTestCase class and should be used when writing test cases that involve interaction with the database, such as database queries, model object creations, and more.

The class provides the following added features:

Ability to reset the database to a default state before a test case runs
Can skip tests based on database features, which can be quite handy if the database being used for testing does not support all the features of your production database
The LiveServerTestCase class
This class is like the TransactionTestCase class, but with a small difference that the test cases written in the class, instead of using the default test client, use a live server created by Django.

This ability to run the live server for testing comes in handy when writing test cases that test for the rendered web pages and any interaction with them, which is not possible while using the default test client.

Such test cases can leverage tools such as Selenium, which can be used to build interactive test cases that modify the state of the rendered page by interacting with it.

Modularizing test code
In the previous exercises, we saw how we can write test cases for different components of our project. But an important aspect to note is, till now, we have written the test cases for all the components in a single file.

This approach is okay when the application does not have a lot of views and models, but this can become problematic as our application grows because now, our single tests.py file will be hard to maintain.

To avoid running into such scenarios, we should try to modularize our test cases so that the test cases for models are kept separately from test cases related to the views and other properties. To achieve this modularization, all we need to do is follow two simple steps:

Create a new directory named tests inside our application directory by running the following command:
mkdir tests

Copy

Explain
Create a new empty file named __init__.py inside our tests directory by running the following command:
touch __init__.py

Copy

Explain
This __init__.py file is required by Django to correctly detect the tests directory we created as a module and not a regular directory.

Once you have completed the preceding steps, you can go ahead and create new testing files for the different components in your application. For example, to write test cases for your models, you can create a new file named test_models.py inside the tests directory and add any associated code for your model testing inside this file.

Also, you don’t need to take any other additional steps to run your tests. The same command will work perfectly fine for your modular testing code base as well:

python manage.py test

Copy

Explain
With this, we know how we can write test cases for our projects. So, how about we test this knowledge and write test cases for the Bookr project we are working on?

Activity 14.01 – testing models and views in Bookr
In this activity, you will implement test cases for the Bookr project. You will implement test cases to validate the functioning of the models created inside the reviews application of the Bookr project, and then you will implement a simple test case for validating the index view inside the reviews application.

The following steps will help you work through this activity:

Create a directory named tests inside the reviews application directory so that all our test cases for the reviews application can be modularized.
Create an empty __init__.py file so that the directory is considered not as a general directory, but rather a Python module directory.
Create a new file named test_models.py for implementing the code for testing the models. Inside this file, import the models you want to test.
Inside the test_models.py file, create a new class that inherits from the TestCase class of the django.tests module and implements methods to validate the process of creating and reading the Model objects.
To test the view function, create a new file named test_views.py inside the tests directory that was created in step 1.
Inside the test_views.py file, import the test Client class from the django.tests module and the index view function from the reviews application’s views.py file.
Inside the test_views.py file you created in step 5, create a new TestCase class and implement methods to validate the index view.
Inside the TestCase class you created in step 7, create a new function called setUp(), inside which you should initialize an instance of RequestFactory, which will be used to create a request object that can be directly passed to the view function for testing.
Once you have completed the previous steps are written the test cases, run them by executing python manage.py to validate that the test cases pass.
Upon completing this activity, all test cases should pass successfully.

Important note

The solution for this activity can be found at on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

Summary
In this chapter, we learned how to write test cases for different components of our web application project with Django. We learned why testing plays a crucial role in the development of any web application and the different types of testing techniques that are employed in the industry to make sure the application code they ship is stable and bug-free.

Then, we looked at how we can use the TestCase class provided by Django’s test module to implement our unit tests, which can be used to test the models as well as views. We also looked at how we can use Django’s test client to test our view functions, some of which require the user to be authenticated. We also glanced over another approach of using RequestFactory to test method views and class-based views.

We concluded this chapter by understanding the predefined classes provided by Django and where they should be used, while also looking at how we can modularize our testing code base to make it appear clean.

As we move to the next chapter, we will try to understand how we can make our Django application more powerful by integrating third-party libraries into our project. This functionality will be used to implement third-party authentication into our Django application and allow the users to log in to the application using popular services such as Google Sign-In, Facebook Sign-In, and others.



| ≪ [ 13 Generating CSV, PDF, and Other Binary Files ](/packtpub/2024/422-web_development_with_django_2ed/13_generating_csv,_pdf,_and_other_binary_files) | 14 Testing Your Django Applications | [ 15 Django Third-Party Libraries ](/packtpub/2024/422-web_development_with_django_2ed/15_django_third-party_libraries) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/422-web_development_with_django_2ed/14_testing_your_django_applications
> (2) Markdown
> (3) Title: 14 Testing Your Django Applications
> (4) Short Description: Publication date: May 2023 Publisher Packt Pages 764
> (5) tags: Django
> Book Title: 422-Web Development with Django 2ed
> Link: https://subscription.packtpub.com/book/web-development/9781803230603/pref
> create: 2024-05-08 수 14:11:52
> Images: /packtpub/2024/422-web_development_with_django_2ed_img/14/
> .md Name: 14_testing_your_django_applications.md

