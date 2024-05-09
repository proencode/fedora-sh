
| ≪ [ 10 Advanced Django Admin and Customizations ](/packtpub/2024/422-web_development_with_django_2ed/10_advanced_django_admin_and_customizations) | 11 Advanced Templating and Class-Based Views | [ 12 Building a REST API ](/packtpub/2024/422-web_development_with_django_2ed/12_building_a_rest_api) ≫ |
|:----:|:----:|:----:|

# 11 Advanced Templating and Class-Based Views



Book image


Advanced Templating and Class-Based Views
In Chapter 3, URL Mapping, Views, and Templates, we learned how to build views and create templates in Django. Then, we learned how to use those views to render the templates we built. In this chapter, we will build upon our knowledge of developing views by using class-based views, allowing us to write views that can group logical methods into a single entity. This skill comes in handy when developing a view that maps to multiple HTTP request methods for the same application programming interface (API) endpoint. With method-based views, we may end up using a lot of the if-else conditions to successfully handle the different types of HTTP request methods. In contrast, class-based views allow us to define separate methods for every HTTP request method we want to handle. Then, based on the type of request received, Django takes care of calling the correct method in the class-based view.

Beyond the ability to build views based on different development techniques, Django also comes packed with a powerful templating engine. This engine allows developers to build reusable templates for their web applications. This reusability of the templating engine is further enhanced by using template tags and filters, which help easily implement commonly used features inside templates, features such as iterating over lists of data, formatting the data in a given style, extracting a piece of text from a variable to display, and overriding the content in a specific block of a template. All these features also expand the reusability of a Django template.

As we go through this chapter, we will look at how we can expand the default set of template filters and template tags provided by Django by leveraging Django’s ability to define our own custom template tags and filters. These custom template tags and filters can then be used to implement some common features in a reusable fashion across our web application. For example, while building a user profile badge that can be shown in several places inside a web application, it is better to leverage the ability to write a custom template inclusion tag that just inserts the template of the badge in any of the views we desire, rather than rewriting the entire code for the badge template or by introducing additional complexity to the templates.

In this chapter, we will be covering the following topics:

Template filters
Custom template filters
String filters
Template tags
Django views
Technical requirements
The complete code files for this chapter can be found at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter11

Template filters
While developing templates, developers often just want to change the value of a template variable before rendering it to the user. For example, consider that we are building a profile page for a Bookr user. There, we want to show the number of books the user has read. Below that, we also want to show a table listing the books they have read.

To achieve this, we can pass two separate variables from our view to the HTML template. One can be named books_read, which denotes the number of books read by the user. The other can be book_list, containing the list of names of the books read by the user, for example:

<span class="books_read">You have read {{ books_read }}
  books</span>
<ul>
    {% for book in book_list %}
      <li>{{ book }} </li>
    {% endfor %}
</ul>

Copy

Explain
Template filters in Django are simple Python-based functions that accept a variable as an argument (and any additional data in the context of the variable), change its value as per our requirements, and then render the changed value.

Now, the same outcome from writing the previous snippet can also be obtained without the use of two separate variables by using template filters in Django, as follows:

<span class="books_read">You have read
  {{ book_list|length }}</span>
<ul>
    {% for book in book_list %}
      <li>{{ book }}</li>
    {% endfor %}
</ul>

Copy

Explain
Here, we used the built-in length filter provided by Django. The use of this filter causes the length of the book_list variable to be evaluated and returned, which is then inserted into our HTML template during rendering.

Like length, there are a lot of other template filters that come pre-packaged with Django and that are ready to be used. For example, the lowercase filter converts the text to all lowercase format, the last filter can be used to return the last item in the list, and the json_script filter can be used to output a Python object passed to the template as a JSON value wrapped in a <script> tag in your template.

Important note

You can refer to Django’s official documentation for the complete list of template filters offered by Django at https://docs.djangoproject.com/en/3.1/ref/templates/builtins/.

Now, with the knowledge of how to use template filters, let’s jump into understanding how we can write our own custom filters.

Custom template filters
Django supplies a lot of useful filters that we can use in our templates while we are working on our projects. But what if someone wants to format a specific piece of text and render it with different fonts? Or, say, someone wants to translate an error code to a user-friendly error message based on the mapping of the error code in the backend. In these cases, predefined filters do not suffice, and we would like to write our own filter that we can reuse across the project.

Luckily, Django supplies an easy-to-use API that we can use to write custom filters. This API provides developers with some useful decorator functions that can be used to quickly register a Python function as a custom template filter. Once a Python function is registered as a custom filter, a developer can start using the function in templates.

An instance of this template library method is required to access the filters. This instance can be created by instantiating the Library() class in Django from Django’s template module, as shown here:

from django import template
register = template.Library()

Copy

Explain
Once the instance is created, we can now use the filter decorator from the template library instance to register our filters.

Creating custom template filters
There are a couple of steps we need to take to create custom template filters. Let’s try to understand what these steps are and how they help us with the creation of a custom template filter in the next subsection.

Setting up the directory for storing template filters
It is important to note that when creating a custom template filter or template tag, we need to put them in the templatetags directory under the application directory. This requirement arises because Django is internally configured to look for custom template tags and filters when loading a web application. A failure to name the directory templatetags will result in Django not loading the custom template filters and tags created by us.

To create this directory, first, navigate to the application folder inside which you want to create custom template filters, and then run the following command in the terminal:

mkdir templatetags

Copy

Explain
Once the directory is created, the next step is to create a new file inside the templatetags directory to store the code for our custom filters. This can be done by executing the following command inside the templatetags directory:

touch custom_filter.py

Copy

Explain
Important note

The aforementioned command won’t work on Windows. You can, however, navigate to the desired directory and create a new file using Windows Explorer.

Alternatively, this can be done by using the GUI interface provided by PyCharm.

Setting up the template library
Once the file for storing the code for the custom filter is created, we can now start working on implementing our custom filter code. For custom filters to work in Django, they need to be registered to Django’s template library before they can be used inside templates. To that end, the first step is to set up an instance of the template library, which will be used to register our custom filters. For this, inside the custom_filters.py file we created in the previous section, we first need to import the template module from the Django project:

from django import template

Copy

Explain
Once the import is resolved, the next step is to create an instance of the template library by adding the following line of code:

register = template.Library()

Copy

Explain
The Library class from Django’s template module is implemented as a singleton class that returns the same object that is only initialized once at the start of the application.

Once the template library instance is set up, we can proceed with implementing our custom filter.

Implementing the custom filter function
Custom filters inside Django are nothing more than simple Python functions that essentially take the following parameters:

The value on which the filter is being applied (mandatory)
Any additional parameters (zero or more) that need to be passed to the filter (optional)
These functions need to be decorated with the filter attribute from Django’s template library instance to behave as template filters. For example, the generic implementation of a custom filter will look like the following:

@register.filter
def my_filter(value, arg):
    # Implementation logic of the filter

Copy

Explain
With this, we have learned how to implement a custom filter that can be used inside templates. In the next section, we will learn how to use these custom filters.

Using custom filters inside templates
Once the filter is created, it’s simple to start using it inside our templates. To do that, the filter must first be imported into the template. This can be easily done by adding the following line to the top of the template file:

{% load custom_filter %}

Copy

Explain
When Django’s templating engine parses the template files, the preceding line is automatically resolved by Django to find the correct module specified under the templatetags directory. As a consequence, all the filters mentioned inside the custom_filter module are automatically made available inside the template.

Using our custom filter inside the template is as simple as adding the following line:

{{ some_value|generic_filter:"arg" }}

Copy

Explain
Equipped with this knowledge, let’s now create our first custom filter.

Exercise 11.01 – Creating a custom template filter
In this exercise, we will write a custom filter named explode, which returns a list of strings when provided with a string and a user-supplied separator. For example, consider the following string:

names = "john,doe,mark,swain"

Copy

Explain
You will apply the following filter to this string:

{{ names|explode:"," }}

Copy

Explain
The output after applying this filter should be as follows:

["john", "doe", "mark", "swain"]

Copy

Explain
Let’s get started with the steps:

Create a new application inside the bookr project that you can use for demo purposes:
python manage.py startapp filter_demo

Copy

Explain
The preceding command will set up a new application inside your Django project.

Now, create a new directory named templatetags inside your filter_demo application directory to store the code for your custom template filters. To create the directory, run the following command from inside the filter_demo directory from the terminal app or Command Prompt:
mkdir templatetags

Copy

Explain
Once the directory is created, create a new file named explode_filter.py inside the templatetags directory.
Open the file and add the following lines to it:
from django import template
register = template.Library()

Copy

Explain
The preceding code creates an instance of the Django library that can be used to register our custom filter with Django.

Add the following code to implement the explode filter:
@register.filter
def explode(value, separator):
    return value.split(separator)

Copy

Explain
The explode filter takes two arguments; one is value on which the filter was used, and the second is separator, passed from the template to the filter. The filter will use this separator to convert the string into a list.

With the custom filter ready, create a template where this filter can be applied. For this, first, create a new folder named templates under the filter_demo directory and then create a new file named index.html inside it with the following contents:
<html>
<head>
  <title>Custom Filter Example</title>
<body>
{% load explode_filter %}
{{ names|explode:"," }}
</body>
</html>

Copy

Explain
In the first line, Django’s template engine loads the custom filter from the explode_filter module so that it can be used inside the templates. To achieve this, Django will look for the explode_filter module under the templatetags directory, and if found, will load it for use.

In the next line, you pass the names variable passed to the template and apply the explode filter to it, while also passing in the , symbol as a separator value to the filter.

Now, with the template created, the next thing is to create a Django view that can render this template and pass the name variable to the template. For this, open the views.py file and add the following highlighted code:
from django.shortcuts import render
def index(request):
    names = "john,doe,mark,swain"
    return render(request, "index.html", {'names':
                  names})

Copy

Explain
The preceding code snippet performs some basic operations. It first imports the render helper from the django.shortcuts module, which helps render the templates. Once the import is complete, it defines a new view function named index(), which renders index.html.

Now map the view to a URL that can then be used to render the results in the browser. To do this, create a new file named urls.py inside the filter_demo directory and add the following code to it:
from django.urls import path
from . import views
urlpatterns = [
    path('', views.index, name='index')
]

Copy

Explain
Add the filter_demo application to the project URL mapping. To this end, open urls.py in the bookr project directory and add the following highlighted line inside urlpatterns:
urlpatterns = [
    path('filter_demo/', include('filter_demo.urls')),
    ….
]

Copy

Explain
After the changes have been made, the urls.py file under the bookr project directory should resemble the one shown under https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter11/Exercise11.01/bookr/urls.py.

Finally, add the application under the INSTALLED_APPS section under settings.py of the bookr project:
INSTALLED_APPS = [
    ….,
    'filter_demo'
]

Copy

Explain
This requirement arises due to the security guidelines implemented by Django, which require that the application implementing custom filters/tags needs to be added to the INSTALLED_APPS section. Once the changes have been made, the settings.py file should resemble the file at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter11/Exercise11.01/bookr/settings.py.

To view whether the custom filter works, run the following command:
python manage.py runserver localhost:8000

Copy

Explain
Now, navigate to the following page in our browser: http://localhost:8000/filter_demo.

This page should appear as shown in Figure 11.1:
Figure 11.1 – Index page displayed by using the explode filter
Figure 11.1 – Index page displayed by using the explode filter

With this, we saw how we can quickly create a custom filter inside Django and then use it in our templates. In the next section, let’s take a look at another type of filter, namely, string filters, which work solely on string-type values.

String filters
In Exercise 11.01, Creating a custom template filter, we built a custom filter, which allowed us to split a provided string with a separator and generate a list from it. This filter can take any kind of variable and split it as a list of values based on a delimiter provided. But what if we wanted to restrict our filter to work only with strings and not with any other type of values, such as integers?

We can use the stringfilter decorator provided by Django’s template library to develop filters that work only on strings. When the stringfilter decorator is used to register a Python method as a filter in Django, the framework ensures that the value being passed to the filter is converted to a string before the filter executes. This reduces any potential issues that may arise when non-string values are passed to our filter.

