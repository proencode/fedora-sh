
| ≪ [ 14 Testing Your Django Applications ](/packtpub/2024/422-web_development_with_django_2ed/14_testing_your_django_applications) | 15 Django Third-Party Libraries | [ 16 Using a Frontend JavaScript Library with Django ](/packtpub/2024/422-web_development_with_django_2ed/16_using_a_frontend_javascript_library_with_django) ≫ |
|:----:|:----:|:----:|

# 15 Django Third-Party Libraries

Django Third-Party Libraries
Because Django has been around since 2007, there is a rich ecosystem of third-party libraries that can be plugged into an application to give it extra features. So far, we have learned a lot about Django and used many of its features, including database models, URL routing, templating, forms, and more. We used these Django tools directly to build a web app, but now we will look at how to leverage the work of others to quickly add even more advanced features to our own apps. We have alluded to apps for storing files (in Chapter 5, Serving Static Files, we mentioned an app, django-storages, that can store our static files in a CDN), but in addition to file storage, we can also use apps to plug into third-party authentication systems, integrate with payment gateways, customize how our settings are built, modify images, build forms more easily, debug our site, use different types of databases, and much more. Chances are that if you want to add a certain feature, an app exists for it.

We don’t have space to cover every app in this chapter, so we’ll just focus on four that provide useful features across many different types of apps. django-configurations allows you to configure your Django settings using classes and take advantage of inheritance to simplify settings for different environments. This works in tandem with dj-database-urls to specify your database connection setting using just a URL. The Django Debug Toolbar lets you get extra information to help with debugging, right in your browser. The last app we’ll look at is django-crispy-forms, which provides extra CSS classes to make forms look nicer, as well as making them easier to configure using just Python code.

For each of these libraries, we will cover its installation, basic setup, and use, mostly as they apply to Bookr. They also have more configuration options to further customize to fit your application. Each of these apps can be installed with pip.

We will also briefly introduce django-allauth, which allows a Django application to authenticate users against third-party providers (such as Google, GitHub, Facebook, and Twitter). We won’t cover its installation and setup in detail but will provide some examples to help you configure it.

In this chapter, we will cover the following topics:

Environment variables
django-configurations
dj-database-urls
The Django Debug Toolbar
django-crispy-forms
django-allauth
Technical requirements
All the code files for this chapter can be found at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter15.

Environment variables
When we create a program, we often want the user to be able to configure some of its behavior. For example, say you have a program that connects to a database and saves all the records it finds into a file. Normally, it would probably print out just a success message to the terminal, but you might also want to run it in debug mode, which also makes it print out all the SQL statements it is executing.

There are many ways of configuring a program like this. For example, you could have it read from a configuration file. But in some cases, the user may quickly want to run the Django server with a particular setting on (say, debug mode), and then run the server again with the same setting off. Having to change the configuration file every time can be inconvenient. In this case, we can read from an environment variable. Environment variables are key-value pairs that can be set in your operating system and then read by a program. There are several ways they can be set:

Your shell (terminal) can read variables from a profile script when it starts, then each program will have access to these variables.
You can set a variable inside a terminal, and it will be made available to any programs that start subsequently. In Linux and macOS, this is done with the export command; Windows uses the set command. Any variables you set in this way override those in the profile script, but only for the current session. When you close the terminal, the variables are lost.
You can set environment variables at the same time as running a command in a terminal. These will only persist for the program being run, and they override exported environment variables and those read from a profile script.
You can set environment variables inside a running program, and they will be available only inside the program (or for programs that your program starts). Environment variables set in this way will override all the other methods we have just set.
These might sound complicated, but we will explain them with a short Python script and show how variables can be set in the last three ways (the first method depends on what shell you use). The script will also show how environment variables are read.

Environment variables are available in Python using the os.environ variable. This is a dictionary-like object that can be used to access environment variables by name. It is safest to access values using the get method, just in case they are not set. It also provides a setdefault method, which allows you to set a value only if it is not set (that is, it doesn’t overwrite an existing key).

Here is the example Python script that reads environment variables:

import os
# This will set the value since it's not already set
os.environ.setdefault('UNSET_VAR', 'UNSET_VAR_VALUE')
# This value will not be set since it's already passed
# in from the command line
os.environ.setdefault('SET_VAR', 'SET_VAR_VALUE')
print(f"UNSET_VAR: {os.environ.get('UNSET_VAR', '')}")
print(f"SET_VAR: {os.environ.get('SET_VAR', '')}")
# All these values were provided from the shell in some way
print(f"HOME: {os.environ.get('HOME', '')}")
print(f"VAR1: {os.environ.get('VAR1', '')}")
print(f"VAR2: {os.environ.get('VAR2', '')}")
print(f"VAR3: {os.environ.get('VAR3', '')}")
print(f"VAR4: {os.environ.get('VAR4', '')}")

Copy

Explain
We then set up our shell by setting some variables. In Linux or macOS, we use export (note there is no output from these commands):

$ export SET_VAR="Set Using Export"
$ export VAR1="Set Using Export"
$ export VAR2="Set Using Export"

Copy

Explain
In Windows, we will use the set command in the command line, as follows:

set SET_VAR="Set Using Export"
set VAR1="Set Using Export"
set VAR2="Set Using Export"

Copy

Explain
In Linux and macOS, we can also provide environment variables by setting them before the command (the actual command is just python3 env_example.py):

$ VAR2="Set From Command Line" VAR3="Also Set From Command Line" python3 env_example.py

Copy

Explain
Important note

Note that the preceding command will not work on Windows. For Windows, the environment variables must be set before execution and cannot be passed in at the same time.

The output from this preceding command is as follows:

UNSET_VAR:UNSET_VAR_VALUE
SET_VAR:Set Using Export
HOME: /Users/ben
VAR1: Set Using Export
VAR2: Set From Command Line
VAR3: Also Set From Command Line
VAR4:

Copy

Explain
This is how the environment variables are interpreted by the Python script:

When the script runs os.environ.setdefault('UNSET_VAR', 'UNSET_VAR_VALUE'), the value is set inside the script, since no value for UNSET_VAR was set by the shell. The value that is output is the one set by the script itself.
When os.environ.setdefault('SET_VAR', 'SET_VAR_VALUE') is executed, the value is not set, since one was provided by the shell. This was set with the export SET_VAR="Set Using Export" command.
The value for HOME was not set by any of the commands that were run – this is one provided by the shell. It is the user’s home directory. This is just an example of an environment variable that a shell normally provides.
VAR1 was set by export and was not overridden when executing the script.
VAR2 was set by export but was subsequently overridden when executing the script.
VAR3 was only set when executing the script.
VAR4 was never set – we use the get method to access it to avoid a KeyError.
Now that environment variables have been covered, we can return to discussing the changes that need to be made to manage.py to support django-configurations.

django-configurations
One of the main considerations when deploying a Django application to production is how to configure it. As you have seen throughout this book, the settings.py file is where all your Django configuration is defined. Even third-party apps have their configuration in this file. You have already seen this in Chapter 12, Building a REST API, when working with the Django REST framework.

There are many ways to provide different configurations and switch between them in Django. If you have begun working on an existing application that already has a specific method of switching between configurations in development and production environments, then you should probably keep using that method.

When we release Bookr onto a product web server, in Chapter 17, Deploying a Django Application (Part 1 – Server Setup), we will need to switch to a production configuration, and that’s when we will use django-configurations.

To install django-configurations, use pip3 as follows:

pip3 install django-configurations

