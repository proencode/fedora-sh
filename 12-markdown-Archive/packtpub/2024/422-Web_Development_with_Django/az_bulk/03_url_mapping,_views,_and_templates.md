
| ≪ [ 02 Models and Migrations ](/packtpub/2024/422-web_development_with_django_2ed/02_models_and_migrations) | 03 URL Mapping, Views, and Templates | [ 04 An Introduction to Django Admin ](/packtpub/2024/422-web_development_with_django_2ed/04_an_introduction_to_django_admin) ≫ |
|:----:|:----:|:----:|

# 03 URL Mapping, Views, and Templates

Packt Logo

Book image


URL Mapping, Views, and Templates
In the previous chapter, we were introduced to databases, and we learned how to store, retrieve, update, and delete records from a database. We also learned how to create Django models and apply database migrations.

However, these database operations alone cannot display an application’s data to a user. We need a way to display all the stored information in a meaningful way to the user – for example, displaying all the books present in our Bookr application’s database, in a browser, and in a presentable format. This is where Django views, templates, and URL mapping come into play. Views are the part of a Django application that takes in a web request and provides a web response. For example, a web request could be a user trying to view a website by entering the website address, and a web response could be the website’s home page loading in the user’s browser. Views are one of the most important parts of a Django application, where the application logic is written. This application logic controls interactions with the database, such as creating, reading, updating, or deleting records from the database. It also controls how the data is displayed to the user. This is done with the help of Django HTML templates.

This chapter introduces you to three core concepts of Django: views, templates, and URL mapping. You will start by exploring the two main types of views in Django: function-based views and class-based views. Next, you will learn the basics of Django template language and template inheritance. Using these concepts, you will create a page to display the list of all the books in the Bookr application. You will also create another page to display the details, review comments, and ratings of books.

In this chapter, we will study the following topics:

Understanding function-based views
Understanding class-based views
URL configuration
Working with Django templates
Django’s template language
By using and learning about the previously mentioned topics, by the end of this chapter, we will have implemented a way to list all the books and display details of any given book in the Bookr application.

Django views can be broadly classified into two types: function-based views and class-based views. In this chapter, we will learn more about function-based views in Django.

Note

Class-based views, which is a more advanced topic, will be discussed in detail in Chapter 11, Advanced Templating and Class-Based Views.

Technical requirements
The complete code files for this chapter can be found at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter03.

Understanding function-based views
As the name implies, function-based views are implemented as Python functions. To understand how they work, consider the following snippet, which shows a simple view function named home_page:

from django.http import HttpResponse
def home_page(request):
    message = "<html><h1>Welcome to my Website</h1></html>"
    return HttpResponse(message)

Copy

Explain
The view function defined here, named home_page, takes a request object as an argument and returns an HttpResponse object with a Welcome to my Website message. The advantage of using function-based views is that, since they are implemented as simple Python functions, they are easier to learn and also easily readable for other programmers. The major disadvantage of function-based views is that the code cannot be reused and made as concisely as class-based views for generic use cases. The next section is a brief introduction to class-based views.

Understanding class-based views
As the name implies, class-based views are implemented as Python classes. Using the principles of class inheritance, these classes are implemented as subclasses of Django’s generic view classes. Unlike function-based views, where all the view logic is expressed explicitly in a function, Django’s generic view classes come with various pre-built properties and methods that can provide shortcuts to writing clean, reusable views. This property comes in handy quite often during web development; for example, developers often need to render an HTML page without needing any data inserted from the database, or any customization specific to the user. In this case, it is possible to simply inherit from Django’s TemplateView, and specify the path of the HTML file. The following is an example of a class-based view that can display the same message as in the function-based view example:

from django.views.generic import TemplateView
class HomePage(TemplateView):
    template_name = 'home_page.html'

Copy

Explain
In the preceding code snippet, HomePage is a class-based view inheriting Django’s TemplateView from the django.views.generic module. The template_name class attribute defines the template to render when the view is invoked. For the template, we add an HTML file to our templates folder with the following content:

<html><h1>Welcome to my Website</h1></html>

Copy

