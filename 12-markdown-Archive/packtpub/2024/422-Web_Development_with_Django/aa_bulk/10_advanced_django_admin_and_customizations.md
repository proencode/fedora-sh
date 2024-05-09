
| ≪ [ 09 Sessions and Authentication ](/packtpub/2024/422-web_development_with_django_2ed/09_sessions_and_authentication) | 10 Advanced Django Admin and Customizations | [ 11 Advanced Templating and Class-Based Views ](/packtpub/2024/422-web_development_with_django_2ed/11_advanced_templating_and_class-based_views) ≫ |
|:----:|:----:|:----:|

# 10 Advanced Django Admin and Customizations



Book image


Advanced Django Admin and Customizations
Let’s say we want to customize the front page of a large organization’s admin site. We want to show the health of the different systems in the organization and see any high-priority alerts that are active. If this were an internal website built on top of Django, we would need to customize it. Adding these kinds of functionalities will require the developers in the IT team to customize the default admin panel and create their own custom AdminSite module, which will render a different index page in comparison to what is provided by the default admin site. Fortunately, Django makes these kinds of customizations easy.

In this chapter, we will look at how we can leverage Django’s framework and its extensibility to customize Django’s default admin interface (as shown in Figure 10.1). We’ll not just learn how to make the interface more personal; we will also learn how we can control the different aspects of the admin site to make Django load a custom admin site, instead of the one that ships with the default framework. Such customization can come in handy when we want to introduce features into the admin site that are not present by default:

Figure 10.1 – Default Django administration panel interface
Figure 10.1 – Default Django administration panel interface

This chapter builds upon the skills we practiced in Chapter 4, Introduction to Django Admin. Just to recap, we learned how to use the Django admin site to take control of the administration and authorization for our Bookr app. We also learned how to register models to read and edit their contents and also to customize Django’s admin interface using the admin.site properties.

The following topics are covered in this chapter:

Customizing the admin site
Adding views to the admin site
Now, let’s expand our knowledge further by taking a look at how we can start customizing the admin site by utilizing Django’s AdminSite module to add powerful new functionalities to the admin portal of our web application.

Technical requirements
The complete code files for this chapter can be found at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter10

Customizing the admin site
Django, as a web framework, provides a lot of customization options for building web applications. We will be using this same freedom provided by Django when we work on building the admin application for our project.

In Chapter 4, Introduction to Django Admin, we looked at how we can use the admin.site properties to customize the elements of Django’s admin interface. However, what if we require more control over how our admin site behaves? For example, what if we wanted to show a custom template for the login page or the logout page when the user comes to the Bookr admin panel? In this case, the admin.site properties provided might not be enough, and we will need to build customizations that can extend the default admin site’s behavior. Luckily, this can be easily achieved by extending the AdminSite class from Django’s admin module. However, before we jump into building our admin site, let’s first understand how Django discovers admin files and how we can use this admin file discovery mechanism to build a new app inside Django that will act as our admin site app.

Discovering admin files in Django
When we build applications in our Django project, we use the admin.py file frequently to register our models or create ModelAdmin classes that customize our interactions with the models inside the admin interface. These admin.py files store and provide this information to our project’s admin interface. The discovery of these files is affected automatically by Django once we add django.contrib.admin to the INSTALLED_APPS section inside our settings.py file:

Figure 10.2 – The Bookr application structure
Figure 10.2 – The Bookr application structure

As we can see in the preceding figure, we have an admin.py file under the reviews application directory that is used by Django to customize the admin site for Bookr.

When the admin application is added, it tries to find the admin module inside every app of the Django project we are working on, and if a module is found, the admin application loads the contents from it.

Django’s AdminSite class
Before we start customizing Django’s admin site, we must understand how the default admin site is generated and handled by Django.

To provide us with the default admin site, Django packages a module known as the admin module, which holds a class known as AdminSite. This class implements a lot of useful functionalities and intelligent defaults that the Django community considers important for implementing a useful administration panel for most Django websites. The default AdminSite class provides a lot of built-in properties that not only control the look and feel of how the default admin site is rendered in the web browser but also control the way we can interact with it, and how a particular interaction will result in an action.

Some of these defaults include the site template properties, such as text to be shown in the site header, text to be shown in the title bar of the web browser, integration with Django’s auth module for authenticating to the admin site, and a host of other properties.

As we progress on our path to building a custom admin site for our Django web project, it is more than desirable to retain a lot of the useful functionalities that are already built into Django’s AdminSite class. This is where the concepts of Python object-oriented programming come to our rescue.