The steps to implement a string filter are similar to the ones we followed for building a custom filter with some minor changes.

Remember the custom_filter.py file we created in the Setting up the directory for storing template filters section? Let’s now add a new Python function inside it that will act as our string filter.

Before we can implement a string filter, we first need to import the stringfilter decorator, which demarcates a custom filter function as a string filter. You can add this decorator by adding the following import statement inside the custom_filters.py file:

from django.template.defaultfilters import stringfilter

Copy

Explain
Now, to implement our custom string filter, the following syntax can be used:

@register.filter
@stringfilter
def generic_string_filter(value, arg):
    # Logic for string filter implementation

Copy

Explain
With this approach, we can build as many string filters as we want and use them just like any other filter.

Template tags
Template tags are a powerful feature of Django’s templating engine. They allow developers to build powerful templates by generating HTML by evaluating certain conditions and help avoid the repetitive writing of common code.

One example where we may use template tags is the sign-up/login options in the navigation bar of a website. In this case, we can use template tags to evaluate whether the visitor on the current page is logged in. Based on that, we can render either a profile banner or a sign-up/login banner.

Tags are also a common occurrence while developing templates. For example, consider the following line of code, which we used to import the custom filters inside our templates in the previous section:

{% load explode_filter %}

Copy

Explain
This uses a template tag known as load, responsible for loading the explode filter into the template. Template tags are much more powerful compared to filters. While filters have access only to the values they are operating on, template tags have access to the context of the whole template and hence they can be used to build a lot of complex functionalities inside a template.

Let’s now look at the different types of template tags supported by Django and how we can build our own custom template tags.

The types of template tags
Django mainly supports two types of template tags:

Simple tags: These are the tags that operate on the variable data provided (and any additional variables to them) and render in the same template they have been called in. For example, one such use case can include rendering a custom welcome message to the user based on their username or displaying the user’s last login time based on their username.
Inclusion tags: These tags take in the provided data variables and generate an output by rendering another template. For example, the tag can take in a list of objects and iterate over them to generate an HTML list.
In the next sections, we will look at how we can create these different types of tags and use them in our application.

Simple tags
Simple tags provide a way for developers to build template tags that take in one or more variables from the template, process them, and return a response. The response returned from the template tag replaces the template tag definition provided inside the HTML template. These kinds of tags can be used to build several useful functionalities, for example, the parsing of dates or displaying any active alerts, if there are any, that we want to show to the user.

The simple tags can be created easily using the simple_tag decorator provided by the template library, by decorating the Python method, which should act as a template tag. Now, let’s look at how we can implement a custom simple tag using Django’s template library.

Creating a simple template tag
Creating simple template tags follows the same conventions we discussed in the Custom template filters section, with some subtle differences. First, let’s go over understanding how template tags can be created for use in our Django templates.

Setting up the directory
Just like custom filters, custom template tags also need to be created inside the same templatetags directory to make them discoverable by Django’s templating engine. The directory can be created either directly using the PyCharm GUI or by running the following command inside the application directory where we want to create our custom tags:

mkdir templatetags

Copy

Explain
Once this is done, we can now create a new file that will store the code for our custom template tags by using the following command:

touch custom_tags.py

Copy

Explain
Important note

The aforementioned command won’t work on Windows. You can, however, create a new file using Windows Explorer.

Setting up the template library
Once the directory structure is set up and we have a file in place for keeping the code for our custom template tags, we can now start creating our template tags. But before that, we need to set up an instance of Django’s template library as we did earlier. This can be done by adding the following lines of code to our custom_tag.py file:

from django import template
register = template.Library()

Copy

Explain
Like custom filters, the template library instance is used here to register the custom template tags for use inside Django templates.

Implementing a simple template tag
Simple template tags inside Django are Python functions that can take any number of arguments as we desire. These Python functions need to be decorated with the simple_tag decorator from the template library to register those functions as simple template tags. The following snippet of code shows how a simple template tag is implemented:

@register.simple_tag
def generic_simple_tag(arg1, arg2):
    # Logic to implement a generic simple tag

Copy

Explain
Next, let’s use these simple tags inside the templates.

Using simple tags inside templates
Using simple tags inside Django templates is quite easy. Inside the template file, we need first to make sure that we have the tag imported inside the template by adding the following to the top of the template file:

{% load custom_tag %}

Copy

Explain
The preceding statement will load all the tags from the custom_tag.py file we defined earlier and make them available inside our template. Then we can use our custom simple tag by adding the following command:

{% custom_simple_tag "argument1" "argument2" %}

Copy

Explain
Wasn’t that easy?! Now, let’s put this knowledge into practice and create our first custom simple tag.

Exercise 11.02 – Creating a custom simple tag
In this exercise, we will create a simple tag that will take in two arguments: the first will be a greeting message, and the second will be the user’s name. This tag will print a formatted greeting message. Let’s get started with the steps:

Following on from the example shown in Exercise 11.01, let’s reuse the same directory structure to store the code for the simple tag inside. So, first, create a new file named simple_tag.py under the filter_demo directory. Inside this file, add the following code:
from django import template
register = template.Library()
@register.simple_tag
def greet_user(message, username):
    return "{greeting_message}, {user}!!!"
    .format(greeting_message=message, user=username)

Copy

Explain
In this case, you create a new Python method, greet_user(), which takes in two arguments, message, the message to use for the greeting, and username, the name of the user who should be greeted. This method is then decorated with @register.simple_tag, indicating that this method is a simple tag and can be used as a template tag in the templates.

Now, create a new template that will use your simple tag. For this, create a new file named simple_tag_template.html under the filter_demo/templates directory and add the following code to it:
<html>
<head>
  <title>Simple Tag Template Example</title>
</head>
<body>
{% load simple_tag %}
{% greet_user "Hey" username %}
</body>
</html>

Copy