Copy

Explain
Important note

For Windows, you can use pip instead of pip3 in the preceding command.

The output will be as follows:

Collecting django-configurations
  Downloading django_configurations-2.4-py3-none-any.whl
  (17 kB)
Requirement already satisfied: django>=3.2 in /Users/ben/.virtualenvs/bookr/lib/python3.8/site-packages (from django-configurations) (4.0)
Requirement already satisfied: sqlparse>=0.2.2 in /Users/ben/.virtualenvs/bookr/lib/python3.8/site-packages (from django>=3.2->django-configurations) (0.4.2)
Requirement already satisfied: asgiref<4,>=3.4.1 in /Users/ben/.virtualenvs/bookr/lib/python3.8/site-packages (from django>=3.2->django-configurations) (3.4.1)
Requirement already satisfied: backports.zoneinfo; python_version < "3.9" in /Users/ben/.virtualenvs/bookr/lib/python3.8/site-packages (from django>=3.2->django-configurations) (0.2.1)
Installing collected packages: django-configurations
Successfully installed django-configurations-2.4

Copy

Explain
django-configurations changes your settings.py file so that all the settings are read from a class you define, which will be a subclass of configurations.Configuration. Instead of the settings being global variables inside settings.py, they will be attributes of the class you define. By using this class-based method, we can take advantage of object-oriented paradigms, most notably inheritance. Settings, defined in a class, can inherit settings from another class. For example, the production settings class can inherit the development settings class and just override some specific settings – such as forcing DEBUG to be False in production.

We can illustrate what needs to be done to the settings file by just showing the first few settings in the file. A standard Django settings.py file normally starts like this (comment lines have been removed):

  from pathlib import Path
  BASE_DIR = Path( file ).resolve().parent.parent
  SECRET_KEY = "django-insecure-c!...-pz6s^_k6w#eo7&"
  DEBUG = True
  # The rest of the settings are not shown

Copy

Explain
To convert the settings into django-configurations, first import Configuration from configurations. Then, define a Configuration subclass. Finally, indent all the settings to be under the class. In PyCharm, this is as simple as selecting all the settings and pressing Tab to indent them all.

After doing this, your settings.py file will look like this:

from pathlib import Path
from configurations import Configuration
class Dev(Configuration):
    BASE_DIR = Path(__file__).resolve().parent.parent
    SECRET_KEY = "django-insecure-c!…&xxf*skpgkey6%$ld-
    pz6s^_k6w#eo7&"
    DEBUG = True
    …
    # All other settings indented in the same manner

Copy

Explain
To have different configurations (different sets of settings), you can just extend your configuration classes and override the settings that should differ.

For example, one variable that needs overriding in production is DEBUG; it should be False (for security and performance reasons). A Prod class can be defined that extends Dev and sets DEBUG, like this:

class Dev(Configuration):
    DEBUG = True
    …
    # Other settings truncated
class Prod(Dev):
    DEBUG = False
    # no other settings defined since we're only overriding
    DEBUG

Copy

Explain
Of course, you can override other production settings too, not just DEBUG. Usually, for security, you would also redefine SECRET_KEY and ALLOWED_HOSTS, and to configure Django to use your production database, you’d set the DATABASES value too. Any Django setting can be configured as you choose.

If you try to execute runserver (or other management commands) now, you will get an error because Django doesn’t know how to find the settings.py file when the settings files are laid out like this:

django.core.exceptions.ImproperlyConfigured: django-configurations settings importer wasn't correctly installed. Please use one of the starter functions to install it as mentioned in the docs: https://django-configurations.readthedocs.io/

Copy

Explain
We need to make some changes to the manage.py file before it starts to work again.

manage.py changes
There are two lines that need to be added/changed in manage.py to enable django-configurations. First, we need to define a default environment variable that tells the Django configuration which Configuration class it should load.

This line should be added in the main() function to set the default value for the DJANGO_CONFIGURATION environment variable:

os.environ.setdefault('DJANGO_CONFIGURATION', 'Dev')

Copy

Explain
This sets the default to Dev – the name of the class we defined. As we saw in our example script, if this value is already defined, it won’t be overwritten. This will allow us to switch between configurations using an environment variable.

The second change is to swap the execute_from_command_line function with one that django-configurations provides. Consider the following line:

from django.core.management import execute_from_command_line

Copy

Explain
This line is changed as follows:

from configurations.management import execute_from_command_line

Copy

Explain
From now on, manage.py will work as it did before, except it now prints out which Configuration class it’s using when it starts (Figure 15.1):

Figure 15.1 – django-configurations using configuration Dev
Figure 15.1 – django-configurations using configuration Dev

In the second line, you can see the django-configurations output that uses the Dev class for settings.

Configuration from environment variables
As well as switching between Configuration classes using environment variables, django-configurations lets us give values for individual settings using environment variables. It provides Value classes that will automatically read values from the environment. We can define defaults if no values are provided. Since environment variables are always strings, the different Value classes are used to convert from a string into the specified type.

Let’s look at this in practice with a few examples. We will allow DEBUG, ALLOWED_HOSTS, TIME_ZONE, and SECRET_KEY to be set with environment variables as follows:

  from configurations import Configuration, values
  class Dev(Configuration):
      DEBUG = values.BooleanValue(True)
      ALLOWED_HOSTS = values.ListValue([])
      TIME_ZONE = values.Value('UTC')
      SECRET_KEY = "django-insecure-c!...-pz6s^_k6w#eo7&"
      …
      # Other settings truncated
  class Prod(Dev):
     DEBUG = False
     SECRET_KEY = values.SecretValue()     
     # no other settings are present

Copy

Explain
We’ll explain the settings one at a time:

In Dev, DEBUG is read from an environment variable and cast to a Boolean value. The values yes, y, true, and 1 become True; the values no, n, false, and 0 become False. This allows us to run with DEBUG off, even on a development machine, which can be useful in some cases (for example, testing a custom exception page rather than Django’s default one). In the Prod configuration, we don’t want DEBUG to accidentally become True, so we set it statically.
ALLOWED_HOSTS is required in production. It is a list of hosts for which Django should accept requests.
The ListValue class will convert a comma-separated string into a Python list.
For example, the www.example.com,example.com string is converted into ["www.example.com", "example.com"].

TIME_ZONE accepts just a string value, so it is set using the Value class. This class just reads the environment variable and does not transform it at all.
SECRET_KEY is statically defined in the Dev configuration; it can’t be changed with an environment variable. In the Prod configuration, it is set with SecretValue. This is like Value in that it is just a string setting; however, it does not allow a default. If a default is set, then an exception is raised. This is to ensure you don’t ever put a secret value into settings.py, since it might be accidentally shared (for example, uploaded to GitHub). Note that since we do not use SECRET_KEY for Dev in production, we don’t care if it’s leaked.
By default, django-configurations expects the DJANGO_ prefix for each environment variable. For example, to set DEBUG, use the DJANGO_DEBUG environment variable, and to set ALLOWED_HOSTS, use DJANGO_ALLOWED_HOSTS.

Now that we’ve introduced django-configurations and the changes that need to be made to a project to support it, let’s add it to Bookr and make those changes. In the next exercise, we will install and set up django-configurations in Bookr.

Exercise 15.01 – Django configurations setup
In this exercise, we will install django-configurations using pip, and then update settings.py to add a Dev and Prod configuration. We’ll then make the necessary changes to manage.py to support the new configuration style, and test that everything is still working. Let’s get started with the steps:

