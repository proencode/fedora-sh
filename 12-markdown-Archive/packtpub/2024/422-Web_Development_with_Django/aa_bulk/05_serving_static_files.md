
| ≪ [ 04 An Introduction to Django Admin ](/packtpub/2024/422-web_development_with_django_2ed/04_an_introduction_to_django_admin) | 05 Serving Static Files | [ 06 Forms ](/packtpub/2024/422-web_development_with_django_2ed/06_forms) ≫ |
|:----:|:----:|:----:|

# 05 Serving Static Files

Serving Static Files
A web application with just plain HyperText Markup Language (HTML) is quite limiting. We can enhance the look of web pages with Cascading Style Sheets (CSS) and images, and add interaction with JavaScript. We call all these kinds of files “static files.” They are developed and then deployed as part of the application. We can compare this to dynamic responses, which are generated in real time when a request is made. All the views you have written generate a dynamic response by rendering a template. Note that we will not consider templates to be static files as they are not sent verbatim to a client; instead, they are rendered first and sent as part of a dynamic response.

During development, the static files are created on the developer’s machine, and then they must be moved to the production web server. If you must move to production in a short timeframe (say, a few hours) then it can be time-consuming to collect all the static assets, move them to the correct directory, and upload them to the server. When developing web applications using other frameworks or languages, you might need to manually put all of your static files into a specific directory that your web server hosts. Making changes to the URL from which static files are served might mean updating values throughout your code.

Django can manage static assets for us to make this process easier. It provides tools for serving them with its development server during development. When your application goes to production, it can also collect all your assets and copy them to a folder for a dedicated web server to host. This allows you to keep your static files segregated in a meaningful way during development, and automatically bundle them for deployment.

This functionality is provided by Django’s built-in staticfiles app. It adds several useful features for working with and serving static files:

The static template tag automatically builds the static URL for an asset and includes it in your HTML.
A view (called static) serves static files in development.
Static file finders can be used to customize where assets are found on your filesystem.
The collectstatic management command finds all static files and moves them into a single directory for deployment.
The findstatic management command shows which static file on the disk has been loaded for a particular request. This also helps us debug if a particular file is not being loaded.
In the exercises and activities of this chapter, we will be adding static files (images and CSS) to the Bookr application. Each file will be stored inside the Bookr project directory during development. We will need to generate a URL for each so that the templates can reference them, and the browser can download them. Once the URL has been generated, Django will need to serve these files. When we deploy the Bookr application to production, all the static files need to be found and moved to a directory where they can be served by the production web server. If there are static files that are not loading as expected, we need some method of determining what the cause is.

For the sake of simplicity, let’s take a single static file as an example: logo.png. We will briefly introduce the role of each feature we mentioned in the previous paragraph and explain it in depth throughout this chapter. There are five parts of the static files app that we will look at:

The static template tag is used to convert a filename into a URL or path that can be used in a template – for example, from logo.png to /static/logo.png.
The static view receives a request to load the static file at the /static/logo.png path. It reads the file and sends it to the browser.
A static file finder (or just finder) is used by the static view to locate the static file on the disk. There are different finders, but in this example, one is just converting from the /static/logo.png URL path to the path on the disk, bookr/static/logo.png.
When deploying to production, the collectstatic management command must be used. This will copy the logo.png file from the Bookr project directory to a web server directory, such as /var/www/bookr/static/logo.png.
If a static file is not working (for example, the request for it returns a 404 Not Found response, or the wrong file is being served), then we can use the findstatic management command to try to determine the reason. This command takes the filename as a parameter and will output which directories were looked through and where it was able to locate that requested file.
These are the most common features that are used day to day, but there are others that we will also discuss.

In this chapter, you will start by learning the difference between static and dynamic responses. You will then see how the Django staticfiles app helps manage static files. As you continue to work on the Bookr app, you will enhance it with images and CSS. You’ll see the different ways you can lay out your static files for your project and examine how Django consolidates them for production deployment. Django includes tools for referencing static files in templates; you’ll see how these tools help reduce the amount of work you must do when deploying the application to production. After this, you’ll explore the findstatic command, which can be used to debug issues with your static files. Later, you’ll get an overview of how to write code for storing static files on a remote service. Finally, you’ll look at caching web assets and how Django can help with cache invalidation.

We will cover the following main topics in this chapter:

Static file serving
Introduction to Static Files Finder
Generating static URLs with the static template tag
FileSystem Finder
Static file finders – use during collectstatic
STATICFILES_DIRS prefixed mode
The findstatic command
Serving the latest files (for cache validation)
Custom storage engines
Technical requirements
All the code files for this chapter can be found at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter05.

Static file serving
In the introduction, we mentioned that Django includes a view function called static that serves static files. The first important point to make regarding serving static files is that Django does not intend to serve them in production. It is not Django’s role, and in production, Django will refuse to serve static files. This is normal and intended behavior. If Django is just reading from the filesystem and sending out a file, then it has no advantage over a normal web server, which will probably be more performant at this task. Further, if you serve static files with Django, you will keep the Python process busy for the duration of this request and it will be unable to serve the dynamic requests for which it is more suited.

For these reasons, the Django static view is designed only for use during development and will not work if your DEBUG setting is False. Since during development we usually only have one person accessing the site at a time (the developer), then Django is fine to serve static files. We will discuss how the staticfiles app supports production deployment more shortly. The entire production deployment process will be covered in Chapter 17, Deploying a Django Application (Part 1 – Server Setup), which is hosted on the GitHub repository of this book.

A URL mapping to the static view is automatically set up when running the Django development server, provided that your settings.py file consists of the following elements:

Has DEBUG set to True
Contains 'django.contrib.staticfiles' in its INSTALLED_APPS
Both settings exist by default.

The URL mapping that is created is roughly equivalent to having the following map in your urlpatterns:

path(settings.STATIC_URL, django.conf.urls.static)

Copy

Explain
Any URL starting with settings.STATIC_URL (which is /static/ by default) gets mapped to the static view.

Note

You could use the static view without having staticfiles in INSTALLED_APPS, but you must set up an equivalent URL mapping manually.

Next, we’ll talk about how Django locates static files using Static Files Finder.

Introduction to Static Files Finder
There are three times when Django needs to locate static files on disk, and for this, it uses static file finder. It can be thought of as a plugin. It is a class that implements methods for converting URL paths into disks and iterates through the project directory to find static files.

The first time Django does this is when the Django static view receives a request to load a particular static file; here, it needs to convert the path in the URL into a location on disk. For example, let’s say the URL’s path is /static/logo.png, and it is converted into the bookr/static/logo.png path on the disk. As we noted in the previous section, this only happens during development. On a production server, Django should not receive this request as it will be handled directly by the web server.

The second time is when using the collectstatic management command. This gathers all the static files in the project directory and copies them to a single directory to be served by the production web server. bookr/static/logo.png will get copied to the web server root – for example, /var/www/bookr/static/logo.png. Static File Finder contains code for locating all the static files inside your project directory.

The last time Static File Finder is used is while executing the findstatic management command. This is similar to the first usage, where it accepts a static filename (such as logo.png), but it outputs the full path (bookr/static/logo.png) to the terminal instead of loading the file’s content.

Django comes with some built-in finders, but you can also write your own if you want to store static files in a custom directory layout. The list of finders Django uses is defined by the STATICFILES_FINDERS setting in settings.py. In this chapter, we will cover the behavior of the default Static File Finders, AppDirectoriesFinder and FileSystemFinder, in the AppDirectoriesFinder and FileSystemFinder sections, respectively.

Note

If you look in settings.py, you won’t see the STATICFILES_FINDERS setting defined by default. This is because Django will use its built-in default setting, which is defined as ['django.contrib.staticfiles.finders.FileSystemFinder', ' django.contrib.staticfiles.finders.AppDirectoriesFinder']. If you add the STATICFILES_FINDERS setting to your settings.py file to include a custom finder, be sure to include these defaults if you’re using them.

In this section, we will first discuss static file finders and their use in the first case – responding to a request. Then, we will introduce some more concepts and return to the behavior of collectstatic and how it uses static file finders.

Static file finders – use during a request
When Django receives a request for a static file (remember, Django will only serve static files during development), each static file finder that has been defined will be queried until a file on the disk has been found. Or, if none of the finders can locate a file, the static view will return an HTTP 404 Not Found response.