As we start moving forward to create our custom admin site, we will try to leverage the existing useful set of functionalities that are provided by Django’s default AdminSite class. To do this, instead of building everything from scratch, we will work on creating a new child class that inherits from Django’s AdminSite class to leverage the existing set of functionalities and useful integration that Django already provides us with. This kind of approach allows us to focus on adding a new and useful set of functionalities to our custom admin site, rather than spending time implementing the basic set of functionalities from scratch. For example, the following code snippet shows how we can create a child class of Django’s AdminSite class:

class MyAdminSite(admin.AdminSite):
    …

Copy

Explain
To start working on our custom admin site for our web application, let’s start by overriding some of the basic properties of Django’s admin panel through the use of the custom AdminSite class we are going to work on.

Some of the properties that can be overridden include site_header, site_title, and others.

Note

When creating a custom admin site, we will have to register once again any Model and ModelAdmin classes that we might have registered using the default admin.site variable earlier. This happens because a custom admin site doesn’t inherit the instance details from the default admin site provided by Django, and so unless we re-register our Model and ModelAdmin interfaces, our custom admin site will not show them.

Now, with the knowledge of how Django discovers what to load into the admin interface and how we can start building our custom admin site, let’s go ahead and try to create our custom admin app for Bookr, which extends the existing admin module provided by Django. In the exercise that follows, we are going to create a custom admin site interface for our Bookr application using Django’s AdminSite class.

Exercise 10.01 – creating a custom admin site for Bookr
In this exercise, you will create a new application that extends the default Django admin site and allows you to customize the components of the interface. Consequently, you will customize the default title of Django’s admin panel. Once that is done, you will override the default value of Django’s admin.site property to point to your custom admin site:

Before you can start working on your custom admin site, you first need to make sure that you are in the correct directory in your project from where you can run your Django application’s management commands. For this, use the Terminal or Windows Command Prompt to navigate to the bookr directory and then create a new application named bookr_admin, which is going to act as the admin site for Bookr, by running the following commands:
python3 manage.py startapp bookr_admin

Copy

Explain
Once this command has been executed successfully, you should have a new directory named bookr_admin inside your project.

Now, with the default structure configured, the next step is to create a new class named BookrAdmin, which will extend the AdminSite class provided by Django to inherit the properties of the default admin site. To do this, open the admin.py file under the bookr_admin directory inside PyCharm. Once the file is open, you will see that the file already has the following code snippet present inside it:
from django.contrib import admin

Copy

Explain
Now, keeping this import statement as is, starting from the next line, create a new class named BookrAdmin, which inherits from the AdminSite class provided by the admin module you imported earlier:

class BookrAdmin(admin.AdminSite):

Copy

Explain
Inside this new BookrAdmin class, override the default value for the site_header variable, which is responsible for rendering the site header in Django’s admin panel by setting the site_header property, as shown next:

site_header = "Bookr Administration"

Copy

Explain
With this, the custom admin site class is now defined. To use this class, you will first create an instance of this class. This can be done as follows:

admin_site = BookrAdmin(name='bookr_admin')

Copy

Explain
Save the file but don’t close it yet; we’ll revisit it in step 5. Next, let’s edit the urls.py file in the bookr app.
With the custom class now defined, the next step is to modify the urlpatterns list to map the /admin endpoint in our project to the new AdminSite class you created. To do this, open the urls.py file under the Bookr project directory inside PyCharm and change the mapping of the admin/ endpoint to point to our custom site:
from bookr_admin.admin import admin_site
urlpatterns = [
    ….,
    path('admin/', admin_site.urls)
]

Copy

Explain
We first imported the admin_site object from the admin module of the bookr_admin app. Then, we used the urls property of the object to map to the admin/ endpoint in our application as follows:

path('admin/', admin_site.urls)

Copy

Explain
In this case, the urls property of our admin_site object is being automatically populated by the admin.AdminSite base class provided by Django’s admin module. Once complete, your urls.py file should look like this: https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter10/Exercise10.01/bookr/urls.py.

Now, with the configuration done, let’s run our admin app in the browser. For this, run the following command from the root of your project directory where the manage.py file is located:
python manage.py runserver localhost:8000

Copy

Explain
Then, navigate to http://localhost:8000/admin (or http://127.0.0.1:8000/admin), which opens a page that resembles the following screenshot:

Figure 10.3 – The home page view for the custom Bookr admin site
Figure 10.3 – The home page view for the custom Bookr admin site

In the preceding screenshot (Figure 10.3), you will see that Django displays a message, You don't have permission to view or edit anything. The issue of not having adequate permissions happens because, before now, we have not registered any models with our custom AdminSite instance. The issue also applies to the User and Groups models that are shipped along with the Django auth module. Now, let’s make our custom admin site a bit more useful by registering the User model from Django’s auth module.

To register the User model from Django’s auth module, open the admin.py file under the bookr_admin directory inside PyCharm, and add the following line at the top of the file:
from django.contrib.auth.admin import User

Copy

Explain
At the end of the file, use your BookrAdmin instance to register this model as follows:

admin_site.register(User)

Copy

Explain
By now, your admin.py file should look like this:

from django.contrib import admin
from django.contrib.auth.admin import User
class BookrAdmin(admin.AdminSite):
    site_header = "Bookr Administration"
admin_site = BookrAdmin(name='bookr_admin')
admin_site.register(User)

Copy

Explain
Once this is done, reload the web server and visit http://localhost:8000/admin. Now, you should be able to see the User model being displayed for editing inside the admin interface, as shown here:

Figure 10.4 – The home page view showing our registered models on the Bookr Administration site
Figure 10.4 – The home page view showing our registered models on the Bookr Administration site

With this, we just created our admin site application, and we can also now validate the fact that the custom site has a different header – Bookr Administration.

Overriding the default admin.site
In the previous section, after we created our own AdminSite application, we saw that we had to register models manually. This happens because most of the apps that we have built prior to our custom admin site still use the admin.site property to register their models, and if we want to use our AdminSite instance, we will have to update all those applications to use our instance, which can become cumbersome if there are a lot of applications inside a project.

Luckily, we can avoid this additional burden by overriding the default admin.site property. To do this, we first have to create a new AdminConfig class, which will override the default admin.site property for us, so that our application is marked as the default admin site and, hence, overrides the admin.site property inside our project. In the next exercise, we’ll look at how we can map our custom admin site as a default admin site for an application.

Exercise 10.02 – overriding the default admin site
In this exercise, you will use the AdminConfig class to override the default admin site for your project such that you can keep on using the default admin.site variable to register models, override site properties, and so on:

Open the admin.py file under the bookr_admin directory and remove the import for the User model and the BookrAdmin instance creation, which you wrote in step 5 of Exercise 10.01 – creating a custom admin site for Bookr. Once this is done, the file contents should resemble the following:
from django.contrib import admin
class BookrAdmin(admin.AdminSite):
    site_header = "Bookr Administration"

Copy

Explain
You will then need to create an AdminConfig class for the custom admin site, such that Django recognizes the BookrAdmin class as AdminSite and overrides the admin.site property. To do this, open up the apps.py file inside the bookr_admin directory and overwrite the contents of the file with the contents shown here:
from django.contrib.admin.apps import AdminConfig
class BookrAdminConfig(AdminConfig):
    default_site = 'bookr_admin.admin.BookrAdmin'

Copy

Explain
In this, we first imported the AdminConfig class from Django’s admin module. This class is used to define which application should be used as a default admin site and to override the default behavior of how Django’s admin site works.

For our use case, we create a class called BookrAdminConfig, which acts as a child class of Django’s AdminConfig class and overrides the default_site property to point to our BookrAdmin class, which is our custom admin site:

default_site = 'bookr_admin.admin.BookrAdmin'

Copy

Explain
Once this is done, we need to set our application as an admin application inside our Bookr project. To achieve this, open the settings.py file of the Bookr project, and under the INSTALLED_APPS section, replace 'reviews.apps.ReviewsAdminConfig' with 'bookr_admin.apps.BookrAdminConfig'. The settings.py file should look like this: https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter10/Exercise10.02/bookr/settings.py.

With the application mapped as the admin application, the final step involves modifying the URL mapping such that the 'admin/' endpoint uses the admin.site property to find the correct URL. For this, open the urls.py file under the bookr project. Consider the following entry in the urlpatterns list:
path('admin/', admin_site.urls)

Copy

Explain
Replace it with the following entry:

from django.contrib import admin
urlpatterns = [
    ....
    path('admin/', admin.site.urls)
]

Copy

Explain
Remember that admin_site.urls is a module, while admin.site is a Django internal property.