In a terminal, make sure you have activated the bookr virtual environment, and then run the following command to install django-configurations using pip3:
pip3 install django-configurations

Copy

Explain
Note

For Windows, you can use pip instead of pip3 in the preceding command.

The install process will run, and you should have an output like Figure 15.2:

Figure 15.2 – django-configurations installation with pip
Figure 15.2 – django-configurations installation with pip

In PyCharm, open settings.py inside the bookr package. Underneath the existing os import, import Configuration and values from configurations, like this:
from configurations import Configuration, values

Copy

Explain
After the imports but before your first setting definition (the line that sets the BASE_DIR value), add a new Configuration subclass, called Dev:
class Dev(Configuration):

Copy

Explain
Now, we need to move all the existing settings so that they are attributes of the Dev class rather than global variables. In PyCharm, this is as simple as selecting all the settings and then pressing the Tab key to indent them. After doing this, your settings should look as follows:
Figure 15.3 – The new Dev configuration
Figure 15.3 – The new Dev configuration

After indenting the settings, we will change some of the settings to be read from environment variables. First, change DEBUG to be read as BooleanValue. It should default to True. Consider this line:
    DEBUG = True

Copy

Explain
Then, change it to this:

    DEBUG = values.BooleanValue(True)

Copy

Explain
This will automatically read DEBUG from the DJANGO_DEBUG environment variable and convert it into a Boolean. If the environment variable is not set, then it will default to True.

Also, convert ALLOWED_HOSTS to be read from an environment variable, using the values.ListValue class. It should default to [] (an empty list). Consider the following line:
    ALLOWED_HOSTS = []

Copy

Explain
Change it to this:

    ALLOWED_HOSTS = values.ListValue([])

Copy

Explain
ALLOWED_HOSTS will be read from the DJANGO_ALLOWED_HOSTS environment variable, and default to an empty list.

Everything you have done so far has involved adding/changing attributes on the Dev class. Now, at the end of the same file, add a Prod class that inherits from Dev. It should define two attributes, DEBUG = True and SECRET_KEY = values.SecretValue(). The completed class should look like this:
class Prod(Dev):
    DEBUG = False
    SECRET_KEY = values.SecretValue()

Copy

Explain
Save settings.py.

If we try to run any management command now, we will receive an error that django-configurations is not set up properly. We need to make some changes to manage.py to make it work again. Open manage.py in the bookr project directory.
Consider the line that reads as follows:

  os.environ.setdefault('DJANGO_SETTINGS_MODULE',
                        'bookr.settings')

Copy

Explain
Under it, add this line:

os.environ.setdefault('DJANGO_CONFIGURATION', 'Dev')

Copy

Explain
This will set the default configuration to the Dev class. It can be overridden by setting the DJANGO_CONFIGURATION environment variable (for example, to Prod).

Two lines below the line from the previous step, you should already have the following import statement:
from django.core.management import execute_from_command_line

Copy

Explain
Change this to the following:

from configurations.management import execute_from_command_line

Copy

Explain
This will make the manage.py script use the Django configuration’s execute_from_command_line function, instead of the Django built-in one.

Save manage.py.

Start the Django dev server. If it begins without error, you can be confident that the changes you made have worked. To be sure, check that the pages load in your browser. Open http://127.0.0.1:8000/ and try browsing around the site. Everything should look and feel as it did before:
Figure 15.4 – The Bookr site should look and feel as it did before
Figure 15.4 – The Bookr site should look and feel as it did before

In this exercise, we installed django-configurations and refactored our settings.py file to use its Configuration class to define our settings. We added the Dev and Prod configurations and made DEBUG, ALLOWED_HOSTS, and SECRET_KEY settable with environment variables. Finally, we updated manage.py to use the Django configuration’s execute_from_command_line function, which enabled the use of this new settings.py format.

In the next section, we will cover dj-database-url, a package that makes it possible to configure your Django database settings using URLs.

dj-database-url
dj-database-url is another app that helps with the configuration of your Django application. Specifically, it allows you to set the database (that your Django app connects to) using a URL instead of a dictionary of configuration values. As you can see in your existing settings.py file, the DATABASES setting contains a couple of items and gets more verbose when using a different database that has more configuration options (for username, password, and so on). We can instead set these from a URL, which can contain all these values.

The URL’s format will differ slightly, depending on whether you are using a local SQLite database or a remote database server. To use SQLlite on disk (as Bookr is currently), the URL is like this:

sqlite:///<path>

Copy

Explain
Note there are three slashes present. This is because SQLite doesn’t have a hostname, so this is like a URL being like this:

<protocol>://<hostname>/<path>

Copy

Explain
That is, the URL has a blank hostname. All three slashes are, therefore, together.

To build a URL for a remote database server, the format is usually like this:

<protocol>://<username>:<password>@<hostname>:<port>/
<database_name>

Copy

Explain
For example, to connect to a PostgreSQL database called bookr_django on the host, db.example.com, on port 5432, with the username bookr and the password b00ks, the URL would be like this:

postgres://bookr:b00ks@db.example.com:5432/bookr_django

Copy

Explain
Now that we’ve seen the format for URLs, let’s look at how we can actually use them in our settings.py file. First, dj-database-url must be installed using pip3:

pip3 install dj-database-url

Copy

Explain
Note

For Windows, you can use pip instead of pip3 in the preceding command.

The output is as follows:

Collecting dj-database-url
  Downloading https://files.pythonhosted.org/packages/d4/a6/4b8578c1848690d0c307c7c0596af2077536c9ef2a04d42b00fabaa 7e49d/dj_database_url-0.5.0-py2.py3-none-any.whl
Installing collected packages: dj-database-url
Successfully installed dj-database-url-0.5.0

Copy

Explain
Now, dj_database_url can be imported into settings.py, and the dj_database_url.parse method can be used to transform the URL into a dictionary that Django can use. We can use its return value to set the default (or other) item in the DATABASES dictionary:

import dj_database_url
DATABASES = {'default': dj_database_url.parse( 
'postgres://bookr:b00ks@db.example.com:5432/bookr_django'
)}

Copy

Explain
Alternatively, for our SQLite database, we can utilize the BASE_DIR setting, as we are already, and include it in the URL:

import dj_database_url
DATABASES = {'default': dj_database_url.parse(
    f'sqlite:///{BASE_DIR}/db.sqlite3')}

Copy

Explain
After parsing, the DATABASES dictionary is similar to what we defined before. It includes some redundant items that do not apply to an SQLite database (USER, PASSWORD, HOST, and so on), but Django will ignore them:

DATABASES = {
    'default': {
        'NAME': '/Users/ben/bookr/bookr/db.sqlite3',
        'USER': '',
        'PASSWORD': '',
        'HOST': '',
        'PORT': '',
        'CONN_MAX_AGE': 0,
        'ENGINE': 'django.db.backends.sqlite3'
    }
}

Copy

Explain
This method of setting the database connection information is not that useful, since we are still statically defining the data in settings.py. The only difference is that we are using a URL instead of a dictionary. dj-database-url can also automatically read the URL from an environment variable. This will allow us to override these values by setting them in the environment.

To read the data from the environment, use the dj_database_url.config function, like this:

import dj_database_url
DATABASES = {'default': dj_database_url.config()}

Copy

Explain
The URL is automatically read from the DATABASE_URL environment variable.

We can improve on this by also providing a default argument to the config function. This is the URL that will be used by default if one is not specified in an environment variable:

  import dj_database_url
  DATABASES = {
      'default': dj_database_url.config(
          default=f'sqlite:///{BASE_DIR}/db.sqlite3')}