For example, the URL of the request will be something like /static/main.css or /static/reviews/logo.png. Each finder will be queried in turn with the path from the URL and will return a path such as bookr/static/main.css for the first file and bookr/reviews/static/reviews/logo.png for the second. Each finder will use its logic to convert from a URL path into a filesystem path – we will discuss this logic in the AppDirectoriesFinder and FileSystemFinder sections.

AppDirectoriesFinder
The AppDirectoriesFinder class is used to find static files inside each app directory, in a directory called static. The application must be listed in the INSTALLED_APPS setting in your settings.py file (we did this in Chapter 1, An Introduction to Django). As we also mentioned in Chapter 1, An Introduction to Django, it is good for apps to be self-contained. By letting each application have a static directory, we can continue the self-contained design by also storing app-specific static files inside the app directory.

Before we use AppDirectoriesFinder, we will explain a problem that can occur if multiple static files have the same name, and also how to solve this problem.

Static file namespacing
In the prior section, Static file finders – use during a request, we discussed serving a file named logo.png. This would provide a logo for the reviews application. The filename (logo.png) could be quite common – you could imagine that if we added a store app (for purchasing books), it would also have a logo. Not to mention that third-party Django apps might also want to use a common name such as logo.png. The problem we are about to describe could apply to any static file that has a common name, such as styles.css or main.js.

Let’s consider the reviews and stores examples. We can add a static directory in each of these apps. Then, each static directory would have a logo.png file (although it would be a different logo). The directory structure is shown in Figure 5.1:

Figure 5.1 – Directory layout with static directories inside app directories
Figure 5.1 – Directory layout with static directories inside app directories

The URL path that we use to download the static file is relative to the static directory. Therefore, it is unclear which logo.png is being referenced if we make an HTTP request for /static/logo.png. Django will check the static directory for each application in turn (in the order they are specified in the INSTALLED_APPS setting). The first logo.png it locates, it will serve. There is no way, in this directory layout, to specify which logo.png you want to load.

We can solve this problem by namespacing our static files. This is the process of using another directory inside the static directory, named the same as the app. The reviews app has a reviews directory inside its static directory, and the store app has a store directory inside its static directory. The respective logo.png files are then moved inside these sub-directories. The new directory layout is shown in Figure 5.2:

Figure 5.2 – Directory layout with namespaced directories
Figure 5.2 – Directory layout with namespaced directories

To load a specific file, we must include the namespaced directory too. For the reviews logo, the URL path is /static/reviews/logo.png, which maps to bookr/reviews/static/review/logo.png on the disk. Similarly, for the store logo, the path is /static/store/logo.png, which maps to bookr/store/static/store/logo.png. You might have noticed that the example paths for the logo.png file were already namespaced in the Static file finders – use during a request section.

Note

If you are considering writing a Django app that might be released as a standalone plugin, you could use an even more explicit sub-directory name. For example, you could choose one that contains the entire dotted project path: bookr/reviews/static/bookr.reviews. In most cases, though, it’s fine for the sub-directory name to be unique for just your project.

Now that we have introduced AppDirectoriesFinder and static file namespacing, we can use them to serve our first static file. In the first exercise of this chapter, we will create a new Django project for a basic business site. We will then serve a logo file from an app called landing that we will create in this project. The AppDirectoriesFinder class is used to find static files inside each app directory, in a directory called static. The application must be listed in the INSTALLED_APPS setting in your settings.py file. As we mentioned in Chapter 1, An Introduction to Django, it is good for apps to be self-contained. By letting each application have a static directory, we can continue the self-contained design by also storing app-specific static files inside the app directory.

The easiest way to serve a static file is from an app directory. This is because we don’t need to make any settings changes. Instead, we just need to create the files in the correct directory, and they will be served using the default Django configuration.

The business site project

For the exercises in this chapter, we’ll create a new Django project, and use it to demonstrate the static file concepts. The project will be a basic business site with a simple landing page that has a logo. The project will have one app, called landing.

You can refer to Exercise 1.01 – creating a project and app, and starting the dev server from Chapter 1, An Introduction to Django, to refresh your memory on creating a Django project.

Exercise 5.01 – serving a file from an app directory
In this exercise, you will add a logo file for the landing app. This will be done by putting a logo.png file in a static directory inside the landing app directory. Once you’ve done this, you can test that the static file is being served correctly and confirm the URL that will serve it:

Start by creating the new Django project. You can reuse the Bookr virtual environment that already has Django installed.
Open a new terminal and activate the virtual environment (refer to the Preface for instructions on how to create and activate a virtual environment).
Run the django-admin command in the terminal (or Command Prompt) to start a Django project named business_site:
django-admin startproject business_site

Copy

Explain
There won’t be any output. This command will scaffold the Django project in a new directory named business_site.

Create a new Django app in this project by using the startapp management command. The app should be called landing. To do this, cd into the business_site directory, then run the following:
python3 manage.py startapp landing

Copy

Explain
Note that there won’t be any output again. The command will create the landing app directory inside the business_site directory.

Note

Remember that on Windows, the command is python manage.py startapp landing.

Launch PyCharm and open the business_site directory. If you already have a project open, you can do this by choosing File | Open; otherwise, just click Open in the Welcome to PyCharm window. Navigate to the business_site directory, select it, then click Open. If prompted, choose Trust Project. The business_site project window should look similar to what’s shown in Figure 5.3:
Note

For detailed instructions on how to set up and configure PyCharm to work with your Django project, refer to Exercise 1.02 – project setup in PyCharm, in Chapter 1, An Introduction to Django.

Figure 5.3 – The business_site project
Figure 5.3 – The business_site project

Create a new run configuration to execute manage.py runserver for the project. You can reuse the Bookr virtual environment again. The Run/Debug Configurations window should look similar to what’s shown in Figure 5.4 when you’re done:
Note

If you are unsure of how to configure these settings in PyCharm, refer to Exercise 1.02 – project setup in PyCharm, in Chapter 1, An Introduction to Django.

Figure 5.4 – Run/Debug Configurations for Runserver
Figure 5.4 – Run/Debug Configurations for Runserver

You can test that the configuration has been set up correctly by clicking the Run button, and then visiting http://127.0.0.1:8000/ in your browser. You should see the Django welcome screen. If the debug server fails to start or you see the Bookr main page, then you probably still have the Bookr project running. Try stopping the Bookr runserver process (press Ctrl + C in the terminal that’s running it) and then starting the new one you just set up.

Open settings.py in the business_site directory and add 'landing' to the INSTALLED_APPS setting. We learned how to do this in Step 1 of Exercise 1.05 – creating a templates directory and base template, in Chapter 1, An Introduction to Django.
In PyCharm, right-click on the landing directory in the project pane and select New | Directory.
Enter static and press the Enter key:
Figure 5.5 – Naming the directory static
Figure 5.5 – Naming the directory static

Right-click on the static directory you just created and select New | Directory again.
Enter landing and press Enter. This will implement namespacing of the static files directory, as we discussed earlier:
Figure 5.6 – Naming the new directory reviews to implement namespacing
Figure 5.6 – Naming the new directory reviews to implement namespacing

Download the logo.png file from https://raw.githubusercontent.com/PacktPublishing/Web-Development-with-Django-Second-Edition/main/Chapter05/Exercise5.01/business_site/landing/static/landing/logo.png and move it into the landing/static/landing directory.
Start the Django dev server. If it is not already running, then navigate to http://127.0.0.1:8000/static/landing/logo.png. You should see the image being served in your browser:
Figure 5.7 – Image served by Django
Figure 5.7 – Image served by Django

If you see the image shown in Figure 5.7, you have set up static file serving correctly.

Now that you’ve seen that loading static images works correctly, we’ll learn more about how to prevent hardcoding these URLs. In the next section, you’ll see how Django can automatically generate correct static URLs for use in templates.

Generating static URLs with the static template tag
In Exercise 5.01 – serving a file from an app directory, you set up an image file to be served by Django. We saw that the URL of the image was http://127.0.0.1:8000/static/landing/logo.png, which you could use inside an HTML template. For example, to display the image with an img tag, you could use this code in your template:

<img src="http://127.0.0.1:8000/static/landing/logo.png">

Copy

Explain
Or, since Django is also serving the media and has the same host as the dynamic template response, you can simplify this by just including the path, as follows:

<img src="/static/landing/logo.png">

Copy