Once the preceding steps are complete, let’s reload our web server and check whether our admin site loads by visiting http://localhost:8000/admin. If the website that loads looks like the one shown here, we have our own custom admin app now being used for the admin interface:

Figure 10.5 – The home page view of the custom Bookr Administration site
Figure 10.5 – The home page view of the custom Bookr Administration site

As you can see, once we override admin.site with our admin app, the models that were registered earlier using the admin.site.register property start to show up automatically.

With this, we now have a custom base template, which we can now utilize to build the remainder of our Django admin customizations. As we work through the chapter, we will discover some interesting customizations that allow us to make the admin dashboard an integrated part of our application.

Customizing admin site text using AdminSite attributes
Just as we can use the admin.site properties to customize the text for our Django application, we can also use the attributes exposed by the AdminSite class to customize these texts. In Exercise 10.02 – overriding the default admin site, we took a look at updating the site_header property of the admin site. Similarly, there are many other properties we can modify. Some of the properties that can be overridden are described as follows:

site_header: Text to display at the top of every admin page (defaults to Django Administration).
site_title: Text to display in the title bar of the browser (defaults to Django Admin Site).
site_url: The link to use for the View Site option (defaults to /). This is overridden when the site runs on a custom path, and the redirection should take the user to the sub-path directly.
index_title: This is the text that should be shown on the index page of the admin application (defaults to Site administration).
Note

For more information on all the Adminsite attributes, refer to the official Django documentation at https://docs.djangoproject.com/en/4.1/ref/contrib/admin/#adminsite-attributes.

If we want to override these attributes in our custom admin site, the process is very simple, as shown next:

class MyAdminSite(admin.AdminSite):
    site_header = "My web application"
    site_title = "My Django Web application"
    index_title = "Administration Panel"

Copy

Explain
As we have seen in the examples so far, we have created a custom admin application for Bookr and then made it the default admin site for our project. An interesting question that arises is, since the properties that we have customized hitherto can also be customized by using the admin.site object directly, when should we create a custom admin application in comparison to modifying the admin.site properties?

As it turns out, there could be multiple reasons why someone would opt for a custom admin site – for example, they want to change the layout of the default admin site to make it align with the overall layout of their application. This is very common when you create a web application for a business where the homogeneity of the content is very important. Here is a short list of requirements that may compel a developer to go ahead and build a custom admin site, as opposed to simply modifying the properties of the admin.site variable:

A need to override the index template for the admin interface
A need to override the login or logout template
A need to add a custom view to the admin interface
Customizing admin site templates
Just like some of the customizable common texts, such as site_header and site_title, that appear across the admin site, Django also allows us to customize the templates, which are used to render different pages on the admin site by setting certain properties in the AdminSite class.

These customizations can include the modification of templates that are used to render the index page, login page, model data page, and more. These customizations can be easily done by leveraging the templating system provided by Django. For example, the following code snippet shows how we can add a new template to the Django admin dashboard:

{% extends "admin/base_site.html" %}
{% block content %}
  <!-- Template Content -->
{% endblock %}

Copy

Explain
In this custom template, there are a couple of important aspects that we need to understand.

When customizing the existing Django admin dashboard by modifying how certain pages inside the dashboard appear or by adding a new set of pages to the dashboard, a developer might not want to write every single piece of HTML again from scratch to maintain the basic look and feel of the Django admin dashboard.

Usually, while customizing the admin dashboard, we want to retain the layout in which Django organizes the different elements displayed on the dashboard such that we can focus on modifying parts of a page that matter to us. This basic layout of the page, along with the common page elements, such as the page header and page footer, are defined inside the Django admin’s base template, which also acts as a master template for all the pages inside the default Django admin website.

When we want to retain the way the common elements inside the Django admin pages are organized and rendered, we need to extend from this base template such that our custom template pages provide a consistent user experience in the same way as the other pages inside the Django admin dashboard. This can be done by using the template extension tags and extending the base_site.html template from the admin module provided by Django:

{% extends "admin/base_site.html" %}

Copy

Explain
Once this is done, the next task is to define our own content for the custom template. The base_site.html template provided by Django provides a block-based placeholder for a developer to add their own content for the template. To add this content, the developer has to put the logic for their own custom elements for the page inside the {% block content %} tags. This essentially overrides any content defined by the {% block content %} tag inside the base_site.html template, following the concepts of template inheritance in Django.

Now, let’s look at how we can customize the template, which is used to render the logout page, once the user clicks the Logout button in the admin panel.