Copy

Explain
This way, we can specify a default URL that can be overridden by an environment variable in production.

We can also specify the environment variable that the URL is read from by passing in the env argument – this is the first positional argument. In this way, you could read multiple URLs for different database settings:

import dj_database_url
DATABASES = {
    'default': dj_database_url.config(
        default=f'sqlite:///{BASE_DIR}/db.sqlite3'),
    'secondary': dj_database_url.config(
        'DATABASE_URL_SECONDARY',
    default=f'sqlite:///{BASE_DIR}/db-secondary.sqlite3')
}

Copy

Explain
In this example, the default item’s URL is read from the DATABASE_URL environment variable, and secondary is read from DATABASE_URL_SECONDARY.

django-configurations also provides a config class that works in tandem with dj_database_url: DatabaseURLValue. This differs slightly from dj_database_url.config in that it generates the entire DATABASES dictionary, including the default item. For example, consider the following code:

import dj_database_url
DATABASES = {'default': dj_database_url.config()}

Copy

Explain
This code is equivalent to the following:

from configurations import values
DATABASES = values.DatabaseURLValue()

Copy

Explain
Do not write DATABASES['default'] = values.DatabaseURLValue(), as your dictionary will be doubly nested.

If you need to specify multiple databases, you will need to fall back to dj_database_url.config directly, rather than using DatabaseURLValue.

Like other values classes, DatabaseURLValue takes a default value as its first argument. You might also want to use the environment_prefix argument and set it to DJANGO so that the environment variable being read is consistently named with the others. A full example of using DatabaseURLValue would, therefore, be like this:

DATABASES = values.DatabaseURLValue(
    f'sqlite:///{BASE_DIR}/db.sqlite3',
    environ_prefix='DJANGO')

Copy

Explain
By setting the environment_prefix like this, we can set the database URL using the DJANGO_DATABASE_URL environment variable (rather than just DATABASE_URL). This means it is consistent with other environment variable settings that also start with DJANGO_, such as DJANGO_DEBUG or DJANGO_ALLOWED_HOSTS.

Note that even though we are not importing dj-database-url in settings.py, django-configurations uses it internally, so it still must be installed.

In the next exercise, we will configure Bookr to use DatabaseURLValue to set its database configuration. It will be able to read from an environment variable and fall back to a default we specify.

Exercise 15.02 – dj-database-url and setup
In this exercise, we will install dj-database-url using pip3. Then, we will update Bookr’s settings.py to configure the DATABASE setting using a URL, which is read from an environment variable. Let’s get started with the steps:

In a terminal, make sure you have activated the bookr virtual environment, and then run the following command to install dj-database-url using pip3:
pip3 install dj-database-url

Copy

Explain
The installation process will run, and you should have output similar to this:

Figure 15.5 – dj-database-url installation with pip
Figure 15.5 – dj-database-url installation with pip

In PyCharm, open settings.py in the bookr package directory. Scroll down to find where the DATABASES attribute is being defined. Replace it with the values.DatabaseURLValue class. The first argument (default value) should be the URL to the SQLite database: f'sqlite:///{BASE_DIR}/db.sqlite3'. Also, pass in environ_prefix, set to DJANGO. After completing this step, you should be setting the attribute like this:
    DATABASES = values.DatabaseURLValue(
        f'sqlite:///{BASE_DIR}/db.sqlite3',
        environ_prefix='DJANGO'
    )

Copy

Explain
Save settings.py.

Start the Django dev server. As with Exercise 15.01 – Django configurations setup, if it starts fine, you can be confident that your change was successful. To be sure, open http://127.0.0.1:8000/ in a browser and check that everything looks and behaves as it did before. You should visit a page that queries from the database (such as the Books List page) and check that a list of books is displayed:
Figure 15.6 – Bookr pages with database queries still work﻿ing
Figure 15.6 – Bookr pages with database queries still working

In this exercise, we updated our settings.py to determine its DATABASES setting from a URL specified in an environment variable. We used the values.DatabaseURLValue class to automatically read the value, and provided a default URL. We also set the environ_prefix argument to DJANGO so that the environment variable name is DJANGO_DATABASE_URL, which is consistent with other settings.

In the next section, we will take a tour of the Django Debug Toolbar, an app that helps you debug your Django applications through the browser.

The Django Debug Toolbar
The Django Debug Toolbar is an app that displays debug information about a web page right in your browser. It includes information about what SQL commands were run to generate the page, the request and response headers, how long the page took to render, and more. These can be useful in the following situations:

A page is taking a long time to load – maybe it is running too many database queries. You can see whether the same queries are being run multiple times, in which case you could consider caching. Otherwise, some queries can be sped up by adding an index to the database.
You want to determine why a page is returning the wrong information. Your browser may have sent headers you did not expect, or maybe some headers from Django are incorrect.
Your page is slow because it is spending time on non-database code – you can profile the page to see what functions are taking the longest.
The page looks incorrect. You can see what templates Django rendered. There might be a third-party template that is being rendered unexpectedly. You can also check all the settings that are being used (including the built-in Django ones that we are not setting). This can help to pinpoint a setting that is incorrect and causing the page to not behave correctly.
We’ll explain how to use the Django Debug Toolbar to see this information. Before diving into how to set up the Django Debug Toolbar and use it, let’s take a quick look at it. The toolbar is shown on the right of the browser window and can be toggled open and closed to display information:

Figure 15.7 – The Django Debug Toolbar closed
Figure 15.7 – The Django Debug Toolbar closed

The preceding figure shows the Django Debug Toolbar in its closed state. Note the toggle bar in the top-right corner of the window. Clicking the toolbar opens it:

Figure 15.8 – The Django Debug Toolbar open
Figure 15.8 – The Django Debug Toolbar open

Figure 15.8 shows the Django Debug Toolbar open.

Installing the Django Debug Toolbar is done using pip:

pip3 install django-debug-toolbar

Copy

Explain
Note

For Windows, you can use pip instead of pip3 in the preceding command.

Then, there are a few steps to set it up, mostly by making changes to settings.py:

Add debug_toolbar to the INSTALLED_APPS settings list.
Add debug_toolbar.middleware.DebugToolbarMiddleware to the MIDDLEWARE settings list. It should be done as early as possible; for Bookr, it can be the first item on the list. This is the middleware that all requests and responses pass through.
Add '127.0.0.1' to the INTERNAL_IPS settings list (this setting may have to be created). The Django Debug Toolbar will only show IP addresses listed here.
Add the Django Debug Toolbar URLs to the base urls.py file. We want to add this mapping only if we are in DEBUG mode:
path('__debug__/', include(debug_toolbar.urls))

Copy

Explain
In the next exercise, we will go through these steps in detail.

Once the Django Debug Toolbar is installed and set up, any page you visit will show the DjDT sidebar (you can open or close it using the DjDT menu). When it’s open, you’ll be able to see another set of sections that you can click on to get more information.

Each panel has a checkbox next to it, this allows you to enable or disable the collection of that metric. Each metric that is collected will slightly slow down the page load (although, usually, this is not noticeable). If you find that one metric collection is slow, you can turn it off here. In the following points, we will go over each panel of this toolbar:

The first is History, which shows the history of requests made in the browser. You can switch to previous requests in order to see the stats associated with them in the Django Debug Toolbar (Figure 15.9):
Figure 15.9 – The DjDT History panel (screenshot cropped for brevity)
Figure 15.9 – The DjDT History panel (screenshot cropped for brevity)