Explain
This is a very basic example of class-based views, which will be explored further in Chapter 11, Advanced Templating and Class-Based Views. The major advantage of using class-based views is that fewer lines of code need to be used to implement the same functionality as compared to function-based views. Also, by inheriting Django’s generic views, we can keep the code concise and avoid the duplication of code. However, a disadvantage of class-based views is that the code is often less readable for someone new to Django, which means that learning about it is usually a longer process as compared to function-based views.

In the next section, we will learn about URL configuration.

URL configuration
Django views cannot work on their own in a web application. When a web request is made to the application, Django’s URL configuration takes care of routing the request to the appropriate view function to process the request. A typical URL configuration in the urls.py file in Django looks like this:

  from . import views
  urlpatterns = [
      path(‘url-path/’, views.my_view, name=’my-view’),
  ]

Copy

Explain
Here, urlpatterns is the variable defining the list of URL paths, and 'url-path/' defines the path to match.

views.my_view is the view function to invoke when there is a URL match, and name='my-view' is the name of the view function used to refer to the view. There may be a situation wherein, elsewhere in the application, we want to get the URL of this view. We wouldn’t want to hardcode the value, as it would then have to be specified twice in the code base. Instead, we can access the URL by using the name of the view, as follows:

from django.urls import reverse
url = reverse('my-view')

Copy

Explain
If needed, we can also use a regular expression in a URL path to match string patterns using re_path():

urlpatterns = [
    re_path(r'^url-path/(?P<name>pattern)/$',
            views.my_view, name='my-view')
]

Copy

Explain
Here, name refers to the pattern name, which can be any Python regular expression pattern, and this needs to be matched before calling the defined view function. You can also pass parameters from the URL into the view itself, as shown in this example:

urlpatterns = [
    path(r'^url-path/<int:id>/', views.my_view,
         name='my-view')
]

Copy

Explain
In the preceding example, <int:id> tells Django to look for URLs that contain an integer at this position in the string, and to assign the value of that integer to the id argument. This means that if the user navigates to /url-path/14/, the id=14 keyword argument is passed to the view. This is often useful when a view needs to look up a specific object in the database and return corresponding data. For example, suppose we had a User model, and we wanted the view to display the user’s name. The view could be written as follows:

  def my_view(request, id):
      user = User.objects.get(id=id)
      return HttpResponse(f”This user’s name is \
      {user.first_name} {user.last_name}”)

Copy

Explain
When the user accesses /url-path/14/, the preceding view is called, and the id=14 argument is passed into the function.

Here is the typical workflow when a URL such as http://0.0.0.0:8000/url-path/ is invoked using a web browser:

An HTTP request would be made to the running application for the URL path. Upon receiving the request, it reaches for the ROOT_URLCONF setting present in the settings.py file:
ROOT_URLCONF = 'project_name.urls'

Copy

Explain
This determines the URL configuration file that will be used first. In this case, it is the URL file present in the project directory, project_name/urls.py.

Next, Django goes through the list named urlpatterns, and once it matches url-path/ with the path present in the URL, http://0.0.0.0:8000/url-path/, it invokes the corresponding view function.
URL configuration is sometimes also referred to as URL conf or URL mapping, and these terms are often used interchangeably. Overall, we can say that URL configuration is present to route the URL request posted in a browser to an appropriate view function. To understand views and URL mapping better, let’s start with a simple exercise.

Exercise 3.01 – implementing a simple function-based view
In this exercise, we will write a very basic function-based view and use the associated URL configuration to display the Welcome to Bookr! message in a web browser. We will also tell the user how many books we have in the database. Let’s get started with the steps:

First, ensure that ROOT_URLCONF in bookr/settings.py points to the project’s URL file by adding the following command:
ROOT_URLCONF = 'bookr.urls'

Copy

Explain
Open the bookr/reviews/views.py file and add the following code snippet:
   from django.http import HttpResponse 
   from .models import Book
   def welcome_view(request):
       message = f”<html><h1>Welcome to Bookr!</h1>
       <p>{Book.objects.count()} books and 
       counting!</p></html>”
       return HttpResponse(message)

Copy

Explain
In the preceding snippet, we first import the HttpResponse class from the django.http module. Next, we define the welcome_view function, which can display the Welcome to Bookr! message in a web browser. The request object is a function parameter that carries the HTTP request object. The next line defines the message variable, which contains HTML that displays the header, followed by a line that counts the number of books available in the database.