Exercise 10.03 – customizing the logout template for the Bookr admin site
In this exercise, you are going to customize the template that is used to render the logout page once the user clicks the Logout button on the admin site. Such overrides can come in handy when a website developed for a banking user might want to redirect them to an instruction page once they click Logout, in order to show them instructions to make sure that their banking session is securely closed:

Under the templates directory that you should have created in the earlier chapters, create another directory named admin, which will be used for storing templates for your custom admin site.
Note

Before proceeding, make sure that the templates directory is added to the DIRS list in your settings.py file (under bookr/project).

Now, with the directory structure setup complete and Django configured to load the templates, the next step involves writing a custom logout template that you want to render. To do this, let’s create a new file named logout.html under the templates/admin directory we created in step 1 and add the following content beneath it:
{% extends "admin/base_site.html" %}
{% block content %}
<p>You have been logged out from the Admin panel.</p>
<p><a href="{% url 'admin:index' %}">Login Again</a>
or <a href="{{ site_url }}">Go to Home Page</a></p>
{% endblock %}

Copy

Explain
In the preceding code snippet, we are doing a couple of things. First, for our custom logout template, we are going to use the same master layout as provided by the django.contrib.admin module. So, consider the following:

{% extends "admin/base_site.html" %}

Copy

Explain
When we write this, Django tries to find and load the admin/base_site.html template inside the templates directory provided by the django.contrib.admin module.

Now, with our base template all set to be extended, the next thing we will do is try to override the HTML of the content block by executing the following command:

{% block content %}
…
{% endblock %}

Copy

Explain
The value of admin:index and site_url is provided by the AdminSite class automatically, based on the settings we define.

Using the value for admin:index and site_url, we will create our Login Again hyperlink, which, when clicked, will take the user back to the login form, and the Go to Home Page link, which will take the user back to the home page of the website. The file should look like this now: https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter10/Exercise10.03/templates/admin/logout.html.

Now, with the custom template defined, the next step is to make use of the custom template on our custom admin site. To do this, let’s open the admin.py file under the bookr_admin directory and add the following field as the final value in the BookrAdmin class:
logout_template = 'admin/logout.html'

Copy

Explain
Save the file. It should look like this: https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter10/Exercise10.03/bookr_admin/admin.py.

Once all the preceding steps are complete, let’s start our development server by running the following command:
python manage.py runserver localhost:8000

Copy

Explain
Then, we navigate to http://localhost:8000/admin.

Once you are there, try to log in and then click Logout. Once you are logged out, you will see the following page rendered:

Figure 10.6 – The logout view rendered to users after clicking the Logout button
Figure 10.6 – The logout view rendered to users after clicking the Logout button

With this, we have successfully overridden our first template. Similarly, we can also override other templates inside Django’s admin panel, such as the templates for the index view and the login form.

Adding views to the admin site
Just like general applications inside Django, which can have multiple views associated with them, Django allows developers to add custom views to the admin site also, which allows a developer to increase the scope of what the admin site interface can do.

The ability to add your own views to the admin site provides a lot of extensibility to the admin panel of the website, which can be leveraged for several additional use cases. For example, as we discussed at the start of the chapter, the IT team of a big organization can add a custom view to the admin site, which can then be used to monitor the health of the different IT systems at the organization, as well as provide the IT team with the ability to quickly look at any urgent alerts that need to be addressed.

Now, the next question we need to answer is, how can we add a custom view to the admin site?

As it turns out, adding a new view inside the admin template is quite easy and follows the same approach we used while creating views for our applications, with some minor modifications. So, let’s look at how we can add a new view to our Django admin dashboard.

Creating the view function
The first step to adding a new view to the Django application is to create a view function that implements the logic to handle the view. In the previous chapters, we created the view functions inside a separate file known as views.py, which was used to hold all our method- and class-based views.

In the context of adding a new view to the Django admin dashboard, to create a new view, we need to define a new view function inside our custom AdminSite class. For example, to add a new view that renders a page showing the health of the different IT systems inside an organization, we can create a new view function named system_health_dashboard() inside our custom AdminSite class implementation, as shown in the following code snippet:

class SysAdminSite(admin.AdminSite):
    def system_health_dashboard(self, request):
        # View function logic

Copy

Explain
Inside the view function, we can perform any operations we want in order to generate a view and, finally, use that response to render a template. Inside this view function, there are some important pieces of logic we need to make sure are implemented correctly.