The second panel is Versions, which shows the version of Django running. You can click it to open a large Versions display, which will also show the version of Python and the Django Debug Toolbar (Figure 15.10):
Figure 15.10 – The DjDT Versions panel (screenshot cropped for brevity)
Figure 15.10 – The DjDT Versions panel (screenshot cropped for brevity)

The third panel is Time, which shows how long it took to process the request. It is broken down into system time and user time as well (Figure 15.11):
Figure 15.11 – The DjDT Time panel
Figure 15.11 – The DjDT Time panel

The differences between system time and user time are beyond the scope of this book; basically, system time is time spent in the kernel (for example, doing network or file reading/writing) and user time is code that is outside the operating system kernel (this includes the code you’ve written in Django, Python, and so on).

Also shown is the time spent in the browser, such as the time taken to get a request and how long it took to render a page.

The fourth panel, Settings, shows all the settings your application is using (Figure 15.12):
Figure 15.12 – THe DjDT Settings panel
Figure 15.12 – THe DjDT Settings panel

This is useful because it shows both your settings from settings.py and the default Django settings.

The fifth panel is Headers (Figure 15.13). It shows the headers of the request the browser made and the response headers that Django has sent:
Figure 15.13 – The DjDT Headers panel
Figure 15.13 – The DjDT Headers panel

The sixth panel, Request, shows the view that generated the response, and the arguments and keyword arguments (args and kwargs parameters) that it was called with (Figure 15.14). You can also see the name of the URL used in URL map:
Figure 15.14 – The DjDT Request panel (some panels not shown for brevity)
Figure 15.14 – The DjDT Request panel (some panels not shown for brevity)

It also shows the request’s cookies, the information stored in the session (sessions were introduced in Chapter 8, Media Serving and File Upload), as well as the request.GET and request.POST data.

The seventh panel, SQL, shows all the SQL database queries that were executed when building the response (Figure 15.15):
Figure 15.15 – The DjDT SQL panel
Figure 15.15 – The DjDT SQL panel

You can see how long each query took to execute and in what order they were executed. It also flags similar and duplicate queries so that you can potentially refactor your code to remove them.

Each SELECT query displays two action buttons, Sel, short for select, and Expl, short for explain. These do not show up for INSERT, UDPATE, or DELETE queries.

The Sel button shows the SELECT statement that was executed and all the data that was retrieved for the query (Figure 15.16):

Figure 15.16 – The DjDT SQL selected panel
Figure 15.16 – The DjDT SQL selected panel

The Expl button shows the EXPLAIN query for the SELECT query (Figure 15.17):

Figure 15.17 – The DjDT SQL explained panel (some panels not shown for brevity)
Figure 15.17 – The DjDT SQL explained panel (some panels not shown for brevity)

EXPLAIN queries are beyond the scope of the book, but they basically show how a database tried to execute the SELECT query – for example, what database indexes were used. You might find that a query does not use an index and you can, therefore, get faster performance by adding one.

The eighth panel is Static files, and it shows you which static files were loaded in this request (Figure 15.18). It also shows you all the static files that are available and how they would be loaded (that is, which static file finder found them). The Static files panel’s information is like the information you can get from the findstatic management command:
Figure 15.18 – The DjDT Static files panel
Figure 15.18 – The DjDT Static files panel

The ninth panel, Templates, shows information about the templates that were rendered (Figure 15.19):
Figure 15.19 – The DjDT Templates panel
Figure 15.19 – The DjDT Templates panel

It shows the paths the templates were loaded from and the inheritance chain.

The 10th panel, Cache, shows information about data fetched from Django’s cache:
Figure 15.20 – The DjDT Cache panel (some panels not shown for brevity)
Figure 15.20 – The DjDT Cache panel (some panels not shown for brevity)

Since we aren’t using caching in Bookr, this section is blank. If we were, we would be able to see how many requests to the cache had been made, and how many of those requests were successful in retrieving items. We would also see how many items had been added to the cache. This can give you an idea about whether you are using the cache effectively or not. If you are adding a lot of items to the cache but not retrieving any, then you should reconsider what data you are caching. Conversely, if you have a lot of cache misses (a miss is when you request data that is not in the cache), then you should be caching more data than you are already.

The 11th panel is Signals, which shows information about Django signals (Figure 15.21):
Figure 15.21 – The DjDT Signals panel (some panels not shown for brevity)
Figure 15.21 – The DjDT Signals panel (some panels not shown for brevity)

While we won’t cover signals in this book, suffice to say, they are like events that you can hook into to execute functions when Django does something – for example, if a user is created, sending them a welcome email. This section shows which signals were sent and which functions received them.

The 12th panel, Logging, shows log messages that were generated by your Django app (Figure 15.22):
Figure 15.22 – The DjDT Logging panel
Figure 15.22 – The DjDT Logging panel

Since no log messages were generated in this request, this panel is empty.

The next option, Intercept redirects, is not a section with data. Instead, it lets you toggle redirect interception. If your view returns a redirect, it will not be followed. Instead, a page like Figure 15.22 is displayed:

Figure 15.23 – A redirect that DjDT has intercepted
Figure 15.23 – A redirect that DjDT has intercepted

This allows you to open the Django Debug Toolbar for the view that generated the redirect; otherwise, you’d only be able to see the information for the view that you were redirected to.

The final panel is Profiling. This is off by default, as profiling can slow down your response quite a lot. Once it is turned on, you must refresh the page to generate the profiling information (shown in Figure 15.24):
Figure 15.24 – The DjDT Profiling panel
Figure 15.24 – The DjDT Profiling panel

The information shown here is a breakdown of how long each function call in your response took. The left of the page shows a stack trace of all the calls performed. On the right are columns with timing data. The columns are as follows:

CumTime: The cumulative amount of time spent in the function and any sub-functions it calls
Per: The cumulative time divided by the number of calls (Count)
TotTime: The amount of time spent in this function but not in any sub-function it calls
A second Per: The total time divided by the number of calls (Count)
Count: The number of calls of this function
This information can help you determine how to speed up your app. For example, it can be easier to speed up a function that is called 1,000 times by a small fraction than to optimize a large function that is only called once. Any more in-depth tips on how to speed up your code are beyond the scope of this book.

We will reinforce what we have learned about the Django Debug Toolbar by installing and configuring it in the following exercise.

Exercise 15.03 – setting up the Django Debug Toolbar
In this exercise, we will add the Django Debug Toolbar settings by modifying the INSTALLED_APPS, MIDDLEWARE, and INTERNAL_IPS settings. Then, we’ll add the debug_toolbar.urls map to the bookr package’s urls.py file. Finally, we will load a page with the Django Debug Toolbar in a browser and use it:

In a terminal, make sure you have activated the bookr virtual environment, and then run the following command to install the Django Debug Toolbar using pip3:
pip3 install django-debug-toolbar

Copy

Explain
Note

For Windows, you can use pip instead of pip3 in the preceding command.

The install process will run, and you should have output similar to Figure 15.25:

Figure 15.25 – django-debug-toolbar installation with pip
Figure 15.25 – django-debug-toolbar installation with pip

Open settings.py in the bookr package directory. Add debug_toolbar to the INSTALLED_APPS setting:
INSTALLED_APPS = […
    'debug_toolbar',
]

Copy

Explain
This will allow Django to find the Django Debug Toolbar’s static files.