Explain
In the preceding code snippet, we just created a bare-bones HTML page that will use your custom simple tag. The semantics of loading a custom template tag is similar to that of loading a custom template filter and requires the use of a {% load %} tag in the template. The process will look for the simple_tag.py module under the templatetags directory and, if found, will load the tags that have been defined under the module.

The following line shows how we can use the custom template tag:

{% greet_user "Hey" username %}

Copy

Explain
In this, we first used Django’s tag specifier, {% %}, and inside it, the first argument we passed is the name of the tag that needs to be used, followed by the first argument, Hey, which is the greeting message, and the second argument, username, which will be passed to the template from the view function.

With the template created, the next step involves creating a view that will render your template. For this, add the following code in the views.py file under the filter_demo directory:
def greeting_view(request):
    return render(request, 'simple_tag_template.html',
    {'username': 'jdoe'})

Copy

Explain
In the preceding code snippet, we created a simple function-based view, which will render your simple_tag_template defined in step 2 and pass the 'jdoe' value to the username variable.

With the view created, the next step is to map it to a URL endpoint in your application. To do this, open the urls.py file under the filter_demo directory and add the following inside the urlpatterns list:
path('greet', views.greeting_view, name='greeting')

Copy

Explain
With this, greeting_view is now mapped to the /greet URL endpoint for your filter_demo application.

The final set of changes should resemble the ones at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter11/Exercise11.02.

To see the custom tag in action, start your web server by running the following command:
python manage.py runserver localhost:8000

Copy

Explain
After visiting http://localhost:8000/filter_demo/greet in the browser, you should see the following page:

Figure 11.2 – Greeting message generated with the help of the custom simple tag
Figure 11.2 – Greeting message generated with the help of the custom simple tag

With this, we created our first custom template tag and used it successfully to render our template, as shown in Figure 11.2. Now, let’s look at another important aspect of simple tags, which is associated with passing the context variables available in the template to the template tag.

Passing the template context in a custom template tag
In the previous exercise, we created a simple tag to which we passed two arguments, the greeting message and the username. But what if we wanted to pass a large number of variables to the tag? Or simply, what if we did not want to pass the user’s username explicitly to the tag?

There are times when developers would like to have access to all the variables, and data that is present in the template to be available inside the custom tag. Fortunately for us, this is easy to implement.

Using our previous example of the greet_user tag, let’s create a new tag named contextual_greet_user and see how we can pass the data available in the template directly to the tag instead of passing it manually as an argument.

The first modification we need to make is to modify our decorator to look like the following:

@register.simple_tag(takes_context=True)

Copy

Explain
With this, we tell Django that when our contextual_greet_user tag is used, Django should also pass it the template context, which has all the data passed from the view to the template. With this addition done, the next thing we need to do is to change our contextual_greet_user implementation to accept the added context as an argument. The following code shows the modified form of the contextual_greet_user tag, which uses our template context to render a greeting message:

@register.simple_tag(takes_context=True)
def contextual_greet_user(context, message):
    username = context['username']
    return "{greeting_message}, {user}"
        .format(greeting_message=message, user=username)

Copy

Explain
In the preceding code example, we can see how the contextual_greet_user() method was modified to accept the passed context as the first argument, followed by the greeting message passed by the user.

To leverage this modified template tag, all we need to do is to change our call to the contextual_greet_user tag inside simple_tag_template.html under filter_demo to look like this:

{% contextual_greet_user "Hey" %}

Copy

Explain
Then, when we reload our Django web application, the output at http://localhost:8000/filter_demo/greet should look the same as what was shown in step 5 of Exercise 11.02 – creating a custom simple tag.

With this, we learned how we can build a simple tag and handle passing the template context to the tag. Now, let’s take a look at how we can build an inclusion tag that can be used to render data in a certain format, as described by another template.

Inclusion tags
Simple tags allow us to build tags that accept one or more input variables, do some processing on them, and return an output. This output is then inserted where the simple tag was used.

But what if we wanted to build tags that, instead of returning text output, return an HTML template, which can then be used to render the parts of the page? For example, many web applications allow users to add custom widgets to their profiles. These individual widgets can be built as an inclusion tag and rendered independently. This kind of approach keeps the code for the base page template and the individual templates separate and hence allows for easy reuse and refactoring.

Developing custom inclusion tags is a similar process to how we develop our simple tags. This involves the use of the inclusion_tag decorator provided by the template library. So, let’s take a look at how we can do it.

Implementing inclusion tags
Inclusion tags are those tags used for rendering a template as a response to their usage inside a template. These tags can be implemented in a similar manner to how other custom template tags are implemented, with some minor modifications.

Inclusion tags are also simple Python functions that can take multiple parameters, where each parameter maps to an argument passed from the template where the tag was called. These tags are decorated using the inclusion_tag decorator from Django’s template library. The inclusion_tag decorator takes a single parameter, the name of the template, which should be rendered as a response to the processing of the inclusion tag.

A generic implementation of an inclusion tag will look like the one shown in the following code snippet:

@register.inclusion_tag('template_file.html')
def my_inclusion_tag(arg):
    # logic for processing
    return {'key1': 'value1'}

Copy

Explain
Notice the return value in this case. An inclusion tag is supposed to return a dictionary of values that will be used to render the template_file.html file specified as an argument in the inclusion_tag decorator.

Using an inclusion tag inside a template
An inclusion tag can easily be used inside a template file. This can be done by first importing the tag as follows:

{% load custom_tags %}

Copy

Explain
And then we use the tag like any other tag:

{% my_inclusion_tag "argument1" %}

Copy

Explain
The response of the rendering of this tag will be a sub-template that will be rendered inside our primary template where the inclusion tag was used.

Exercise 11.03 – Building a custom inclusion tag
In this exercise, we are going to build a custom inclusion tag, which will render the list of books read by a user:

For this exercise, you will continue to use the same demo folders as in earlier exercises. First, create a new file named inclusion_tag.py under the filter_demo/templatetags directory and write the following code inside it:
from django import template
register = template.Library()
@register.inclusion_tag('book_list.html')
def book_list(books):
    book_list = [book_name for book_name, book_author
        in books.items()]
    return {'book_list': book_list}

Copy