The first one is to set the current_app property for the request field inside the view function. This is required in order to allow Django’s URL resolver inside the templates to correctly resolve the view functions for an application. To set this value inside the custom view function we just created, we need to set the current_app property, as shown in the following code snippet:

request.current_app = self.name

Copy

Explain
The self.name field is automatically populated by Django’s AdminSite class, and we don’t need to initialize it explicitly. With this, our minimal custom view implementation will appear, as shown in the following code snippet:

class SysAdminSite(admin.AdminSite):
    def system_health_dashboard(self, request):
        request.current_app = self.name
        # View function logic

Copy

Explain
Accessing common template variables
When creating a custom view function, we might want access to the common template variables, such as site_header and site_title, in order to render them correctly in the template associated with our view function. As it turns out, this is quite easy to achieve with the use of the each_context() method provided by the AdminSite class.

The each_context() method of the AdminSite class takes a single parameter, request, which is the current request context, and returns the template variables that are to be inserted in all the admin site templates.

For example, if we wanted to access the template variables inside our custom view function, we could implement code similar to the following code snippet:

def system_health_dashboard(self, request):
    request.current_app = self.name
    context = self.each_context(request)
    # view function logic

Copy

Explain
The value returned by the each_context() method is a dictionary containing the name of the variable and the associated value.

Mapping URLs for the custom view
Once the view function has been defined, the next step involves mapping this view function to a URL such that a user can access it or allow the other views to link to it. For the views defined inside AdminSite, this URL mapping to views is controlled by the get_urls() method implemented by the AdminSite class. The get_urls() method returns the urlpatterns list that maps to the AdminSite views.

If we want to add a URL mapping for our custom view, the preferred approach includes overriding the implementation of get_urls() in our custom AdminSite class and adding the URL mapping there. This approach is demonstrated in the following code snippet:

class SysAdminSite(admin.AdminSite):
    def get_urls(self):
        base_urls = super().get_urls(). # Get the existing
                                          set of URLs
        # Define our URL patterns for custom views
        urlpatterns = [
            path("health_dashboard/",
                  self.system_health_dashboard)
        ]
        return base_urls + urlpatterns. # Return the
                                          updated mapping

Copy

Explain
The get_urls() method is generally called automatically by Django, and there is no need to perform any manual processing on it.

Once this is done, the last step involves making sure that our custom admin view is only accessible through the admin site, and non-admin users should not be able to access it. Let’s take a look at how that can be achieved.

Restricting custom views to the admin site
If you followed all the previous headings thoroughly, you will now have a custom AdminSite view ready for use. However, there is a small glitch. This view is also directly accessible to any user who is not on the admin site.

To ensure that such a situation does not arise, we need to restrict this view to the admin site. This can be achieved quite simply by wrapping our URL path inside the admin_view() call, as shown in the following code snippet:

urlpatterns = [
    self.admin_view(path("health_dashboard/",
                          self.system_health_dashboard))
]

Copy

Explain
The admin_view function makes sure the path provided to it is restricted just to the admin dashboard and that no user without admin privileges can access it.

Now, let’s add a new custom view to our admin site.

Exercise 10.04 – adding custom views to the admin site
In this exercise, you will add a custom view to the admin site, which will render a user profile and will show the user the options to modify their email and add a new profile picture. To build this custom view, follow the steps described:

Open the admin.py file under the bookr_admin directory and add the following imports. These will be required to build our custom view inside the admin site application:
from django.template.response import TemplateResponse
from django.urls import path

Copy

Explain
Open the admin.py file under the bookr_admin directory and create a new method named profile_view, which takes in a request variable as its parameter, inside the BookrAdmin class:
def profile_view(self, request):

Copy

Explain
Next, inside the method, get the name of the current application and set that in the request context. For this, you can use the name property of the class, which is auto-populated by Django. To get this property and set it in your request context, you need to add the following line:

request.current_app = self.name

Copy

Explain
Once you have the application name populated to the request context, the next step is to fetch the template variables, which are required to render the contents, such as site_title and site_header, in the admin templates. For this, leverage the each_context() method of the AdminSite class, which provides the dictionary of the admin site template variables from the class:

context = self.each_context(request)

Copy

Explain
Once you have the data in place, the last step is to return a TemplateResponse object, which will render the custom profile template when someone visits the URL endpoint mapped to your custom view:

return TemplateResponse(request,
    "admin/admin_profile.html", context)

Copy