Add debug_toolbar.middleware.DebugToolbarMiddleware to the MIDDLEWARE setting – it should be the first item in the list:
MIDDLEWARE = [
    'debug_toolbar.middleware.DebugToolbarMiddleware',
…]

Copy

Explain
This will route requests and responses through DebugToolbarMiddleware, allowing the Django Debug Toolbar to inspect the request and insert its HTML into the response.

The final setting to add is the 127.0.0.1 address to INTERNAL_IPS. You will not yet have an INTERNAL_IPS setting defined, so add this as a setting:
INTERNAL_IPS = ['127.0.0.1']

Copy

Explain
This will make the Django Debug Toolbar only show up on the developer’s computer. You can now save settings.py.

We now need to add the Django Debug Toolbar URLs. Open urls.py in the bookr package directory. We already have an if condition that checks for DEBUG mode and then adds the media URL, like so:
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL,
    document_root=settings.MEDIA_ROOT)

Copy

Explain
We will also add include to debug_toolbar.urls inside this if statement; however, we will add it to the start of urlpatterns, rather than appending it to the end. Add this code inside the if statement:

    import debug_toolbar
    urlpatterns = [
        path('__debug__/',
            include(debug_toolbar.urls)),
    ] + urlpatterns

Copy

Explain
Save urls.py.

Start the Django dev server if it is not already running and navigate to http://127.0.0.1:8000. You should see the Django Debug Toolbar open. If it is not open, click the DjDT toggle button at the top-right to open it:
Figure 15.26 – The DjDT toggle shown in the corner
Figure 15.26 – The DjDT toggle shown in the corner

Try going through some of the panels and visiting different pages to see what information you can find out. Try also turning on Intercept redirects and then creating a new book review. After submitting the form, you should see the intercepted page, rather than being redirected to the new review (Figure 15.27):
Figure 15.27 – The redirect intercept page after submitting a new review
Figure 15.27 – The redirect intercept page after submitting a new review

You can then click the Location link to go to the page that it was being redirected to.

You can also try turning on Profiling and seeing which functions are being called a lot and which are taking up most of the rendering time.
Once you are finished experimenting with the Django Debug Toolbar, turn off Intercept redirects and Profiling.
In this exercise, we installed and set up the Django Debug Toolbar by adding settings and URL maps. We then saw it in action and examined the useful information it can give us, including how to work with redirects and see profiling information.

In the next section, we will look at the django-crispy-forms app, which will let us reduce the amount of code needed to write forms.

django-crispy-forms
In Bookr, we are using the Bootstrap CSS framework. It provides styles that can be applied to forms using CSS classes. Since Django is independent of Bootstrap, when we use Django forms, it does not even know that we are using Bootstrap and so has no idea of what classes to apply to form widgets.

django-crispy-forms acts as an intermediary between Django forms and Bootstrap forms. It can take a Django form and render it with the correct Bootstrap elements and classes. It not only supports Bootstrap but also other frameworks, such as Uni-Form and Foundation (although Foundation support must be added using a separate package, crispy-forms-foundation).

Its installation and setup are quite simple. Once again, it is installed with pip3:

pip3 install django-crispy-forms

Copy

Explain
Note

For Windows, you can use pip instead of pip3 in the preceding command.

Then, there are just a couple of settings changes. First, add crispy_forms to your INSTALLED_APPS. Then, you need to tell django-crispy-forms what framework you are using so that it loads the correct templates. This is done with the CRISPY_TEMPLATE_PACK setting. In our case, it should be set to bootstrap4:

CRISPY_TEMPLATE_PACK = 'bootstrap4'

Copy

Explain
django-crispy-forms has two main modes of operation, either as a filter or a template tag. The former is easier to drop into an existing template. The latter allows more configuration options and moves more of the HTML generation into the Form class. We’ll look at both of these in order.

The crispy filter
The first method to render a form with django-crispy-forms is by using the crispy template. First, the filter must be loaded into the template. The library name is crispy_forms_tags:

{% load crispy_forms_tags %}

Copy

Explain
Then, instead of rendering a form with the as_p method (or another method), use the crispy filter. Consider the following line:

{{ form.as_p }}

Copy

Explain
Replace it with this:

{{ form|crispy }}

Copy

Explain
Here’s a quick before-and-after showing the Review Create form. None of the rest of the HTML has been changed, apart from the form rendering. Figure 15.28 shows the standard Django form:

Figure 15.28 – The Review Create form with default styling
Figure 15.28 – The Review Create form with default styling

Figure 15.29 shows the form after django-crispy-forms has added the Bootstrap classes:

Figure 15.29 – The Review Create form with Bootstrap classes added by django-crispy-forms
Figure 15.29 – The Review Create form with Bootstrap classes added by django-crispy-forms

When we integrate django-crispy-forms into Bookr, we will not use this method; however, it is worth knowing about because of how easy it is to drop it into your existing templates.

The crispy template Tag
The other method of rendering a form with django-crispy-forms is with the use of the crispy template tag. To use it, the crispy_forms_tags library must first be loaded into the template (as we did in the previous section). Then, the form is rendered like this:

{% crispy form %}

Copy

Explain
How does this differ from the crispy filter? The crispy template tag will also render the <form> element and the {% csrf_token %} template tag for you. So, consider, for example, that you used it like this:

<form method="post">
  {% csrf_token %}
  {% crispy form %}
</form>

Copy

Explain
The output for this would be as follows:

<form method="post" >
<input type="hidden" name="csrfmiddlewaretoken" value="…">
<form method="post">
<input type="hidden" name="csrfmiddlewaretoken" value="…">
    … form fields …
</form>
</form>

Copy

Explain
That is, the form and CSRF token fields are duplicated. In order to customize the <form> element that is generated, django-crispy-forms provides a FormHelper class, which can be set as a Form instance’s helper attribute. It is the FormHelper instance that the crispy template tag uses to determine what attributes <form> should have.

Let us look at ExampleForm with a helper added. First, import the required modules:

from django import forms
from crispy_forms.helper import FormHelper

Copy

Explain
Next, define a form:

class ExampleForm(forms.Form):
    example_field = forms.CharField()

Copy

Explain
We could instantiate a FormHelper instance and then set it to the form.helper attribute (for example, in a view), but it’s usually more useful to just create and assign it inside the form’s __init__ method. We haven’t created a form with an __init__ method yet, but it’s no different from any other Python class:

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

Copy

Explain
Next, we set the helper and form_method for the helper (which is then rendered in the form’s HTML):

self.helper = FormHelper()
self.helper.form_method = 'post'

Copy

Explain
Other attributes can be set on the helper, such as form_action, form_id, and form_class. We don’t need to use these in Bookr though. We also do not need to manually set enctype on the form or its helper, as the crispy form tag will automatically set this to multipart/form-data if the form contains file upload fields.

If we tried to render the form now, we wouldn’t be able to submit it, as there’s no submit button (remember that we added submit buttons to our forms manually; they are not part of the Django form). django-crispy-forms also includes layout helpers that can be added to the form. They will be rendered after the other fields. We can add a submit button like this – first, import the Submit class:

from crispy_forms.layout import Submit

Copy

Explain
Note

django-crispy-forms does not properly support using a <button> input to submit a form, but for our purposes, <input type="submit"> is functionally identical.

We then instantiate it and add it to the helper’s inputs in a single line:

self.helper.add_input(Submit("submit", "Submit"))

Copy

Explain
The first argument to the Submit constructor is its name, and the second is its label.

django-crispy-forms is aware that we are using Bootstrap and will automatically render the button with the btn btn-primary classes.