Explain
The @register.inclusion_tag decorator is used to mark the method as a custom inclusion tag. This decorator takes the template’s name as an argument that should be used to render the data returned by the tag function.

After the decorator, we defined a function that implements the logic of our custom inclusion tag. This function takes a single argument called books. This argument will be passed from the template file and contain a list of books the reader has read (in the form of a Python dictionary). Inside the definition, we converted the dictionary into a Pythonic list of book names. The key in the dictionary is mapped to the name of the book, and the value is mapped to the author:

books_list = [book_name for book_name, book_author in books.items()]

Copy

Explain
Once the list is formed, the following code returns the list as a context for the template passed to the inclusion tag (in this example, book_list.html):

return {'book_list': books_list}

Copy

Explain
The value returned by this method will be passed by Django to the book_list.html template, and the contents will then be rendered.

Next, create the actual template, which will contain the rendering structure for the template tag. For this, create a new template file, book_list.html, under the filter_demo/templates directory, and add the following content to it:
<ul>
    {% for book in book_list %}
      <li>{{ book }}</li>
    {% endfor %}
</ul>

Copy

Explain
Here, in the new template file, we created an unordered list that will hold the list of books a user has read. Next, using the for template tag, we iterate over the values within book_list that will be provided by the custom template function:

{% for book in book_list %}

Copy

Explain
This iteration results in the creation of several list items, as defined by the following:

<li>{{ book }}</li>

Copy

Explain
The list item is generated with the contents from book_list and passed to the template. The for tag executes as many times as the number of items present in book_list.

With the template defined for the book_list tag, modify the existing greeting template to make this tag available inside it and use it to show a list of books that the user has read. For this, modify the simple_tag_template.html file under the filter_demo/templates directory and change the code to look as follows:
<html>
<head>
  <title>Simple Tag Template Example</title>
</head>
<body>
{% load simple_tag inclusion_tag %}
{% greet_user "Hey" username %}
<br />
<span class="message">You have read the following
  books till date</span>
{% book_list books %}
</body>
</html>

Copy

Explain
In this snippet, the first thing you did was load the inclusion_tag module by writing the following:

{% load simple_tag inclusion_tag %}

Copy

Explain
Once the tag is loaded, you can now use it anywhere in the template. To use it, you added the book_list tag in the following format:

{% book_list books %}

Copy

Explain
This tag takes a single argument, which is a dictionary of books, inside which the key is the book title, and the value of the key is the author of the book.

With the template now modified, the final step involves passing the required data to the template. To achieve this, modify views.py in the filter_demo directory and change the greeting view function to look like this:
def greeting_view(request):
    books = {
        "The night rider": "Ben Author",
        "The Justice": "Don Abeman"
    }
    return render(request, 'simple_tag_template.html',
    {'username': 'jdoe', 'books': books})

Copy

Explain
Here, we modified the greeting_view function to add a dictionary of books and their authors, and then we passed it to the simple_tag_template context.

Once the changes have been made, the files should resemble the ones hosted at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter11/Exercise11.03.

With the preceding changes implemented, it’s time to render the modified template. To do this, restart your Django application server by running the following command:
python manage.py runserver localhost:8080

Copy

Explain
Navigate to http://localhost:8080/greet, which should now render a page similar to the following screenshot:
Figure 11.3 – List of books read by a user when they visit the greeting endpoint
Figure 11.3 – List of books read by a user when they visit the greeting endpoint

The page shows the list of books read by a user when they visit the greeting endpoint. The list you see on the page is rendered using inclusion tags. The template for listing these books is created separately first, and then, using the inclusion tag, it is added to the page.

With this, we now have the foundations on which we can build highly complex template filters or custom tags that can be helpful in the development of the projects we want to work on.

Now, let’s take a look at Django views and dive into a new territory of class-based views provided by Django to help us leverage the power of object-oriented programming that allows the reuse of code for the rendering of a view.

Django views
To recall, a view in Django is a piece of Python code that allows a request to be taken in, performs an action based on the request, and then returns a response to the user, hence forming an important part of our Django applications.

Inside Django, we have the option of building our views by following two different methodologies, one of which we have already seen in the preceding examples and is known as function-based views, while the other one, which we will be covering soon, is known as class-based views:

Function-based views (FBVs): FBVs inside Django are nothing more than generic Python functions that are supposed to take an HTTPRequest type object as their first positional parameter and return an HTTPResponse type object, which corresponds to the action the view wants to perform once the request is processed by it. In the preceding exercise, index() and greeting_view() were examples of FBVs.
Class-based views (CBVs): CBVs are views that closely adhere to the Python object-oriented principles and allow mapping of the view calls in a class-based representation. These views are specialized in nature, and a given type of CBV performs a specific operation. The benefits that CBVs provide include easy extensibility of the view and the reuse of code, which may turn out to be a complex task with FBVs.
Now, with the basic definitions clear and with knowledge of FBVs already in our arsenal, let’s look at CBVs and see what they have in store for us.

Class-based views
Django provides different ways in which developers can write views for their applications. One way is to map a Python function to act as a view function to create FBVs. Another way of creating views is to use Python object instances (based on top of Python classes). These are known as CBVs. An important question that arises is, what is the need for a CBV when we can already create views using the FBV approach?

When creating FBVs, the idea is that, at times, we may be replicating the same logic again and again, for example, the processing of certain fields or logic for handling certain request types. Although it is completely possible to create logically separate functions that handle a particular piece of logic, the task becomes difficult to manage as the complexity of the application increases.

This is where CBVs come in handy, as they abstract away implementation of the common repetitive code that we need to write to handle certain tasks, such as the rendering of templates, while also making it easy to reuse pieces of code through the use of inheritance and mix-ins. For example, the following code snippet shows the implementation of a CBV:

from django.http import HttpResponse
from django.views import View
class IndexView(View):
    def get(self, request):
        return HttpResponse("Hey there!")

Copy

Explain
In the preceding example, we built a simple CBV by inheriting from the built-in view class, which Django provides.

Using these CBVs is also quite easy. For example, let’s say we wanted to map IndexView to a URL endpoint in our application. In this case, all we need to do is to add the following line to our urlpatterns list inside the urls.py file of the application:

urlpatterns = [
    path('my_path', IndexView.as_view(), name='index_view')
]

Copy

Explain
In this, as we can observe, we used the as_view() method of the CBV we created. Every CBV implements the as_view() method, which allows the view class to be mapped to a URL endpoint by returning the instance of the view controller from the view class.

Django provides a couple of built-in CBVs that provide the implementation of a lot of common tasks, such as how to render a template or how to process a particular request. The built-in CBVs help avoid rewriting code from scratch when handling basic functionality, thereby enabling the reusability of code. Some of these in-built views include the following:

View: This is the base class for all CBVs available in Django that allows a custom CBV to be written with all the features provided and overridable. A user can implement their own definitions for different HTTP Request methods, such as GET, POST, PUT, and DELETE, and the view will automatically delegate the call to the method responsible for handling the request based on the type of request received.
TemplateView: This is a view that can be used to render a template based on the parameters for the template data provided in the URL of the call. This allows developers to easily render a template without writing any logic related to how the rendering should be handled.
RedirectView: This is a view that can automatically redirect a user to the correct resource based on the request they have made.
DetailView: This is a view that is mapped to a Django model and can be used to render the data obtained from the model using a template of choice.
The preceding views are just some of the built-in views that Django provides by default, and we will cover more of them as we move through the chapter.

Now, to better understand how CBVs work inside Django, let’s try to build our first CBV.

Exercise 11.04 – Creating a book catalog using a CBV
In this exercise, we will create a class-based form view that will help build a book catalog. This catalog will consist of the name of the book and the name of the author of the book:

To get started, create a new application inside our bookr project and name it book_management. This can be done by simply running the following command:
python manage.py startapp book_management

Copy

Explain
Now, before building the book catalog, you first need to define a Django model that will help you store the records inside the database. To do this, open the models.py file under the book_management app you just created and define a new model named Book, as shown here:
from django.db import models
class Book(models.Model):
    name = models.CharField(max_length=255)
    author = models.CharField(max_length=50)

Copy

Explain
The model contains two fields, the name of the book and the name of the author.

With the model in place, migrate the model to your database such that you can start storing your data inside the database.
Once all the preceding steps are complete, add your book_management application to the INSTALLED_APPS list such that Django can discover it and you can use your model properly. For this, open the settings.py file under the bookr directory and add the following code at the final position in the INSTALLED_APPS section:
INSTALLED_APPS = [
    ….,
    'book_management'
]

Copy

Explain
After the changes have been made, the settings.py file should look like this: https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter11/Exercise11.04/bookr/settings.py.
Migrate your model to the database by running the following two commands. These will first create a Django migrations file and then create a table in your database:
python manage.py makemigrations
python manage.py migrate

Copy

Explain
Now, with the database model in place, let’s create a new form that we will use to capture information pertaining to the books, such as the book title, author, and ISBN. For this, create a new file named forms.py under the book_management directory and add the following code inside it:
from django import forms
from .models import Book
class BookForm(forms.ModelForm):
    class Meta:
        model = Book
        fields = ['name', 'author']

Copy

Explain
In the preceding code snippet, we first imported Django’s forms module, which will allow us to easily create forms and also provide the form’s rendering capability. The next line imports the model that will store the data for the form:

from django import forms
from .models import Book

Copy

Explain
In the next line, we created a new class named BookForm, which inherits from ModelForm. This is nothing but a class that maps the fields of the model to the form. To successfully achieve this mapping between the model and the form, we defined a new subclass named Meta under the BookForm class and set the attribute model to point to the Book model and the attribute fields to the list of fields that you want to display in the form:

class Meta:
    model = Book
    fields = ['name', 'author']

Copy

Explain
This allows ModelForm to render the correct form of HTML when expected to do so. The ModelForm class provides a built-in Form.save() method, which, when used, writes the data in the form to the database and helps avoid having to write redundant code.

Now that you have both your model and the form ready, go ahead and implement a view that will render the form and accept input from the user. For this, open views.py under the book_management directory and add the following lines of code to the file:
from django.http import HttpResponse
from django.views.generic.edit import FormView
from django.views import View
from .forms import BookForm
class BookRecordFormView(FormView):
    template_name = 'book_form.html'
    form_class = BookForm
    success_url = '/book_management/entry_success'
    def form_valid(self, form):
        form.save()
        return super(BookRecordFormView)
            .form_valid(form)
