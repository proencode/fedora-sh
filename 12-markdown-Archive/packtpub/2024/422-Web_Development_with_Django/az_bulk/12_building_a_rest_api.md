
| ≪ [ 11 Advanced Templating and Class-Based Views ](/packtpub/2024/422-web_development_with_django_2ed/11_advanced_templating_and_class-based_views) | 12 Building a REST API | [ 13 Generating CSV, PDF, and Other Binary Files ](/packtpub/2024/422-web_development_with_django_2ed/13_generating_csv,_pdf,_and_other_binary_files) ≫ |
|:----:|:----:|:----:|

# 12 Building a REST API

Packt Logo

Book image


Building a REST API
In the previous chapter, we learned about templates and class-based views. These concepts greatly help expand the range of functionalities we can provide to the user on the frontend (in their web browser). However, that is not sufficient to build a modern web application. Web apps typically have the frontend built with an entirely separate library, such as ReactJS or AngularJS. These libraries provide powerful tools for building dynamic user interfaces but do not communicate directly with our backend Django code or database. The frontend code simply runs in the web browser and does not have direct access to any data on our backend server. Therefore, we need to create a way for these applications to “talk” to our backend code. One of the best ways to do this in Django is by using REST APIs.

APIs are used to facilitate interaction between different pieces of software, and they communicate using Hypertext Transfer Protocol (HTTP). This is the standard protocol for communication between servers and clients and is fundamental to transferring information on the web. APIs receive requests and send responses in HTTP format.

This chapter introduces REST APIs and Django REST framework (DRF). You will start by implementing a simple API for the Bookr project. Next, you will learn about the serialization of model instances, which is a key step in delivering data to the frontend of Django applications. Finally, you will explore different types of API views, including both functional and class-based types.

In our use case in this chapter, an API will help facilitate interaction between our Django backend and our frontend JS code. For example, imagine that we want to create a frontend application that allows users to add new books to the Bookr database. The user’s web browser would send a message (an HTTP request) to our API to say that they want to create an entry for a new book and perhaps include some details about the book in that message. Our server would send back a response to report on whether the book was successfully added or not. The web browser would then be able to display the outcome of their action to the user.

In this chapter, we will cover the following topics:

Understanding REST APIs
Django REST framework
By the end of this chapter, you will be able to implement custom API endpoints, including token-based authentication.

Technical requirements
All the code files of this chapter can be found at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter12.

Understanding REST APIs
Most modern web APIs can be classified as REST APIs. REST APIs are simply a type of API that focuses on communicating and synchronizing the state of objects between the database server and frontend client.

For example, imagine that you are updating your details on a website for which you are signed in to your account. When you go to the account details page, the web server tells your browser about the various details attached to your account. When you change the values on that page, the browser sends back the updated details to the web server and tells it to update these details on the database. If the action is successful, the website will show you a confirmation message.

This is a very simple example of what is known as decoupled architecture between frontend and backend systems. Decoupling allows greater flexibility and makes it easier to update or change components in your architecture. So, let’s say you want to create a new frontend website. In such a case, you don’t have to change the backend code at all, as long as your new frontend is built to make the same API requests as the old one.

REST APIs are stateless, meaning neither the client nor the server stores any states in between to do the communication. Every time a request is made, the data is processed, and a response is sent back without the protocol having to store any intermediate data. What this means is that the API is processing each request in isolation. It doesn’t need to store information regarding the session itself. This is in contrast to a stateful protocol (such as Transmission Control Protocol (TCP)), which maintains information regarding the session during its life.

So, a RESTful web service, as the name suggests, is a collection of REST APIs used to carry out a set of tasks. For example, if we develop a set of REST APIs for the Bookr application to carry out a certain set of tasks, we can call it a RESTful web service. Next, we will start working on DRF.

Django REST framework
DRF is an open source Python library that can be used to develop REST APIs for a Django project. DRF has most of the necessary functionality built in to help develop APIs for any Django project. Throughout this chapter, we will be using it to develop APIs for our Bookr project. In the following section, we will install and configure DRF.

Installation and configuration
To install djangorestframework in the virtual environment setup along with PyCharm, follow these steps:

Enter the following code in your Terminal app or Command Prompt to do this:
pip install djangorestframework

Copy

Explain
Next, open the settings.py file and add rest_framework to INSTALLED_APPS as shown in the following snippet:
INSTALLED_APPS = [
    "bookr_admin.apps.BookrAdminConfig",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "rest_framework",
    "reviews",]

Copy

Explain
You are now ready to start using DRF to create your first simple API.

Functional API views
In Chapter 3, URL Mapping, Views, and Templates, we learned about simple functional views that take a request and return a response. We can write similar functional views using DRF. However, note that class-based views are more commonly used and will be covered next. A functional view is created by simply adding the following decorator onto a normal view, as follows:

from rest_framework.decorators import api_view
@api_view
def my_view(request):
    ...

Copy

Explain
This decorator takes the functional view and turns it into a subclass of the APIView DRF. It’s a quick way to include an existing view as part of your API. Using what we have learned so far, we will create a simple REST API using DRF in the next section.

Exercise 12.01 – creating a simple REST API

In this exercise, you will create your first REST API using DRF and implement an endpoint using a functional view. You will create this endpoint to view the total number of books in the database:

Note

You’ll need to have DRF installed on your system to proceed with this exercise. If you haven’t already installed it, make sure you refer to the Installation and configuration section earlier in this chapter.

Create api_views.py in the bookr/reviews folder.
REST API views work like Django’s conventional views. We could have added the API views, along with the other views, in the views.py folder. However, having our REST API views in a separate file will help us maintain a cleaner code base.

Add the following code in api_views.py:
  from rest_framework.decorators import api_view 
  from rest_framework.response import Response 
  from .models import Book
  @api_view()
  def first_api_view(request): 
      num_books = Book.objects.count()
      return Response({"num_books": num_books})

Copy

Explain
The first line imports the api_view decorator, which will convert our functional view into one that can be used with DRF, and the second line imports Response, which will be used to return a response.

The view function returns a Response object containing a dictionary with the number of books in our database (see the highlighted part).

Open bookr/reviews/urls.py and import the api_views module. Then, add a new path to the api_views module in the URL patterns that we have developed throughout this book, as follows:
from . import views, api_views
urlpatterns = [path('api/first_api_view/',
                api_views.first_api_view),
    …
]

Copy

Explain
Start the Django service with the python manage.py runserver command and go to http://127.0.0.1:8000/api/first_api_view/ to make your first API request. Your screen should appear as in Figure 12.1:
Figure 12.1﻿ – First Api ﻿View with the number of books
Figure 12.1 – First Api View with the number of books

Calling this URL endpoint made a default GET request to the API endpoint, which returned a JSON key-value pair ("num_books": 0). Also, notice how DRF provides a nice interface to view and interact with the APIs.

We could also use the Linux curl (client URL) command to send an HTTP request as follows:
curl http://127.0.0.1:8000/api/first_api_view/
{"num_books":18}

Copy

Explain
Alternatively, if you are using Windows 10, you can make an equivalent HTTP request with curl.exe from Command Prompt as follows:

curl.exe http://127.0.0.1:8000/api/first_api_view/

Copy

Explain
In this exercise, we learned how to create an API view using DRF and a simple functional view. We will now look at a more elegant way to convert between information stored in the database and what gets returned by our API using serializers.

Understanding serializers
By now, we are well versed in the way Django works with data in our application. Broadly, the columns of a database table are defined in a class in models.py, and when we access a row of the table, we are working with an instance of that class. Ideally, we often just want to pass this object to our frontend application. For example, if we wanted to build a website that displayed a list of books in our Bookr app, we would want to call the title property of each book instance to know what string to display to the user. However, our frontend application knows nothing about Python and needs to retrieve this data through an HTTP request, which just returns a string in a specific format.

This means that any translation of information between Django and the frontend (via our API) must be done by representing the information in JSON format. JSON objects look similar to a Python dictionary, except there are some extra rules that constrict the exact syntax. In our previous example in Exercise 12.01, Creating a simple REST API, the API returned the following JSON object containing the number of books in our database:

{"num_books": 0}

Copy

Explain
But what if we wanted to return the full details about an actual book in our database with our API? DRF’s serializer class helps to convert complex Python objects into formats such as JSON or XML so that they can be transmitted across the web using the HTTP protocol. The part of DRF that does this conversion is named serializer. Serializers also perform deserialization, which refers to converting serialized data back into Python objects, so that the data can be processed in the application. In the following section, we will implement a way to display a list of books.

Exercise 12.02 – creating an API view to display a list of books

In this exercise, you will use serializers to create an API that returns a list of all books present in the bookr application:

Create a file named serializers.py in the bookr/reviews folder. This is the file where we will place all the serializer code for the APIs.
Add the following code to serializers.py:
from rest_framework import serializers
class PublisherSerializer(serializers.Serializer):
    name = serializers.CharField()
    website = serializers.URLField()
    email = serializers.EmailField()
class BookSerializer(serializers.Serializer):
    title = serializers.CharField()
    publication_date = serializers.DateField()
    isbn = serializers.CharField()
    publisher = PublisherSerializer()

Copy

Explain
Here, the first line imports the serializers from the rest_framework module.

Following the imports, we have defined two classes, PublisherSerializer and BookSerializer. As the names suggest, they are serializers for the Publisher and Book models, respectively. Both these serializers are subclasses of serializers.Serializer, and we have defined field types for each serializer, such as CharField, URLField, EmailField, and so on.

Look at the Publisher model in the bookr/reviews/models.py file. The Publisher model has the name, website, and email attributes. So, to serialize a Publisher object, we need the name, website, and email attributes in the serializer class, which we have defined accordingly in PublisherSerializer.

Similarly, for the Book model, we have defined title, publication_date, isbn, and publisher as the desired attributes in BookSerializer. Since publisher is a foreign key for the Book model, we have used PublisherSerializer as the serializer for the publisher attribute.

Open bookr/reviews/api_views.py, remove any pre-existing code, and add the following code:
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Book
from .serializers import BookSerializer
@api_view()
def all_books(request):
    books = Book.objects.all()
    book_serializer = BookSerializer(books, many=True)
    return Response(book_serializer.data)

Copy

Explain
In the second line, we have imported the newly created BookSerializer from the serializers module.

We then add a functional view, all_books (as in the previous exercise). This view takes a query set containing all books and then serializes them using BookSerializer. The serializer class is also taking an argument, many=True, which indicates that the books object is queryset or a list of many objects. Remember that serialization takes Python objects and returns them in a JSON serializable format, as follows:

[OrderedDict([('title', 'Advanced Deep Learning with Keras'), ('publication_date', '2018-10-31'), ('isbn', '9781788629416'), ('publisher', OrderedDict([('name', 'Packt Publishing'), ('website', 'https://www.packtpub.com/'), ('email', 'info@packtpub.com')]))]), OrderedDict([('title', 'Hands-On Machine Learning for Algorithmic Trading'), ('publication_date', '2018-12-31'), ('isbn', '9781789346411'), ('publisher', OrderedDict([('name', 'Packt Publishing'), ('website', 'https://www.packtpub.com/'), ('email', 'info@packtpub.com')]))]) …

Copy

Explain
Open bookr/reviews/urls.py, remove the previous example path for first_api_view, and add the all_books path, as shown in the following code:
from django.urls import path
from . import views, api_views
urlpatterns = [
    path(
        'api/all_books/',
        api_views.all_books, name='all_books'
    ),
    …
]

Copy

Explain
This newly added path calls the all_books view function when it comes across the api/all_books/ path in the URL.

Once all the code is added, run the Django server with the python manage.py runserver command and navigate to http://127.0.0.1:8000/api/all_books/. You should see something similar to Figure 12.2:
Figure 12.2: List of books shown in the all_books endpoint
Figure 12.2: List of books shown in the all_books endpoint

The preceding screenshot shows that the list of all books is returned upon calling the /api/all_books endpoint. And with that, you have successfully used a serializer to return data efficiently in your database with the help of a REST API.

Till now, we have been focusing on functional views. However, you will now learn that class-based views are more commonly used in DRF and will make your life much easier.

Class-based API views and generic views
Similar to what we learned in Chapter 11, Advanced Templating and Class-Based Views, we can also write class-based views for REST APIs. Class-based views are the preferred way of writing views among developers, as a lot can be achieved by writing very little code.

Just as with conventional views, DRF offers a set of generic views that makes writing class-based views even simpler. Generic views are designed considering some of the most common operations needed while creating APIs. Some of the generic views offered by DRF are ListAPIView, RetrieveAPIView, and so on. In Exercise 12.02, Creating an API view to display a list of books, our functional view was responsible for creating queryset of the objects and then calling the serializer. Equivalently, we could use ListAPIView to do the same thing:

class AllBooks(ListAPIView):
    queryset = Book.objects.all()
    serializer_class = BookSerializer

Copy

Explain
Here, queryset of objects is defined as a class attribute. Passing queryset through to serializer is handled by methods on ListAPIView.

Model serializers

In Exercise 12.02, Creating an API view to display a list of books, our serializer was defined as follows:

class BookSerializer(serializers.Serializer):
    title = serializers.CharField()
    publication_date = serializers.DateField()
    isbn = serializers.CharField()
    publisher = PublisherSerializer()

Copy

Explain
However, our model for Book looks like this (note how similar the definitions of the model and serializer appear to be):

  class Book(models.Model):
      """A published book."""
      title = models.CharField(max_length=70, 
          help_text="The title of the book.")
      publication_date = models.DateField(
          verbose_name="Date the book was published.")
      isbn = models.CharField(max_length=20, 
          verbose_name="ISBN number of the book.")
      publisher = models.ForeignKey(Publisher, on_delete=models.CASCADE)
      contributors = models.ManyToManyField("Contributor", 
                        through="BookContributor")

Copy

Explain
We would prefer not to specify that the title must be serializers.CharField(). It would be easier if the serializer just looked at how title was defined in the model and could figure out what serializer field to use.

This is where model serializers come in. They provide shortcuts to create serializers by utilizing the definition of the fields on the model. Instead of specifying that title should be serialized using CharField, we just tell the model serializer we want to include title, and it uses the CharField serializer because the title field on the model is also CharField.

For example, suppose we wanted to create a serializer for the Contributor model in models.py. Instead of specifying the types of serializers that should be used for each field, we can give it a list of the field names and let it figure out the rest:

from rest_framework import serializers
from .models import Contributor
class ContributorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Contributor
        fields = [‹first_names', 'last_names', 'email']

Copy

Explain
In the following exercise, we will see how we can use a model serializer to avoid the duplication of code in the preceding classes.

Exercise 12.03 – creating class-based API views and model serializers

In this exercise, you will create class-based views to display a list of all books while using model serializers:

Open the bookr/reviews/serializers.py file, remove any pre-existing code, and replace it with the following code:
  from rest_framework import serializers
   from .models import Book, Publisher
  class PublisherSerializer( 
      serializers.ModelSerializer):
      class Meta:
          model = Publisher
          fields = ['name', 'website', 'email']
  class BookSerializer(serializers.ModelSerializer): 
      publisher = PublisherSerializer()
      class Meta:
          model = Book
          fields = ['title', 'publication_date', 'isbn', 
          'publisher']

Copy

Explain
Here, we have included two model serializer classes, PublisherSerializer and BookSerializer. Both these classes inherit the serializers.ModelSerializer parent class. We do not need to specify how each field gets serialized; instead, we can simply pass a list of field names, and the field types are inferred from the definition in models.py.

Although mentioning the field inside fields is sufficient for the model serializer, under certain special cases, such as this one, we may have to customize the field since the publisher field is a foreign key. Hence, we must use PublisherSerializer to serialize the publisher field.

Next, open bookr/reviews/api_views.py, remove any pre-existing code, and add the following code:
from rest_framework import generics
from .models import Book
from .serializers import BookSerializer
class AllBooks(generics.ListAPIView):
    queryset = Book.objects.all()
    serializer_class = BookSerializer

Copy

Explain
Here, we use the DRF class-based ListAPIView instead of a functional view. This means that the list of books is defined as a class attribute, and we do not have to write a function that directly handles the request and calls the serializer. The book serializer from the previous step is also imported and assigned as an attribute of this class.

Open the bookr/reviews/urls.py file and modify the /api/all_books API path to include the new class-based view as follows:

urlpatterns = [
    path(
        'api/all_books/',
        api_views.AllBooks.as_view(),
        name='all_books'
    ),
…
]

Copy

Explain
Since we are using a class-based view, we have to use the class name along with the as_view() method.

Once all the preceding modifications are completed, wait till the Django service restarts or start the server with the python manage.py runserver command, and then open the API at http://127.0.0.1:8000/api/all_books/ in the web browser. You should see something like Figure 12.3:
Figure 12.3: List of books shown in the all_books endpoint
Figure 12.3: List of books shown in the all_books endpoint

Similar to what we saw in Exercise 12.02, Creating an API view to display a list of books, this is a list of all books present in the book review application. In this exercise, we used model serializers to simplify our code, and the generic class-based ListAPIView to return a list of the books in our database. In the next section, you will implement an API endpoint to return a list of top contributors.

Activity 12.01 – creating an API endpoint for a top contributors page
Imagine that your team decides to create a web page that displays the top contributors (authors, coauthors, and editors) in your database. They decide to enlist the services of an external developer to create an app in ReactJS. To integrate with the Django backend, the developer will need an endpoint that provides the following:

A list of all contributors in the database
For each contributor, a list of all books they contributed to
For each contributor, the number of books they contributed to
For each book they contributed to, their role in the book
The final API view should look like this:

Figure 12.4: The top contributors endpoint
Figure 12.4: The top contributors endpoint

To perform this task, execute the following steps:

Add a method to the Contributor class that returns the number of contributions made.
Add ContributionSerializer, which serializes the BookContribution model.
Add ContributorSerializer, which serializes the Contributor model.
Add ContributorView, which uses ContributorSerializer.
Add a pattern to urls.py to enable access to ContributorView.
Note

The solution for this activity can be found on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

Simplifying the code using ViewSets
We have seen how we can optimize our code and make it more concise using class-based generic views. ViewSets and routers help us further simplify our code. As the name indicates, ViewSets are a set of views represented in a single class. For example, we used the AllBooks view to return a list of all books in the application and the BookDetail view to return the details of a single book. Using ViewSets, we could combine both these classes into a single class.

DRF also provides a class named ModelViewSet. This class not only combines the two views mentioned in the preceding discussion (list and detail) but also allows you to create, update, and delete model instances. The code needed to implement all this functionality could be as simple as specifying the serializer and queryset. For example, a view that allows you to manage all these actions for your user model could be defined as tersely as the following:

class UserViewSet(viewsets.ModelViewSet):
    serializer_class = UserSerializer
    queryset = User

Copy

Explain
Lastly, DRF provides a ReadOnlyModelViewSet class. This is a simpler version of the preceding ModelViewSet. It is identical, except that it only allows you to list and retrieve specific users. You cannot create, update, or delete records. In the following section, we will learn about routers.

URL configuration using routers and Viewsets
Routers, when used along with a viewset, automatically create the required URL endpoints for the viewset. This is because a single viewset is accessed at different URLs. For example, in the preceding UserViewSet, you would access a list of users at the /api/users/ URL, and a specific user record at the /api/users/123 URL, where 123 is the primary key of that user record. Here is a simple example of how you might use a router in the context of the previously defined UserViewSet:

from rest_framework import routers
router = routers.SimpleRouter()
router.register(r'users', UserViewSet)
urlpatterns = router.urls

Copy

Explain
Now, let’s try combining the concepts of routers and ViewSets in a simple exercise.

Exercise 12.04 – using ViewSets and routers
In this exercise, we will combine the existing views to create a viewset and create the required routing for the viewset:

Open the bookr/reviews/serializers.py file, remove the pre-existing code, and add the following code snippet:
from django.contrib.auth.models import User
from django.utils import timezone
from rest_framework import serializers
from rest_framework.exceptions import
    NotAuthenticated, PermissionDenied
from .models import Book, Publisher, Review
from .utils import average_rating
class PublisherSerializer(
    serializers.ModelSerializer):

Copy

Explain
You can find the complete code snippet at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/blob/main/Chapter12/Exercise12.04/bookr/reviews/serializers.py.

Here, we added two new fields to BookSerializer, namely reviews and rating. The interesting thing about these fields is that the logic behind them is defined as a method on the serializer itself. This is why we use the serializers.SerializerMethodField type to set the serializer class attributes.

Open the bookr/reviews/api_views.py file, remove the pre-existing code, and add the following:
   from rest_framework import viewsets 
  from rest_framework.pagination import (
      LimitOffsetPagination)
  from .models import Book, Review
  from .serializers import (BookSerializer,
       ReviewSerializer)
  class BookViewSet(viewsets.ReadOnlyModelViewSet): 
      queryset = Book.objects.all() serializer_class 
      = BookSerializer
  class ReviewViewSet(viewsets.ModelViewSet): 
      queryset = Review.objects.order_by('-
      date_created')) 
          serializer_class = ReviewSerializer
      pagination_class = LimitOffsetPagination 
      authentication_classes = []

Copy

Explain
Here, we have removed the AllBook and BookDetail views and replaced them with BookViewSet and ReviewViewSet. In the first line, we import the ViewSets module from rest_framework. The BookViewSet class is a subclass of ReadOnlyModelViewSet, which ensures that the views are only used for the GET operation.

Next, open the bookr/reviews/urls.py file, remove the first two URL patterns starting with api/, and then add the following (highlighted) code:
   from django.urls import path, include
   from rest_framework.routers import DefaultRouter 
   from . import views, api_views
   router = DefaultRouter() 
   router.register(r'books', api_views.BookViewSet)
   router.register(r'reviews', api_views.ReviewViewSet)
   urlpatterns = [ 
        path(
           'api/', include((router.urls, 'api'))
       ),
       path(
           'books/', views.book_list, 
            name='book_list'),
       path(
           'books/<int:pk>/', views.book_detail, 
           name='book_detail'
       ),
       path(
           'books/<int:book_pk>/reviews/new/', 
           views.review_edit, name='review_create'
       ),
       path(
           'books/<int:book_pk>/reviews/<int:review_pk>/', 
                    views.review_edit, name='review_edit'
       ),
       path(
           'books/<int:pk>/media/', views.book_media, 
           name='book_media'
       ),
       path(
           'publishers/<int:pk>/', 
               views.publisher_edit, 
           name='publisher_detail'
       ),
       path(
           'publishers/new/›, views.publisher_edit, 
           name='publisher_create'
       )]

Copy

Explain
Here, we have combined the all_books and book_detail paths into a single path called books. We have also added a new endpoint under the reviews path, which we will need in a later chapter.

We start by importing the DefaultRouter class from rest_framework.routers. Then, we create a router object using the DefaultRouter class and then register the newly created BookViewSet and ReviewViewSet, as can be seen from the highlighted code. This ensures that BookViewSet is invoked whenever the API has the /api/books path.

Save all the files, and once the Django service restarts (or you start it manually with the python manage.py runserver command), go to the http://127.0.0.1:8000/api/books/ URL to get a list of all the books. You should see the following view in the API explorer:
Figure 12.5: Book list at the /api/books path
Figure 12.5: Book list at the /api/books path

You can also access the details for a specific book using the http://127.0.0.1:8000/api/books/1/ URL. In this case, it will return details for the book with a primary key of 1 (if it exists in your database):
Figure 12.6: Book details for “Advanced Deep Learning with Keras”
Figure 12.6: Book details for “Advanced Deep Learning with Keras”

In this exercise, we saw how we can use ViewSets and routers to combine the list and detail views into a single viewset. Using ViewSets makes our code more consistent and idiomatic, making it easier to collaborate with other developers. This becomes particularly important when integrating with a separate frontend application. In the next section, we will learn in brief about different types of authentication and implement token-based authentication for the book review application.

Implementing authentication
As we learned in Chapter 9, Sessions and Authentication, it is important to authenticate the users of our application. It is good practice to only allow those users who have registered in the application to log in and access information from the application. Similarly, for REST APIs, we also need to design a way to authenticate and authorize users before any information is passed on. For example, suppose Facebook’s website makes an API request to get a list of all comments for a post. If they did not have authentication on this endpoint, you could use it to get comments for any post you want programmatically. They obviously don’t want to allow this, so some sort of authentication needs to be implemented.

There are different authentication schemes, such as basic authentication, session authentication, token authentication, remote user authentication, and various third-party authentication solutions. For the scope of this chapter and for our Bookr application, we will use token authentication.

Note

For further reading on all the authentication schemes, please refer to the official documentation at https://www.django-rest-framework.org/api-guide/authentication.

Token-based authentication
Token-based authentication works by generating a unique token for a user in exchange for the user’s username and password. Once the token is generated, it will be stored in the database for further reference and will be returned to the user upon every login.

This token is unique to the user, and they can then use it to authorize every API request they make. Token-based authentication eliminates the need to pass the username and password on every request. It is much safer and is best suited to client-server communication, such as a JavaScript-based web client interacting with the backend application via REST APIs.

An example of this would be a ReactJS or AngularJS application interacting with a Django backend via REST APIs.

The same architecture can be used if you are developing a mobile application to interact with the backend server via REST APIs, for instance, an Android or iOS application interacting with a Django backend via REST APIs.

Exercise 12.05 – omplementing token-based authentication for Bookr APIs
In this exercise, you will implement token-based authentication for the bookr application’s APIs:

Open the bookr/settings.py file and add rest_framework.authtoken to INSTALLED_APPS:
   INSTALLED_APPS = [
       'django.contrib.admin',
       'django.contrib.auth',
       'django.contrib.contenttypes',
       'django.contrib.sessions',
       'django.contrib.messages',
       'django.contrib.staticfiles', 
       'rest_framework',
       'rest_framework.authtoken',
       'reviews']

Copy

Explain
Since the authtoken app has associated database changes, run the migrate command in the command line/terminal as follows:
python manage.py migrate

Copy

Explain
Open the bookr/reviews/api_views.py file, remove any pre-existing code, and replace it with the following:
from django.contrib.auth import authenticate
from rest_framework import viewsets
from rest_framework.authentication import
    TokenAuthentication
from rest_framework.authtoken.models import Token
from rest_framework.pagination import
    LimitOffsetPagination
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.status import HTTP_404_NOT_FOUND,
    HTTP_200_OK
from rest_framework.views import APIView

Copy

Explain
You can find the complete code for this file at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/blob/main/Chapter12/Exercise12.05/bookr/reviews/api_views.py.

Here, we have defined a view called Login. The purpose of this view is to allow a user to get (or create if it does not already exist) a token that they can use to authenticate with the API.

We override the post method of this view because we want to customize the behavior when a user sends us data (that is, their login details). First, we use the authenticate method from Django’s auth library to check whether the username and password are correct. If they are correct, then we will have a user object. If not, we return an HTTP 404 error. If we do have a valid user object, then we simply get or create a token and return it to the user.

Next, let’s add the authentication class to BookViewSet. This means that when a user tries to access this viewset, it will require them to authenticate using token-based authentication. Note that it’s possible to include a list of different accepted authentication methods, not just one. We also add the permissions_classes attribute, which just uses DRF’s built-in class that checks to see whether the given user has permission to view the data in this model:
class BookViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Book.objects.all()
    serializer_class = BookSerializer
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

Copy

Explain
Note

The preceding code (highlighted) won’t match the code you see on GitHub as we’ll be modifying it later in step 9.

Open the bookr/reviews/urls.py file and add the following path into URL patterns:
  path(
      'api/login', api_views.Login.as_view(), 
      name=›login›
  )

Copy

Explain
Save the file and wait for the application to restart, or start the server manually with the python manage.py runserver command. Then access the application using the http://127.0.0.1:8000/api/login URL. Your screen should appear as follows:
Figure 12.7: Login page
Figure 12.7: Login page

The API at /api/login is a POST-only message; hence, Method GET not allowed is displayed.

Next, enter the following snippet in the Content field and click on POST:
{
"username": "Peter",
"password": "testuserpassword"
}

Copy

Explain
You will need to replace this with an actual username and password for your account in the database. Now you can see the token generated for the user. This is the token we need to use to access BookSerializer:

Figure 12.8: The token generated for the user
Figure 12.8: The token generated for the user

Try to access the list of books using the API that we previously created at http://127.0.0.1:8000/api/books/. Note that you are now not allowed to access it. This is because this viewset now requires you to use your token to authenticate.
The same API can be accessed using curl on the command line:

curl -X GET http://127.0.0.1:8000/api/books/
{"detail":"Authentication credentials were not provided."}

Copy

Explain
Since the token was not provided, the Authentication credentials were not provided message is displayed:

Figure 12.9: Message saying that the authentication details weren’t provided
Figure 12.9: Message saying that the authentication details weren’t provided

Note that if you’re using Windows 10, replace curl in the preceding command with curl.exe and execute it from Command Prompt.

To pass the Authorization token (obtained in step 7) as a header, you can use the following command (Windows users can replace curl with curl.exe):

curl -X GET http://127.0.0.1:8000/api/books/ -H "Authorization: Token cd5dafa1d4361fd1502652d266eed3dcdb55c64f1"

Copy

Explain
Note

Before pasting this command, make sure you’ve replaced the token with the one you got when you ran step 7 of this exercise. It will be different from the one we have shown here.

The preceding command should now return the list of books:

[{"title":"Advanced Deep Learning with Keras","publication_date":"2018-10-31","isbn":"9781788629416","publisher":{"name":"Packt Publishing","website":"https://www.packtpub.com/","email":"info@packtpub.com"},"rating":4,"reviews":[{"content":"A must read for all","date_created":… (truncated)

Copy

Explain
This operation ensured that only an existing user of the application could access and fetch the collection of all books.

Before moving on, set the authentication and permission classes on BookViewSet to an empty string. Future chapters will not utilize these authentication methods, and we will assume for the sake of simplicity that an unauthenticated user can access our API:
class BookViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Book.objects.all()
    serializer_class = BookSerializer
    authentication_classes = []
    permission_classes = []

Copy

Explain
In this exercise, we implemented token-based authentication in our Bookr app. We created a login view that allows us to retrieve the token for a given authenticated user. This then enabled us to make API requests from the command line by passing through the token as a header in the request.

Overall, in this section, we learned about different types of authentication, and then we learned in detail about token authentication and authorization while working with REST APIs.

Summary
This chapter introduced REST APIs, a fundamental building block in most real-world web applications. These APIs facilitate communication between the backend server and the web browser, so they are central to your growth as a Django web developer. We learned how to serialize data in our database so that it can be transmitted via an HTTP request. Next, we learned about the various options DRF gives us to simplify the code we write, taking advantage of the existing definitions of the models themselves. We also covered ViewSets and routers and saw how they can be used to condense code even further by combining the functionality of multiple views. Finally, we learned about authentication and authorization and implemented token-based authentication for the book review app.

In the next chapter, we will extend Bookr’s functionality for its users by learning how to generate CSVs, PDFs, and other binary file types.



| ≪ [ 11 Advanced Templating and Class-Based Views ](/packtpub/2024/422-web_development_with_django_2ed/11_advanced_templating_and_class-based_views) | 12 Building a REST API | [ 13 Generating CSV, PDF, and Other Binary Files ](/packtpub/2024/422-web_development_with_django_2ed/13_generating_csv,_pdf,_and_other_binary_files) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/422-web_development_with_django_2ed/12_building_a_rest_api
> (2) Markdown
> (3) Title: 12 Building a REST API
> (4) Short Description: Publication date: May 2023 Publisher Packt Pages 764
> (5) tags: Django
> Book Title: 422-Web Development with Django 2ed
> Link: https://subscription.packtpub.com/book/web-development/9781803230603/pref
> create: 2024-05-08 수 14:11:52
> Images: /packtpub/2024/422-web_development_with_django_2ed_img/12/
> .md Name: 12_building_a_rest_api.md