The advantage of using a crispy template tag and FormHelper is that it means there is only one place where attributes and the behavior of the form are defined. We are already defining all the form fields in a Form class; this allows us to define the other attributes of the form in the same place. We can change a form from a GET submission to a POST submission easily here. The FormHelper instance will then automatically know that it needs to add a CSRF token to its HTML output when rendered.

We’ll put all this into practice in the next exercise, where you will install django-crispy-forms, update SearchForm to utilize a form helper, and then render it using the crispy template tag.

Exercise 15.04 – using Django Crispy Forms with SearchForm
In this exercise, you will install django-crispy-forms and then convert SearchForm to be usable with the crispy template tag. This will be done by adding an __init__ method and building a FormHelper instance inside it:

In a terminal, make sure you have activated the bookr virtual environment, and then run this command to install django-crispy-forms using pip3:
pip3 install django-crispy-forms

Copy

Explain
Note

For Windows, you can use pip instead of pip3 in the preceding command.

The installation process will run, and you should have output similar to Figure 15.30:

Figure 15.30 – django-crispy-forms installation with pip
Figure 15.30 – django-crispy-forms installation with pip

Open settings.py in the bookr package directory, and then add crispy_forms to your INSTALLED_APPS setting:
    INSTALLED_APPS = […
        'reviews',
        'debug_toolbar',
        'crispy_forms',
    ]

Copy

Explain
This will allow Django to find the required templates.

While in settings.py, add a new setting for CRISPY_TEMPLATE_PACK – its value should be bootstrap4. This should be added as an attribute in the Dev class:
    CRISPY_TEMPLATE_PACK = 'bootstrap4'

Copy

Explain
This lets django-crispy-forms know that it should be using the templates designed for Bootstrap version 4 when rendering forms. You can now save and close settings.py.

Open the reviews app’s forms.py file. First, we need to add two imports to the top of the file – FormHelper from crispy_forms.helper, and Submit from crispy_forms.layout:
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Submit

Copy

Explain
Next, add an __init__ method to SearchForm. It should accept *args and **kwargs as arguments. Then, call the super().__init__ method with them:
class SearchForm(forms.Form):
…
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

Copy

Explain
This will simply pass through whatever arguments are provided to the superclass constructor.

Still inside the __init__ method, set self.helper to an instance of FormHelper. Then, set the helper’s form_method to get. Finally, create an instance of Submit, passing in an empty string as the name (first argument), and Search as the button label (second argument). Add this to the helper with the add_input method:
        self.helper = FormHelper()
        self.helper.form_method = "get"
        self.helper.add_input(Submit("", "Search"))

Copy

Explain
You can save and close forms.py.

In the reviews app’s templates directory, open search-results.html. At the start of the file, after the extends template tag, use a load template tag to load crispy_forms_tags:
{% load crispy_forms_tags %}

Copy

Explain
Locate the existing <form> in the template. It should look like this:
<form>
    {{ form.as_p }}
    <button type="submit" class="btn btn-primary">
    Search</button>
</form>

Copy

Explain
You can delete the entered <form> element and replace it with a crispy template tag:

{% crispy form %}

Copy

Explain
This will use the django-crispy-forms library to render the form, including the <form> element and submit button. After making this change, this portion of the template should look like Figure 15.31:

Figure 15.31 – search-results.html after replacing <form> with the crispy form renderer
Figure 15.31 – search-results.html after replacing <form> with the crispy form renderer

You can now save search-results.html.

Start the Django dev server if it is not already running and go to http://127.0.0.1:8000/book-search/. You should see the book search form as shown in Figure 15.32:
Figure 15.32 – The book search form rendered with django-crispy-forms
Figure 15.32 – The book search form rendered with django-crispy-forms

You should be able to use the form in the same manner as you did before (Figure 15.33):

Figure 15.33 – Performing a search with the updated search form
Figure 15.33 – Performing a search with the updated search form

Try viewing the source of the page in your web browser to see the rendered output. You will see that the <form> element has been rendered with the method="get" attribute, as we specified to FormHelper in step 5. Note also that django-crispy-forms has not inserted a CSRF token field – it knows that one is not required for a form submitted using GET.

In this exercise, we installed django-crispy-forms using pip3 (pip for Windows) and then configured it in settings.py by adding it to INSTALLED_APPS and defining CRISPY_TEMPLATE_PACK we wanted to use (in our case, bootstrap4). We then updated the SearchForm class to use a FormHelper instance to control the attributes on the form and added a submit button using the Submit class. Finally, we changed the search-results.html template to use the crispy template tag to render the form, which allowed us to remove the <form> element we were using before and simplify form generation by moving all the form-related code into Python code (instead of it being partially in HTML and partially in Python).

Aside from giving a Django website a modern look, we also need a way to give our site standards of authentication that are convenient and trusted by users.

django-allauth
When browsing websites, you have probably seen buttons that allow you to log in using another website’s credentials – for example, using your GitHub login:

Figure 15.34 – The sign-in form with options to log in with Google or GitHub
Figure 15.34 – The sign-in form with options to log in with Google or GitHub

Before we explain the process, let us introduce the terminology we will be using:

Requesting site: The site the user is trying to log in to.
Authentication provider: The third-party provider that the user is authenticating to (for example, Google or GitHub).
Authentication application: This is something the creators of the requesting site set up on the authentication provider. It determines what permissions the requesting site will have with the authentication provider. For example, the requesting application can get access to your GitHub username but won’t have permission to write to your repositories. The user can stop the requesting site from accessing your information from the authentication provider by disabling access to the authentication application.
The process is generally the same regardless of which third-party sign-in option you choose. First, you will be redirected to the authentication provider site and asked to authorize the authentication application to access your account (Figure 15.35):

Figure 15.35 – The authentication provider authorization screen
Figure 15.35 – The authentication provider authorization screen

After you authorize the authentication application, the authentication provider will redirect you back to the requesting site. The URL that you are redirected to will contain a secret token that the requesting site can use to request your user information in the backend. This allows the requesting site to verify who you are by communicating directly with the authentication provider. After validating your identity using a token, the requesting site can redirect you to your content. This flow is illustrated in a sequence diagram in Figure 15.36:

Figure 15.36 – Third-party authentication flow
Figure 15.36 – Third-party authentication flow

Now that we have introduced authenticating using a third-party service, we can discuss django-allauth. This is an app that easily plugs your Django application into a third-party authentication service, including Google, GitHub, Facebook, and Twitter. In fact, at the time of writing, django-allauth supports over 75 authentication providers.

The first time a user authenticates to your site, django-allauth will create a standard Django User instance for you. It also knows how to parse the callback/redirect URL that the authentication provider loads after the end user authorizes the authentication application.

django-allauth adds three models to your application:

SocialApplication: This stores the information used to identify your authentication application. The information you enter will depend on the provider, who will give you a client ID, secret key, and (optionally) a key. Note that these are the names that django-allauth uses for these values and they will differ based on the provider. We will give some examples of these values later in this section. SocialApplication is the only one of the django-allauth models that you will create yourself; django-allauth creates the others automatically when a user authenticates.
SocialApplicationToken: This contains the values needed to identify a Django user to the authentication provider. It contains a token and (optionally) a token secret. It also contains a reference to the SocialApplication model that created it and the SocialAccount model to which it applies.
SocialAccount: This links a Django user to the provider (for example, Google or GitHub) and stores extra information that the provider may have given.
Since there are so many authentication providers, we will not cover how to set them all up, but we will give a short instruction on setup and how to map the auth tokens from the providers to the right fields in SocialApplication. We will do this for the two auth providers we have been mentioning throughout the chapter – Google and GitHub.

