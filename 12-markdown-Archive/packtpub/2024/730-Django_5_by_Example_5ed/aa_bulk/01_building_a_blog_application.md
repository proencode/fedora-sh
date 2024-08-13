
| ≪ [ 00 Preface ](/packtpub/2024/730_Django_5_by_Example/00_Preface) | 01 Building a Blog Application | [ 02 Enhancing Your Blog and Adding Social Features ](/packtpub/2024/730_Django_5_by_Example/02_Enhancing_Your_Blog_and_Adding_Social_Features) ≫ |
|:----:|:----:|:----:|

# 01 Building a Blog Application

Building a Blog Application
In this book, you will learn how to build professional-grade web projects using Django. This initial chapter will guide you through the essential building blocks of a Django application, from installation to deployment. If you haven’t set up Django on your machine yet, the Installing Django section will walk you through the installation process.

Before starting our first Django project, let’s go over what you are about to learn. This chapter will give you a general overview of the framework. It will guide you through the different major components to create a fully functional web application: models, templates, views, and URLs. You will gain an understanding of how Django works and how the different framework components interact.

You will also learn the difference between Django projects and applications, and you will learn about the most important Django settings. You will build a simple blog application that allows users to navigate through all published posts and read individual posts. You will also create a simple administration interface to manage and publish posts. In the next two chapters, you will extend the blog application with more advanced functionalities.

Consider this chapter as your roadmap for constructing a fully-fledged Django application. Don’t be concerned if some components or concepts appear unclear at first. The different framework components will be explored in detail throughout this book.

This chapter will cover the following topics:

Installing Python
Creating a Python virtual environment
Installing Django
Creating and configuring a Django project
Building a Django application
Designing data models
Creating and applying model migrations
Setting up an administration site for your models
Working with QuerySets and model managers
Building views, templates, and URLs
Understanding the Django request/response cycle
You will start by installing Python on your machine.

The source code for this chapter can be found at https://github.com/PacktPublishing/Django-5-by-example/tree/main/Chapter01.

All Python packages used in this chapter are included in the requirements.txt file in the source code for the chapter. You can follow the instructions to install each Python package in the following sections, or you can install all the requirements at once with the command python -m pip install -r requirements.txt.

Installing Python
Django 5.0 supports Python 3.10, 3.11, and 3.12. In the examples in this book, we will use Python 3.12.

If you’re using Linux or macOS, you probably have Python installed. If you’re using Windows, you can download a Python installer from the python.org website. You can download Python for your OS from https://www.python.org/downloads/.

Open the command-line shell prompt of your machine. If you are using macOS, press Command + spacebar to open Spotlight and write Terminal to open Terminal.app. If you are using Windows, open the Start menu and type powers into the search box. Then, click on the Windows PowerShell application to open it. Alternatively, you can use the more basic command prompt by typing cmd into the search box and clicking on the Command Prompt application to open it.

Verify that Python 3 is installed on your machine by typing the following command in the shell prompt:

python3 --version

Copy

Explain
If you see the following, then Python 3 is installed on your computer:

Python 3.12.3

Copy

Explain
If you get an error, try the python command instead of python3. If you use Windows, it’s recommended that you replace python with the py command.

If your installed Python version is lower than 3.12, or if Python is not installed on your computer, download Python 3.12 from https://www.python.org/downloads/ and follow the instructions to install it. On the download site, you can find Python installers for Windows, macOS, and Linux.

Throughout this book, when Python is referenced in the shell prompt, we will use the python command, though some systems may require using python3. If you are using Linux or macOS and your system’s Python is Python 2, you will need to use python3 to use the Python 3 version you installed. Note that Python 2 reached end-of-life in January 2020 and shouldn’t be used anymore.

In Windows, python is the Python executable of your default Python installation, whereas py is the Python launcher. The Python launcher for Windows was introduced in Python 3.3. It detects what Python versions are installed on your machine and it automatically delegates to the latest version.

If you use Windows, you should use the py command. You can read more about the Windows Python launcher at https://docs.python.org/3/using/windows.html#launcher.

Next, you are going to create a Python environment for your project and install the necessary Python libraries.

Creating a Python virtual environment
When you write Python applications, you will usually use packages and modules that are not included in the standard Python library. You may have Python applications that require a different version of the same module. However, only a specific version of a module can be installed system-wide. If you upgrade a module version for an application, you might end up breaking other applications that require an older version of that module.

To address this issue, you can use Python virtual environments. With virtual environments, you can install Python modules in an isolated location rather than installing them system-wide. Each virtual environment has its own Python binary and can have its own independent set of installed Python packages in its site-packages directory.

Since version 3.3, Python comes with the venv library, which provides support for creating lightweight virtual environments. By using the Python venv module to create isolated Python environments, you can use different package versions for different projects. Another advantage of using venv is that you won’t need any administrative privileges to install Python packages.

If you are using Linux or macOS, create an isolated environment with the following command:

python -m venv my_env

Copy

Explain
Remember to use python3 instead of python if your system comes with Python 2 and you installed Python 3.

If you are using Windows, use the following command instead:

py -m venv my_env

Copy

Explain
This will use the Python launcher in Windows.

The previous command will create a Python environment in a new directory named my_env. Any Python libraries you install while your virtual environment is active will go into the my_env/lib/python3.12/site-packages directory.

If you are using Linux or macOS, run the following command to activate your virtual environment:

source my_env/bin/activate

Copy

Explain
If you are using Windows, use the following command instead:

.\my_env\Scripts\activate

Copy

Explain
The shell prompt will include the name of the active virtual environment enclosed in parentheses, like this:

(my_env) zenx@pc:~ zenx$

Copy

Explain
You can deactivate your environment at any time with the deactivate command. You can find more information about venv at https://docs.python.org/3/library/venv.html.

Installing Django
If you have already installed Django 5.0, you can skip this section and jump directly to the Creating your first project section.

Django comes as a Python module and thus can be installed in any Python environment. If you haven’t installed Django yet, the following is a quick guide to installing it on your machine.

Installing Django with pip
The pip package management system is the preferred method of installing Django. Python 3.12 comes with pip preinstalled, but you can find pip installation instructions at https://pip.pypa.io/en/stable/installation/.

Run the following command at the shell prompt to install Django with pip:

python -m pip install Django~=5.0.4

Copy

Explain
This will install Django’s latest 5.0 version in the Python site-packages directory of your virtual environment.

Now we will check whether Django has been successfully installed. Run the following command in a shell prompt:

python -m django --version

Copy

Explain
If you get an output that starts with 5.0, Django has been successfully installed on your machine. If you get the message No module named Django, Django is not installed on your machine. If you have issues installing Django, you can review the different installation options described at https://docs.djangoproject.com/en/5.0/intro/install/.

All Python packages used in this chapter are included in the requirements.txt file in the source code for the chapter, mentioned above. You can follow the instructions to install each Python package in the following sections, or you can install all requirements at once with the command pip install -r requirements.txt.

Django overview
Django is a framework consisting of a set of components that solve common web development problems. Django components are loosely coupled, which means they can be managed independently. This helps separate the responsibilities of the different layers of the framework; the database layer knows nothing about how the data is displayed, the template system knows nothing about web requests, and so on.

Django offers maximum code reusability by following the DRY (don’t repeat yourself) principle. Django also fosters rapid development and allows you to use less code by taking advantage of Python’s dynamic capabilities, such as introspection.

You can read more about Django’s design philosophies at https://docs.djangoproject.com/en/5.0/misc/design-philosophies/.

Main framework components
Django follows the MTV (Model-Template-View) pattern. It is a slightly similar pattern to the well-known MVC (Model-View-Controller) pattern, where the template acts as the view and the framework itself acts as the controller.

The responsibilities in the Django MTV pattern are divided as follows:

Model: This defines the logical data structure and is the data handler between the database and the view.
Template: This is the presentation layer. Django uses a plain-text template system that keeps everything that the browser renders.
View: This communicates with the database via the model and transfers the data to the template for viewing.
The framework itself acts as the controller. It sends a request to the appropriate view, according to the Django URL configuration.

When developing any Django project, you will always work with models, views, templates, and URLs. In this chapter, you will learn how they fit together.

The Django architecture
Figure 1.1 shows how Django processes requests and how the request/response cycle is managed with the different main Django components – URLs, views, models, and templates:

Diagram

Description automatically generated
Figure 1.1: The Django architecture

This is how Django handles HTTP requests and generates responses:

A web browser requests a page by its URL and the web server passes the HTTP request to Django.
Django runs through its configured URL patterns and stops at the first one that matches the requested URL.
Django executes the view that corresponds to the matched URL pattern.
The view potentially uses data models to retrieve information from the database.
Data models provide data definitions and behaviors. They are used to query the database.
The view renders a template (usually HTML) to display the data and returns it with an HTTP response.
We will get back to the Django request/response cycle at the end of this chapter in the The request/response cycle section.

Django also includes hooks in the request/response process, which are called middleware. Middleware has been intentionally left out of this diagram for the sake of simplicity. You will use middleware in different examples of this book, and you will learn how to create custom middleware in Chapter 17, Going Live.

We have covered the foundational elements of Django and how it processes requests. Let’s explore the new features introduced in Django 5.

New features in Django 5
Django 5 introduces several key features that you will use in the examples of this book. This version also deprecates certain features and eliminates previously deprecated functionalities. Django 5.0 presents the following new major features:

Facet filters in the administration site: Facet filters can be added now to the administration site. When enabled, facet counts are displayed for applied filters in the admin object list. This feature is presented in the Added facet counts to filters section of this chapter.
Simplified templates for form field rendering: Form field rendering has been simplified with the capability to define field groups with associated templates. This aims to make the process of rendering related elements of a Django form field, such as labels, widgets, help text, and errors, more streamlined. An example of using field groups can be found in the Creating templates for the comment form section of Chapter 2, Enhancing Your Blog and Adding Social Features.
Database-computed default values: Django adds database-computed default values. An example of this feature is presented in the Adding datetime fields section of this chapter.
Database-generated model fields: This is a new type of field that enables you to create database-generated columns. An expression is used to automatically set the field value each time the model is changed. The field value is set using the GENERATED ALWAYS SQL syntax.
More options for declaring model field choices: Fields that support choices no longer require accessing the .choices attribute to access enumeration types. A mapping or callable instead of an iterable can be used directly to expand enumeration types. Choices with enumeration types in this book have been updated to reflect these changes. An instance of this can be found in the Adding a status field section of this chapter.
Django 5 also comes with some improvements in asynchronous support. Asynchronous Server Gateway Interface (ASGI) support was first introduced in Django 3 and improved in Django 4.1 with asynchronous handlers for class-based views and an asynchronous ORM interface. Django 5 adds asynchronous functions to the authentication framework, provides support for asynchronous signal dispatching, and adds asynchronous support to multiple built-in decorators.

Django 5.0 drops support for Python 3.8 and 3.9.

You can read the complete list of changes in the Django 5.0 release notes at https://docs.djangoproject.com/en/5.0/releases/5.0/.

As a time-based release, there are no drastic changes in Django 5, making it straightforward to upgrade Django 4 applications to the 5.0 release.

If you want to quickly upgrade an existing Django project to the 5.0 release, you can use the django-upgrade tool. This package rewrites the files of your project by applying fixers up to a target version. You can find instructions to use django-upgrade at https://github.com/adamchainz/django-upgrade.

The django-upgrade tool is inspired by the pyupgrade package. You can use pyupgrade to automatically upgrade syntax for newer versions of Python. You can find more information about pyupgrade at https://github.com/asottile/pyupgrade.

Creating your first project
Your first Django project will consist of a blog application. This will offer you a solid introduction to Django’s capabilities and functionalities.

Blogging is the perfect starting point to build a complete Django project, given its wide range of required features, from basic content management to advanced functionalities like commenting, post sharing, search, and post recommendations. The blog project will be covered in the first three chapters of this book.

In this chapter, we will start by creating the Django project and a Django application for the blog. We will then create our data models and synchronize them to the database. Finally, we will create an administration site for the blog, and we will build the views, templates, and URLs.

Figure 1.2 shows a representation of the blog application pages that you will create:


Figure 1.2: Diagram of functionalities built in Chapter 1

The blog application will consist of a list of posts including the post title, publishing date, author, a post excerpt, and a link to read the post. The post list page will be implemented with the post_list view. You will learn how to create views in this chapter.

When readers click on the link of a post in the post list page, they will be redirected to a single (detail) view of a post. The detail view will display the title, publishing date, author, and the complete post body.

Let’s start by creating the Django project for our blog. Django provides a command that allows you to create an initial project file structure.

Run the following command in your shell prompt:

django-admin startproject mysite

Copy

Explain
This will create a Django project with the name mysite.

Avoid naming projects after built-in Python or Django modules in order to prevent conflicts.

Let’s take a look at the generated project structure:

mysite/
    manage.py
    mysite/
      __init__.py
      asgi.py
      settings.py
      urls.py
      wsgi.py

Copy

Explain
The outer mysite/ directory is the container for our project. It contains the following files:

manage.py: This is a command-line utility used to interact with your project. You won’t usually need to edit this file.
mysite/: This is the Python package for your project, which consists of the following files:
__init__.py: An empty file that tells Python to treat the mysite directory as a Python module.
asgi.py: This is the configuration to run your project as an ASGI application with ASGI-compatible web servers. ASGI is the emerging Python standard for asynchronous web servers and applications.
settings.py: This indicates settings and configuration for your project and contains initial default settings.
urls.py: This is the place where your URL patterns live. Each URL defined here is mapped to a view.
wsgi.py: This is the configuration to run your project as a Web Server Gateway Interface (WSGI) application with WSGI-compatible web servers.
Applying initial database migrations
Django applications require a database to store data. The settings.py file contains the database configuration for your project in the DATABASES setting. The default configuration is a SQLite3 database. SQLite comes bundled with Python 3 and can be used in any of your Python applications. SQLite is a lightweight database that you can use with Django for development. If you plan to deploy your application in a production environment, you should use a full-featured database, such as PostgreSQL, MySQL, or Oracle. You can find more information about how to get your database running with Django at https://docs.djangoproject.com/en/5.0/topics/install/#database-installation.

Your settings.py file also includes a list named INSTALLED_APPS that contains common Django applications that are added to your project by default. We will go through these applications later in the Project settings section.

Django applications contain data models that are mapped to database tables. You will create your own models in the Creating the blog data models section. To complete the project setup, you need to create the tables associated with the models of the default Django applications included in the INSTALLED_APPS setting. Django comes with a system that helps you manage database migrations.

Open the shell prompt and run the following commands:

cd mysite
python manage.py migrate

Copy

Explain
You will see an output that ends with the following lines:

Applying contenttypes.0001_initial... OK
Applying auth.0001_initial... OK
Applying admin.0001_initial... OK
Applying admin.0002_logentry_remove_auto_add... OK
Applying admin.0003_logentry_add_action_flag_choices... OK
Applying contenttypes.0002_remove_content_type_name... OK
Applying auth.0002_alter_permission_name_max_length... OK
Applying auth.0003_alter_user_email_max_length... OK
Applying auth.0004_alter_user_username_opts... OK
Applying auth.0005_alter_user_last_login_null... OK
Applying auth.0006_require_contenttypes_0002... OK
Applying auth.0007_alter_validators_add_error_messages... OK
Applying auth.0008_alter_user_username_max_length... OK
Applying auth.0009_alter_user_last_name_max_length... OK
Applying auth.0010_alter_group_name_max_length... OK
Applying auth.0011_update_proxy_permissions... OK
Applying auth.0012_alter_user_first_name_max_length... OK
Applying sessions.0001_initial... OK

Copy

Explain
The preceding lines are the database migrations that are applied by Django. By applying the initial migrations, the tables for the applications listed in the INSTALLED_APPS setting are created in the database.

You will learn more about the migrate management command in the Creating and applying migrations section of this chapter.

Running the development server
Django comes with a lightweight web server to run your code quickly, without needing to spend time configuring a production server. When you run the Django development server, it keeps checking for changes in your code. It reloads automatically, freeing you from manually reloading it after code changes. However, it might not notice some actions, such as adding new files to your project, so you will have to restart the server manually in these cases.

Start the development server by typing the following command in the shell prompt:

python manage.py runserver

Copy

Explain
You should see something like this:

Watching for file changes with StatReloader
Performing system checks...
System check identified no issues (0 silenced).
January 01, 2024 - 10:00:00
Django version 5.0, using settings 'mysite.settings'
Starting development server at http://127.0.0.1:8000/
Quit the server with CONTROL-C.

Copy

Explain
Now, open http://127.0.0.1:8000/ in your browser. You should see a page stating that the project is successfully running, as shown in Figure 1.3:


Figure 1.3: The default page of the Django development server

The preceding screenshot indicates that Django is running. If you take a look at your console, you will see the GET request performed by your browser:

[01/Jan/2024 10:00:15] "GET / HTTP/1.1" 200 16351

Copy

Explain
Each HTTP request is logged in the console by the development server. Any error that occurs while running the development server will also appear in the console.

You can run the Django development server on a custom host and port or tell Django to load a specific settings file, as follows:

python manage.py runserver 127.0.0.1:8001 --settings=mysite.settings

Copy

Explain
When you have to deal with multiple environments that require different configurations, you can create a different settings file for each environment.

This server is only intended for development and is not suitable for production use. To deploy Django in a production environment, you should run it as a WSGI application using a web server, such as Apache, Gunicorn, or uWSGI, or as an ASGI application using a server such as Daphne or Uvicorn. You can find more information on how to deploy Django with different web servers at https://docs.djangoproject.com/en/5.0/howto/deployment/wsgi/.

Chapter 17, Going Live, explains how to set up a production environment for your Django projects.

Project settings
Let’s open the settings.py file and take a look at the configuration of the project. There are several settings that Django includes in this file, but these are only part of all the available Django settings. You can see all the settings and their default values at https://docs.djangoproject.com/en/5.0/ref/settings/.

Let’s review some of the project settings:

DEBUG is a Boolean that turns the debug mode of the project on and off. If it is set to True, Django will display detailed error pages when an uncaught exception is thrown by your application. When you move to a production environment, remember that you have to set it to False. Never deploy a site into production with DEBUG turned on because you will expose sensitive project-related data.
ALLOWED_HOSTS is not applied while debug mode is on or when the tests are run. Once you move your site to production and set DEBUG to False, you will have to add your domain/host to this setting to allow it to serve your Django site.
INSTALLED_APPS is a setting you will have to edit for all projects. This setting tells Django which applications are active for this site. By default, Django includes the following applications:
django.contrib.admin: An administration site.
django.contrib.auth: An authentication framework.
django.contrib.contenttypes: A framework for handling content types.
django.contrib.sessions: A session framework.
django.contrib.messages: A messaging framework.
django.contrib.staticfiles: A framework for managing static files, such as CSS, JavaScript files, and images.
MIDDLEWARE is a list that contains middleware to be executed.
ROOT_URLCONF indicates the Python module where the root URL patterns of your application are defined.
DATABASES is a dictionary that contains the settings for all the databases to be used in the project. There must always be a default database. The default configuration uses a SQLite3 database.
LANGUAGE_CODE defines the default language code for this Django site.
USE_TZ tells Django to activate/deactivate timezone support. Django comes with support for timezone-aware datetimes. This setting is set to True when you create a new project using the startproject management command.
Don’t worry if you don’t understand much about what you’re seeing here. You will learn more about the different Django settings in the following chapters.