class FormSuccessView(View):
    def get(self, request, *args, **kwargs):
        return HttpResponse("Book record saved
                             successfully")

Copy

Explain
In the preceding code snippet, we created two major views, BookRecordFormView, which is also responsible for rendering the book catalog entry form, and FormSuccessView, which you will use to render the success message if the form data is saved successfully. Let’s now look at both views individually and understand what we are doing.

First, we created a new view named the BookRecordFormView CBV, which inherits from FormView:

class BookRecordFormView(FormView)

Copy

Explain
The FormView class allows us to easily create views that deal with forms. To this class, we need to provide certain parameters, such as the name of the template it will render to show the form, the form class that it should use to render the form, and the success URL to redirect to when the form is processed successfully:

template_name = 'book_form.html'
form_class = BookForm
success_url = '/book_management/entry_success'

Copy

Explain
The FormView class also provides a form_valid() method, which is called when the form successfully finishes the validation. Inside the form_valid() method, we can decide what we want to do. For our use case, when the form validation completes successfully, we first call the form.save() method, which persists the data for our form into the database, and then call the base class form_valid() method, which will cause the form view to redirect to the successful URL in the event that form validation was a success:

def form_valid(self, form):
    form.save()
    return super().form_valid(form)

Copy

Explain
Important note

The form_valid() method should always return an HttpResponse object.

This completes the implementation of BookRecordFormView. The next thing we have to do is to build a view named FormSuccessView, which we will use to render the success message once the data is saved successfully for the book record form we just created. This is done by creating a new view class named FormSuccessView, which inherits from the view base class of Django CBVs:

class FormSuccessView(View)

Copy

Explain
Inside this class, we override the get() method, which will be rendered when the form is saved successfully. Inside the get() method, we render a simple success message by returning a new HttpResponse:

def get(self, request, *args, **kwargs):
    return HttpResponse("Book record saved
                         successfully")

Copy

Explain
Now, create a template that will be used to render the form. For this, create a new templates folder under the book_management directory and a new file named book_form.html. Add the following lines of code inside the file:
<html>
<head>
  <title>Book Record Insertion</title>
</head>
<body>
  <form method="POST">
    {% csrf_token %}
    {{ form.as_p }}
    <input type="submit" value="Save record" />
  </form>
</body>
</html>

Copy

Explain
Inside this code snippet, two important things need to be discussed.

The first is the use of the {% csrf_token %} tag. This tag is inserted to prevent the form from running into cross-site request forgery (CSRF) attacks. The csrf_token tag is one of the built-in template tags provided by Django to avoid such attacks. It does so by generating a unique token for every form instance that is rendered.

The second is the use of the {{ form.as_p }} template variable. The data for this variable is provided by our FormView-based view automatically. The as_p call causes the form fields to be rendered inside the <p></p> tags.

With the CBVs now built, go ahead and map them to URLs so that you can start using them to add new book records. To do this, create a new file named urls.py under the book_management directory and add the following code to it:
from django.urls import path
from .views import BookRecordFormView, FormSuccessView
urlpatterns = [
    path('new_book_record',
          BookRecordFormView.as_view(),
          name='book_record_form'),
    path('entry_success', FormSuccessView.as_view(),
          name='form_success')
]

Copy

Explain
Most parts of the preceding snippet are similar to the ones you wrote earlier, but there is one thing different in the way we map our CBVs under the URL patterns. When using CBVs, instead of directly adding the function name, we use the class name and its as_view method, which maps the class object to the view. For example, to map BookRecordFormView as a view, we will use BookRecordFormView.as_view().

With the URLs added to our urls.py file, the next thing is to add our application URL mapping to our bookr project. To do this, open the urls.py file under the bookr application and add the following line to urlpatterns:
urlpatterns = [
    path('book_management/',
          include('book_management.urls')),
    ….
]

Copy

Explain
Now, start your development server by running the following command:
python manage.py runserver localhost:8080

Copy

Explain
Then, visit http://localhost:8080/book_management/new_book_record.
If everything works fine, you will see a page as shown here:

Figure 11.4 – The view for adding a new book to the database
Figure 11.4 – The view for adding a new book to the database

Upon clicking Save record, your record will be written to the database, and the following page will appear:

Figure 11.5 – The template is rendered when the record is successfully inserted
Figure 11.5 – The template is rendered when the record is successfully inserted

With this, we have created our own CBV, which allows us to save records for new books. With our knowledge of CBVs in tow, let’s now look at how we can perform create, read, update, and delete (CRUD) operations with the help of CBVs.

CRUD operations with CBVs
While working with Django models, one of the most common patterns we run into involves creating, reading, updating, and deleting objects that are stored inside our database. The Django admin interface allows us to achieve these CRUD operations easily, but what if we wanted to build custom views to give us the same capability?

As it turns out, Django’s CBVs allow us to achieve this quite easily. All we need to do is to write our custom CBVs and inherit them from the built-in base classes provided by Django. Building on our existing example of book record management, let’s see how we can build CRUD-based views in Django.

The Create view
To build a view that helps in object creation, we’ll need to open the view.py file under the book_management directory and add the following lines of code to it:

from django.views.generic.edit import CreateView
from .models import Book
class BookCreateView(CreateView):
model = Book
    fields = ['name', 'author']
    template_name = 'book_form.html'
    success_url = '/book_management/entry_success'

Copy

Explain
With this, we created CreateView for the book resource. Before we can use it, we will need to map it to a URL. To do this, we can open the urls.py file and add the following entry under the urlpatterns list:

urlpatterns = [
    ….,
    path('book_record_create', BookCreateView.as_view(),
          name='book_create')
]

Copy

Explain
Now, when we visit http://localhost:8080/book_management/book_record_create, we will be greeted with the following page:

Figure 11.6 – A view to insert a new book record based on the Create view
Figure 11.6 – A view to insert a new book record based on the Create view

This looks similar to the one we got when using the form view. On filling in the data and clicking Save record, Django will save the data to the database.

The Read view
In this view, we want to see a list of records that our database stores for the books. To achieve this, we will build a view named DetailView, which will render details about the book we are requesting. To build this view, we can add the following lines of code to our views.py file under the book_management directory:

from django.views.generic import DetailView
class BookRecordDetailView(DetailView):
    model = Book
    template_name = 'book_detail.html'

Copy

Explain
In the preceding code snippet, we created DetailView, which will help us to render the details pertaining to the book ID we are asking for. DetailView internally queries our database model with the book ID we provide to it and, if a record is found, renders the template with the data stored inside the record by passing it as an object variable inside the template context.

Once this is done, the next step is to create the template for our book details. For this, we’ll need to create a new template file named book_detail.html under our templates directory inside the book_management application with the following contents:

<html>
<head>
  <title>Book List</title>
</head>
<body>
  <span>Book Name: {{ object.name }}</span><br />
  <span>Author: {{ object.author }}</span>
</body>
</html>

Copy

Explain
Now, with the template created, the last thing we need to do is to add a URL mapping for the Detail view. This can be done by appending the following to the urlpatterns list under the urls.py file of the book_management application:

path('book_record_detail/<int:pk>',
      BookRecordDetailView.as_view(), name='book_detail')

Copy

Explain
Now, with all of this configured, if we now open http://localhost:8080/book_management/book_record_detail/2, we will get to see the details about our book, as shown here:

Figure 11.7 – The view rendered when we try to access a previously stored book record
Figure 11.7 – The view rendered when we try to access a previously stored book record

With the preceding examples, we just enabled CRUD operations for our Book model, all while using CBVs.

The Update view
In this view, we want to update the data for a given record. To do this, we need to open the view.py file under the book_management directory and add the following lines of code to it:

from django.views.generic.edit import UpdateView
from .models import Book
class BookUpdateView(UpdateView):
    model = Book
    fields = ['name', 'author']
    template_name = 'book_form.html'
    success_url = '/book_management/entry_success'

Copy

Explain
In the preceding code snippet, we used the built-in UpdateView template, which allows us to update the stored records. Therefore fields attribute here should take in the name of the fields that we would like to allow the user to update.

Once the view is created, the next step is to add the URL mapping. To do this, open the urls.py file under the book_management directory and add the following lines of code:

urlpatterns = [
    path('book_record_update/<int:pk>',
          BookUpdateView.as_view(), name='book_update')
]

Copy

Explain
In this example, we appended <int:pk> to the URL field. This signifies the field input we will have to retrieve the record for. Inside Django models, Django inserts a primary key of the integer type, which uniquely identifies the records. Inside the URL mapping, this is the field that we asked to insert.

Now, when we try to open http://localhost:8080/book_management/book_record_update/1, it should show us a record of the first record that we inserted into our database and allow us to edit it:

Figure 11.8 – The view displaying the book record update template based on the Update view
Figure 11.8 – The view displaying the book record update template based on the Update view

The Delete view
The Delete view, as the name suggests, is a view that deletes the record from our database. To implement such a view for our Book model, we will need to open the views.py file under the book_management directory and add the following code snippet to it:

from django.views.generic.edit import DeleteView
from .models import Book
class BookDeleteView(DeleteView):
    model = Book
    template_name = 'book_delete_form.html'
    success_url = '/book_management/delete_success'

Copy

Explain
With this, we just created a Delete view for our book records. As we can see, this view uses a different template where all we would like to confirm from the user is whether they really want to delete the record or not. To achieve this, you can create a new template file, book_delete_form.html, and add the following code to it:

<html>
<head>
  <title>Delete Book Record</title>
</head>
<body>
  <p>Delete Book Record</p>
  <form method="POST">
    {% csrf_token %}
    Do you want to delete the book record?
    <input type="submit" value="Delete record" />
  </form>
</body>
</html>

Copy

Explain
Important note

For the code related to the /delete_success endpoint, take a look at the code files under the Chapter 11 directory on the book’s accompanying GitHub repository.

Then we can add a mapping for our delete view by modifying the urlpatterns list inside the urls.py file under the book_management directory as follows:

urlpatterns = [
    ….,
    path('book_record_delete/<int:pk>',
          BookDeleteView.as_view(), name='book_delete')
]

Copy

Explain
Now, when visiting http://localhost:8080/book_management/book_record_delete/1, we should be greeted with the following page:

Figure 11.9 – The Delete Book Record view based on the Delete view class
Figure 11.9 – The Delete Book Record view based on the Delete view class

Upon clicking the Delete record button, the record will be deleted from the database, and the Deletion success page will be rendered.

With our knowledge of the CRUD views and template filters and tags, let’s look into applying it to solve an implementation activity.

Activity 11.01 – Rendering details on the user profile page using inclusion tags
In this activity, you will create a custom inclusion tag that helps to develop a user profile page that renders not only the users’ details but also lists the books they have read.

The following steps should help you to complete this activity successfully:

Create a new templatetags directory under the reviews application inside the bookr project to provide a place where you can create your custom template tags.
Create a new file named profile_tags.py, which will store the code for your inclusion tag.
Inside the profile_tags.py file, import Django’s template library and use it to initialize an instance of the template library class.
Import the Review model from the reviews application to fetch the reviews written by a user. This will be used to filter the reviews for the current user to render on the user profile page.
Next, create a new Python function named book_list, which will contain the logic for your inclusion tag. This function should only take a single parameter, the username of the currently logged-in user.
Inside the body of the book_list function, add the logic for fetching the reviews for this user and extract the name of the books this user has read. Assume that a user has read all those books for which they have provided a review.
Decorate this book_list function with the inclusion_tag decorator and provide it with a template name book_list.html.
Create a new template file named book_list.html, which was specified to the inclusion tag decorator in step 7. Inside this file, add code to render a list of books. This can be done by using a for loop construct and rendering HTML list tags for every item inside the list provided.
Modify the existing profile.html file under the templates directory, which will be used to render the user profile. Inside this template file, include the custom template tag and use it to render the list of books read by the user.
Once you have completed all these steps, starting the application server and visiting the user profile page should render a page that is similar to the one shown in Figure 11.10:

Figure 11.10 – The user profile page with the list of books read by the user
Figure 11.10 – The user profile page with the list of books read by the user

Important note

The solution to this activity can be found on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

Summary
In this chapter, we learned about the advanced templating concepts in Django and understood how we can create custom template tags and filters to fit a myriad of use cases and support the reusability of components across the application. We then examined how Django provides us with the flexibility to implement FBVs and CBVs to render our responses.

While exploring CBVs, we learned how they can help us avoid code duplication and leverage the built-in CBVs to render forms that save data, help us update existing records, and implement CRUD operations on our database resources.

As we move to the next chapter, we will now utilize our knowledge of building CBVs to work on implementing REST APIs in Django. This will allow us to perform well-defined HTTP operations on our data inside our Bookr application without maintaining any state inside the application.



| ≪ [ 10 Advanced Django Admin and Customizations ](/packtpub/2024/422-web_development_with_django_2ed/10_advanced_django_admin_and_customizations) | 11 Advanced Templating and Class-Based Views | [ 12 Building a REST API ](/packtpub/2024/422-web_development_with_django_2ed/12_building_a_rest_api) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/422-web_development_with_django_2ed/11_advanced_templating_and_class-based_views
> (2) Markdown
> (3) Title: 11 Advanced Templating and Class-Based Views
> (4) Short Description: Publication date: May 2023 Publisher Packt Pages 764
> (5) tags: Django
> Book Title: 422-Web Development with Django 2ed
> Link: https://subscription.packtpub.com/book/web-development/9781803230603/pref
> create: 2024-05-08 수 14:11:52
> Images: /packtpub/2024/422-web_development_with_django_2ed_img/11/
> .md Name: 11_advanced_templating_and_class-based_views.md