In the last line, we return an HttpResponse object with the string associated with the message variable. When the welcome_view view function is called, it will display Welcome to Bookr! 2 books and counting in the web browser.

Now, create the URL mapping to call the newly created view function. Open the project URL file, bookr/urls.py, and add the list of urlpatterns as follows:
from django.contrib import admin
from django.urls import include, path
urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('reviews.urls'))
]

Copy

Explain
The first line in the list of urlpatterns, that is, path('admin/', admin.site.urls), routes to the admin URLs if admin/ is present in the URL path (for example, http://0.0.0.0:8000/admin).

Similarly, consider the second line, path('', include('reviews.urls')). Here, the path mentioned is an empty string, ''. If the URL does not have any specific path after http://hostname:port-number/ (for example, http://0.0.0.0:8000/), it includes urlpatterns, present in review.urls.

The include function is a shortcut that allows you to combine URL configurations. It is common to keep one URL configuration per application in your Django project. Here, we’ve created a separate URL configuration for the reviews app and have added it to our project-level URL configuration.

Since we do not have the reviews.urls URL module yet, create a file called bookr/reviews/urls.py, and add the following lines of code:
from django.contrib import admin
from django.urls import path
from . import views
urlpatterns = [
    path('', views.welcome_view,
    name='welcome_view'),
]

Copy

Explain
Here, we have used an empty string again for the URL path. So, when http://0.0.0.0:8000/ is invoked, after getting routed from bookr/urls.py into bookr/reviews/urls.py, this pattern invokes the welcome_view view function.

After making changes to the two files, we have the necessary URL configuration ready to call the welcome_view view. Now, start the Django server with ./manage.py runserver and type http://0.0.0.0:8000 or http://127.0.0.1:8000 in your web browser. You should be able to see the Welcome to Bookr! message:
Figure 3.1 – Displaying “Welcome to Bookr!” and the number of books on the home page
Figure 3.1 – Displaying “Welcome to Bookr!” and the number of books on the home page

Note

If there is no URL match, Django invokes error handling, such as displaying a 404 Page not found message or something similar.

In this exercise, we learned how to write a basic view function and do the associated URL mapping. We have created a web page that displays a simple message to the user and reports how many books are currently in our database.

However, astute readers will have noticed that it doesn’t look very nice to have HTML code sitting inside our Python function as in the preceding example. As our views get bigger, this will become even more unsustainable. Therefore, in the next section, we will turn our attention to where our HTML code is supposed to be – inside templates.

Working with Django templates
In Exercise 3.01 – implementing a simple function-based view, we saw how to create a view, do the URL mapping, and display a message in the browser. But if you recall, we hardcoded the Welcome to Bookr! HTML message in the view function itself and returned an HttpResponse object, as follows:

message = f"<html><h1>Welcome to Bookr!</h1> "
"<p>{Book.objects.count()} books and counting!</p></html>"
return HttpResponse(message)

Copy

Explain
Hardcoding HTML inside Python modules is not a good practice, because as the amount of content to be rendered on a web page increases, so does the amount of HTML code we need to write for it. Having a lot of HTML code among Python code can make the code hard to read and maintain in the long run.

For this reason, Django templates provide us with a better way to write and manage HTML templates. Django’s templates not only work with static HTML content but also with dynamic HTML templates.

Django’s template configuration is done in the TEMPLATES variable present in the settings.py file. This is how the default configuration looks:

TEMPLATES = [
  {
    'BACKEND':
      'django.template.backends.django.DjangoTemplates',
    'DIRS': [],
    'APP_DIRS': True,
    'OPTIONS': {
      'context_processors': [
        'django.template.context_processors.debug',
        'django.template.context_processors.request',
        'django.contrib.auth.context_processors.auth',
        'django.contrib.messages.context_processors.messages',
      ],
    },
  },
]

Copy

Explain
Let’s go through each keyword present in the preceding snippet:

'BACKEND': 'django.template.backends.django.DjangoTemplates': This refers to the template engine to be used. A template engine is an API used by Django to work with HTML templates. Django is built with Jinja2 and the DjangoTemplates engine. The default configuration is the DjangoTemplates engine and Django template language. However, this can be changed for a different one if required, such as Jinja2 or any other third-party template engine. For our Bookr application though, we will leave this configuration as it is.
'DIRS': []: This refers to the list of directories where Django searches for the templates in the given order.
'APP_DIRS': True: This tells the Django template engine whether it should look for templates in the installed apps defined under INSTALLED_APPS in the settings.py file. The default option for this is True.
'OPTIONS': This is a dictionary containing template engine-specific settings. Inside this dictionary, there is a default list of context processors, which helps the Python code to interact with templates to create and render dynamic HTML templates.
The current default settings are mostly fine for our purposes. However, in the next exercise, we will create a new directory for our templates, and we will need to specify the location of this folder. For example, if we have a directory called my_templates, we need to specify its location by adding it to the TEMPLATES settings as follows:

TEMPLATES = [
{
  'BACKEND':
    'django.template.backends.django.DjangoTemplates',
  'DIRS': [os.path.join(BASE_DIR, 'my_templates')],
  'APP_DIRS': True,
  'OPTIONS': {
    'context_processors': [
    'django.template.context_processors.debug',
    'django.template.context_processors.request',
    'django.contrib.auth.context_processors.auth',
    'django.contrib.messages.context_processors.messages',
    ],
  },
},
]

Copy

Explain
BASE_DIR is the directory path to the project folder. This is defined in the settings.py file. The os.path.join() method joins the project directory with the templates directory, returning the full path for the templates directory. In the following exercise, we shall use a template to display a message to the user.

Exercise 3.02 – using templates to display a greeting message
In this exercise, we will create our first Django template, and, just as we did in the previous exercise, we will display the Welcome to Bookr! message using the templates. Let’s get started with the steps:

Create a directory called templates in the bookr project directory and inside it, create a file called base.html. The directory structure should look like the following figure:
Figure 3.2 – Directory structure for bookr
Figure 3.2 – Directory structure for bookr

Note

When the default configuration is used (that is, when DIRS is an empty list), Django searches for templates present only in the app folders’ templates directory (the reviews/templates folder in the case of a book review application). Since we have included the new template directory in the main project directory, Django’s template engine will not be able to find the directory unless the directory is included in the 'DIRS' list.

Add the folder to the TEMPLATES settings:
TEMPLATES = [
{
  'BACKEND':
    'django.template.backends.django.DjangoTemplates',
  'DIRS': [os.path.join(BASE_DIR, 'my_templates')],
  'APP_DIRS': True,
  'OPTIONS': {
    'context_processors': [
      'django.template.context_processors.debug',
      'django.template.context_processors.request',
      'django.contrib.auth.context_processors.auth',
      'django.contrib.messages.context_processors
        .messages',
    ],
  },
},
]

Copy

Explain
Add the following lines of code into the base.html file:
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Home Page</title>
</head>
    <body>
        <h1>Welcome to Bookr!</h1>
    </body>
</html>

Copy

Explain
This is simple HTML that displays the Welcome to Bookr! message in the header.

Modify the code inside bookr/reviews/views.py so that it looks as follows:
from django.shortcuts import render
def welcome_view (request):
    return render(request, 'base.html')

Copy

Explain
Since we have already configured the 'templates' directory in the TEMPLATES configuration, base.html is available for use for the template engine. The code renders the base.html file using the imported render method from the django.shortcuts module.

Save the files, run ./manage.py runserver, and open the http://0.0.0.0:8000/ or http://127.0.0.1:8000/ URL to check the newly added template loading in the browser:
Figure 3.3 – Displaying “Welcome to Bookr!” on the home page
Figure 3.3 – Displaying “Welcome to Bookr!” on the home page

In this exercise, we created an HTML template and used Django templates and views to return the Welcome to Bookr! message.

Overall, we can say that Django templates help us to work with HTML templates and present information to the user in a desired format. Next, we will learn about the Django template language, which can be used to render the application’s data along with HTML templates.

Django’s template language
Django templates not only return static HTML templates but can also add dynamic application data while generating the templates. Along with data, we can also include some programmatic elements in the templates. All of these put together form the basics of Django’s template language. The following few sections look at some of the basic parts of the Django template language, such as template variables, template tags, comments, and filters.

Template variables
A template variable is represented between two curly braces, as shown here:

{{ variable }}

Copy

Explain
When this is present in the template, the value carried by the variables will be replaced in the template. Template variables help add the application’s data into the templates:

template_variable = "I am a template variable."
<body>
    {{ template_variable }}
</body>

Copy

Explain
Template tags
A tag is similar to a programmatic control flow, such as an if condition or a for loop. A tag is represented between two curly braces and percentage signs, as shown. Here is an example of a for loop iterating over a list using template tags:

{% for element in element_list %}
{% endfor %}

Copy

Explain
Unlike Python programming, we also add the end of the control flow by adding the end tag, such as {% endfor %}. This can be used along with template variables to display the elements in the list, as shown here:

<ul>
    {% for element in element_list %}
        <li>{{ element.title }}</li>
    {% endfor %}
</ul>

Copy

Explain
Comments
Comments in the Django template language can be written as shown here; anything in between {% comment %} and {% endcomment %} will be commented out:

{% comment %}
    <p>This text has been commented out</p>
{% endcomment %}

Copy

Explain
Filters
Filters can be used to modify a variable to represent it in a different format. The syntax for a filter is a variable separated from the filter name using a pipe (|) symbol:

{{ variable|filter }}

Copy

Explain
Here are some examples of built-in filters:

{{ variable|lower }}: This converts the variable string into lowercase
{{ variable|title}}: This converts the first letter of every word into uppercase
Let’s use the concepts we have learned to develop the book review application.

Exercise 3.03 – displaying a list of books and reviews
In this exercise, we will create a web page that can display a list of all books, their ratings, and the number of reviews present in the book review application. For this, we will be using some features of the Django template language, such as variables and template tags, to pass the book review application data into the templates to display meaningful data on the web page:

Create a file called utils.py under bookr/reviews/utils.py and add the following code:
def average_rating(rating_list):
    if not rating_list:
        return 0
    return round(sum(rating_list) / len(rating_list))

Copy

Explain
This is a helper method that will be used to calculate the average rating of a book.

Remove all the code present inside bookr/reviews/views.py and add the following code to it:
from django.shortcuts import render, get_object_or_404
from .models import Book
from .utils import average_rating
def index(request):
    return render(request, "base.html")
def book_search(request):
    search_text = request.GET.get("search", "")
    return render(request,
        "reviews/search-results.html",
        {"search_text": search_text})

Copy

Explain
This is a view to display the list of books for the book review application. The first three lines import Django modules, model classes, and the helper method we just added.

Here, books_list is the view method. In this method, we start by querying the list of all books. Next, for every book, we calculate the average rating and the number of reviews posted. All this information for each book is appended to a list called book_list as a list of dictionaries. This list is then added to a dictionary named context and is passed to the render function.

The render function takes three parameters: the first one is the request object that was passed into the view, the second is the books_list.html HTML template, which will display the list of books, and the third is context, which we pass to the template.

Since we have passed book_list as a part of the context, the template will be using this to render the list of books using template tags and template variables.

Create the book_list.html file in the bookr/reviews/templates/reviews/books_list.html path and add the following HTML code to the file:
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Bookr</title>
</head>
    <body>
        <h1>Book Review application</h1>
        <hr>

Copy

Explain
You can find the complete code at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/blob/main/Chapter03/Exercise3.03/bookr/reviews/templates/reviews/book_list.html.

This is a simple HTML template with template tags and variables iterating over book_list to display the list of books.

In bookr/reviews/urls.py, add the following URL pattern to invoke the books_list view:
from django.urls import path
from . import views
urlpatterns = [
    path('books/', views.book_list,
          name='book_list'),
]

Copy

Explain
This does the URL mapping for the books_list view function.

Save all the modified files and wait for the Django service to restart. Open http://0.0.0.0:8000/books/ in the browser, and you should see something similar to the following figure:
Figure 3.4 – List of books present in the book review application
Figure 3.4 – List of books present in the book review application

In this exercise, we created a view function, created templates, and also did the URL mapping, which can display a list of all books present in the application. Although we were able to display a list of books using a single template, next, let’s explore a bit about how to work with multiple templates in an application that has common or similar code.

Template inheritance
As we build the project, the number of templates will increase. It is highly probable that when we design the application, some of the pages will look similar and have common HTML code for certain features. Using template inheritance, other HTML files can inherit the common HTML code. This is similar to class inheritance in Python, where the parent class has all the common code, and the child class has those extras that are unique to the child’s requirements.

For example, let’s consider the following to be a parent template that is named base.html:

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Hello World</title>
</head>
    <body>
        <h1>Hello World using Django templates!</h1>
        {% block content %}
        {% endblock %}
    </body>
</html>

Copy

Explain
The following is an example of a child template:

{% extends 'base.html' %}
{% block content %}
<h1>How are you doing?</h1>
{% endblock %}

Copy

Explain
In the preceding snippet, the {% extends 'base.html' %} line extends the template from base.html, which is the parent template. After extending from the parent template, any HTML code in between the block content will be displayed along with the parent template. Once the child template has been rendered, here is how it looks in the browser:

Figure 3.5 – Greeting message after extending the base.html template
Figure 3.5 – Greeting message after extending the base.html template

In the next section, we will do some template styling using Bootstrap.

Template styling with Bootstrap
We have seen how to display all the books using views, templates, and URL mapping. Although we were able to display all the information in the browser, it would be even better if we could add some styling and make the web page look better. For this, we can add a few elements of Bootstrap. Bootstrap is an open source Cascading Style Sheets (CSS) framework that is particularly good for designing responsive pages that work across desktop and mobile browsers.

Using Bootstrap is simple. First, you need to add Bootstrap CSS to your HTML. You can experiment yourself by creating a new file called example.html. Populate it with the following code and open it in a browser:

<!doctype html>
<html lang="en">
  <head>
      <!-- Required meta tags -->
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width,
      initial-scale=1, shrink-to-fit=no">
      <!-- Bootstrap CSS -->
      <link rel="stylesheet" href=
       "https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/
       css/bootstrap.min.css" integrity="sha384-
       Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9M
       uhOf23Q9Ifjh" crossorigin="anonymous">
  </head>
      <body>
          Content goes here
      </body>
</html>

Copy

Explain
The Bootstrap CSS link in the preceding code adds the Bootstrap CSS library to your page. This means that certain HTML element types and classes will inherit their styles from Bootstrap. For example, if you add the btn-primary class to the class of a button, the button will be rendered in blue with white text.

Try adding the following between <body> and </body>:

<h1>Welcome to my Site</h1>
<button type="button" class="btn btn-primary">
  Checkout my Blog!</button>

Copy

Explain
You will see that the title and button are both styled nicely, using Bootstrap’s default styles:

Figure 3.6 – Display after applying Bootstrap
Figure 3.6 – Display after applying Bootstrap

This is because in the Bootstrap CSS code, it specifies the color of the btn-primary class with the following code:

.btn-primary {
    color: #fff;
    background-color: #007bff;
    border-color: #007bff
}

Copy

Explain
You can see that using third-party CSS libraries such as Bootstrap allows you to quickly create nicely styled components without needing to write too much CSS. Next, we shall use template inheritance from a base template and also add some styling elements such as a navigation bar.

Note

We recommend that you explore Bootstrap further with its tutorial here: https://getbootstrap.com/docs/4.4/getting-started/introduction/.

Exercise 3.04 – adding template inheritance and a Bootstrap navigation bar
In this exercise, we will use template inheritance to inherit the template elements from a base template and reuse them in the book_list template to display the list of books. We will also use certain elements of Bootstrap in the base HTML file to add a navigation bar to the top of our page. The bootstrap code for base.html was taken from https://getbootstrap.com/docs/4.4/getting-started/introduction/ and https://getbootstrap.com/docs/4.4/components/navbar/. Let’s get started with the steps:

Open the base.html file from the bookr/templates/base.html location. Remove any existing code and replace it with the following code:
<!doctype html>
{% load static %}
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,
        initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->

Copy

Explain
You can view the entire code for this file at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/blob/main/Chapter03/Exercise3.04/bookr/reviews/templates/reviews/base.html.

This is a base.html file with all the Bootstrap elements for styling and the navigation bar.

Next, open the template at bookr/reviews/templates/reviews/books_list.html, remove all the existing code, and replace it with the following code:
{% extends 'base.html' %}
{% block content %}
<ul class="list-group">
  {% for item in book_list %}
  <li class="list-group-item">
      <span class="text-info">Title: </span> <span>{{
          item.book.title }}</span>
      <br>
      <span class="text-info">Publisher:
          </span><span>{{
              item.book.publisher }}</span>

Copy

Explain
You can view the complete code for this file at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/blob/main/Chapter03/Exercise3.04/bookr/reviews/templates/reviews/book_list.html.

This template has been configured to inherit the base.html file, and it has also been added with a few styling elements to display the list of books. The part of the template that helps in inheriting the base.html file is as follows:

{% extends 'base.html' %}
{% block content %}
{% endblock %}

Copy

Explain
After adding the two new templates, open either of the URLs (http://0.0.0.0:8000/books/ or http://127.0.0.1:8000/books/) in your web browser to see the book list page, which should now look neatly formatted:
Figure 3.7 – Neatly formatted book list page
Figure 3.7 – Neatly formatted book list page

In this exercise, we added some styling to the application using Bootstrap, and we also used template inheritance while we displayed the list of books from the book review application. So far, we have worked extensively on displaying all the books present in the application. In the next activity, you will display the details and reviews of an individual book.

Activity 3.01 – implementing the book details view
In this activity, you will implement a new view, template, and URL mapping to display these details of a book: the title, publisher, publication date, and overall rating. In addition to these details, the page should also display all the review comments, specifying the name of the commenter and the dates on which the comments were written and (if applicable) modified. The following steps will help you complete this activity:

Create a book details endpoint that extends the base template.
Create a book details view that takes a specific book’s primary key as the argument and returns an HTML page listing the book’s details and any associated reviews.
Do the required URL mapping in urls.py. The book details view URL should be http://0.0.0.0:8000/books/1/ (where 1 will represent the ID of the book being accessed). You can use the get_object_or_404 method to retrieve the book with the given primary key.
Note

The get_object_or_404 function is a useful shortcut for retrieving an instance based on its primary key. You could also do this using the .get() method described in Chapter 2, Models and Migrations: Book.objects.get(pk=pk). However, get_object_or_404 has the added advantage of returning an HTTP 404 Not Found response if the object does not exist. If we simply use get() and someone attempts to access an object that does not exist, our Python code will hit an exception and return an HTTP 500 Server Error response. This is undesirable because it looks as though our server has failed to handle the request correctly.

At the end of the activity, you should be able to click the Reviews button on the book list page and get a detailed view of a book. The detailed view should have all the details displayed, as shown in the following screenshot:
Figure 3.8 – Page displaying the book details
Figure 3.8 – Page displaying the book details

Note

The solution for this activity can be found on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

In the templates section, we learned how to use Django templates to present static information to the user, template language to display the application’s dynamic data, and Bootstrap to add styling to the information and make it presentable to users.

Summary
This chapter covered the core infrastructure required to handle an HTTP request to our website. The request is first mapped via URL patterns to an appropriate view. Parameters from the URL are also passed into the view to specify the object displayed on the page. The view is responsible for compiling any necessary information to display on the website, and then passes this dictionary through to a template, which renders the information as HTML code that can be returned as a response to the user. We covered both class- and function-based views and learned about the Django template language and template inheritance. We created two new pages for the book review application, one displaying all the books present and the other being the book details view page. In the next chapter, we will learn about Django admins and superusers, registering models, and performing create, read, update, and delete (CRUD) operations using the admin site.



| ≪ [ 02 Models and Migrations ](/packtpub/2024/422-web_development_with_django_2ed/02_models_and_migrations) | 03 URL Mapping, Views, and Templates | [ 04 An Introduction to Django Admin ](/packtpub/2024/422-web_development_with_django_2ed/04_an_introduction_to_django_admin) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/422-web_development_with_django_2ed/03_url_mapping,_views,_and_templates
> (2) Markdown
> (3) Title: 03 URL Mapping, Views, and Templates
> (4) Short Description: Publication date: May 2023 Publisher Packt Pages 764
> (5) tags: Django
> Book Title: 422-Web Development with Django 2ed
> Link: https://subscription.packtpub.com/book/web-development/9781803230603/pref
> create: 2024-05-08 수 14:11:52
> Images: /packtpub/2024/422-web_development_with_django_2ed_img/03/
> .md Name: 03_url_mapping,_views,_and_templates.md