django-allauth installation and setup
Like the other apps in this chapter, django-allauth is installed with pip3:

pip3 install django-allauth

Copy

Explain
Note

For Windows, you can use pip instead of pip3 in the preceding command.

We then need a few settings changes. django-allauth requires the django.contrib.sites app to run, so it needs to be added to INSTALLED_APPS. Then, a new setting needs to be added to define a SITE_ID value for our site. We can just set this to 1 in our settings.py file:

    INSTALLED_APPS = [
        "bookr_admin.apps.BookrAdminConfig",
        "django.contrib.sites", # this entry added
        "django.contrib.auth",
        # The rest of the values are truncated
    ]
    SITE_ID = 1

Copy

Explain
Note

It is possible to have a single Django project hosted on multiple hostnames and have it behave differently on each, but also have content shared across all the sites. We don’t need to use SITE_ID anywhere else in our project, but one instance must be set here. You can read more about the SITE_ID settings at https://docs.djangoproject.com/en/3.0/ref/contrib/sites/.

We also need to add allauth and allauth.socialaccount to INSTALLED_APPS:

    INSTALLED_APPS = [
        # The rest of the values are truncated
        "allauth",
        "allauth.socialaccount",
    ]

Copy

Explain
Then, each provider we want to support must also be added to the list of INSTALLED_APPS – for example, consider the following snippet:

    INSTALLED_APPS = [
        # The rest of the values are truncated
        "allauth.socialaccount.providers.github",
        "allauth.socialaccount.providers.google",
    ]

Copy

Explain
After all of this is done, we need to burn the migrate management command to create the django-allauth models:

python3 manage.py migrate

Copy

Explain
Once this is done, new social applications can be added through the Django admin interface (Figure 15.37):

Figure 15.37 – Adding a social application
Figure 15.37 – Adding a social application

To add a social application, select a provider (this list will only show those in the INSTALLED_APPS list), enter a name (it can just be the same as the provider), and enter the client ID from the provider’s website (we will go into detail on this soon). You may also need a secret key and a key. Select the site the secret key and key should apply to. (If you only have one Site instance, then its name does not matter – just select it. The site name can be updated in the Sites section of Django admin. You can also add more sites there.)

We will now look at the tokens used by our three example providers.

GitHub auth setup
A new GitHub application can be set up under your GitHub profile. During development, your callback URL for the application should be set to http://127.0.0.1:8000/accounts/github/login/callback/ and updated with the real hostname when you deploy to production. After creating the app, it will provide a client ID and client secret. These are your client ID and secret key respectively in django-allauth.

Google auth setup
The creation of a Google application is done through your Google Developers console. The authorized redirect URI should be set to http://127.0.0.1:8000/accounts/google/login/callback/ during development and updated after production deployment. The app’s Client ID is also Client id in django-allauth, and the app’s Client secret is Secret key.

Initiating authentication with django-allauth
To initiate authentication through a third-party provider, you first need to add the django-allauth URLs in your URL maps. Somewhere inside your urlpatterns is one of your urls.py files, including allauth.urls:

urlpatterns = [path('allauth', include('allauth.urls')),]

Copy

Explain
You will then be able to initiate a login using URLs such as http://127.0.0.1:8000/allauth/github/logi/n?process=login, http://127.0.0.1:8000/allauth/google/login/?process=login, and so on. django-allauth will handle all the redirects for you and then create/authenticate the Django user when they return to the site. You can have buttons on your login page with text such as Login with GitHub or Login with Google that links to these URLs.

Other django-allauth features
Other than authentication with third-party providers, django-allauth can also add some useful features that Django does not have built in. For example, you can configure it to require an email address for a user, and have the user verify their email address by clicking a confirmation link they receive before they log in. django-allauth can also handle generating a URL for a password reset that is emailed to the user. You can find the documentation for django-allauth that explains these features, and more, at https://django-allauth.readthedocs.io/en/stable/overview.html.

Now that we have covered the first four third-party apps in depth and given a brief overview of django-allauth, you can undertake the activity for this chapter. In this activity, we will refactor the ModelForm instances we are using to use the CrispyFormHelper class.

Activity 15.01 – using FormHelper to update forms
In this activity, we will update the ModelForm instances (PublisherForm, ReviewForm, and BookMediaForm) to use the CrispyFormHelper class. Using FormHelper, we can define the text of the Submit button inside the Form class itself. We can then move the <form> rendering logic out of the instance-form.html template and replace it with a crispy template tag.

These steps will help you complete the activity:

Create an InstanceForm class that subclasses forms.ModelForm. This will be the base of the existing ModelForm classes.
In the __init__ method of InstanceForm, set a FormHelper instance on self.
Add a Submit button to FormHelper. If the form is instantiated with instance, then the button text should be Save; otherwise, it should be Create.
Update PublisherForm, ReviewForm, and BookMediaForm to extend from InstanceForm.
Update the instance-form.html template so that <form> is rendered using the crispy template tag. The rest of <form> can be removed.
In the book_media view, the is_file_upload context item is no longer required.
When you are finished, you should see the forms rendered with Bootstrap themes. Figure 15.38 shows the New Publisher page:

Figure 15.38 – The New Publisher page
Figure 15.38 – The New Publisher page

Figure 15.39 shows the New Review page:

Figure 15.39 – The New Review form
Figure 15.39 – The New Review form

Finally, the book media page is displayed in Figure 15.40:

Figure 15.40 – The book media page
Figure 15.40 – The book media page

Note that the form still behaves fine and allows file uploads. django-crispy-forms has automatically added the enctype="multipart/form-data" attribute to <form>. You can verify this by viewing the page source.

Note

The solution for this activity can be found on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

Summary
In this chapter, we introduced five third-party Django apps that can enhance your website. We installed and set up django-configurations, which allowed us to easily switch between different settings and change them using environment variables. dj-database-url also helped with settings, allowing us to make database settings changes using URLs. We saw how the Django Debug Toolbar could help us see what our app was doing and help us debug problems we had with it. django-crispy-forms can not only render our forms using the Bootstrap CSS but also lets us save code by defining their behavior as part of the form class itself. We briefly looked at django-allauth and saw how it can be integrated into third-party authentication providers. In the activity for this chapter, we updated our ModelForm instances to use the django-crispy-forms FormHelper and removed some logic from the template by using the crispy template tag.

In the next chapter, we will look at how to integrate the React JavaScript framework into a Django application.



| ≪ [ 14 Testing Your Django Applications ](/packtpub/2024/422-web_development_with_django_2ed/14_testing_your_django_applications) | 15 Django Third-Party Libraries | [ 16 Using a Frontend JavaScript Library with Django ](/packtpub/2024/422-web_development_with_django_2ed/16_using_a_frontend_javascript_library_with_django) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/422-web_development_with_django_2ed/15_django_third-party_libraries
> (2) Markdown
> (3) Title: 15 Django Third-Party Libraries
> (4) Short Description: Publication date: May 2023 Publisher Packt Pages 764
> (5) tags: Django
> Book Title: 422-Web Development with Django 2ed
> Link: https://subscription.packtpub.com/book/web-development/9781803230603/pref
> create: 2024-05-08 수 14:11:53
> Images: /packtpub/2024/422-web_development_with_django_2ed_img/15/
> .md Name: 15_django_third-party_libraries.md