Explain
With the view function now created, the next step is to make AdminSite return the URLs mapping the view to a path inside AdminSite. To do this, you need to create a new method called get_urls(), which overrides the AdminSite.get_urls() method and returns the mapping of your new view. This can be done by first creating a new method named get_urls() inside the BookrAdmin class you have created for your custom admin site:
def get_urls(self):

Copy

Explain
Inside this method, the first thing you need to do is to get the list of the URLs that are already mapped to the admin endpoint. This is a required step; otherwise, your custom admin site will not be able to load any results associated with the model editing pages, logout page, and so on if this mapping is lost. To get this mapping, call the get_urls() method of the base class from which the BookrAdmin class is derived:

urls = super().get_urls()

Copy

Explain
Once the URLs from the base class have been captured, the next step is to create a list of URLs that map our custom view to a URL endpoint in the admin site. To do this, we will create a new list named url_patterns and map our profile_view method to the admin_profile endpoint. This is done by using the path utility function from Django, which allows us to map the view function with a string-based API endpoint path:

url_patterns = [
    path("admin_profile", self.profile_view)
]
return url_patterns + urls

Copy

Explain
Save the admin.py file. It should look like this: https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter10/Exercise10.04/bookr_admin/admin.py.

Note that the value returned by get_urls() is a non-modifiable list. In the preceding code snippet, if we try to switch the order between the merging of the url_patterns and urls objects, the method won’t work and the admin_profile URL won’t be created.

Now, with the BookrAdmin class configured for the new view, the next step is to create your template for the admin profile page. To do this, create a new file named admin_profile.html under the templates/admin directory of your project root. Inside this file, first, add an extends tag to make sure that you are extending from the default admin template:
{% extends "admin/index.html" %}

Copy

Explain
This step ensures that all of your admin template style sheets and HTML are available for use inside your custom view template. For example, without having this extends tag, your custom view will not show any specific content already mapped to the admin site, such as site_header, site_title, or any links to log out or go to another page.

Once the extends tag is added, add a block tag and provide it with the value of content. This makes sure that the code you add between the pair of {% block content %}…{% endblock %} segments overrides whatever value is present in the index.html template that comes prepackaged with the Django admin module:

{% block content %}

Copy

Explain
Inside the block tag, add the HTML required to render the profile view that was created in step 2 of this exercise:

<p>Welcome to your profile, {{ username }}</p>
<p>You can do the following operations</p>
<ul>
    <li><a href="#">Change E-Mail Address</a></li>
    <li><a href="#">Add Profile Picture</a></li>
</ul>
{% endblock %}

Copy

Explain
The file should now look like this: https://github.com//PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter10/Exercise10.04/templates/admin/admin_profile.html.

Now, with the preceding steps complete, reload your application server by running python manage.py runserver localhost:8000 and then visiting http://localhost:8000/admin/admin_profile.
When the page opens, you can expect to see something like the following screenshot:

Figure 10.7 – The profile page view on the Bookr Administration site
Figure 10.7 – The profile page view on the Bookr Administration site

Note

The view created so far will render just fine, irrespective of whether a user is logged into the admin application.

To make sure that this view is only accessible to logged-in admins, you need to make a small modification inside your get_urls() method, which you defined in step 2 of this exercise.

Inside the get_urls() method, modify the url_patterns list to look something like the one shown here:

url_patterns = [
    path("admin_profile",
          self.admin_view(self.profile_view)),
]

Copy

Explain
In the preceding code, you wrapped your profile_view method inside the admin_view() method.

The AdminSite.admin_view() method causes the view to be restricted to users who are logged in. If a user who is currently not logged into the admin site tries to visit the URL directly, they will be redirected to the login page, and only in the event of a successful login will they be allowed to see the contents of our custom page.

During this exercise, we leveraged our existing understanding of writing views for Django applications, merging it with the context of the AdminSite class to build a custom view for our admin dashboard. With this knowledge, we can now move on and add useful functionalities to our Django admin to supercharge its usefulness.

Passing additional keys to templates using template variables
Inside the admin site, the variable values passed to the templates are done so by using template variables. These template variables are prepared and returned by the AdminSite.each_context() method.

Now, if there is a value that you want to pass to all the templates of your admin site, you can override the AdminSite.each_context() method and add the required fields to the request context. Let’s look at an example to see how we can achieve this outcome.

Consider the username field, which we passed to our admin_profile template earlier. If we want to pass it to every template inside our custom admin site, we first need to override the each_context() method inside our BookrAdmin class, as shown here:

def each_context(self, request):
    context = super().each_context(request)
    context['username'] = request.user.username
    return context

Copy

Explain
The each_context() method takes a single argument (we’re not considering self here) of the HTTPRequest type, which it uses to evaluate certain other values.

Now, inside our overridden each_context() method, we first make a call to the base class each_context() method to retrieve the context dictionary for the admin site:

context = super().each_context(request)

Copy

Explain
Once that is done, the next thing to do is to add our username field to context and set its value to the value of the request.user.username field:

context['username'] = request.user.username

Copy

Explain
Once this is done, the last thing that remains is to return this modified context.

Now, whenever a template is rendered by our custom admin site, the template will be passed with this additional username variable.

Activity 10.01 – building a custom admin dashboard with a built-in search
In this activity, you will use the knowledge gained about the different aspects of creating a custom admin site to build a custom admin dashboard for Bookr. Inside this dashboard, you will introduce the capability of allowing a user to search for books, by using either the name of the book or the name of the book publisher and allowing the user to modify or delete these book records.

The following steps will help you build a custom admin dashboard and add the ability to search for a book record by the name of the publisher:

Create a new application inside the Bookr project named bookr_admin, if not created already. This is going to store the logic for our custom admin site.
Inside the admin.py file under the bookr_admin directory, create a new class, BookrAdmin, which inherits from the AdminSite class of Django’s admin module.
Inside the newly created BookrAdmin class from step 2, add any customizations for the site title or any other branding components of the admin dashboard.
Inside the apps.py file under the bookr_admin directory, create a new BookrAdminConfig class, and inside this new BookrAdminConfig class, set the default site attribute to the fully qualified module name for our custom admin site class, BookrAdmin.
Inside the settings.py file of your Django project, add the fully qualified path of the BookrAdminConfig class created in step 4 as the first installed application.
To register the Books model from the reviews application inside Bookr, open the admin.py file inside the reviews directory and make sure that the Books model is registered to the admin site by using admin.site.register(ModelClass).
To allow users to search for a book by the name of the publisher, inside the admin.py file of the reviews application, modify the BookAdmin class and add to it a property named search_fields, which contains publisher_name as a field.
To get the publisher’s name correctly for the search_fields property, introduce a new method named get_publisher inside the BookAdmin class, which will return the name field of the publisher from the Book model.
Make sure that the BookAdmin class is registered as a Model admin class for the Book model inside our Django admin dashboard by using admin.site.register(Book, BookModel).
After completing this activity, once you start the application server and visit http://localhost:8000/admin and navigate to the Book model, you should be able to search for books by using the publisher’s name and, in the event of a successful search, see a page that resembles the one shown in the following screenshot:

Figure 10.8 – The book editing page inside the Bookr Administration dashboard
Figure 10.8 – The book editing page inside the Bookr Administration dashboard

Note

The solution for this activity can be found on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions

Summary
In this chapter, we took a look at how Django allows the customization of its admin site, by providing easy-to-use properties for some of the more general parts of the site, such as title fields, headings, and home links. Beyond this, we learned how to build a custom admin site by leveraging the concepts of object-oriented programming in Python and creating a child class of AdminSite.

This functionality was further enhanced by implementing a custom template for the logout page. We also learned how we can supercharge our admin dashboard by adding a new set of views to allow enhanced usage of the dashboard.

As we move on to the next chapter, we will get to build upon what we have learned thus far and extend that knowledge by being introduced to the concept of building our own custom tags and filters for templates, as well as the ability to build our views in an object-oriented style using the concept of class-based views.



| ≪ [ 09 Sessions and Authentication ](/packtpub/2024/422-web_development_with_django_2ed/09_sessions_and_authentication) | 10 Advanced Django Admin and Customizations | [ 11 Advanced Templating and Class-Based Views ](/packtpub/2024/422-web_development_with_django_2ed/11_advanced_templating_and_class-based_views) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/422-web_development_with_django_2ed/10_advanced_django_admin_and_customizations
> (2) Markdown
> (3) Title: 10 Advanced Django Admin and Customizations
> (4) Short Description: Publication date: May 2023 Publisher Packt Pages 764
> (5) tags: Django
> Book Title: 422-Web Development with Django 2ed
> Link: https://subscription.packtpub.com/book/web-development/9781803230603/pref
> create: 2024-05-08 수 14:11:52
> Images: /packtpub/2024/422-web_development_with_django_2ed_img/10/
> .md Name: 10_advanced_django_admin_and_customizations.md