Explain
Both addresses (URLs and paths) have been hardcoded into the template – that is, we include the full path to the static file and make assumptions about where the file is being hosted. This works fine with the Django dev server or if you host your static files and Django website on the same domain. For more performance as your site becomes more popular, you might consider serving static files from their own domain or Content Delivery Network (CDN).

Note

A CDN is a service that can host parts or all of your website for you. It provides several web servers and can seamlessly speed up the loading of your website. For example, it might serve files to a user from the server that is geographically closest to them. There are several CDN providers and depending on how they are set up, they might require you to specify a certain domain from which to serve your static files.

Take, for instance, a common separation approach: using a different domain for static file serving. You host your main website at https://www.example.com but want to serve static files from https://static.example.com. During development, we could use just the path to the logo file, as in the example we just saw. But when we deploy to the production server, our URLs would need to change so that they include the domain, like so:

<img src="https://static.example.com/landing/logo.png">

Copy

Explain
Since all the links are hardcoded, this would need to be done for every URL throughout our templates, every time we deploy to production. Once they have been changed, though, the URL will no longer work in the Django dev server. Luckily, Django provides a solution to this problem.

The staticfiles app provides a template tag, static, for dynamically generating the URL to a static file inside a template. Since the URLs are all being dynamically generated, we can change the URL for all of them by changing just one setting (STATIC_URL in settings.py – more on this soon). Furthermore, later, we will introduce a method for invalidating browser caches for static files that relies on the use of the static template tag.

The static tag is very simple – it takes a single argument, which is the project-relative path to a static asset. It will then output this path, prepended by the STATIC_URL setting. But first, it must be loaded into the template with the {% load static %} template tag.

Django has a set of default template tags and filters (or tag sets) that it automatically makes available to every template. Django (and third-party libraries) also provides tag sets that are not automatically loaded. In these cases, we need to load these extra template tags and filters into a template before we can use them. This can be done with the load template tag, which should come near the start of a template (although it must be after the extends template tag if one is used). The load template tag takes one or more packages/libraries to load; take the following example:

{% load package_one package_two package_three %}

Copy

Explain
This would load the template tag and filters set provided by the (made up) package_one, package_two, and package_three packages.

The load template tag must be used in the actual template that requires the loaded package. For example, if your template extends another template, and that base template has loaded a certain package, your dependent template does not automatically have access to that package. Your template must still load the package to access the new tag set. The static template tag is not part of the default set, which is why we need to load it.

Then, it can be used to interpolate anywhere inside the template file. For example, by default, Django uses /static/ as STATIC_URL. If we wanted to generate the static URL for our logo.png file, we would use the tag in a template like this:

{% static landing/logo.png' %}

Copy

Explain
The output inside the template would be this:

/static/landing/logo.png

Copy

Explain
This will become clearer with an example, so let’s look at how the static tag could be used to generate a URL for several different assets.

We can include the logo as an image on the page with an img tag, as follows:

<img src="{% static 'landing/logo.png' %}">

Copy

Explain
This is rendered in the template like so:

<img src="/static/landing/logo.png">

Copy

Explain
Alternatively, we could use the static tag to generate the URL for a linked CSS file, as follows:

<link href="{% static 'path/to/file.css' %}" rel="stylesheet">

Copy

Explain
This will be rendered like so:

<link href="/static/path/to/file.css" rel="stylesheet">

Copy

Explain
It can be used in a script tag to include a JavaScript file, using the following line of code:

in a script tag:<script src="{% static 'path/to/file.js' %}"></script>

Copy

Explain
This is rendered as follows:

<script src="/static/path/to/file.js"></script>

Copy

Explain
You can even use it to generate a link to a static file for download, as we’ve done here:

<a href="{% static 'path/to/document.pdf' %}">Download PDF</a>

Copy

Explain
Note

Note that this won’t generate the actual PDF content – it will just create a link to an already existing file.

This is rendered as follows:

<a href="/static/path/to/document.pdf">Download PDF</a>

Copy

Explain
While referring to these examples, we can now demonstrate the advantage of using the static tag instead of hardcoding. When we are ready to deploy to production, we can just change the STATIC_URL value in settings.py. None of the values in the templates need to be changed.

For example, we can change STATIC_URL to https://static.example.com/, and then when the page gets rendered next, the examples we’ve seen will automatically update.

The following line shows this for the image:

<img src="https://static.example.com/landing/logo.png">

Copy

Explain
The following is for the CSS link:

<link href="https://static.example.com/path/to/files.css" rel="stylesheet">

Copy

Explain
For the script, it’s as follows:

<script src="https://static.example.com/path/to/file.js"></script>

Copy

Explain
And finally, the following is for the link:

<a href="https://static.example.com/path/to/document.pdf">Download PDF</a>

Copy

Explain
Note that in all these examples, a literal string is being passed as an argument (it is quoted). You can also use a variable as an argument – for example, if you were rendering a template with a context, such as in this example code:

def view_function(request):
    context = {"image_file": "logofile.png"}
    return render(request, "example.html", context)

Copy

Explain
We are rendering the example.html template with a variable called image_file. This variable has a value of logo.png.

You would pass this variable to the static tag without quotes:

<img src="{% static image_file %}">

Copy

Explain
It would render like this (assuming we changed STATIC_URL back to /static/):

<img src="/static/logo.png">

Copy

Explain
The template tag can also be used with the as [variable] suffix to assign the result to a variable for use later in the template. This can be useful if the static file lookup takes a long time and you want to refer to the same static file multiple times (such as by including an image in multiple places).

The first time you refer to the static URL, give it a variable name to assign to. In this case, we are creating the logo_path variable:

<img src="{% static 'logo.png' as logo_path %}">

Copy

Explain
This renders the same as the examples we’ve seen before:

<img src="/static/logo.png">

Copy

Explain
However, we can then use the assigned variable (logo_path) again later in the template:

<img src="{{ logo_path }}">

Copy

Explain
This renders the same again:

<img src="/static/logo.png">

Copy

Explain
This variable is now just a normal context variable in the template scope and can be used anywhere in the template. Be careful, though, as you might override a variable that has already been defined – although this a general warning when using any of the template tags that assign variables (for example, {% with %}).

In the next exercise, we will put the static template into practice by adding a template to the business_site project, then including the example image.

Exercise 5.02 – using the static template tag
In Exercise 5.01 – serving a file from an app directory, you tested serving logo.png from the static directory. In this exercise, you will continue with the business site project and create an index.html file as the template for our landing page. Then, you’ll include the logo inside this page using the {% static %} template tag:

In PyCharm (make sure you’re in the business_site project), right-click on the landing directory and create a new folder called templates.
Right-click on the new templates directory and select New | HTML File. Select HTML 5 file and name it index.html:
Figure 5.8 – New index.html
Figure 5.8 – New index.html

Open the index.html file and first, load the static tag library to make the static tag available in the template. Do this with the load template tag. On the second line of the file (just after <!DOCTYPE html>), add this line to load the static library:
{% load static %}

Copy

Explain
You can also make the template a bit nicer with some extra content. Enter the Business Site text inside the <title> tags:
<title>Business Site</title>

Copy

Explain
Then, inside the body, add an <h1> element with the Welcome to my Business Site text:

<h1>Welcome to my Business Site</h1>

Copy

Explain
Underneath the heading text, use the {% static %} template tag to set the source of an <img>. You will use it to refer to the logo from Exercise 5.01 – serving a file from an app directory:
<img src="{% static 'landing/logo.png' %}">

Copy

Explain
Finally, to flesh out the site a bit, add a <p> element under <img>. Give it some text about the business:
<p>Welcome to the site for my Business. For all your Business needs!</p>

Copy

Explain
Although the extra text and title are not too important, they give us an idea of how to use the {% static %} template tag around the rest of the content. Save the file. It should look like this once complete: https://raw.githubusercontent.com/PacktPublishing/Web-Development-with-Django-Second-Edition/main/Chapter05/Exercise5.02/business_site/landing/templates/index.html.

Next, set up a URL to use to render the template. You will also use the built-in TemplateView to render the template without having to create a view. Open urls.py in the business_site package directory. At the start of the file, import TemplateView as follows:
from django.views.generic import TemplateView

Copy

Explain
You can also remove this Django admin import line since we’re not using it in this project:

from django.contrib import admin

Copy

Explain
Add a URL map from / to TemplateView. The as_view method of TemplateView takes template_name as an argument, which is used in the same way as a path that you might pass to the render function. Your urlpatterns should look like this:
urlpatterns = [
    path("",
    TemplateView.as_view(template_name="index.html")),
]

Copy

Explain
Save the urls.py file. Once complete, it should look like this: https://raw.githubusercontent.com/PacktPublishing/Web-Development-with-Django-Second-Edition/main/Chapter05/Exercise5.02/business_site/business_site/urls.py.

Start the Django dev server, if it’s not already running. Navigate to http://127.0.0.1:8000/ in your browser. You should see your new landing page, as shown in Figure 5.9:
Figure 5.9 – My business site with a logo
Figure 5.9 – My business site with a logo

In this exercise, we added a base template for landing and loaded the static library into the template. Once the static library was loaded, we were able to use the static template tag to load an image. Then, we were able to see our business logo rendered in the browser.

So far, the static file loading has used AppDirectoriesFinder because it required no extra configuration to use. In the next section, we will look at FileSystemFinder, which is more flexible but requires a small amount of configuration to use.

FileSystemFinder
So far, we’ve learned about AppDirectoriesFinder, which loads static files inside Django app directories. However, we expect well-designed apps to be self-contained, and therefore they should only contain static files that they rely on. If we have other static files that are used throughout the website or across different apps, we should store them outside the app directory.

Note

As a general rule, your CSS is probably consistent throughout your site and could be kept in a global directory. Some images and JavaScript code could be specific to apps, so these would be stored in the static directory for that application. This is just general advice, though: you can store static files anywhere that makes the most sense for your project.

In our business site application, we will be storing a CSS file in a site static directory as it will be used not only in the landing app but also throughout the site as we add more apps.

Django provides support for serving static files from arbitrary directories using its FileSystemFinder static file finder. The directories can be anywhere on the disk. Usually, you will have a static directory inside your project directory, but if your company has a global static directory that is used in many different projects (including non-Django web applications), then you could use this as well.

FileSystemFinder uses the STATICFILES_DIRS setting in the settings.py file to determine which directories to search for static files in. This is not present when the project is created and must be set by the developer. We will add it in the next exercise. There are two options for building this list:

Setting a list of directories
Setting a list of tuples in the form of (prefix, directory)
The second use case will be easier to understand once we have covered some more of the fundamentals, so we will return to it after explaining and demonstrating the first case. This will be covered in the STATICFILES_DIRS prefixed mode section. For now, we will just explain the first use case, which is just a list of one or more directories.

In business_site, we will add a static directory inside the project directory (that is, in the same directory that contains the landing app and the manage.py file). We can use the BASE_DIR setting when building the list to assign to STATICFILES_DIRS:

STATICFILES_DIRS = [BASE_DIR / "static"]

Copy

Explain
We also mentioned earlier in this section that you might want to set multiple directory paths in this list, for example, if you had some company-wide static data shared by multiple web projects. Simply add extra directories to the STATICFILES_DIRS list:

STATICFILES_DIRS = [BASE_DIR / "static",
    "/Users/username/projects/company-static/"
]

Copy

Explain
Each of these directories would be checked, in the order specified, to find a matching file. If a file existed in both directories, the first one found would be served. For example, if the static/main.css (inside the business_site project directory) and /Users/username/projects/company-static/bar/main.css files both existed, a request for /static/main.css would serve the business_site project’s main.css as it is first in the list. Consider this when deciding the order in which you add directories to STATICFILES_DIRS; you may choose to prioritize your project static files over the global ones or vice versa.

In our business site (and later with Bookr), we will only use one static directory in this list, so we won’t have to worry about this problem.

In the next exercise, we will add a static directory with a CSS file inside. Then, we will configure the STATICFILES_DIRS setting so that it can be served from the static directory.

Exercise 5.03 – serving from a project static directory
We showed an example of serving an application-specific image file in Exercise 5.01 – serving a file from an app directory. Now, we want to serve a CSS file that is to be used throughout our project to set styles, so we will serve this from a static directory right inside the project folder.

In this exercise, you’ll set up your project to serve static files from a specific directory, and then use the {% static %} template tag again to include it in the template. This will be done using the business_site example project:

Open the business_site project in PyCharm if it’s not already open. Then, right-click on the business_site project directory (the top-level business_site directory, not the business_site package directory) and select New | Directory.
In the New Directory dialog, enter static and click OK.
Right-click on the static directory you just created and select New | File.
In the Name New File dialog, enter main.css and click OK.
The blank main.css file should open automatically. Enter a couple of simple CSS rules to center the text and set a font and background color, like so:
body {
    font-family: Arial, sans-serif;
    text-align: center;
    background-color: #f0f0f0;
}

Copy

Explain
You can now save and class main.css. You can take a look at the complete file for reference at https://raw.githubusercontent.com/PacktPublishing/Web-Development-with-Django-Second-Edition/main/Chapter05/Exercise5.03/business_site/static/main.css.

Open business_site/settings.py. Here, set a list of directories to the STATICFILES_DIRS settings. In this case, the list will have just one item. Define a new variable called STATICFILES_DIRS at the bottom of the settings.py file using the following code:
STATICFILES_DIRS = [BASE_DIR / "static"]

Copy

Explain
In the settings.py file, BASE_DIR is a variable that contains the path to the project directory. You can build the full path to the static directory you created in Step 2 by joining static to BASE_DIR. Then, you can put this inside a list. The complete settings.py file should look like this: https://raw.githubusercontent.com/PacktPublishing/Web-Development-with-Django-Second-Edition/main/Chapter05/Exercise5.03/business_site/business_site/settings.py.

Start the Django dev server if it is not running. You can verify that the settings are correct by checking whether you can load the main.css file. Note that this is not namespaced, so the URL is http://127.0.0.1:8000/static/main.css. Open this URL in your browser and check that the content matches what you just entered and saved:
Figure 5.10 – CSS served by Django
Figure 5.10 – CSS served by Django

If the file does not load, check your STATICFILES_DIRS settings. You may need to restart the Django dev server if it was running while you made changes to settings.py.

Now, you need to include main.css in your index template. Open index.html in the templates folder. Before the closing </head> tag, add this <link> tag to load the CSS:
<link rel="stylesheet" href="{% static 'main.css' %}">

Copy

Explain
This links in the main.css file, using the {% static %} template tag. As mentioned earlier, since main.css is not namespaced, you can just include its name. Save the file; it should look like this: https://raw.githubusercontent.com/PacktPublishing/Web-Development-with-Django-Second-Edition/main/Chapter05/Exercise5.03/business_site/landing/templates/index.html.

Load http://127.0.0.1:8000/ in your browser; you should see the background color, fonts, and alignment all change:
Figure 5.11 – CSS applied with custom fonts visible
Figure 5.11 – CSS applied with custom fonts visible

Your business landing page should look like what’s shown in Figure 5.11. Since you included the CSS in the index.html template, it will be available in all the templates that extend this template (although none do at the moment; it’s good planning for the future).

In this exercise, we put some CSS rules into a file and served them using Django’s FileSystemFinder. This was accomplished by creating a static directory inside the business_site project directory and specifying it in the Django settings (the settings.py file) using the STATICFILES_DIRS setting. We linked the main.css file to the index.html template using the static template tag. We loaded the main page in our browser and saw that the font and color changes applied.

We’ve now covered how static file finders are used during a request (to load a specific static file when given a URL). We’ll now look at their other use case: finding and copying static files for production deployment when running the collectstatic management command.

Static file finders – use during collectstatic
Once we have finished working on our static files, they need to be moved into a specific directory that can be served by our production web server. We can then deploy our website by copying our Django code and static files to our production web server. In the case of business_site, we will want to move logo.png and main.css (along with other static files that Django itself includes) into a single directory that can be copied to the production web server. This is the role of the collectstatic management command.

We have already discussed how Django uses static file finders during request handling. Now, we will cover the other use case: collecting static files for deployment. Upon running the collectstatic management command, Django uses each finder to list static files on the disk. Every static file that is found is then copied into the STATIC_ROOT directory (also defined in settings.py). This is a little bit like the reverse of handling a request. Instead of getting a URL path and mapping it to a filesystem path, the filesystem path is copied to a location that can be predicted by the frontend web server. This allows the frontend web server to handle a request for a static file independently of Django.

Note

A frontend web server is a web server that’s designed to route requests to applications (such as Django) or read static files from disk. They can handle requests faster but aren’t able to generate dynamic content in the same way as something such as Django. Frontend web servers are software such as Apache HTTPD, Nginx, and lighttpd.

For some specific examples of how collectstatic works, we’ll use the two files from Exercise 5.01 – serving a file from an app directory and Exercise 5.03 – serving from a project status directory, respectively: landing/static/landing/logo.png and static/main.css.

Let’s assume that STATIC_ROOT has been set to a directory being served by a normal web server – this would be something such as /var/www/business_site/static. The destination for these files would be /var/www/business_site/static/reviews/logo.png and /var/www/business_site/static/main.css, respectively.

Now, when a request for a static file comes in, the web server will be able to serve it easily because the paths are mapped consistently:

/static/main.css is served from the /var/www/business_site/static/main.css file
/static/reviews/logo.png is served from the /var/www/business_site/static/reviews/logo.png file
This means the web server root is /var/www/business_site/ and static paths are loaded directly from disk in the usual manner that a web server would load files.

With that, we have demonstrated how Django locates static files during development and can serve them itself. In production, we need the frontend web server to be able to serve static files without involving Django, for both safety and speed.

Without having to run collectstatic, a web server would not be able to map a URL back to a path. For example, it would not know that main.css must be loaded from the project static directory while logo.png is to be loaded from the landing app directory – it has no concept of the Django directory layout.

You might be tempted to serve files directly from the Django project directory by setting your web server root to this directory – don’t do this. There is a security risk in sharing your entire Django project directory as it would make it possible to download settings.py or other sensitive files. Running collectstatic will copy the files to a directory that can be moved outside the Django project directory to the web server root for security.

So far, we have talked about using collectstatic to copy static files directly to the web server root. You could also have Django copy them to an intermediary directory and have your deployment process move to a CDN or another server afterward. We won’t go into detail on specific deployment processes; how you choose to copy static files to the web server will depend on your or your company’s existing setup (for example, a continuous delivery pipeline).

Note

The collectstatic command does not take into consideration the use of static template tags. It will collect all the static files inside static directories, even those that your project does not include inside a template.

In the next exercise, we will see the collectstatic command in action. We’ll use it to copy all the business_site static files that we have so far into a temporary directory.

Exercise 5.04 – collecting static files for production
While we won’t be covering deployment to a web server in this chapter, we can still use the collectstatic management command and see its result. In this exercise, we will create a temporary holding location for the static files to be copied into. This directory will be called static_production_test and will be located inside the business_site project directory. As part of the deployment process, you could copy this directory to your production web server. However, since we won’t be setting up a web server until Chapter 17, Deploying a Django Application (Part 1 – Server Setup), we will just examine its contents to understand how files are copied and organized:

In PyCharm, create a temporary directory to put the collected files in. Right-click on the business_site project directory (this is the top-level folder, not the business_site module) and select New | Directory.
In the New Directory dialog, enter static_production_test and click OK.
Open settings.py and, at the bottom of the file, define a new setting for STATIC_ROOT. Set it to the path of the directory you just created:
STATIC_ROOT = BASE_DIR / "static_production_test"

Copy

Explain
This will join static_dir to BASE_DIR (the business_site project path) to generate the full path. Save the settings.py file. It should look like this: https://raw.githubusercontent.com/PacktPublishing/Web-Development-with-Django-Second-Edition/main/Chapter05/Exercise5.04/business_site/business_site/settings.py.

In a terminal, run the collectstatic manage command:
python3 manage.py collectstatic

Copy

Explain
You should see an output like the following:

130 static files copied to '/Users/ben/business_site/static_production_test'.

Copy

Explain
This might seem like a lot if you were expecting it to copy just two files, but remember that it will copy all the files for all installed apps. In this case, as you have the Django admin app installed, most out of the 132 files support that.

Let’s look through the static_production_test directory to check what has been created. An expanded view of this directory (from the PyCharm project page) is shown in Figure 5.12, for reference. Yours should be similar:
Figure 5.12 – Destination directory of the collectstatic command
Figure 5.12 – Destination directory of the collectstatic command

You should notice three items inside it:

The admin directory: This contains files from the Django admin app. If you look inside this, you’ll see it has been organized into subfolders for css, fonts, img, and js.
The landing directory: This is the static directory from your landing app. Inside it is the logo.png file. This directory has been created to match the namespacing of the directory that we created.
The main.css file: This is from your project static directory. Since you didn’t place it inside a namespacing directory, this has been placed directly inside STATIC_ROOT.
If you want, you can open any of these files and verify that their content matches the files you have just been working on – they should do as they are simply copies of the original files.

In this exercise, we collected all the static files from business_site (including the admin static files that Django includes). They were copied into the directory defined by the STATIC_ROOT setting (static_production_test inside the business_site project directory). We saw that main.css was directly inside this folder but that other static files were namespaced inside their app directories (admin and reviews). This folder could have been copied to a production web server to deploy our project.

In the next section, we’ll look at how a prefix can be added to each static file directory source to customize how static files are organized after being collected.

STATICFILES_DIRS prefixed mode
As mentioned earlier, the STATICFILES_DIRS setting also accepts items as tuples in the form of (prefix, directory). These modes of operation are not mutually exclusive; STATICFILES_DIRS may contain both non-prefixed (string) or prefixed (tuple) items. Essentially, this allows you to map a certain URL prefix to a directory. In Bookr, we do not have enough static assets to warrant setting this up, but it can be useful if you want to organize your static assets differently. For example, you can keep all your images in a certain directory, and all your CSS in another directory. You might need to do this if you use a third-party CSS generation tool such as Node.js with LESS.

Note

LESS is a CSS pre-processor that uses Node.js. It allows you to write CSS using variables and other programming-like concepts that don’t exist natively. Node.js will then compile this to CSS. A more in-depth explanation is outside the scope of this book; suffice it to say that if you use it (or a similar tool), then you might want to serve directly from the directory to which it saves its compiled output.

The easiest way to explain how prefixed mode works is with a short example. This will expand on the STATICFILES_DIRS setting we created in Exercise 5.03 – serving from a project static directory; however, this is not an exercise. In this example, two prefixed directories are being added to this setting – one for serving images and one for serving CSS:

STATICFILES_DIRS = [
    BASE_DIR / "static",
    ("images", BASE_DIR / "static_images"),
    ("css", BASE_DIR / "static_css"),
]

Copy

Explain
As well as the static directory that was already being served with no prefix, we have added serving of the static_images directory inside the business_site project directory. This has a prefix of images. We have also added serving for the static_css directory inside the Bookr project directory, with a prefix of css.

Then, we can serve three files, main.js, main.css, and main.jpg, from the static, static_css, and static_images directories, respectively. The directory layout will be as shown in Figure 5.13:

Figure 5.13 – Directory layout for use with prefixed URLs
Figure 5.13 – Directory layout for use with prefixed URLs

In terms of accessing these via a URL, the mapping is as shown in Figure 5.14:

Figure 5.14 – Mapping a URL to a file based on the prefix
Figure 5.14 – Mapping a URL to a file based on the prefix

Django routes any static URL with a prefix to the directory that matches that prefix.

When used with the static template tag, use the prefix and filename, not the directory name; take the following example:

{% static 'images/main.jpg' %}

Copy

Explain
When the static files are gathered using the collectstatic command, they are moved into a directory with the prefix name, inside STATIC_ROOT. The source paths and the target paths inside the STATIC_ROOT directory are shown in Figure 5.15:

Figure 5.15 – Mapping from the path in the project directory to the path in STATIC_ROOT
Figure 5.15 – Mapping from the path in the project directory to the path in STATIC_ROOT

Django creates the prefix directories inside STATIC_ROOT. Because of this, the paths can be kept consistent, even when using a web server and not routing the URL lookup through Django.

Next, we’ll look at a management command that’s useful for troubleshooting when static files aren’t being loaded as you expect: findstatic.

The findstatic command
The staticfiles application also provides one more management command: findstatic. This command allows you to enter the relative path to a static file (the same as what would be used inside a static template tag) and Django will tell you where that file was located. It can also be used in verbose mode to output the directories it is searching through.

Note

You may not be familiar with the concept of verbosity, or verbose mode. Having a higher verbosity (or simply turning on verbose mode) will cause a command to generate more output. Many command-line applications can be executed with more or less verbosity. This can be helpful when you’re trying to debug programs you are using. To see an example of verbose mode in action, you can try running the Python shell in verbose mode. Enter python -v (instead of just python) and press Enter. Python will start in verbose mode, which prints out the path of every file it imports.

This command is mostly useful for debugging/troubleshooting purposes. If the wrong file is loading, or a particular file can’t be found, you can use this command to try to find out why. The command will display which file on disk is being loaded for a specific path, or let you know that the file can’t be found and what directories were searched.

This can help solve issues where multiple files have the same name, and the precedence is not how you expect. You may also see that Django is not searching in a directory you expect for the file, in which case the static directory might need to be added to the STATICFILES_DIRS setting.

In the next exercise, you will execute the findstatic management command so that you are familiar with what the outputs are for good (file found correctly) and bad (file missing) scenarios.

Exercise 5.05 – finding files using findstatic
You will now run the findstatic command with a variety of options and understand what its output means. First, we will use it to find a file that exists and see that it displays the path to the file. Then, we will try to find a file that doesn’t exist and check the error that is output. We will then repeat this process with multiple levels of verbosity and different ways of interacting with the command. While this exercise will not make changes to or progress the Bookr project, it is good to be familiar with the command in case you need to use it when working on your own Django applications. Let’s get started:

Open a terminal and navigate to the business_site project directory.
Execute the findstatic command with no options. It will output some help explaining how it is used:
python3 manage.py findstatic

Copy

Explain
The following help output will be displayed:

usage: manage.py findstatic [-h] [--first] [--version] [-v {0,1,2,3}] [--settings SETTINGS] [--pythonpath PYTHONPATH] [--traceback] [--no-color] [--force-color]
[--skip-checks]staticfile [staticfile ...]
manage.py findstatic: error: Enter at least one label.

Copy

Explain
You can find one or more files at a time. Let’s start with one that we know exists: main.css. We’ll use the findstatic management command to locate it on disk by entering the following command:
python3 manage.py findstatic main.css

Copy

Explain
The preceding command outputs the path at which main.css was found:

Found 'main.css' here:
  /Users/ben/business_site/static/main.css

Copy

Explain
Your full path will be different (unless you are also called Ben), but you can see that when Django locates main.css in a request, it will load the main.css file from the project’s static directory.

This can be useful if a third-party application you have installed has not namespaced its static files correctly and is conflicting with one of your files.

Let’s try finding a file that does not exist, logo.png:
python3 manage.py findstatic logo.png

Copy

Explain
Django will display an error stating that the file could not be found:

No matching file found for 'logo.png'.

Copy

Explain
Django is unable to locate this file because we have namespaced it – we must include the full relative path, the same way we used it in the static template tag.

Try finding the logo.png again, but this time using the full path:
python3 manage.py findstatic landing/logo.png

Copy

Explain
Django can find the file now:

Found 'landing/logo.png' here:
  /Users/ben/business_site/landing/static/landing/logo
  .png

Copy

Explain
You can find multiple files at once by adding each file as an argument:
python3 manage.py findstatic landing/logo.png
missing-file.js main.css

Copy

Explain
The location status for each file is shown as follows:

No matching file found for 'missing-file.js'.
Found 'landing/logo.png' here:
  /Users/ben/business_site/landing/static/landing/logo
  .png
Found 'main.css' here:
  /Users/ben/business_site/static/main.css

Copy

Explain
The command can be executed with a verbosity of 0, 1, or 2. By default, it executes at verbosity 1. To set the verbosity, use the --verbosity or -v flag. Decreasing the verbosity to 0 only outputs the paths it locates without any extra information. No errors are displayed for missing paths:
python3 manage.py findstatic -v0 landing/logo.png
missing-file.js main.css

Copy

Explain
The output shows only found paths – notice that no error is shown for the missing file, missing-file.js:

/Users/ben/business_site/landing/static/landing/
logo.png
/Users/ben/business_site/static/main.css

Copy

Explain
This level of verbosity can be useful if you are piping the output to another file or command.

To get more information about which directories Django is searching in for the file you have requested, increase the verbosity to 2:
python3 manage.py findstatic -v2 landing/logo.png
missing-file.js main.css

Copy

Explain
The output contains much more information, including the directories that have been searched for the requested file. You can see that as the admin application is installed, Django is also searching in the Django admin application directory for static files:

Figure 5.16 – findstatic executed with verbosity 2, showing exactly which directories were searched
Figure 5.16 – findstatic executed with verbosity 2, showing exactly which directories were searched

The findstatic command is not something that you will use day to day when working with Django, but it is useful to know about when you’re trying to troubleshoot problems with static files. We saw the command’s output, the full path to a file that existed, as well as the error messages when files did not exist. We also ran the command and supplied multiple files at once and saw that information about all the files was outputted. Finally, we ran the command with different levels of verbosity. The -v0 flag suppressed errors about missing files. -v1 was the default and displayed found paths and errors. Increasing the verbosity using the -v2 flag also printed out the directories that were being searched through for a particular static file.

In the next section, we’ll take a look at caching static files and how Django helps us ensure our users are served the latest versions.

Serving the latest files (for cache invalidation)
If you are not familiar with caching, the basic idea is that some operations can take a long time to perform. We can speed up a system by storing the results of the operation in a place that is faster to access so that the next time we need them, they can be retrieved quickly. The “operation” that takes a long time can be anything – a function that takes a long time to run, an image that takes a long time to render, or a large asset that takes a long time to download over the internet. We are interested in this last scenario.

You might have noticed that the first time you ever visit a particular website, it can be slow to load, but then the next time, it loads much faster. This is because your browser has cached some (or all) of the static files the site needs to load.

To use our business site as an example, we have a page that includes the logo.png file. The first time we visit the business site, we must download the dynamic HTML, which is small and quick to transfer. Our browser parses the HTML and sees that the logo.png file should be included. It can then download this file too, which is much larger and can take longer to download. Note that this scenario assumes that our business site is now hosted on a remote server and not on our local machine – which is very fast for us to access.

If the web server has been set up correctly, your browser will store logo.png on your computer. The next time we visit the landing page (or indeed any page that includes the logo.png file), our browser will recognize the URL and can load the file from disk instead of having to download it again, thus speeding up the browsing experience.

Note

We said that the browser will cache “if the web server is set up correctly.” What does this mean? The frontend web server should be configured to send special HTTP headers as part of a static file response. It can send a Cache-Control header, which can have values such as no-cache (the file should never be cached – that is, the latest version should be requested every time) or max-age=seconds (the file should only be downloaded again if it was last retrieved more than seconds ago). The response could also contain the Expires header, with the value being a date. The file is considered to be “stale” once this date has been reached, and at that point, the new version should be requested.

One of the hardest problems in computer science is cache invalidation. For instance, if we change logo.png, how does our browser know it should download the new version? The only surefire way of knowing it had changed would be to download the file again and compare it with the version we had already saved every time. Of course, this defeats the purpose of caching since we would still be downloading every time the file changed (or not). We can cache for an arbitrary or server-specified amount of time, but if the static file changed before that time was up, we wouldn’t know. We would use the old version until we considered it expired, at which time we’d download the new version. If we had a one-week expiry and the static file changed the next day, we’d still be using the old one for six days. Of course, the browser can be made to reload the page without using the cache (how this is done depends on the browser; for example, Shift + F5 or Cmd + Shift + R) if you want to forcefully download all static assets again.

There is no need to try to cache our dynamic responses (rendered templates). Since they are designed to be dynamic, we would want to make sure that the user gets the latest version on every page load, so they should not be cached. They are also quite a small size (compared to assets such as images), so there is not much speed advantage when caching them.

Django provides a built-in solution. During the collectstatic phase, when the files are copied, Django can append a hash of their content to the filename. For example, the source file, logo.png, will be copied to static_production_test/landing/logo.f30ba08c60ba.png. This is only done when using the ManifestFilesStorage storage engine.

Since the filename only changes when the content changes, the browser will always download the new content.

Using ManifestFilesStorage is just one way of invalidating caches. There may be other options that are more suitable for your particular application.

Note

A hash is a one-way function that generates a string of a fixed length, regardless of the length of the input. There are several different hash functions available, and Django uses MD5 for content hashing. While no longer cryptographically secure, it is adequate for this purpose. To illustrate the fixed-length property, the MD5 hash of the a string is 0cc175b9c0f1b6a831c399e269772661. The MD5 hash of the a much longer string string is 69fc4316c18cdd594a58ec2d59462b97. They are both 32 characters long.

You can choose the storage engine by changing the STATICFILES_STORAGE value in settings.py. This is a string with a dotted path to the module and class to use. The class that implements the hash-addition functionality is django.contrib.staticfiles.storage.ManifestStaticFilesStorage.

Using this storage engine doesn’t require you to make any changes to your HTML templates, provided you are including static assets with the static template tag. Django generates a manifest file (staticfiles.json, in JSON format) that contains a mapping between the original filename and the hashed filename. It will automatically insert the hashed filename when using the static template tag. If you are including your static files without using the static tag and instead just manually inserting the static URL, then your browser will attempt to load the non-hashed path and the URL will not automatically be updated when the cache should be invalidated.

For example, you can include logo.png with the static tag:

<img src="{% static 'reviews/logo.png' %}">

Copy

Explain
When the page is rendered, the latest hash will be retrieved from staticfiles.json and the output will be like this:

<img src="/static/landing/logo.f30ba08c60ba.png">

Copy

Explain
Whereas, if we had not used the static tag and instead hardcoded the path, it would always appear as written:

<img src="/static/landing/logo.png">

Copy

Explain
Since this does not contain a hash, our browser will not see the path changing and thus never attempt to download the new file.

Django retains the previous version of files with the old hash when running collectstatic, so older versions of your application can still refer to it if they need to. The latest version of the file is also copied with no hash so that non-Django applications can refer to it without needing to look up the hash.

In the next exercise, we will change our project settings to use the ManifestFilesStorage engine, then run the collectstatic management command. This will copy all the static assets as in Exercise 5.04 – collecting static files for production; however, they will now have their hash included in the filename.

Exercise 5.06 – exploring the ManifestFilesStorage storage engine
In this exercise, you will temporarily update settings.py to use ManifestFilesStorage, then run collectstatic to see how the files are generated with a hash:

In PyCharm (still in the business_site project), open settings.py and add a STATICFILES_STORAGE setting at the bottom of the file:
STATICFILES_STORAGE = "django.contrib.staticfiles.storage.ManifestStaticFilesStorage"

Copy

Explain
The completed file should look like this: https://github.com/PacktWorkshops/The-Django-Workshop/blob/master/Chapter05/Exercise5.06/business_site/business_site/settings.py.

Open a terminal, navigate to the business_site project directory, and run the collectstatic command like before:
python3 manage.py collectstatic

Copy

Explain
If your static_production_test directory is not empty (which will probably be the case as files were moved there in Exercise 5.04 – collecting static files for production), then you will be prompted to allow the overwriting of the existing files:

Figure 5.17 – Prompt to allow overwrit﻿ing during static collection
Figure 5.17 – Prompt to allow overwriting during static collection

Just type yes and then press Enter to allow the overwrite.

The output from this command will tell you the number of files that were copied, as well as the number that were processed and had the hash added to the filename:

0 static files copied to '/Users/ben/business_site/static_production_test', 130 unmodified, 98 post-processed.

Copy

Explain
Since you haven’t changed any files since we last ran collectstatic, no files have been copied. Instead, Django post-processes the files (28 of them) – that is, it generates their hashes and appends them to the filename.

The static files were copied into the static_production_test directory as they were before; however, there are now two copies of each file: one named with the hash and one without. For example, static/main.css has been copied to static_production_test/main.856c74fb7029.css (this filename might be different if your CSS file contents differ; for example, if it has extra spaces or newlines):
Figure 5.18 – Expanded static_production_test directory with hashed filenames
Figure 5.18 – Expanded static_production_test directory with hashed filenames

Figure 5.18 shows the expanded static_production_test directory layout. You can see two copies of each file’s static file, as well as the staticfiles.json manifest file. To take logo.png as an example, you can see that landing/static/landing/logo.png has been copied to static_production_test/landing/logo.ba8d3d8fe184.png.

Let’s make a change to the main.css file and see how the hash changes.

Add some blank lines to the end of the file and save it (make sure that you edit the source file and not the one that was already copied to the static_production_test directory). This won’t change the effect of the CSS but the change in the file will affect its hash. Re-run the collectstatic command in a terminal:
python3 manage.py collectstatic

Copy

Explain
Once again, you may have to enter yes to confirm the overwrite, which will give you the following output:

You have requested to collect static files at the destination
location as specified in your settings:
    /Users/ben/business_site/static_production_test
This will overwrite existing files!
Are you sure you want to do this?
Type 'yes' to continue, or 'no' to cancel: yes
1 static file copied to '/Users/ben/business_site/static_production_test', 129 unmodified, 98 post-processed.

Copy

Explain
Since only one file was changed, only one static file was copied (main.css).

Look inside the static_production_test directory again. You should see that the old file with the old hash was retained and that a new file with a new hash has been added:
Figure 5.19 – Another main.css file with the latest hash was added
Figure 5.19 – Another main.css file with the latest hash was added

In this case, we have main.856c74fb7029.css (existing), main.02b59bcc5cd9.css (new), and main.css. Your hashes may differ.

The main.css file (no hash) always contains the newest content – that is, the contents of the main.02b59bcc5cd9.css and main.css files are identical. During the execution of collectstatic, Django will copy the file with a hash, as well as without a hash.

Now, examine the staticfiles.json file that Django generates. This is the mapping that allows Django to look up the hashed path from the normal path. Open static_production_test/staticfiles.json. All the content may appear in one line. If it does, enable text soft wrapping from the View menu | Active Editor | Soft Wrap. Scroll to the end of the file; you should see an entry for the main.css file; take the following example:
"main.css": "main.02b59bcc5cd9.css"

Copy

Explain
This is how Django can populate the correct URL in a template when using the static template tag: by looking up the hashed path in this mapping file.

We’ve finished using business_site, which we were just using for testing. You can delete the project or keep it around for reference during the activities.
Note

Unfortunately, we can’t examine how the hashed URL is interpolated in the template because, when running in debug mode, Django does not look up the hashed version of the file. As we know, the Django dev server only runs in debug mode, so if we were to turn debug mode off to try to view the hashed interpolation, the Django dev server would not start. You will need to examine this interpolation yourself when going to production and when using a frontend web server.

In this exercise, we configured Django to use ManifestFilesStorage for its static file storage by adding the STATICFILES_STORAGE setting to settings.py. Then, we executed the collectstatic command to see how the hashes are generated and added to the filename of the copied files. We saw the staticfiles.json manifest file, which stored a lookup from the original path to the hashed path. Finally, we cleaned up the settings and directories that we added in this exercise and Exercise 5.04 – collecting static files for production. These were the STATIC_ROOT setting, the STATICFILES_STORAGE setting, and the static_production_test directory.

So far, we’ve only seen how to locate static files stored on our disk. Django can be customized to locate static files stored in other locations (such as in the cloud). In the next section, we’ll briefly look at how to use custom storage engines.

Custom storage engines
In the previous section, we set the storage engine to ManifestFilesStorage. This class is provided by Django, but it is also possible to write a custom storage engine. For example, you could write a storage engine that uploads your static files to a CDN, Amazon S3, or Google Cloud bucket when you run collectstatic.

Writing a custom storage engine is beyond the scope of this book. Third-party libraries already exist that support uploading to a variety of cloud services. One such library is Django Storages, which can be found at https://django-storages.readthedocs.io/.

The following code is a short skeleton indicating which methods you should implement to create a custom file storage engine:

from django.conf import settings
from django.contrib.staticfiles import storage
class CustomFilesStorage(storage.StaticFilesStorage):
    def __init__(self):
        """The class must be able to be instantiated
           without any arguments.
        Create custom settings in settings.py and read them
        instead."""
        self.setting = settings.CUSTOM_STORAGE_SETTING

Copy

Explain
The class you define (in this example, it’s called CustomFilesStorage) must be able to be instantiated without any arguments. The __init__ function must be able to load any settings from global identifiers (in this case, from our Django settings):

    def delete(self, name):
        """Implement delete of the file from the remote
           service."""

Copy

Explain
The delete method should be able to delete the file, specified by the name argument, from the remote service:

    def exists(self, name):
        """Return True if a file with name exists in the
           remote service."""

Copy

Explain
The exists method should query the remote service to check whether the file specified by name exists. It should return True if the file exists, or False if it doesn’t:

    def listdir(self, path):
        """List a directory in the remote service. Return
           should be a 2-tuple of lists, the first a list
           of directories, the second a list of files."""

Copy

Explain
The listdir method should query the remote service to list the directory at path. It should then return a two-tuple list. The first element of this tuple is a list of directories inside path, while the second element is a list of files; take the following example:

return (["directory1", "directory2"], ["main.css", "document.txt", "image.jpg"])

Copy

Explain
If path contains no directories or no files, then an empty list should be returned for that element. You would return two empty lists if the directory was empty:

    def size(self, name):
        """Return the size in bytes of the file with
           name."""

Copy

Explain
The size method should query the remote service and get the size of the file specified by name:

    def url(self, name):
        """Return the URL where the file of with name can
           be access on the remote service. For example,
           this might be URL of the file after it has been
           uploaded to a specific remote host with a
           specific domain."""

Copy

Explain
The url method should determine the URL to access the file specified by name. This can be built by appending name to a specific static hosting URL:

    def _open(self, name, mode="rb"):
        """Return a File-like object pointing to file with
           name. For example, this could be a URL handle
           for a remote file."""

Copy

Explain
The _open method will provide a handle remote file, specified by name. How you implement this will depend on the type of remote service. You might have to download the file and then use a memory buffer (such as an io.BytesIO object) to simulate opening the file:

    def _save(self, name, content):
        """Write the content for a file with name. In this
           method you might upload the content to a remote
           service."""

Copy

Explain
The _save method should save content to the remote file at name. The method of implementing this will depend on your remote service. It might transfer the file over SFTP, or upload it to a CDN.

While this example does not implement any transferring to or from a remote service, you can refer to it to get an idea of how to implement a custom storage engine.

After implementing your custom storage engine, you can make it active by setting its dotted module path in the STATICFILES_STORAGE setting in settings.py.

You’ll now work on the first activity in this chapter. In this activity, you’ll add a static logo image to the Bookr application. The logo will be displayed in the Reviews section of the website.

Activity 5.01 – adding a Reviews logo
The Bookr app should have a logo that is specific to pages in the Reviews app. This will involve adding a base template just for the Reviews app and updating our current Reviews templates to inherit from it. Then, you’ll include the Bookr Reviews logo on this base template.

These steps will help you complete this activity:

Add a CSS rule to position the logo. Put this rule into the existing base.html file, after the .navbar-brand rule:
.navbar-brand > img {
  height: 60px;
}

Copy

Explain
Add a brand block template tag that inheriting templates can override. Put this inside the <a> element with the navbar-brand class. The default contents of block should be left as Book Review.
Add a static directory inside the Reviews app, containing a namespaced directory. Download the Reviews logo.png file from https://raw.githubusercontent.com/PacktPublishing/Web-Development-with-Django-Second-Edition/main/Chapter05/Activity5.01/bookr/reviews/static/reviews/logo.png and put it inside this directory.
Create a templates directory for the Bookr project (inside the Bookr project directory). Then, move the Reviews app’s current base.html into this directory so that it becomes a base template for the whole project.
Add the new templates directory’s path to the TEMPLATES["DIRS"] setting in settings.py.
Create another base.html template specifically for the Reviews app. Put it inside the Reviews app’s templates directory. The new template should extend the existing (now global) base.html file.
The new base.html file should override the content of the brand block. This block should contain just a <img> whose src attribute is set using the {% static %} template tag. The image source should be the logo we added in Step 2.
Refer to the following screenshots to see what your pages should look like after these changes. Note that although you are making changes to the base template, it will not change the layout of the main page:

Figure 5.20 – The Book List page after adding the Reviews logo
Figure 5.20 – The Book List page after adding the Reviews logo

On the Book Details page, you will also see the Reviews logo:

Figure 5.21 – The Book Details page after adding the Reviews logo
Figure 5.21 – The Book Details page after adding the Reviews logo

Note

The solution for this activity can be found on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

Activity 5.02 – CSS enhancements
Currently, the CSS is kept inline in the base.html template. As a best practice, it should be moved into its own file so that it can be cached separately and decrease the size of the HTML downloads. As part of this, you’ll also add some CSS enhancements such as fonts and colors, and link in Google Fonts CSS to support these changes.

These steps will help you complete this activity:

Create a directory named static in the Bookr project directory. Then, create a new file inside it named main.css.
Copy the contents of the <style> element from the main base.html template into the new main.css file, then remove the <style> element from the template. Add these extra rules to the end of the CSS file:
body {
    font-family: 'Source Sans Pro', sans-serif;
    background-color: #e6efe8
    color: #393939;
}
h1, h2, h3, h4, h5, h6 {
    font-family: 'Libre Baskerville', serif;
}

Copy

Explain
Link to the new main.css file with a <link rel="stylesheet" href="…"> tag. Use the {% static %} template tag to generate the URL for the href attribute, and don’t forget to load the static library.
Link in the Google Fonts CSS by adding this code to the base template:
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Libre+Baskerville|Source+Sans+Pro&display =swap">

Copy

Explain
(You will need to have an active internet connection so that your browser can include this remote CSS file.)

Update your Django settings to add STATICFILES_DIRS, which is set to the static directory you created in Step 1. When you’re finished, your Bookr application should look like Figure 5.22:
Figure 5.2﻿2 – Main page with a new font and background color
Figure 5.22 – Main page with a new font and background color

Notice the new font and background color. These should be displayed on all the Bookr pages.

Note

The solution for this activity can be found on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

Activity 5.03 – adding a global logo
You have already added a logo that is served on pages for the Reviews app. We have another logo to be used globally by default, but other apps will be able to override it:

Download the Bookr logo (logo.png) from https://raw.githubusercontent.com/PacktPublishing/Web-Development-with-Django-Second-Edition/main/Chapter05/Activity5.03/bookr/static/logo.png.
Save it in the main static directory for the project.
Edit the main base.html file. We already have a block for the logo (brand), so a <img> can be placed inside here. Use the static template tag to refer to the logo you just downloaded.
Check that your pages work. On the main URL, you should see the Bookr logo, but on the Book List and Book Details pages, you should see the Bookr Reviews logo.
When you’re finished, you should see the Bookr logo on the main page:

Figure 5.2﻿3 – Bookr logo on the main page
Figure 5.23 – Bookr logo on the main page

When you visit a page that had the Bookr Reviews logo before, such as the Book List page, it should still show the Bookr Reviews logo:

Figure 5.2﻿4 – Bookr Reviews logo still appears on the Reviews pages
Figure 5.24 – Bookr Reviews logo still appears on the Reviews pages

Note

The solution for this activity can be found on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

Summary
In this chapter, we showed you how to use Django’s staticfiles app to find and serve static files. We used the built-in static view to serve these files with the Django dev server in DEBUG mode. We showed different places to store static files by using a directory that is global to the project or in a specific directory for the application; global resources should be stored in the former while application-specific resources should be stored in the latter. We showed the importance of namespacing static file directories to prevent conflicts. After serving the assets, we used the static tag to include them in our template. We then demoed how the collectstatic command copies all the assets into the STATIC_ROOT directory, for production deployment. We showed how to use the findstatic command to debug the loading of static files. To invalidate caches automatically, we looked at using ManifestFilesStorage to add a hash of the file’s content to the static file URL. Finally, we briefly talked about using a custom file storage engine.

So far, we have only fetched web pages using content that already exists. In the next chapter, we will start adding forms so that we can interact with web pages by sending data to them over HTTP.



| ≪ [ 04 An Introduction to Django Admin ](/packtpub/2024/422-web_development_with_django_2ed/04_an_introduction_to_django_admin) | 05 Serving Static Files | [ 06 Forms ](/packtpub/2024/422-web_development_with_django_2ed/06_forms) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/422-web_development_with_django_2ed/05_serving_static_files
> (2) Markdown
> (3) Title: 05 Serving Static Files
> (4) Short Description: Publication date: May 2023 Publisher Packt Pages 764
> (5) tags: Django
> Book Title: 422-Web Development with Django 2ed
> Link: https://subscription.packtpub.com/book/web-development/9781803230603/pref
> create: 2024-05-08 수 14:11:52
> Images: /packtpub/2024/422-web_development_with_django_2ed_img/05/
> .md Name: 05_serving_static_files.md