Projects and applications
Throughout this book, you will encounter the terms project and application over and over. In Django, a project is considered a Django installation with some settings. An application is a group of models, views, templates, and URLs. Applications interact with the framework to provide specific functionalities and may be reused in various projects. You can think of a project as your website, which contains several applications, such as a blog, wiki, or forum, that can also be used by other Django projects.

Figure 1.4 shows the structure of a Django project:


Figure 1.4: The Django project/application structure

Creating an application
Let’s create our first Django application. We will build a blog application from scratch.

Run the following command in the shell prompt from the project’s root directory:

python manage.py startapp blog

Copy

Explain
This will create the basic structure of the application, which will look like this:

blog/
    __init__.py
    admin.py
    apps.py
    migrations/
        __init__.py
    models.py
    tests.py
    views.py

Copy

Explain
These files are as follows:

__init__.py: This is an empty file that tells Python to treat the blog directory as a Python module.
admin.py: This is where you register models to include them in the Django administration site—using this site is optional.
apps.py: This includes the main configuration of the blog application.
migrations: This directory will contain database migrations of the application. Migrations allow Django to track your model changes and synchronize the database accordingly. This directory contains an empty __init__.py file.
models.py: This includes the data models of your application; all Django applications need to have a models.py file but it can be left empty.
tests.py: This is where you can add tests for your application.
views.py: The logic of your application goes here; each view receives an HTTP request, processes it, and returns a response.
With the application structure ready, we can start building the data models for the blog.

Creating the blog data models
Remember that a Python object is a collection of data and methods. Classes are the blueprint for bundling data and functionality together. Creating a new class creates a new type of object, allowing you to create instances of that type.

A Django model is a source of information about the behaviors of your data. It consists of a Python class that subclasses django.db.models.Model. Each model maps to a single database table, where each attribute of the class represents a database field.

When you create a model, Django will provide you with a practical API to query objects in the database easily.

We will define the database models for our blog application. Then, we will generate the database migrations for the models to create the corresponding database tables. When applying the migrations, Django will create a table for each model defined in the models.py file of the application.

Creating the Post model
First, we will define a Post model that will allow us to store blog posts in the database.

Add the following lines to the models.py file of the blog application. The new lines are highlighted in bold:

from django.db import models
class Post(models.Model):
    title = models.CharField(max_length=250)
    slug = models.SlugField(max_length=250)
    body = models.TextField()
    def __str__(self):
        return self.title

Copy

Explain
This is the data model for blog posts. Posts will have a title, a short label called slug, and a body. Let’s take a look at the fields of this model:

title: This is the field for the post title. This is a CharField field that translates into a VARCHAR column in the SQL database.
slug: This is a SlugField field that translates into a VARCHAR column in the SQL database. A slug is a short label that contains only letters, numbers, underscores, or hyphens. A post with the title Django Reinhardt: A legend of Jazz could have a slug like django-reinhardt-legend-jazz. We will use the slug field to build beautiful, SEO-friendly URLs for blog posts in Chapter 2, Enhancing Your Blog with Advanced Features.
body: This is the field for storing the body of the post. This is a TextField field that translates into a TEXT column in the SQL database.
We have also added a __str__() method to the model class. This is the default Python method to return a string with the human-readable representation of the object. Django will use this method to display the name of the object in many places, such as the Django administration site.

Let’s take a look at how the model and its fields will be translated into a database table and columns. The following diagram shows the Post model and the corresponding database table that Django will create when we synchronize the model to the database:


Figure 1.5: Initial Post model and database table correspondence

Django will create a database column for each of the model fields: title, slug, and body. You can see how each field type corresponds to a database data type.

By default, Django adds an auto-incrementing primary key field to each model. The field type for this field is specified in each application configuration or globally in the DEFAULT_AUTO_FIELD setting. When creating an application with the startapp command, the default value for DEFAULT_AUTO_FIELD is BigAutoField. This is a 64-bit integer that automatically increments according to available IDs. If you don’t specify a primary key for your model, Django adds this field automatically. You can also define one of the model fields to be the primary key by setting primary_key=True on it.

We will expand the Post model with additional fields and behaviors. Once complete, we will synchronize it to the database by creating a database migration and applying it.

Adding datetime fields
We will continue by adding different datetime fields to the Post model. Each post will be published at a specific date and time. Therefore, we need a field to store the publication date and time. We also want to store the date and time when the Post object was created and when it was last modified.

Edit the models.py file of the blog application to make it look like this; the new lines are highlighted in bold:

from django.db import models
from django.utils import timezone
class Post(models.Model):
    title = models.CharField(max_length=250)
    slug = models.SlugField(max_length=250)
    body = models.TextField()
    publish = models.DateTimeField(default=timezone.now)
    def __str__(self):
        return self.title

Copy

Explain
We have added a publish field to the Post model. This is a DateTimeField field that translates into a DATETIME column in the SQL database. We will use it to store the date and time when the post was published. We use Django’s timezone.now method as the default value for the field. Note that we imported the timezone module to use this method. timezone.now returns the current datetime in a timezone-aware format. You can think of it as a timezone-aware version of the standard Python datetime.now method.

Another method to define default values for model fields is using database-computed default values. Introduced in Django 5, this feature allows you to use underlaying database functions to generate default values. For instance, the following code uses the database server’s current date and time as the default for the publish field:

from django.db import models
from django.db.models.functions import Now
class Post(models.Model):
    # ...
    publish = models.DateTimeField(db_default=Now())

Copy

Explain
To use database-generated default values, we use the db_default attribute instead of default. In this example, we use the Now database function. It serves a similar purpose to default=timezone.now, but instead of a Python-generated datetime, it uses the NOW() database function to produce the initial value. You can read more about the db_default attribute at https://docs.djangoproject.com/en/5.0/ref/models/fields/#django.db.models.Field.db_default. You can find all available database functions at https://docs.djangoproject.com/en/5.0/ref/models/database-functions/.

Let’s continue with the previous version of the field:

class Post(models.Model):
    # ...
    publish = models.DateTimeField(default=timezone.now)

Copy

Explain
Edit the models.py file of the blog application and add the following lines highlighted in bold:

from django.db import models
from django.utils import timezone
class Post(models.Model):
    title = models.CharField(max_length=250)
    slug = models.SlugField(max_length=250)
    body = models.TextField()
    publish = models.DateTimeField(default=timezone.now)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    def __str__(self):
        return self.title

Copy

Explain
We have added the following fields to the Post model:

created: This is a DateTimeField field. We will use it to store the date and time when the post was created. By using auto_now_add, the date will be saved automatically when creating an object.
updated: This is a DateTimeField field. We will use it to store the last date and time when the post was updated. By using auto_now, the date will be updated automatically when saving an object.
Utilizing the auto_now_add and auto_now datetime fields in your Django models is highly beneficial for tracking the creation and last modification times of objects.

Defining a default sort order
Blog posts are typically presented in reverse chronological order, showing the newest posts first. For our model, we will define a default ordering. This ordering takes effect when retrieving objects from the database unless a specific order is indicated in the query.

Edit the models.py file of the blog application as shown below. The new lines are highlighted in bold:

from django.db import models
from django.utils import timezone
class Post(models.Model):
    title = models.CharField(max_length=250)
    slug = models.SlugField(max_length=250)
    body = models.TextField()
    publish = models.DateTimeField(default=timezone.now)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    class Meta:
        ordering = ['-publish']
    def __str__(self):
        return self.title

Copy

Explain
We have added a Meta class inside the model. This class defines metadata for the model. We use the ordering attribute to tell Django that it should sort results by the publish field. This ordering will apply by default for database queries when no specific order is provided in the query. We indicate descending order by using a hyphen before the field name, -publish. Posts will be returned in reverse chronological order by default.

Adding a database index
Let’s define a database index for the publish field. This will improve performance for query filtering or ordering results by this field. We expect many queries to take advantage of this index since we are using the publish field to order results by default.

Edit the models.py file of the blog application and make it look like this; the new lines are highlighted in bold:

from django.db import models
from django.utils import timezone
class Post(models.Model):
    title = models.CharField(max_length=250)
    slug = models.SlugField(max_length=250)
    body = models.TextField()
    publish = models.DateTimeField(default=timezone.now)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    class Meta:
        ordering = ['-publish']
        indexes = [
            models.Index(fields=['-publish']),
        ]
    def __str__(self):
        return self.title

Copy

Explain
We have added the indexes option to the model’s Meta class. This option allows you to define database indexes for your model, which could comprise one or multiple fields, in ascending or descending order, or functional expressions and database functions. We have added an index for the publish field. We use a hyphen before the field name to define the index specifically in descending order. The creation of this index will be included in the database migrations that we will generate later for our blog models.

Index ordering is not supported on MySQL. If you use MySQL for the database, a descending index will be created as a normal index.

You can find more information about how to define indexes for models at https://docs.djangoproject.com/en/5.0/ref/models/indexes/.

Activating the application
We need to activate the blog application in the project for Django to keep track of the application and be able to create database tables for its models.

Edit the settings.py file and add blog.apps.BlogConfig to the INSTALLED_APPS setting. It should look like this; the new lines are highlighted in bold:

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'blog.apps.BlogConfig',
]

Copy

Explain
The BlogConfig class is the application configuration. Now Django knows that the application is active for this project and will be able to load the application models.

Adding a status field
A common functionality for blogs is to save posts as a draft until ready for publication. We will add a status field to our model that will allow us to manage the status of blog posts. We will be using the Draft and Published statuses for posts.

Edit the models.py file of the blog application to make it look as follows. The new lines are highlighted in bold:

from django.db import models
from django.utils import timezone
class Post(models.Model):
    class Status(models.TextChoices):
        DRAFT = 'DF', 'Draft'
        PUBLISHED = 'PB', 'Published'
    title = models.CharField(max_length=250)
    slug = models.SlugField(max_length=250)
    body = models.TextField()
    publish = models.DateTimeField(default=timezone.now)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    status = models.CharField(
        max_length=2,
        choices=Status,
        default=Status.DRAFT
    )
    class Meta:
        ordering = ['-publish']
        indexes = [
            models.Index(fields=['-publish']),
        ]
    def __str__(self):
        return self.title

Copy

Explain
We have defined the enumeration class Status by subclassing models.TextChoices. The available choices for the post status are DRAFT and PUBLISHED. Their respective values are DF and PB, and their labels or readable names are Draft and Published.

Django provides enumeration types that you can subclass to define choices simply. These are based on the enum object of Python’s standard library. You can read more about enum at https://docs.python.org/3/library/enum.html.

Django enumeration types present some modifications over enum. You can learn about those differences at https://docs.djangoproject.com/en/5.0/ref/models/fields/#enumeration-types.

We can access Post.Status.choices to obtain the available choices, Post.Status.names to obtain the names of the choices, Post.Status.labels to obtain the human-readable names, and Post.Status.values to obtain the actual values of the choices.

We have also added a new status field to the model that is an instance of CharField. It includes a choices parameter to limit the value of the field to the choices in Status. We have also set a default value for the field using the default parameter. We use DRAFT as the default choice for this field.

It’s a good practice to define choices inside the model class and use the enumeration types. This will allow you to easily reference choice labels, values, or names from anywhere in your code. You can import the Post model and use Post.Status.DRAFT as a reference for the Draft status anywhere in your code.

Let’s take a look at how to interact with status choices.

Run the following command in the shell prompt to open the Python shell:

python manage.py shell

Copy

Explain
Then, type the following lines:

>>> from blog.models import Post
>>> Post.Status.choices

Copy

Explain
You will obtain the enum choices with value-label pairs, like this:

[('DF', 'Draft'), ('PB', 'Published')]

Copy

Explain
Type the following line:

>>> Post.Status.labels

Copy

Explain
You will get the human-readable names of the enum members, as follows:

['Draft', 'Published']

Copy

Explain
Type the following line:

>>> Post.Status.values

Copy

Explain
You will get the values of the enum members, as follows. These are the values that can be stored in the database for the status field:

['DF', 'PB']

Copy

Explain
Type the following line:

>>> Post.Status.names

Copy

Explain
You will get the names of the choices, like this:

['DRAFT', 'PUBLISHED']

Copy

Explain
You can access a specific lookup enumeration member with Post.Status.PUBLISHED and you can access its .name and .value properties as well.

Adding a many-to-one relationship
Posts are always written by an author. We will create a relationship between users and posts that will indicate which user wrote which posts. Django comes with an authentication framework that handles user accounts. The Django authentication framework comes in the django.contrib.auth package and contains a User model. To define the relationship between users and posts, we will use the AUTH_USER_MODEL setting, which points to auth.User by default. This setting allows you to specify a different user model for your project.

Edit the models.py file of the blog application to make it look as follows. The new lines are highlighted in bold:

from django.conf import settings
from django.db import models
from django.utils import timezone
class Post(models.Model):
    class Status(models.TextChoices):
        DRAFT = 'DF', 'Draft'
        PUBLISHED = 'PB', 'Published'
    title = models.CharField(max_length=250)
    slug = models.SlugField(max_length=250)
    author = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='blog_posts'
    )
    body = models.TextField()
    publish = models.DateTimeField(default=timezone.now)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    status = models.CharField(
        max_length=2,
        choices=Status,
        default=Status.DRAFT
    )
    class Meta:
        ordering = ['-publish']
        indexes = [
            models.Index(fields=['-publish']),
        ]
    def __str__(self):
        return self.title

Copy

Explain
We have imported the project’s settings and we have added an author field to the Post model. This field defines a many-to-one relationship with the default user model, meaning that each post is written by a user, and a user can write any number of posts. For this field, Django will create a foreign key in the database using the primary key of the related model.

The on_delete parameter specifies the behavior to adopt when the referenced object is deleted. This is not specific to Django; it is a SQL standard. Using CASCADE, you specify that when the referenced user is deleted, the database will also delete all related blog posts. You can take a look at all the possible options at https://docs.djangoproject.com/en/5.0/ref/models/fields/#django.db.models.ForeignKey.on_delete.

We use related_name to specify the name of the reverse relationship, from User to Post. This will allow us to access related objects easily from a user object by using the user.blog_posts notation. We will learn more about this later.

Django comes with different types of fields that you can use to define your models. You can find all field types at https://docs.djangoproject.com/en/5.0/ref/models/fields/.

The Post model is now complete, and we can now synchronize it to the database.

Creating and applying migrations
Now that we have a data model for blog posts, we need to create the corresponding database table. Django comes with a migration system that tracks the changes made to models and enables them to propagate into the database.

The migrate command applies migrations for all applications listed in INSTALLED_APPS. It synchronizes the database with the current models and existing migrations.

First, we will need to create an initial migration for our Post model.

Run the following command in the shell prompt from the root directory of your project:

python manage.py makemigrations blog

Copy

Explain
You should get an output similar to the following one:

Migrations for 'blog':
    blog/migrations/0001_initial.py
        - Create model Post
        - Create index blog_post_publish_bb7600_idx on field(s)
          -publish of model post

Copy

Explain
Django just created the 0001_initial.py file inside the migrations directory of the blog application. This migration contains the SQL statements to create the database table for the Post model and the definition of the database index for the publish field.

You can take a look at the file contents to see how the migration is defined. A migration specifies dependencies on other migrations and operations to perform in the database to synchronize it with model changes.

Let’s take a look at the SQL code that Django will execute in the database to create the table for your model. The sqlmigrate command takes the migration names and returns their SQL without executing it.

Run the following command from the shell prompt to inspect the SQL output of your first migration:

python manage.py sqlmigrate blog 0001

Copy

Explain
The output should look as follows:

BEGIN;
--
-- Create model Post
--
CREATE TABLE "blog_post" (
  "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  "title" varchar(250) NOT NULL,
  "slug" varchar(250) NOT NULL,
  "body" text NOT NULL,
  "publish" datetime NOT NULL,
  "created" datetime NOT NULL,
  "updated" datetime NOT NULL,
  "status" varchar(10) NOT NULL,
  "author_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
--
-- Create blog_post_publish_bb7600_idx on field(s) -publish of model post
--
CREATE INDEX "blog_post_publish_bb7600_idx" ON "blog_post" ("publish" DESC);
CREATE INDEX "blog_post_slug_b95473f2" ON "blog_post" ("slug");
CREATE INDEX "blog_post_author_id_dd7a8485" ON "blog_post" ("author_id");
COMMIT;

Copy

Explain
The exact output depends on the database you are using. The preceding output is generated for SQLite. As you can see in the output, Django generates the table names by combining the application name and the lowercase name of the model (blog_post), but you can also specify a custom database name for your model in the Meta class of the model using the db_table attribute.

Django creates an auto-incremental id column that is used as the primary key for each model, but you can also override this by specifying primary_key=True on one of your model fields. The default id column consists of an integer that is incremented automatically. This column corresponds to the id field that is automatically added to your model.

The following three database indexes are created:

An index in descending order on the publish column. This is the index we explicitly defined with the indexes option of the model’s Meta class.
An index on the slug column because SlugField fields imply an index by default.
An index on the author_id column because ForeignKey fields imply an index by default.
Let’s compare the Post model with its corresponding database blog_post table:

Table

Description automatically generated with medium confidence
Figure 1.6: Complete Post model and database table correspondence

Figure 1.6 shows how the model fields correspond to database table columns.

Let’s sync the database with the new model.

Execute the following command in the shell prompt to apply the existing migrations:

python manage.py migrate

Copy

Explain
You will get an output that ends with the following line:

Applying blog.0001_initial... OK

Copy

Explain
We just applied migrations for the applications listed in INSTALLED_APPS, including the blog application. After applying the migrations, the database reflects the current status of the models.

If you edit the models.py file in order to add, remove, or change the fields of existing models, or if you add new models, you will have to create a new migration using the makemigrations command. Each migration allows Django to keep track of model changes. Then, you will have to apply the migration using the migrate command to keep the database in sync with your models.

Creating an administration site for models
Now that the Post model is in sync with the database, we can create a simple administration site to manage blog posts.

Django comes with a built-in administration interface that is very useful for editing content. The Django site is built dynamically by reading the model metadata and providing a production-ready interface for editing content. You can use it out of the box, configuring how you want your models to be displayed in it.

The django.contrib.admin application is already included in the INSTALLED_APPS setting, so you don’t need to add it.

Creating a superuser
First, you will need to create a user to manage the administration site. Run the following command:

python manage.py createsuperuser

Copy

Explain
You will see the following output. Enter your desired username, email, and password, as follows:

Username (leave blank to use 'admin'): admin
Email address: admin@admin.com
Password: ********
Password (again): ********

Copy

Explain
Then, you will see the following success message:

Superuser created successfully.

Copy

Explain
We just created an administrator user with the highest permissions.

The Django administration site
Start the development server with the following command:

python manage.py runserver

Copy

Explain
Open http://127.0.0.1:8000/admin/ in your browser. You should see the administration login page, as shown in Figure 1.7:


Figure 1.7: The Django administration site login screen

Log in using the credentials of the user you created in the preceding step. You will see the administration site index page, as shown in Figure 1.8:


Figure 1.8: The Django administration site index page

The Group and User models that you can see in the preceding screenshot are part of the Django authentication framework located in django.contrib.auth. If you click on Users, you will see the user you created previously.

Adding models to the administration site
Let’s add your blog models to the administration site. Edit the admin.py file of the blog application and make it look like this; the new lines are highlighted in bold:

from django.contrib import admin
from .models import Post
admin.site.register(Post)

Copy

Explain
Now, reload the administration site in your browser. You should see your Post model on the site, as follows:


Figure 1.9: The Post model of the blog application included in the Django administration site index page

That was easy, right? When you register a model in the Django administration site, you get a user-friendly interface generated by introspecting your models that allows you to list, edit, create, and delete objects in a simple way.

Click on the Add link beside Posts to add a new post. You will note the form that Django has generated dynamically for your model, as shown in Figure 1.10:


Figure 1.10: The Django administration site edit form for the Post model

Django uses different form widgets for each type of field. Even complex fields, such as DateTimeField, are displayed with an easy interface, such as a JavaScript date picker.

Fill in the form and click on the SAVE button. You should be redirected to the post list page with a success message and the post you just created, as shown in Figure 1.11:


Figure 1.11: The Django administration site list view for the Post model with an added successfully message

Customizing how models are displayed
Now, we will take a look at how to customize the administration site.

Edit the admin.py file of your blog application and change it, as follows. The new lines are highlighted in bold:

from django.contrib import admin
from .models import Post
@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    list_display = ['title', 'slug', 'author', 'publish', 'status']

Copy

Explain
We are telling the Django administration site that the model is registered in the site using a custom class that inherits from ModelAdmin. In this class, we can include information about how to display the model on the administration site and how to interact with it.

The list_display attribute allows you to set the fields of your model that you want to display on the administration object list page. The @admin.register() decorator performs the same function as the admin.site.register() function that you replaced, registering the ModelAdmin class that it decorates.

Let’s customize the admin model with some more options.

Edit the admin.py file of your blog application and change it, as follows. The new lines are highlighted in bold:

from django.contrib import admin
from .models import Post
@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    list_display = ['title', 'slug', 'author', 'publish', 'status']
    list_filter = ['status', 'created', 'publish', 'author']
    search_fields = ['title', 'body']
    prepopulated_fields = {'slug': ('title',)}
    raw_id_fields = ['author']
    date_hierarchy = 'publish'
    ordering = ['status', 'publish']

Copy

Explain
Return to your browser and reload the post list page. Now, it will look like this:


Figure 1.12: The Django administration site custom list view for the Post model

You can see that the fields displayed on the post list page are the ones we specified in the list_display attribute. The list page now includes a right sidebar that allows you to filter the results by the fields included in the list_filter attribute. Filters for ForeignKey fields like author are only displayed in the sidebar if more than one object exists in the database.

A search bar has appeared on the page. This is because we have defined a list of searchable fields using the search_fields attribute. Just below the search bar, there are navigation links to navigate through a date hierarchy; this has been defined by the date_hierarchy attribute. You can also see that the posts are ordered by STATUS and PUBLISH columns by default. We have specified the default sorting criteria using the ordering attribute.

Next, click on the ADD POST link. You will also note some changes here. As you type the title of a new post, the slug field is filled in automatically. You have told Django to prepopulate the slug field with the input of the title field using the prepopulated_fields attribute:


Figure 1.13: The slug model is now automatically prepopulated as you type in the title

Also, the author field is now displayed with a lookup widget, which can be much better than an input selection drop-down when you have thousands of users. This is achieved with the raw_id_fields attribute and it looks like this:


Figure 1.14: The widget to select related objects for the Author field of the Post model

Adding facet counts to filters
Django 5.0 introduces facet filters to the administration site, showcasing facet counts. These counts indicate the number of objects corresponding to each specific filter, making it easier to identify matching objects in the admin changelist view. Next, we are going to make sure facet filters are always displayed for the PostAdmin admin model.

Edit the admin.py file of your blog application and add the following line highlighted in bold:

from django.contrib import admin
from .models import Post
@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    list_display = ['title', 'slug', 'author', 'publish', 'status']
    list_filter = ['status', 'created', 'publish', 'author']
    search_fields = ['title', 'body']
    prepopulated_fields = {'slug': ('title',)}
    raw_id_fields = ['author']
    date_hierarchy = 'publish'
    ordering = ['status', 'publish']
    show_facets = admin.ShowFacets.ALWAYS

Copy

Explain
Create some posts using the administration site and access http://127.0.0.1:8000/admin/blog/post/. The filters should now include total facet counts, as shown in Figure 1.15:


Figure 1.15: Status field filters including facet counts

With a few lines of code, we have customized the way the model is displayed on the administration site. There are plenty of ways to customize and extend the Django administration site; you will learn more about these later in this book.

You can find more information about the Django administration site at https://docs.djangoproject.com/en/5.0/ref/contrib/admin/.

Working with QuerySets and managers
Now that we have a fully functional administration site to manage blog posts, it is a good time to learn how to read and write content to the database programmatically.

The Django object-relational mapper (ORM) is a powerful database abstraction API that lets you create, retrieve, update, and delete objects easily. An ORM allows you to generate SQL queries using the object-oriented paradigm of Python. You can think of it as a way to interact with your database in a Pythonic fashion instead of writing raw SQL queries.

The ORM maps your models to database tables and provides you with a simple Pythonic interface to interact with your database. The ORM generates SQL queries and maps the results to model objects. The Django ORM is compatible with MySQL, PostgreSQL, SQLite, Oracle, and MariaDB.

Remember that you can define the database of your project in the DATABASES setting of your project’s settings.py file. Django can work with multiple databases at a time, and you can program database routers to create custom data routing schemes.

Once you have created your data models, Django gives you a free API to interact with them. You can find the model API reference of the official documentation at https://docs.djangoproject.com/en/5.0/ref/models/.

The Django ORM is based on QuerySets. A QuerySet is a collection of database queries to retrieve objects from your database. You can apply filters to QuerySets to narrow down the query results based on given parameters. The QuerySet equates to a SELECT SQL statement and the filters are limiting SQL clauses such as WHERE or LIMIT.

Next, you are going to learn how to build and execute QuerySets.

Creating objects
Run the following command in the shell prompt to open the Python shell:

python manage.py shell

Copy

Explain
Then, type the following lines:

>>> from django.contrib.auth.models import User
>>> from blog.models import Post
>>> user = User.objects.get(username='admin')
>>> post = Post(title='Another post',
...             slug='another-post',
...             body='Post body.',
...             author=user)
>>> post.save()

Copy

Explain
Let’s analyze what this code does.

First, we are retrieving the user object with the username admin:

>>> user = User.objects.get(username='admin')

Copy

Explain
The get() method allows us to retrieve a single object from the database. This method executes a SELECT SQL statement behind the scenes. Note that this method expects a result that matches the query. If no results are returned by the database, this method will raise a DoesNotExist exception, and if the database returns more than one result, it will raise a MultipleObjectsReturned exception. Both exceptions are attributes of the model class that the query is being performed on.

Then, we create a Post instance with a custom title, slug, and body, and set the user that we previously retrieved as the author of the post:

>>> post = Post(title='Another post', slug='another-post', body='Post body.', author=user)

Copy

Explain
This object is in memory and not persisted to the database; we created a Python object that can be used during runtime but is not saved into the database.

Finally, we are saving the Post object in the database using the save() method:

>>> post.save()

Copy

Explain
This action performs an INSERT SQL statement behind the scenes.

We created an object in memory first and then persisted it to the database. However, you can create the object and persist it to the database in a single operation using the create() method, as follows:

>>> Post.objects.create(title='One more post',
                    slug='one-more-post',
                    body='Post body.',
                    author=user)

Copy

Explain
In certain situations, you might need to fetch an object from the database or create it if it’s absent. The get_or_create() method facilitates this by either retrieving an object or creating it if not found. This method returns a tuple with the object retrieved and a Boolean indicating whether a new object was created. The following code attempts to retrieve a User object with the username user2, and if it doesn’t exist, it will create one:

>>> user, created = User.objects.get_or_create(username='user2')

Copy

Explain
Updating objects
Now, change the title of the previous Post object to something different and save the object again:

>>> post.title = 'New title'
>>> post.save()

Copy

Explain
This time, the save() method performs an UPDATE SQL statement.

The changes you make to a model object are not persisted to the database until you call the save() method.

Retrieving objects
You already know how to retrieve a single object from the database using the get() method. We accessed this method using Post.objects.get(). Each Django model has at least one manager, and the default manager is called objects. You get a QuerySet object using your model manager.

To retrieve all objects from a table, we use the all() method on the default objects manager, like this:

>>> all_posts = Post.objects.all()

Copy

Explain
This is how we create a QuerySet that returns all objects in the database. Note that this QuerySet has not been executed yet. Django QuerySets are lazy, which means they are only evaluated when they are forced to. This behavior makes QuerySets very efficient. If you don’t assign the QuerySet to a variable but, instead, write it directly on the Python shell, the SQL statement of the QuerySet is executed because you are forcing it to generate output:

>>> Post.objects.all()
<QuerySet [<Post: Who was Django Reinhardt?>, <Post: New title>]>

Copy

Explain
Filtering objects
To filter a QuerySet, you can use the filter() method of the manager. This method allows you to specify the content of a SQL WHERE clause by using field lookups.

For example, you can use the following to filter Post objects by their title:

>>> Post.objects.filter(title='Who was Django Reinhardt?')

Copy

Explain
This QuerySet will return all posts with the exact title Who was Django Reinhardt?. Let’s review the SQL statement generated with this QuerySet. Run the following code in the shell:

>>> posts = Post.objects.filter(title='Who was Django Reinhardt?')
>>> print(posts.query)

Copy

Explain
By printing the query attribute of the QuerySet, we can get the SQL produced by it:

SELECT "blog_post"."id", "blog_post"."title", "blog_post"."slug", "blog_post"."author_id", "blog_post"."body", "blog_post"."publish", "blog_post"."created", "blog_post"."updated", "blog_post"."status" FROM "blog_post" WHERE "blog_post"."title" = Who was Django Reinhardt? ORDER BY "blog_post"."publish" DESC

Copy

Explain
The generated WHERE clause performs an exact match on the title column. The ORDER BY clause specifies the default order defined in the ordering attribute of the Post model’s Meta options since we haven’t provided any specific ordering in the QuerySet. You will learn about ordering in a bit. Note that the query attribute is not part of the QuerySet public API.

Using field lookups
The previous QuerySet example consists of a filter lookup with an exact match. The QuerySet interface provides you with multiple lookup types. Two underscores are used to define the lookup type, with the format field__lookup. For example, the following lookup produces an exact match:

>>> Post.objects.filter(id__exact=1)

Copy

Explain
When no specific lookup type is provided, the lookup type is assumed to be exact. The following lookup is equivalent to the previous one:

>>> Post.objects.filter(id=1)

Copy

Explain
Let’s take a look at other common lookup types. You can generate a case-insensitive lookup with iexact:

>>> Post.objects.filter(title__iexact='who was django reinhardt?')

Copy

Explain
You can also filter objects using a containment test. The contains lookup translates to a SQL lookup using the LIKE operator:

>>> Post.objects.filter(title__contains='Django')

Copy

Explain
The equivalent SQL clause is WHERE title LIKE '%Django%'. A case-insensitive version is also available, named icontains:

>>> Post.objects.filter(title__icontains='django')

Copy

Explain
You can check for a given iterable (often a list, tuple, or another QuerySet object) with the in lookup. The following example retrieves posts with an id that is 1 or 3:

>>> Post.objects.filter(id__in=[1, 3])

Copy

Explain
The following example shows the greater than (gt) lookup:

>>> Post.objects.filter(id__gt=3)

Copy

Explain
The equivalent SQL clause is WHERE ID > 3.

This example shows the greater than or equal to lookup:

>>> Post.objects.filter(id__gte=3)

Copy

Explain
This one shows the less than lookup:

>>> Post.objects.filter(id__lt=3)

Copy

Explain
This shows the less than or equal to lookup:

>>> Post.objects.filter(id__lte=3)

Copy

Explain
A case-sensitive/insensitive starts-with lookup can be performed with the startswith and istartswith lookup types, respectively:

>>> Post.objects.filter(title__istartswith='who')

Copy

Explain
A case-sensitive/insensitive ends-with lookup can be performed with the endswith and iendswith lookup types, respectively:

>>> Post.objects.filter(title__iendswith='reinhardt?')

Copy

Explain
There are also different lookup types for date lookups. An exact date lookup can be performed as follows:

>>> from datetime import date
>>> Post.objects.filter(publish__date=date(2024, 1, 31))

Copy

Explain
This shows how to filter a DateField or DateTimeField field by year:

>>> Post.objects.filter(publish__year=2024)

Copy

Explain
You can also filter by month:

>>> Post.objects.filter(publish__month=1)

Copy

Explain
And you can filter by day:

>>> Post.objects.filter(publish__day=1)

Copy

Explain
You can chain additional lookups to date, year, month, and day. For example, here is a lookup for a value greater than a given date:

>>> Post.objects.filter(publish__date__gt=date(2024, 1, 1))

Copy

Explain
To lookup related object fields, you also use the two-underscores notation. For example, to retrieve the posts written by the user with the admin username, use the following:

>>> Post.objects.filter(author__username='admin')

Copy

Explain
You can also chain additional lookups for the related fields. For example, to retrieve posts written by any user with a username that starts with ad, use the following:

>>> Post.objects.filter(author__username__starstwith='ad')

Copy

Explain
You can also filter by multiple fields. For example, the following QuerySet retrieves all posts published in 2024 by the author with the username admin:

>>> Post.objects.filter(publish__year=2024, author__username='admin')

Copy

Explain
Chaining filters
The result of a filtered QuerySet is another QuerySet object. This allows you to chain QuerySets together. You can build an equivalent QuerySet to the previous one by chaining multiple filters:

>>> Post.objects.filter(publish__year=2024) \
>>>             .filter(author__username='admin')

Copy

Explain
Excluding objects
You can exclude certain results from your QuerySet by using the exclude() method of the manager. For example, you can retrieve all posts published in 2024 whose titles don’t start with Why:

>>> Post.objects.filter(publish__year=2024) \
>>>             .exclude(title__startswith='Why')

Copy

Explain
Ordering objects
The default order is defined in the ordering option of the model’s Meta. You can override the default ordering using the order_by() method of the manager. For example, you can retrieve all objects ordered by their title, as follows:

>>> Post.objects.order_by('title')

Copy

Explain
Ascending order is implied. You can indicate descending order with a negative sign prefix, like this:

>>> Post.objects.order_by('-title')

Copy

Explain
You can order by multiple fields. The following example orders objects by author first and then title:

>>> Post.objects.order_by('author', 'title')

Copy

Explain
To order randomly, use the string '?', as follows:

>>> Post.objects.order_by('?')

Copy

Explain
Limiting QuerySets
You can limit a QuerySet to a certain number of results by using a subset of Python’s array-slicing syntax. For example, the following QuerySet limits the results to 5 objects:

>>> Post.objects.all()[:5]

Copy

Explain
This translates to a SQL LIMIT 5 clause. Note that negative indexing is not supported.

>>> Post.objects.all()[3:6]

Copy

Explain
The preceding translates to a SQL OFFSET 3 LIMIT 6 clause, to return the fourth through sixth objects.

To retrieve a single object, you can use an index instead of a slice. For example, use the following to retrieve the first object of posts in random order:

>>> Post.objects.order_by('?')[0]

Copy

Explain
Counting objects
The count() method counts the total number of objects matching the QuerySet and returns an integer. This method translates to a SELECT COUNT(*) SQL statement. The following example returns the total number of posts with an id lower than 3:

>>> Post.objects.filter(id_lt=3).count()
2

Copy

Explain
Checking if an object exists
The exists() method allows you to check if a QuerySet contains any results. This method returns True if the QuerySet contains any items and False otherwise. For example, you can check if there are any posts with a title that starts with Why using the following QuerySet:

>>> Post.objects.filter(title__startswith='Why').exists()
False

Copy

Explain
Deleting objects
If you want to delete an object, you can do it from an object instance using the delete() method, as follows:

>>> post = Post.objects.get(id=1)
>>> post.delete()

Copy

Explain
Note that deleting objects will also delete any dependent relationships for ForeignKey objects defined with on_delete set to CASCADE.

Complex lookups with Q objects
Field lookups using filter() are joined with a SQL AND operator. For example, filter(field1='foo ', field2='bar') will retrieve objects where field1 is foo and field2 is bar. If you need to build more complex queries, such as queries with OR statements, you can use Q objects.

A Q object allows you to encapsulate a collection of field lookups. You can compose statements by combining Q objects with the & (and), | (or), and ^ (xor) operators.

For example, the following code retrieves posts with a title that starts with the string who or why (case-insensitive):

>>> from django.db.models import Q
>>> starts_who = Q(title__istartswith='who')
>>> starts_why = Q(title__istartswith='why')
>>> Post.objects.filter(starts_who | starts_why)

Copy

Explain
In this case, we use the | operator to build an OR statement.

You can read more about Q objects at https://docs.djangoproject.com/en/5.0/topics/db/queries/#complex-lookups-with-q-objects.

When QuerySets are evaluated
Creating a QuerySet doesn’t involve any database activity until it is evaluated. QuerySets will usually return another unevaluated QuerySet. You can concatenate as many filters as you like to a QuerySet, and you will not hit the database until the QuerySet is evaluated. When a QuerySet is evaluated, it translates into a SQL query to the database.

QuerySets are only evaluated in the following cases:

The first time you iterate over them
When you slice them, for instance, Post.objects.all()[:3]
When you pickle or cache them
When you call repr() or len() on them
When you explicitly call list() on them
When you test them in a statement, such as bool(), or, and, or if
More on QuerySets
You will use QuerySets in all the project examples featured in this book. You will learn how to generate aggregates over QuerySets in the Retrieving posts by similarity section of Chapter 3, Extending Your Blog Application.

You will learn how to optimize QuerySets in the Optimizing QuerySets that involve related objects section in Chapter 7, Tracking User Actions.

The QuerySet API reference is located at https://docs.djangoproject.com/en/5.0/ref/models/querysets/.

You can read more about making queries with the Django ORM at https://docs.djangoproject.com/en/5.0/topics/db/queries/.

Creating model managers
The default manager for every model is the objects manager. This manager retrieves all the objects in the database. However, we can define custom managers for models.

Let’s create a custom manager to retrieve all posts that have a PUBLISHED status.

There are two ways to add or customize managers for your models: you can add extra manager methods to an existing manager or create a new manager by modifying the initial QuerySet that the manager returns. The first method provides you with a QuerySet notation like Post.objects.my_manager(), and the latter provides you with a QuerySet notation like Post.my_manager.all().

We will choose the second method to implement a manager that will allow us to retrieve posts using the notation Post.published.all().

Edit the models.py file of your blog application to add the custom manager, as follows. The new lines are highlighted in bold:

class PublishedManager(models.Manager):
    def get_queryset(self):
        return (
            super().get_queryset().filter(status=Post.Status.PUBLISHED)
        )
class Post(models.Model):
    # model fields
    # ...
    objects = models.Manager() # The default manager.
    published = PublishedManager() # Our custom manager.
    class Meta:
        ordering = ['-publish']
        indexes = [
            models.Index(fields=['-publish']),
        ]
    def __str__(self):
        return self.title

Copy

Explain
The first manager declared in a model becomes the default manager. You can use the Meta attribute default_manager_name to specify a different default manager. If no manager is defined in the model, Django automatically creates the objects default manager for it. If you declare any managers for your model but you want to keep the objects manager as well, you have to add it explicitly to your model. In the preceding code, we have added the default objects manager and the published custom manager to the Post model.

The get_queryset() method of a manager returns the QuerySet that will be executed. We have overridden this method to build a custom QuerySet that filters posts by their status and returns a successive QuerySet that only includes posts with the PUBLISHED status.

We have now defined a custom manager for the Post model. Let’s test it!

Start the development server again with the following command in the shell prompt:

python manage.py shell

Copy

Explain
Now, you can import the Post model and retrieve all published posts whose title starts with Who, executing the following QuerySet:

>>> from blog.models import Post
>>> Post.published.filter(title__startswith='Who')

Copy

Explain
To obtain results for this QuerySet, make sure to set the status field to PUBLISHED in the Post object whose title starts with the string Who.

Building list and detail views
Now that you understand how to use the ORM, you are ready to build the views of the blog application. A Django view is just a Python function that receives a web request and returns a web response. All the logic to return the desired response goes inside the view.

First, you will create your application views, then you will define a URL pattern for each view, and finally, you will create HTML templates to render the data generated by the views. Each view will render a template, passing variables to it, and will return an HTTP response with the rendered output.

Creating list and detail views
Let’s start by creating a view to display the list of posts.

Edit the views.py file of the blog application and make it look like this; the new lines are highlighted in bold:

from django.shortcuts import render
from .models import Post
def post_list(request):
    posts = Post.published.all()
    return render(
        request,
        'blog/post/list.html',
        {'posts': posts}
    )

Copy

Explain
This is our very first Django view. The post_list view takes the request object as the only parameter. This parameter is required by all views.

In this view, we retrieve all the posts with the PUBLISHED status using the published manager that we created previously.

Finally, we use the render() shortcut provided by Django to render the list of posts with the given template. This function takes the request object, the template path, and the context variables to render the given template. It returns an HttpResponse object with the rendered text (normally HTML code).

The render() shortcut takes the request context into account, so any variable set by the template context processors is accessible by the given template. Template context processors are just callables that set variables into the context. You will learn how to use context processors in Chapter 4, Building a Social Website.

Let’s create a second view to display a single post. Add the following function to the views.py file:

from django.http import Http404
def post_detail(request, id):
    try:
        post = Post.published.get(id=id)
    except Post.DoesNotExist:
        raise Http404("No Post found.")
    return render(
        request,
        'blog/post/detail.html',
        {'post': post}
    )

Copy

Explain
This is the post_detail view. This view takes the id argument of a post. In the view, we try to retrieve the Post object with the given id by calling the get() method on the published manager. We raise an Http404 exception to return an HTTP 404 error if the model DoesNotExist exception is raised because no result is found.

Finally, we use the render() shortcut to render the retrieved post using a template.

Using the get_object_or_404 shortcut
Django provides a shortcut to call get() on a given model manager and raises an Http404 exception instead of a DoesNotExist exception when no object is found.

Edit the views.py file to import the get_object_or_404 shortcut and change the post_detail view, as follows. The new code is highlighted in bold:

from django.shortcuts import get_object_or_404, render
# ...
def post_detail(request, id):
    post = get_object_or_404(
        Post,
        id=id,
        status=Post.Status.PUBLISHED
    )
    return render(
        request,
        'blog/post/detail.html',
        {'post': post}
    )

Copy

Explain
In the detail view, we now use the get_object_or_404() shortcut to retrieve the desired post. This function retrieves the object that matches the given parameters or an HTTP 404 (not found) exception if no object is found.

Adding URL patterns for your views
URL patterns allow you to map URLs to views. A URL pattern is composed of a string pattern, a view, and, optionally, a name that allows you to name the URL project-wide. Django runs through each URL pattern and stops at the first one that matches the requested URL. Then, Django imports the view of the matching URL pattern and executes it, passing an instance of the HttpRequest class and the keyword or positional arguments.

Create a urls.py file in the directory of the blog application and add the following lines to it:

from django.urls import path
from . import views
app_name = 'blog'
urlpatterns = [
    # post views
    path('', views.post_list, name='post_list'),
    path('<int:id>/', views.post_detail, name='post_detail'),
]

Copy

Explain
In the preceding code, you define an application namespace with the app_name variable. This allows you to organize URLs by application and use the name when referring to them. You define two different patterns using the path() function. The first URL pattern doesn’t take any arguments and is mapped to the post_list view. The second pattern is mapped to the post_detail view and takes only one argument id, which matches an integer, set by the path converter int.

You use angle brackets to capture the values from the URL. Any value specified in the URL pattern as <parameter> is captured as a string. You use path converters, such as <int:year>, to specifically match and return an integer. For example <slug:post> would specifically match a slug (a string that can only contain letters, numbers, underscores, or hyphens). You can see all the path converters provided by Django at https://docs.djangoproject.com/en/5.0/topics/http/urls/#path-converters.

If using path() and converters isn’t sufficient for you, you can use re_path() instead to define complex URL patterns with Python regular expressions. You can learn more about defining URL patterns with regular expressions at https://docs.djangoproject.com/en/5.0/ref/urls/#django.urls.re_path. If you haven’t worked with regular expressions before, you might want to take a look at Regular Expression HOWTO, located at https://docs.python.org/3/howto/regex.html, first.

Creating a urls.py file for each application is the best way to make your applications reusable by other projects.

Next, you have to include the URL patterns of the blog application in the main URL patterns of the project.

Edit the urls.py file located in the mysite directory of your project and make it look like the following. The new code is highlighted in bold:

from django.contrib import admin
from django.urls import include, path
urlpatterns = [
    path('admin/', admin.site.urls),
    path('blog/', include('blog.urls', namespace='blog')),
]

Copy

Explain
The new URL pattern defined with include refers to the URL patterns defined in the blog application so that they are included under the blog/ path. You include these patterns under the namespace blog. Namespaces have to be unique across your entire project. Later, you will refer to your blog URLs easily by using the namespace followed by a colon and the URL name, for example, blog:post_list and blog:post_detail. You can learn more about URL namespaces at https://docs.djangoproject.com/en/5.0/topics/http/urls/#url-namespaces.

Creating templates for your views
You have created views and URL patterns for the blog application. URL patterns map URLs to views, and views decide which data gets returned to the user. Templates define how the data is displayed; they are usually written in HTML in combination with the Django template language. You can find more information about the Django template language at https://docs.djangoproject.com/en/5.0/ref/templates/language/.

Let’s add templates to your application to display posts in a user-friendly manner.

Create the following directories and files inside your blog application directory:

templates/
    blog/
        base.html
        post/
            list.html
            detail.html

Copy

Explain
The preceding structure will be the file structure for your templates. The base.html file will include the main HTML structure of the website and divide the content into the main content area and a sidebar. The list.html and detail.html files will inherit from the base.html file to render the blog post list and detail views, respectively.

Django has a powerful template language that allows you to specify how data is displayed. It is based on template tags, template variables, and template filters:

Template tags control the rendering of the template and look like this: {% tag %}.
Template variables get replaced with values when the template is rendered and look like this: {{ variable }}.
Template filters allow you to modify variables for display and look like this: {{ variable|filter }}.
You can see all the built-in template tags and filters at https://docs.djangoproject.com/en/5.0/ref/templates/builtins/.

Creating a base template
Edit the base.html file and add the following code:

{% load static %}
<!DOCTYPE html>
<html>
<head>
  <title>{% block title %}{% endblock %}</title>
  <link href="{% static "css/blog.css" %}" rel="stylesheet">
</head>
<body>
  <div id="content">
    {% block content %}
    {% endblock %}
  </div>
  <div id="sidebar">
    <h2>My blog</h2>
    <p>This is my blog.</p>
  </div>
</body>
</html>

Copy

Explain
{% load static %} tells Django to load the static template tags that are provided by the django.contrib.staticfiles application, which is contained in the INSTALLED_APPS setting. After loading them, you can use the {% static %} template tag throughout this template. With this template tag, you can include the static files, such as the blog.css file, which you will find in the code of this example under the static/ directory of the blog application. Copy the static/ directory from the code that comes along with this chapter into the same location as your project to apply the CSS styles to the templates. You can find the directory’s contents at https://github.com/PacktPublishing/Django-5-by-example/tree/master/Chapter01/mysite/blog/static.

You can see that there are two {% block %} tags. These tell Django that you want to define a block in that area. Templates that inherit from this template can fill in the blocks with content. You have defined a block called title and a block called content.

Creating the post list template
Let’s edit the post/list.html file and make it look like the following:

{% extends "blog/base.html" %}
{% block title %}My Blog{% endblock %}
{% block content %}
  <h1>My Blog</h1>
  {% for post in posts %}
    <h2>
      <a href="{% url 'blog:post_detail' post.id %}">
        {{ post.title }}
      </a>
    </h2>
    <p class="date">
      Published {{ post.publish }} by {{ post.author }}
    </p>
    {{ post.body|truncatewords:30|linebreaks }}
  {% endfor %}
{% endblock %}

Copy

Explain
With the {% extends %} template tag, you tell Django to inherit from the blog/base.html template. Then, you fill the title and content blocks of the base template with content. You iterate through the posts and display their title, date, author, and body, including a link in the title to the detail URL of the post. We build the URL using the {% url %} template tag provided by Django.

This template tag allows you to build URLs dynamically by their name. We use blog:post_detail to refer to the post_detail URL in the blog namespace. We pass the required post.id parameter to build the URL for each post.

Always use the {% url %} template tag to build URLs in your templates instead of writing hardcoded URLs. This will make your URLs more maintainable.

In the body of the post, we apply two template filters: truncatewords truncates the value to the number of words specified, and linebreaks converts the output into HTML line breaks. You can concatenate as many template filters as you wish; each one will be applied to the output generated by the preceding one.

Accessing our application
Change the status of the initial post to Published, as shown in Figure 1.16, and create some new posts, also with a Published status.


Figure 1.16: The status field for a published post

Open the shell and execute the following command to start the development server:

python manage.py runserver

Copy

Explain
Open http://127.0.0.1:8000/blog/ in your browser; you will see everything running. You should see something like this:


Figure 1.17: The page for the post list view

Creating the post detail template
Next, edit the post/detail.html file:

{% extends "blog/base.html" %}
{% block title %}{{ post.title }}{% endblock %}
{% block content %}
  <h1>{{ post.title }}</h1>
  <p class="date">
    Published {{ post.publish }} by {{ post.author }}
  </p>
  {{ post.body|linebreaks }}
{% endblock %}

Copy

Explain
Next, you can return to your browser and click on one of the post titles to take a look at the detail view of the post. You should see something like this:


Figure 1.18: The page for the post’s detail view

Take a look at the URL – it should include the auto-generated post ID, like /blog/1/.

The request/response cycle
Let’s review the request/response cycle of Django with the application we built. The following schema shows a simplified example of how Django processes HTTP requests and generates HTTP responses:

Timeline

Description automatically generated with medium confidence
Figure 1.19: The Django request/response cycle

Let’s review the Django request/response process:

A web browser requests a page by its URL, for example, https://domain.com/blog/33/. The web server receives the HTTP request and passes it over to Django.

Django runs through each URL pattern defined in the URL patterns configuration. The framework checks each pattern against the given URL path, in order of appearance, and stops at the first one that matches the requested URL. In this case, the pattern /blog/<id>/ matches the path /blog/33/.

Django imports the view of the matching URL pattern and executes it, passing an instance of the HttpRequest class and the keyword or positional arguments. The view uses the models to retrieve information from the database. Using the Django ORM, QuerySets are translated into SQL and executed in the database.

The view uses the render() function to render an HTML template passing the Post object as a context variable.

The rendered content is returned as a HttpResponse object by the view with the text/html content type by default.

You can always use this schema as the basic reference for how Django processes requests. This schema doesn’t include Django middleware, for the sake of simplicity. You will use middleware in different examples of this book, and you will learn how to create custom middleware in Chapter 17, Going Live.

Management commands used in this chapter
In this chapter, we have introduced a variety of Django management commands. You need to get familiar with them, as they will be used often throughout the book. Let’s revisit the commands we have covered in this chapter.

To create the file structure for a new Django project named mysite, we used the following command:

django-admin startproject mysite

Copy

Explain
To create the file structure for a new Django application named blog:

python manage.py startapp blog

Copy

Explain
To apply all database migrations:

python manage.py migrate

Copy

Explain
To create migrations for the models of the blog application:

python manage.py makemigrations blog

Copy

Explain
To view the SQL statements that will be executed with the first migration of the blog application:

python manage.py sqlmigrate blog 0001

Copy

Explain
To run the Django development server:

python manage.py runserver

Copy

Explain
To run the development server specifying host/port and settings file:

python manage.py runserver 127.0.0.1:8001 --settings=mysite.settings

Copy

Explain
To run the Django shell:

python manage.py shell

Copy

Explain
To create a superuser using the Django authentication framework:

python manage.py createsuperuser

Copy

Explain
For the full list of available management commands, check out https://docs.djangoproject.com/en/5.0/ref/django-admin/.

Summary
In this chapter, you learned the basics of the Django web framework by creating a simple blog application. You designed the data models and applied migrations to the database. You also created the views, templates, and URLs for your blog.

In the next chapter, you will enhance your blog by creating canonical URLs for your posts and building SEO-friendly URLs. You will also learn how to implement object pagination and how to build class-based views. You will also create forms to let your users recommend posts by email and comment on posts.

Additional resources
The following resources provide additional information related to the topics covered in this chapter:

Source code for this chapter: https://github.com/PacktPublishing/Django-5-by-example/tree/main/Chapter01
Download Python: https://www.python.org/downloads/
Windows Python launcher: https://docs.python.org/3/using/windows.html#launcher
Python venv library for virtual environments: https://docs.python.org/3/library/venv.html
Python pip installation instructions: at https://pip.pypa.io/en/stable/installation/
Django installation options: https://docs.djangoproject.com/en/5.0/topics/install/
Django 5.0 release notes: https://docs.djangoproject.com/en/5.0/releases/5.0/
The django-upgrade tool: https://github.com/adamchainz/django-upgrade
The pyupgrade tool: https://github.com/asottile/pyupgrade
Django’s design philosophies: https://docs.djangoproject.com/en/5.0/misc/design-philosophies/
Django model field reference: https://docs.djangoproject.com/en/5.0/ref/models/fields/
Model index reference: https://docs.djangoproject.com/en/5.0/ref/models/indexes/
Python support for enumerations: https://docs.python.org/3/library/enum.html
Django model enumeration types: https://docs.djangoproject.com/en/5.0/ref/models/fields/#enumeration-types
Django settings reference: https://docs.djangoproject.com/en/5.0/ref/settings/
Database default values for model fields: https://docs.djangoproject.com/en/5.0/ref/models/fields/#django.db.models.Field.db_default
Database functions: https://docs.djangoproject.com/en/5.0/ref/models/database-functions/
Django administration site: https://docs.djangoproject.com/en/5.0/ref/contrib/admin/
Model API reference: https://docs.djangoproject.com/en/5.0/ref/models/
Making queries with the Django ORM: https://docs.djangoproject.com/en/5.0/topics/db/queries/
QuerySet API reference: https://docs.djangoproject.com/en/5.0/ref/models/querysets/
Complex lookups with Q objects: https://docs.djangoproject.com/en/5.0/topics/db/queries/#complex-lookups-with-q-objects
Django URL dispatcher: https://docs.djangoproject.com/en/5.0/topics/http/urls/
Django template language: https://docs.djangoproject.com/en/5.0/ref/templates/language/
Built-in template tags and filters: https://docs.djangoproject.com/en/5.0/ref/templates/builtins/
Django management commands: https://docs.djangoproject.com/en/5.0/ref/django-admin/
Static files for the code in this chapter: https://github.com/PacktPublishing/Django-5-by-example/tree/master/Chapter01/mysite/blog/static
Join us on Discord!
Read this book alongside other users, Django development experts, and the author himself. Ask questions, provide solutions to other readers, chat with the author via Ask Me Anything sessions, and much more.Scan the QR code or visit the link to join the community.

https://packt.link/Django5ByExample



| ≪ [ 00 Preface ](/packtpub/2024/730_Django_5_by_Example/00_Preface) | 01 Building a Blog Application | [ 02 Enhancing Your Blog and Adding Social Features ](/packtpub/2024/730_Django_5_by_Example/02_Enhancing_Your_Blog_and_Adding_Social_Features) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 01 Building a Blog Application
> (2) Short Description: Django 5 By Example 5ed
> (3) Path: packtpub/2024/730_Django_5_by_Example/01_Building_a_Blog_Application
> Book Title: Django 5 By Example - Fifth Edition
> AuthorDate: By Antonio Melé Publication Date: 2024-04-30
> tags: Django
> Link: https://subscription.packtpub.com/book/web-development/9781805125457/1
> create: 2024-08-13 화 13:49:11
> .md Name: 01_building_a_blog_application.md

