
| ≪ [ 08 Media Serving and File Uploads ](/packtpub/2024/422-web_development_with_django_2ed/08_media_serving_and_file_uploads) | 09 Sessions and Authentication | [ 10 Advanced Django Admin and Customizations ](/packtpub/2024/422-web_development_with_django_2ed/10_advanced_django_admin_and_customizations) ≫ |
|:----:|:----:|:----:|

# 09 Sessions and Authentication

Sessions and Authentication
So far, we have used Django to develop dynamic applications that allow users to interact with application models, but we have not attempted to secure these applications from unwanted use. For example, our Bookr app allows unauthenticated users to add reviews and upload media. This is a critical security issue for any online web app as it leaves the site open to the posting of spam or other inappropriate material and the vandalism of existing content. We want the creation and modification of content to be strictly limited to authenticated users who have registered with the site.

The authentication app supplies Django with the models for representing users, groups, and permissions. It also provides middleware, utility functions, decorators, and mixins that help us integrate user authentication into our apps. Furthermore, the authentication app allows us to group and name certain sets of users.

In Chapter 4, Introduction to Django Admin, we used the Admin app to create a help desk user group with the Can view log entry, Can view permission, Can change user, and Can view user permissions. Those permissions could be referenced in our code using their corresponding codenames: view_logentry, view_permissions, change_user, and view_user. In this chapter, we will learn how to customize Django behavior based on specific user permissions.

Permissions are directives that delineate what is permissible by classes of users. Permissions can be assigned either to groups or directly to individual users. From an administrative point of view, it is cleaner to assign permissions to groups. Groups make it easier to model roles and organizational structures. If a new permission is created, it is less time-consuming to modify a few groups than to remember to assign it to a subset of users.

We are already familiar with creating users and groups and assigning permissions using several methods, such as the option of instantiating users and groups through the model using scripts and the convenience of creating them through the Django Admin app. The authentication app also offers us programmatic ways of creating and deleting users, groups, and permissions and assigning relationships between them.

As we go through this chapter, we’ll learn how to use authentication and permissions to implement application security and how to store user-specific data to customize the user’s experience. This will help us secure the bookr project from unauthorized content changes and make it contextually relevant for different types of users. Adding this basic security to our bookr project is crucial before we consider deploying it on the internet.

This chapter begins with a brief introduction to middleware before delving into the concepts of authentication models and session engines. You will implement Django’s authentication model to restrict permissions to only a specific set of users. Then, you will learn how to leverage Django authentication to provide a flexible approach to application security. After that, you will learn how Django supports multiple session engines to retain user data. By the end of this chapter, you will be proficient at using sessions to retain information on past user interactions and to maintain user preferences for when pages are revisited.

We will cover the following topics in this chapter:

Middleware
Password storage in Django
Authentication decorators and redirection
Enhancing templates with authencation data
Sessions
Authentication, as well as session management (which we’ll learn about in the Sessions section), is handled by something known as a middleware stack. Before we implement authentication in our bookr project, let’s learn a bit about this middleware stack and its modules.

Technical requirements
The complete code files for this chapter can be found at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter09/.

Middleware
In Chapter 3, URL Mapping, Views, and Templates, we discussed Django’s implementation of the request/response process, along with its view and rendering functionality. In addition to these, another feature that plays an extremely important role when it comes to Django’s core web processing is middleware. Django’s middleware refers to a variety of software components that intervene in this request/response process to integrate important functionalities such as security, session management, and authentication.

So, when we write a view in Django, we don’t have to explicitly set a series of important security features in the response header. These additions to the response object are automatically made by the SecurityMiddleware instance after the view returns its response. As middleware components wrap the view and perform a series of pre-processes on the request and post-processes on the response, the view is not cluttered with a lot of repetitive code and we can concentrate on coding application logic rather than worrying about low-level server behavior. Rather than building these functionalities into the Django core, Django’s implementation of a middleware stack allows these components to be both optional and replaceable.

Middleware modules
When we run the startproject subcommand, a default list of middleware modules is added to the MIDDLEWARE variable in the <project>/settings.py file, as follows:

  MIDDLEWARE = [
      "django.middleware.security.SecurityMiddleware",
      "django.contrib.sessions.middleware.SessionMiddleware",
      "django.middleware.common.CommonMiddleware",
      "django.middleware.csrf.CsrfViewMiddleware",
      "django.contrib.auth.middleware.AuthenticationMiddleware",
      "django.contrib.messages.middleware.MessageMiddleware",
      "django.middleware.clickjacking.XframeOptionsMiddleware",
  ]

Copy

Explain
This is a minimal middleware stack that is suitable for most Django applications. The following list elaborates on the general purpose of each module:

SecurityMiddleware provides common security enhancements such as handling SSL redirects and adding response headers to prevent common hacks
SessionMiddleware enables session support and seamlessly associates a stored session with the current request
CommonMiddleware implements a lot of miscellaneous features, such as rejecting requests from the DISALLOWED_USER_AGENTS list, implementing URL rewrite rules, and setting the Content-Length header
CsrfViewMiddleware adds protection against Cross-Site Request Forgery (CSRF)
AuthenticationMiddleware adds the user attribute to the request object
MessageMiddleware adds “flash” message support
XFrameOptionsMiddleware protects against X-Frame-Options header clickjacking attacks
The middleware modules are loaded in the order that they appear in the MIDDLEWARE list. This makes sense because we want to call the middleware that deals with initial security issues first so that dangerous requests are rejected before further processing occurs. Django also comes with several other middleware modules that perform important functions, such as using gzip file compression, redirect configuration, and web cache configuration.

This chapter is devoted to discussing two important aspects of stateful application development that are implemented as middleware components – SessionMiddleware and AuthenticationMiddleware.

The process_request method of SessionMiddleware adds a session object as an attribute of the request object. The process_request method of AuthenticationMiddleware adds a user object as an attribute of the request object.

It is possible to write a Django project without these layers of the middleware stack if a project does not require user authentication or a means of preserving the state of individual interactions. However, most of the default middleware plays an important role in application security. If you don’t have a good reason for changing the middleware components, it is best to maintain these initial settings. The Admin app requires SessionMiddleware, AuthenticationMiddleware, and MessageMiddleware to run, and the Django server will throw errors such as these if the Admin app is installed without them:

django.core.management.base.SystemCheckError: SystemCheckError: System check identified some issues:
ERRORS:
?: (admin.E408) 'django.contrib.auth.middleware.AuthenticationMiddleware' must be in MIDDLEWARE in order to use the admin application.
?: (admin.E409) 'django.contrib.messages.middleware.MessageMiddleware' must be in MIDDLEWARE in order to use the admin application.
?: (admin.E410) 'django.contrib.sessions.middleware.SessionMiddleware' must be in MIDDLEWARE in order to use the admin application.

Copy

Explain
Now that we know about the middleware modules, let’s look at one way we can enable authentication in our project using the authentication app’s views and templates.

Implementing authentication views and templates
We encountered the login form on the Admin app in Chapter 4, Introduction to Django Admin. This is the authentication entry point for staff users who have access to the Admin app. We also need to create a login capability for ordinary users who want to give book reviews. Fortunately, the authentication app comes with the tools to make this possible.

As we work through the forms and views of the authentication app, we will encounter a lot of flexibility in its implementation. We are free to implement our own login pages, define either very simple or fine-grained security policies at the view level, and authenticate against external authorities.

The authentication app exists to accommodate a lot of different approaches to authentication so that Django doesn’t rigidly enforce a single mechanism. For a first-time user encountering the documentation, this can be quite bewildering. For the most part in this chapter, we will follow Django’s defaults, but some of the important configuration options will be noted.

A Django project’s settings object contains attributes for login behavior. LOGIN_URL specifies the URL of the login page. '/accounts/login/' is the default value. LOGIN_REDIRECT_URL specifies the path to where a successful login is redirected. The default path is '/accounts/profile/'.

The authentication app supplies standard forms and views for carrying out typical authentication tasks. These forms are located in django.contrib.auth.forms, while the views are located in django.contrib.auth.views.

The views are referenced by these URL patterns present in django.contrib.auth.urls:

urlpatterns = [
    path('login/', views.LoginView.as_view(),
        name='login'),
    path('logout/', views.LogoutView.as_view(),
        name='logout'),
    path('password_change/',
        views.PasswordChangeView.as_view(),
        name='password_change'),
    path('password_change/done/',
        views.PasswordChangeDoneView.as_view(),
        name='password_change_done'),
    path('password_reset/',
        views.PasswordResetView.as_view(),
        name='password_reset'),
    path('password_reset/done/',
        views.PasswordResetDoneView.as_view(),
        name='password_reset_done'),
    path('reset/<uidb64>/<token>/',
        views.PasswordResetConfirmView.as_view(),
        name='password_reset_confirm'),
    path('reset/done/',
        views.PasswordResetCompleteView.as_view(),
        name='password_reset_complete'),
]

Copy

Explain
If this style of views looks unfamiliar, it is because they are class-based views rather than the function-based views that we have previously encountered. We will learn more about class-based views in Chapter 11, Advanced Templating and Class-Based Views. For now, note that the authentication app makes use of class inheritance to group the functionality of views and prevent a lot of repetitive coding.

If we want to maintain the default URLs and views that are presupposed by the authentication app and Django settings, we can include the authentication app’s URLs in our project’s urlpatterns.

By taking this approach, we have saved a lot of work. We only need to include the authentication app’s URLs in our <project>/urls.py file and assign it to the 'accounts' namespace. Designating this namespace ensures that our reverse URLs correspond to the default template values of the views. The authlib views contain code references to templates named password_reset_done and password_reset_complete, so their paths need to be explicitly included in our urlpatterns too:

from django.contrib import admin, auth
…
urlpatterns = [
    path("admin/", admin.site.urls),
    path("accounts/", include(("django.contrib.auth.urls",
        "auth"),
        namespace="accounts")),
    path("accounts/password_reset/done/",
        auth.views.PasswordResetDoneView.as_view(),
        name="password_reset_done",),
    path("accounts/reset/done/",
        auth.views.PasswordResetCompleteView.as_view(),
        name="password_reset_complete",),
    path("", reviews.views.index),
    path("book-search/", reviews.views.book_search,
        name="book_search"),
    path("", include("reviews.urls")),
]

Copy

Explain
Though the authentication app comes with forms and views, it lacks the templates needed to render these components as HTML. Figure 9.1 lists the templates that we require to implement the authentication functionality in our project. Fortunately, the Admin app does implement a set of templates that we can utilize for our purposes.

We could just copy the template files from the Django source code in the django/contrib/admin/templates/registration directory and django/contrib/admin/templates/admin/login.html into our project’s templates/registration directory:

Note

When we say Django source code, it’s the directory where your Django installation resides. If you installed Django in a virtual environment (as detailed in the Preface), you can find these template files at <name of your virtual environment>/lib/python3.X/site-packages/django/contrib/admin/templates/registration/. Provided your virtual environment is activated and Django is installed in it, you can also retrieve the complete path to the site-packages directory by running the python -c "import sys; print(sys.path)" command in a terminal.

Figure 9.1 ﻿– Default paths for authentication templates
Figure 9.1 – Default paths for authentication templates

Note

We only need to copy the templates that are dependencies for the views and should avoid copying the base.html or base_site.html files.

This gives a promising result at first, but as they stand, the admin templates do not meet our precise needs, as we can see from the login page (Figure 9.2):

Figure 9.2 – A first attempt at a user login screen
Figure 9.2 – A first attempt at a user login screen

As these authentication pages inherit from the Admin app’s admin/base_site.html template, they follow the style of the Admin app. We would prefer for these pages to follow the style of the bookr project that we have developed. We can do this by following these three steps on each Django template that we have copied from the Admin app to our project:

The first change that needs to be made is to replace the {% extends "admin/base_site.html" %} tag with {% extends "base.html" %}.
Given that template/base.html only contains the title, brand, and content block definitions, we should examine the additional block substitutions from our templates in the bookr folder. We are not using the content from the userlinks and breadcrumbs blocks in our app’s template layouts, so these blocks can be removed entirely.
Some of these blocks, such as content_title and reset_link, contain HTML content that is relevant to our application, so they should be retained.

For example, the password_change_done.html template contains the userlinks and breadcrumbs blocks:

{% extends "admin/base_site.html" %}
{% load i18n %}
{% block userlinks %}{% url 'django-admindocs-docroot' as docsroot %}{% if docsroot %}<a href="{{ docsroot }}">{% translate 'Documentation' %}</a> / {% endif %}{% translate 'Change password' %} / <a href="{% url 'admin:logout' %}">{% translate 'Log out' %}</a>{% endblock %}
{% block breadcrumbs %}
<div class="breadcrumbs">
<a href="{% url 'admin:index' %}">{% translate 'Home' %}</a>
&rsaquo; {% translate 'Password change' %}
</div>
{% endblock %}
{% block content %}
<p>{% translate 'Your password was changed.' %}</p>
{% endblock %}

Copy

Explain
It will be simplified to this template in the bookr project:

{% extends "base.html" %}
{% load i18n %}
{% block content %}
<p>{% translate 'Your password was changed.' %}</p>
{% endblock %}

Copy

Explain
Likewise, there are reverse URL patterns that need to change to reflect the current path, so {% url 'login' %} gets replaced with {% url 'accounts:login' %}.
Given these considerations, the next exercise will focus on transforming the Admin app’s login template into a login template for the bookr project.

Note

The i18n module is used for creating multilingual content. If you intend to develop multilingual content for your website, leave the i18n import, translate tags, and translateblock statements in the templates. For brevity, we will not be covering those in detail in this chapter.

Exercise 9.01 – repurposing the Admin app login template
We started this chapter without a login page for our project. By adding the URL patterns for authentication and copying the templates from the Admin app to our project, we can implement the functionality of a login page. But this login page is not satisfactory as it is directly copied from the Admin app and is disconnected from the Bookr design. In this exercise, we will follow the steps needed to repurpose the Admin app’s login template for our project. The new login template will need to inherit its style and format directly from the bookr project’s templates/base.html:

Create a directory inside your project for templates/registration.
The Admin login template is located in the Django source directory at the django/contrib/admin/templates/admin/login.html path. It begins with an extends tag, a load tag, importing the i18n and static modules, and a series of block extensions that override the blocks defined in the child template, django/contrib/admin/templates/admin/base.html. A truncated snippet of the login.html file is shown in the following code block:

{% extends "admin/base_site.html" %}
{% load i18n static %}
{% block extrastyle %}{{ block.super }}…
{% endblock %}
{% block bodyclass %}{{ block.super }} login{% endblock %}
{% block usertools %}{% endblock %}
{% block nav-global %}{% endblock %}
{% block content_title %}{% endblock %}
{% block breadcrumbs %}{% endblock %}

Copy

Explain
Copy this Admin login template, django/contrib/admin/templates/admin/login.html, into templates/registration and begin editing the file using PyCharm.
As the login template you are editing is located at templates/registration/login.html and extends the base template (templates/base.html), replace the argument of the extends tag at the top of templates/registration/login.html with the following:
{% extends "base.html" %}

Copy

Explain
We don’t need most of the contents of this file. Just retain the content block, which contains the login form. The remainder of the template will consist of loading the i18n and static tag libraries:
{% load i18n static %}
{% block content %}
…
{% endblock %}

Copy

Explain
Now, you must replace the paths and reverse URL patterns in templates/registration/login.html with ones that are appropriate to your project. As you don’t have an app_path variable defined in your template, it needs to be replaced with the reverse URL for the login, 'accounts:login'. So, consider the following line:
<form action="{{ app_path }}" method="post" id="login-form">

Copy

Explain
This line changes as follows:

<form action="{% url 'accounts:login' %}" method="post" id="login-form">

Copy

Explain
No 'admin_password_reset' has been defined in your project paths, so it will be replaced with 'accounts:password_reset'.

Consider the following line:

{% url 'admin_password_reset' as password_reset_url %}

Copy

Explain
This changes to the following line:

{% url 'accounts:password_reset' as password_reset_url %}

Copy

Explain
Your login template will look as follows:

templates/registration/login.html

  {% extends "base.html" %}
  {% load i18n static %}
  {% block content %}
  {% if form.errors and not form.non_field_errors %}
  <p class="errornote">
  {% if form.errors.items|length == 1 %}{% translate
  "Please correct the error 
  below." %}{% else %}{% translate "Please correct
  the errors below." %}{% endif %}
  </p>
  {% endif %}

Copy

Explain
You can find the complete code for this file at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter09/Exercise9.01/bookr.

As mentioned previously, to use the standard Django authentication views, we must add URL mappings to them. Open the urls.py file in the bookr project directory, ensure that auth is imported from django.contrib, and add the three paths to the URL patterns:
from django.contrib import admin, auth
…
urlpatterns = [
    …
    path("accounts/",
        include(("django.contrib.auth.urls", "auth"),
        namespace="accounts")),
    path("accounts/password_reset/done/",
        auth.views.PasswordResetDoneView.as_view(),
        name="password_reset_done",),
    path("accounts/reset/done/",
        auth.views.PasswordResetCompleteView.as_view(),
        name="password_reset_complete",),
    …
]

Copy

Explain
Now, when you visit the login link at http://127.0.0.1:8000/accounts/login/, you will see this page:
Figure 9.3 – The Bookr login page
Figure 9.3 – The Bookr login page

By completing this exercise, you have created the template required for non-admin authentication in your project.

Note

Before you proceed, you’ll need to make sure the rest of the templates in the registration directory follow the bookr project’s style; that is, they inherit from the Admin app’s admin/base_site.html template. You’ve already seen this done with password_change_done.html and the login.html templates. Go ahead and apply what you’ve learned in this exercise (and the section before it) to the rest of the files in the registration directory. Alternatively, you may download the modified files from this book’s GitHub repository: https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter09/Activity9.01/bookr.

Now that we have modified our project to enable authentication, we will learn about password and session storage in Django.

Password storage in Django
Django does not store passwords in plain text form in the database. Instead, passwords are digested with a hashing algorithm, such as PBKDF2/SHA256, BCrypt/SHA256, or Argon2. As hashing algorithms are a one-way transformation, this prevents a user’s password from being decrypted from the hash stored in the database. This often comes as a surprise to users who expect a system administrator to retrieve their forgotten password, but it is best practice in security design. So, if we query the database for the password, we will see something like this:

Figure 9.4 – Password hashes in a Django SQLite3 database
Figure 9.4 – Password hashes in a Django SQLite3 database

The components of this string are <algorithm>$<iterations>$<salt>$<hash>. As several hashing algorithms have been compromised over time and we sometimes need to work with mandated security requirements, Django is flexible enough to accommodate new algorithms and can maintain data encrypted in multiple algorithms.

The profile page and the request.user object
When a login is successful, the login view redirects to /accounts/profile. However, this path is not included in the existing auth.url, nor does the authentication app provide a template for it. To avoid a Page not Found error, a view and an appropriate URL pattern are required.

Each Django request has a request.user object. If the request is made by an unauthenticated user, request.user will be an AnonymousUser object. If the request is made by an authenticated user, then request.user will be a User object. This makes it easy to retrieve personalized user information in a Django view and render it in a template.

In the next exercise, we will add a profile page to our bookr project.

Exercise 9.02 – adding a profile page
In this exercise, we will add a profile page to our project. To do so, we need to include the path to it in our URL patterns and also include it in our views and templates. The profile page will simply display the following attributes from the request.user object:

username
first_name and last_name
date_joined
email
last_login
Perform the following steps to complete this exercise:

Add bookr/views.py to the project. It needs a trivial profile function to define our view:
from django.shortcuts import render
def profile(request):
    return render(request, 'profile.html')

Copy

Explain
In the templates folder of your main bookr project, create a new file called profile.html. In this template, the attributes of the request.user object can easily be referenced by using a notation such as {{ request.user.username }}:
{% extends "base.html" %}
{% block title %}Bookr{% endblock %}
{% block content %}
<h2>Profile</h2>
<div>
  <p>
      Username: {{ request.user.username }} <br>
      Name: {{ request.user.first_name }} {{
        request.user.last_name }}<br>
      Date Joined: {{ request.user.date_joined }} <br>
      Email: {{ request.user.email }}<br>
      Last Login: {{ request.user.last_login }}<br>
  </p>
</div>
{% endblock %}

Copy

Explain
We also added a block containing the profile details of the user. More importantly, we made sure that profile.html extends base.html.

Finally, this path needs to be added to the top of the urlpatterns list in bookr/urls.py. First, import the new views and then add a path linking the accounts/profile/ URL to bookr.views.profile:
from bookr.views import profile
urlpatterns = […
    path('accounts/profile/', profile,
        name='profile'),
    path("", reviews.views.index),
    path("book-search/",
        reviews.views.book_search,
        name="book_search"),
    path('', include('reviews.urls'))]

Copy

Explain
This is a good start on a user profile page. When Alice logs in and visits http://localhost:8000/accounts/profile/, it is rendered as shown in Figure 9.5. Remember, if the server needs to be started, use the python manage.py runserver command:

Figure 9:5 – Alice visits her user profile
Figure 9:5 – Alice visits her user profile

With that, we’ve seen how we can redirect a user to their profile page, once they’ve successfully logged in. Now, let’s discuss how we can give content access to specific users only.

Authentication decorators and redirection
Now that we have learned how to allow ordinary users to log in to our project, we can discover how to restrict content to authenticated users. The authentication module comes with some useful decorators that can be used to secure views according to the current user’s authentication or access.

Unfortunately, if, say, a user named Alice was to log out of Bookr, the profile page would still render and display empty details. Instead of this happening, it would be preferable for any unauthenticated visitor to be directed to the login screen:

Figure 9.6 – An unauthenticated user visits a user profile
Figure 9.6 – An unauthenticated user visits a user profile

The authentication app comes with useful decorators for adding authentication behavior to Django views. In this situation of securing our profile view, we can use the login_required decorator:

from django.contrib.auth.decorators import login_required
@login_required
def profile(request):
    …

Copy

Explain
Now, if an unauthenticated user visits the /accounts/profile URL, they will be redirected to http://localhost:8000/accounts/login/?next=/accounts/profile/.

This URL takes the user to the login URL. The next parameter in the GET variables tells the login view where to redirect to after a successful login. The default behavior is to redirect back to the current view, but this can be overridden by specifying the login_url argument to the login_required decorator. For example, if we had some need to redirect to a different page after login, we could have explicitly stated it in the decorator call like this:

@login_required(login_url='/accounts/profile2')

Copy

Explain
If we had rewritten our login view to expect the redirection URL to be specified in a different URL argument to 'next', we could explicate this in the decorator call with the redirect_field_name argument:

@login_required(redirect_field_argument='redirect_to')

Copy

Explain
There are often situations where a URL should be restricted to users or groups holding a specific condition. Consider the case where we have a page for staff users to view any user profile. We don’t want this URL to be accessible to all users, so we want to limit this URL to users or groups with the 'view_user' permission and forward the unauthorized requests to the login URL:

from django.contrib.auth.decorators import (login_required,
    permission_required)
…
@permission_required('view_group')
def user_profile(request, uid):
    user = get_object_or_404(User, id=uid)
    permissions = user.get_all_permissions()
    return render(request, 'user_profile.html',
        {'user': user, 'permissions': permissions})

Copy

Explain
Som with this decorator applied to our user_profile view, an unauthorized user visiting http://localhost:8000/accounts/users/123/profile/ would be redirected to http://localhost:8000/accounts/login/?next=/accounts/users/123/profile/.

Sometimes, though, we need to structure more subtle conditional permissions that don’t fall into the scope of these two directors. For this purpose, Django provides a custom decorator that takes an arbitrary function as an argument. The user_passes_test decorator requires a test_func argument:

  user_passes_test(test_func, login_url=None,
      redirect_field_ name='next')

Copy

Explain
Here’s an example where we have a view, veteran_features, that is only available to users who have been registered on the site for more than a year:

  from django.contrib.auth.decorators import (login_required, 
      permission_required, user_passes_test)
  …
  def veteran_user(user):
      now = datetime.datetime.now()  
      if user.date_joined is None:
          return False
      return now - user.date_joined > datetime.timedelta(days=365)
  @user_passes_test(veteran_user) 
  def veteran_features(request):
      user = request.user
      permissions = user.get_all_permissions() 
      return render(request, 'veteran_profile.html',
          {'user': user, 'permissions': permissions})

Copy

Explain
Sometimes, the logic in our views cannot be handled with one of these decorators and we need to apply the redirect within the control flow of the view. We can do this using the redirect_to_login helper function. It takes the same arguments as the decorators, as shown in the following snippet:

  redirect_to_login(next, login_url=None,
      redirect_field_name='next')

Copy

Explain
We will consolidate our knowledge of authentication decorators by applying them to the Bookr project in the following exercise.

Exercise 9.03 – adding authentication decorators to the views
Having learned about the flexibility of the authentication app’s permission and authentication decorators, we will now set about putting them to use in the Reviews app. We need to ensure that only authenticated users can edit reviews and that only staff users can edit publishers. There are several ways of doing this, so we will attempt a few approaches. All the code in these steps is in the reviews/views.py file:

Your first instinct to solve this problem would be to think that the publisher_edit method needs an appropriate decorator to enforce that the user has edit_publisher permission. For this, you could easily do something like this:
from django.contrib.auth.decorators import
permission_required 
…
@permission_required('edit_publisher')
def publisher_edit(request, pk=None):
    …

Copy

Explain
Using this method is fine and it’s one way to add permissions checking to a view. You can also use a slightly more complicated but more flexible method. Instead of using a permission decorator to enforce permission rights on the publisher_edit method, you can create a test function that requires a staff user and apply this test function to publisher_edit with the user_passes_test decorator. Writing a test function allows more customization on how you validate users’ access rights or permissions. If you made changes to your views.py file in step 1, feel free to comment the decorator out (or delete it) and write the following test function instead:
from django.contrib.auth.decorators import
user_passes_test
…
def is_staff_user(user):
    return user.is_staff
@user_passes_test(is_staff_user)
    …

Copy

Explain
Ensure that login is required for the review_edit and book_media functions by adding the appropriate decorator:
…
from django.contrib.auth.decorators import
    (login_required, user_passes_test)
…
@login_required
def review_edit(request, book_pk, review_pk=None):
@login_required
def book_media(request, pk):
…

Copy

Explain
In the review_edit method, add logic to the view that requires that the user be either a staff user or the owner of the review. The review_edit view controls the behavior of both review creation and review updates. The constraint that we are developing only applies to the case where an existing review is being updated. So, the place to add code is after a Review object has been successfully retrieved. If the user is not a staff account or the review’s creator doesn’t match the current user, we need to raise a PermissionDenied error:
…
from django.core.exceptions import PermissionDenied
from PIL import Image
from django.contrib import messages
…
@login_required
def review_edit(request, book_pk, review_pk=None):
    book = get_object_or_404(Book, pk=book_pk)
    if review_pk is not None:
        review = get_object_or_404(Review,
                                   book_id=book_pk,
                                   pk=review_pk)
        user = request.user
        if not user.is_staff and review.creator.id !=
        user.id:
            raise PermissionDenied
    else:
        review = None
…

Copy

Explain
Now, when a non-staff user attempts to edit another user’s review, a Forbidden error will be thrown, as in Figure 9.7. In the next section, we will look at applying conditional logic in templates so that users aren’t taken to pages that they don’t have sufficient permission to access:

Figure 9.7 – Access is forbidden to non-staff users
Figure 9.7 – Access is forbidden to non-staff users

In this exercise, we used authentication decorators to secure views in a Django app. The authentication decorators that were applied provided a simple mechanism to restrict views from users lacking necessary permissions, non-staff users, and unauthenticated users. Django’s authentication decorators provide a robust mechanism that follows Django’s role and permission framework, while the user_passes_test decorator provides an option to develop custom authentication.

Now that we have used decorators to control the authentication flow of the application, we can customize templates with user authentication data.

Enhancing templates with authentication data
In Exercise 9.02 – adding a profile page, we saw that we can pass the request.user object to the template to render the current user’s attributes in the HTML. We can also take the approach of giving different template renderings according to the user type or permissions held by a user. Consider that we want to add an edit link that only appears to staff users. We might apply an if condition to achieve this:

{% if user.is_staff %}
  <p><a href="{% url 'review:edit' %}">Edit this Review</a>
  </p>
{% endif %}

Copy

Explain
If we didn’t take the time to conditionally render links based on permissions, users would have a frustrating experience navigating the application as many of the links that they click on would lead to 403 Forbidden pages. The following exercise will show how we can use templates and authentication to present contextually appropriate links in our project.

Exercise 9.04 – toggling login and logout links in the base template
In the bookr project’s base template, located in templates/base.html, we have a placeholder logout link in the header. It is coded in HTML as follows:

<li class="nav-item">
  <a class="nav-link" href="#">Logout</a>
</li>

Copy

Explain
We don’t want the logout link to appear after a user has logged out. So, this exercise aims to apply conditional logic to the template so that the Login and Logout links are toggled, depending on whether the user is authenticated:

Edit the templates/base.html file. Copy the structure of the Logout list element and create a Login list element. Then, replace the placeholder links with the correct URLs for the Logout and Login pages – /accounts/logout and /accounts/login, respectively – as follows:
<li class="nav-item">
  <a class="nav-link" href="/accounts/logout">Logout
  </a>
</li>
<li class="nav-item">
  <a class="nav-link" href="/accounts/login">Login</a>
</li>

Copy

Explain
Now, put our two li elements inside an if … else … endif conditional block. The logic condition that we are applying is if user.is_authenticated:
{% if user.is_authenticated %}
  <li class="nav-item">
    <a class="nav-link" href="/accounts/logout">Logout
    </a>
  </li>
    {% else %}
  <li class="nav-item">
    <a class="nav-link" href="/accounts/login">Login
    </a>
  </li>
{% endif %}

Copy

Explain
Now, visit the user profile page at http://localhost:8000/accounts/profile/. When authenticated, you will see the Logout link:
Figure 9.8 – An authenticated user sees the Logout link
Figure 9.8 – An authenticated user sees the Logout link

Now, click the Logout link; you will be taken to the /accounts/logout page. The Login link appears in the menu, confirming that the link is contextually dependent on the authentication state of the user:
Figure 9.9 – An unauthenticated user sees the Login link 
Figure 9.9 – An unauthenticated user sees the Login link

This exercise was a simple example of how Django templates can be used with authentication information to create a stateful and contextual user experience. We also do not want to provide links that a user does not have access to or actions that are not permissible for the user’s permission level. The following activity will use this templating technique to fix some of these problems in Bookr.

Activity 9.01 – authentication-based content using conditional blocks in templates
In this activity, you will apply conditional blocks to templates that modify content based on user authentication and user status. Users should not be presented with links that they are not permitted to visit or actions that they are not authorized to carry out. The following steps will help you complete this activity:

In the book_detail template, in the file at reviews/templates/reviews/book_detail.html, hide the Add Review and Media buttons from non-authenticated users.
Also, hide the heading that says Be the first one to write a review as that is not an option for non-authenticated users.
In the same template, make the Edit Review link only appear for the staff or the user that wrote the review. The conditional logic for the template block is very similar to the conditional logic that we used in the review_edit view in the previous section:
Figure 9.10 – The Edit Review link appears on Alice’s review when Alice is logged in
Figure 9.10 – The Edit Review link appears on Alice’s review when Alice is logged in

When a different user is logged in, the Edit Review link will not be present:

Figure 9.11 – There is no Edit Review link on Alice’s review when Bob is logged in
Figure 9.11 – There is no Edit Review link on Alice’s review when Bob is logged in

Modify template/base.html so that it displays the currently authenticated user’s username to the right of the search form in the header, linking to the user profile page.
By completing this activity, you will have added dynamic content to the template that reflects the authentication state and identity of the current user, as can be seen from the following screenshot:

Figure 9.12 – An authenticated user’s name appears after the search form
Figure 9.12 – An authenticated user’s name appears after the search form

Note

You can find the solution for this activity on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

With that, we have reviewed the available authentication mechanisms in Django and can examine how Django implements sessions.

Sessions
It is worth looking at some theory to understand why sessions are a common solution in web applications for managing user content. The HTTP protocol defines the interactions between a client and a server. It is said to be a “stateless” protocol as no stateful information is retained by the server between requests. This protocol design worked well for delivering hypertextual information in the early days of the World Wide Web, but it did not suit the needs of secured web applications delivering customized information to specific users.

We are now acquainted with seeing websites adapt to our viewing habits. Shopping sites recommend similar products to the ones that we have recently viewed and tell us about products that are popular in our region. These features all required a stateful approach to website development. One of the most common ways to implement a stateful web experience is through sessions. A session refers to a user’s current interaction with a web server or application and requires that data be persisted for the duration of the interaction. This may include information about the links that the user has visited, the actions that they have performed, and the preferences that they have made in their interactions.

If a user sets a blogging site to a dark theme on one page, there is an expectation that the next page will use the same theme as well. We describe this behavior as maintaining state A session key is stored client-side as a browser cookie, which can be identified with server-side information that persists while the user is logged in.

In Django, sessions are implemented as a form of middleware. When we initially created the app in Chapter 4, Introduction to Django Admin, session support was activated by default.

The session engine
Information about current and expired sessions needs to be stored somewhere. In the early days of the World Wide Web, this was done through saving session information in files on the server, but as web server architectures have become more elaborate and their performance demands have increased, other more efficient strategies such as a database or in-memory storage have become the norm. By default, in Django, session information is stored in a project’s database.

This is a reasonable default for most small projects. However, Django’s middleware implementation of sessions gives us the flexibility to store our project’s session information in a variety of ways to suit our system architecture and performance requirements. Each of these different implementations is called a session engine. If we want to change the session configuration, we need to specify the SESSION_ENGINE setting in the project’s settings.py file:

Cached sessions: In some environments, caching session information in memory or a database is an approach that is suited to high performance. Django provides the django.contrib.sessions.backends.cache and django.contrib.sessions.backends.cached_db session engines for this purpose.
File-based sessions: As stated earlier, this is a somewhat antiquated way of maintaining session information but may suit some sites where performance is not an issue and there are reasons not to store dynamic information in a database.
Cookie-based sessions: Rather than keeping session information on the server side, you can keep them entirely in the web browser client by serializing the content of the session as JSON and storing it in a browser-based cookie.
Do you need to flag cookie content?
All of Django’s implementations of sessions require storing a session ID in a cookie on the user’s web browser.

Regardless of the session engine employed, all these middleware implementations involve storing a site-specific cookie in the web browser. In the early days of web development, it was not uncommon to pass session IDs as URL arguments, but this approach has been eschewed in Django for reasons of security.

In many jurisdictions, including the European Union, websites are legally required to warn users if the site sets cookies in their browsers. If there are such legislative requirements in the region where you intend to operate your site, it is your responsibility to ensure that the code meets these obligations. Be sure to use up-to-date implementations and avoid using abandoned projects that have not kept pace with legislative changes.

Note

To cater to these changes and legislative requirements, there are many useful apps, such as Django Cookie Consent and Django Cookie Law, that are designed to work with several legislative frameworks. You can find out more by going to the following links:

https://github.com/jazzband/django-cookie-consent
https://github.com/TyMaszWeb/django-cookie-law
Many JavaScript modules exist that implement similar cookie consent mechanisms.

With this in mind, we can examine how session data is implemented in Django.

Pickle or JSON storage?
Python provides the pickle module in its standard library for serializing Python objects into a byte stream representation. A pickle is a binary structure that has the benefit of being interoperable between different architectures and different versions of Python so that a Python object can be serialized to a pickle on a Windows PC and deserialized to a Python object on a Linux Raspberry Pi.

This flexibility comes with security vulnerabilities and it is not recommended that it is used to represent untrusted data. Consider the following Python object, which contains several types of data. It can be serialized using pickle:

import datetime
data = dict(viewed_books=[17, 18, 3, 2, 1],
            search_history=['1981', 'Machine Learning',
            'Bronte'],
            background_rgb=(96, 91, 92),
            foreground_rgb=(17, 17, 17),
            last_login_login=datetime.datetime(2019, 12, 3,
            15, 30, 30),
            password_change=datetime.datetime(2019, 9, 2,
            8, 41, 25),
            user_class='Veteran',
            average_rating=4.75,
            reviewed_books={18, 3, 7})

Copy

Explain
Using the dumps (dump string) method of the pickle module, we can serialize the data object to produce a byte representation:

import pickle
data_pickle = pickle.dumps(data)

Copy

Explain
JSON stands for JavaScript Object Notation. The syntax of JSON is a small subset of the JavaScript language. It is a widespread standard for messaging and data exchange, commonly used for transferring data between web browsers and servers. We can serialize JSON with a similar approach to the one that we outlined with the pickle format:

import json
data_json = json.dumps(data)

Copy

Explain
Because data contains Python datetime and set objects, which aren’t serializable with JSON, when we attempt to serialize the structure, a type error will be thrown:

TypeError: Object of type datetime is not JSON serializable

Copy

Explain
For serializing to JSON, we could convert the datetime objects into the string type and set them in a list:

data['last_login_login'] =
    data['last_login_login'].strftime("%Y%d%m%H%M%S")
data['password_change'] =
    data['password_change'].strftime("%Y%d%m%H%M%S")
data['reviewed_books'] = list(data['reviewed_books'])

Copy

Explain
As JSON data is human-readable, it is easy to examine:

{"viewed_books": [17, 18, 3, 2, 1], "search_history": ["1981", "Machine Learning", "Bronte"], "background_rgb": [96, 91, 92], "foreground_rgb": [17, 17, 17], "last_login_login": "20190312153030", "password_change": "20190209084125", "user_class": "Veteran", "average_rating": 4.75, "reviewed_books": [18, 3, 7]}

Copy

Explain
Note that we had to explicitly convert the datetime and set objects, but the tuple is automatically converted into a list by the JSON. Django ships with PickleSerializer and JSONSerializer. If the serializer needs to be altered, it can be changed by setting the SESSION_SERIALIZER variable in the project’s settings.py file:

SESSION_SERIALIZER =
'django.contrib.sessions.serializers.JSONSerializer'

Copy

Explain
Exercise 9.05 – examining the session key
The purpose of this exercise is to query the project’s SQLite database and perform queries on the session table to become familiar with how session data is stored. You will then create a Django management command for examining session data that is stored using JSONSerializer:

Start the DB Browser for SQLite application and open your db.sqlite3 database:
Figure 9.13 – Table selection in DB Browser for SQLite
Figure 9.13 – Table selection in DB Browser for SQLite

Under the Database Structure tab, expand the django_session table:
Figure 9.14 – Table definitions in DB Browser for SQLite
Figure 9.14 – Table definitions in DB Browser for SQLite

This reveals that the django_session table in the database stores session information in the session_key, session_data, and expire_date fields.

Click on the Browse Data tab and select the django_session table:
Figure 9.15 – Querying data in the django_session table
Figure 9.15 – Querying data in the django_session table

Django stores the session data using cryptographical signed values. Because by default we are using the database to store our sessions, we will import the Session model, as well as the SessionStore class of django.contrib.sessions.backends.db. SessionStore has a decode method that we can use to read the encoded session_data from the Session object.
This code snippet can be executed using the Django shell by entering python manage.py shell at the command line to get an interactive prompt:
>>> from django.contrib.sessions.backends.db import SessionStore
>>> from django.contrib.sessions.models import Session
>>> session_store = SessionStore()
>>> sessions = Session.objects.all()
>>> session_store.decode(sessions[0].session_data)
{'_auth_user_id': '2', '_auth_user_backend': 'django.contrib.auth.backends.ModelBackend', '_auth_user_hash': 'eb5de6bf54460bafc9e0f555c65d16b17b3fdf754617d1d73529d 9605fea2f0c'}

Copy

Explain
Using this approach, we can create a management command for examining session data. Sensitive data may be stored in sessions, so creating a management command ensures that the data is only accessible by a user with console access to the server that is hosting Django.
Using PyCharm, in the reviews/management/commands directory of the Bookr project, create a Python file called sessioninfo.py.
Let’s start by importing the necessary modules. We will use the pformat command from the pprint module from Python’s Standard Library to format session data. We will need the User model from django.contrib.auth.models and the Session model from django.contrib.sessions.models to query User and Session objects. The BaseCommand class from django.core.management.base provides the scaffolding for our Django Admin command:
from pprint import pformat
from django.contrib.auth.models import User
from django.contrib.sessions.models import Session
from django.contrib.sessions.backends.db import SessionStore
from django.core.management.base import BaseCommand

Copy

Explain
At a minimum, a user command needs to be defined by subclassing BaseCommand as the Command class and defining a handle method. Typically, additional command-line parameters would be defined in an add_arguments method, but we are aiming to create a very simple example. A help attribute of the Command class is used to provide information when the user enters python manage.py --help or python manage.py sessioninfo --help:
class Command(BaseCommand):
    help = "List all user sessions and the data that
    they contain." 

Copy

Explain
Write a handle method of the Command class. First, instantiate a SessionStore object, then iterate through the Session objects and decode the data for each using the SessionStore.decode method. The _auth_user_id key of the decrypted data references a User.id from the database so that we can retrieve the user using the User model.
Now, for each session, write the session key, user ID, username, and email address to the console. We will develop a simple Python utility for decrypting this session information. Note that it is best practice to call self.stdout.write in a management command instead of print when writing to the console:

    def handle(self, *args, **options):
        session_store = SessionStore()
        for session in Session.objects.all():
            data = session_store.decode(
                session.session_data)
            user = User.objects.get(
                id=data['_auth_user_id'])
            self.stdout.write(
                f"Session Key: {session.session_key}" 
                f" User: {user.id} {user.username}"               
                f" {user.email}")
            self.stdout.write(pformat(data))
  {user.email} ") self.stdout.write(pformat(data))

Copy

Explain
Now, you can use this management command to examine session data that is stored in the database. You can call it on the command line as follows:
    python manage.py sessioninfo

Copy

Explain
This will be useful for debugging session behavior when you attempt the final activity:

Figure 9.16 – Python script
Figure 9.16 – Python script

This script outputs the decoded session information. At present, the session only contains three keys:

_auth_user_backend is a string representation of the class of the user backend. As our project stores user credentials in the model, ModelBackend is used.
_auth_user_hash is a hash of the user’s password.
_auth_user_id is the user ID obtained from the model’s User.id attribute.
This exercise helped you become familiar with how session data is stored in Django. We will now turn our attention to adding additional information to Django sessions.

Storing data in sessions
We’ve already covered the way sessions are implemented in Django. Now, we are going to briefly examine some of the ways that we can make use of sessions to enrich our user experience. In Django, the session is an attribute of the request object. It is implemented as a dictionary-like object. In our views, we can assign keys to the session object like a typical dictionary, as shown here:

request.session['books_reviewed_count'] = 39

Copy

Explain
But there are some restrictions. First, the keys in the session must be strings, so integers and timestamps are not allowed. Secondly, keys starting with an underscore are reserved for internal system use. Data is limited to values that can be encoded as JSON, so some byte sequences that can’t be decoded as UTF-8, such as binary_key listed previously, can’t be stored as JSON data. The other warning is to avoid reassigning request.session to a different value. We should only assign or delete keys. So, don’t do this:

request.session = {'books_read_count':30, 'books_reviewed_count': 39}

Copy

Explain
Instead, do this:

request.session['books_read_count'] = 30
request.session['books_reviewed_count'] = 39

Copy

Explain
With those restrictions in mind, we will investigate how we can make use of session data in our Reviews application.

Exercise 9.06 – storing recently viewed books in sessions
The purpose of this exercise is to use the session to keep information about the 10 books that have been most recently browsed by the authenticated user. This information will be displayed on the profile page of the bookr project. When a book is browsed, the book_detail view is called. In this exercise, we will edit reviews/views.py and add some additional logic to the book_detail method. We will add a key to the session called viewed_books. Using basic knowledge of HTML and CSS, the page can be created to show the profile details and viewed books stored in separate divisions of the page, as follows:

Figure 9.17 – The Profile page incorporating Viewed Books
Figure 9.17 – The Profile page incorporating Viewed Books

Let's get started with the steps:

Edit reviews/views.py and the book_detail method. We are only interested in adding session information for authenticated users, so add a conditional statement to check whether the user is authenticated and set max_viewed_books_length, the maximum length of the viewed books list, to 10:
def book_detail(request, pk):
      …
    if request.user.is_authenticated:
        max_viewed_books_length = 10

Copy

Explain
Within the same conditional block, add code to retrieve the current value of request.session['viewed_books']. If this key isn’t present in the session, start with an empty list:
        viewed_books = request.session.get(
            'viewed_books', [])

Copy

Explain
If the current book’s primary key is already present in viewed_books, the following code will remove it:
        viewed_book = [book.id, book.title]
        if viewed_book in viewed_books:
            viewed_books.pop(
                viewed_books.index(viewed_book))

Copy

Explain
The following code inserts the current book’s primary key at the start of the viewed_books list:
        viewed_books.insert(0, viewed_book)

Copy

Explain
Add the following key to only keep the first 10 elements of the list:
        viewed_books = viewed_books[
                        :max_viewed_books_length]

Copy

Explain
The following code will add our viewed_books back to session[ 'viewed_books'] so that it is available in subsequent requests:
        request.session['viewed_books'] = viewed_books

Copy

Explain
As before, at the end of the book_detail function, render the reviews/book_detail.html template given the request and context data:
    return render(request, "reviews/book_detail.html", context)

Copy

Explain
Once complete, the book_detail view will have this conditional block:

def book_detail(request, pk):
    …
    if request.user.is_authenticated:
        max_viewed_books_length = 10
        viewed_books = request.session.get("viewed_books", [])
        viewed_book = [book.id, book.title]
        if viewed_book in viewed_books:
            viewed_books.pop(viewed_books.index(viewed_book))
        viewed_books.insert(0, viewed_book)
        viewed_books = viewed_books[:max_viewed_books_length]
        request.session["viewed_books"] = viewed_books
    return render(request, "reviews/book_detail.html", context)

Copy

Explain
Modify the page layout and CSS of templates/profile.html to accommodate the viewed book division. As we may add more divisions to this page in the future, one convenient layout concept is the flexbox. We will add this CSS and separate the content into nested div instances that will be arranged horizontally on the page. We will refer to the internal div instances as infocell instances and style them with green borders and rounded edges:
<style>
.flexrow { display: flex;
           border: 2px black;
}
.flexrow > div { flex: 1; }
.infocell {
  border: 2px solid green;
  border-radius: 5px 25px;
  background-color: white;
  padding: 5px;
  margin: 20px 5px 5px 5px;
}
</style>
  <div class="flexrow" >
    <div class="infocell" >
      <p>Profile</p>
      …
    </div>
    <div class="infocell" >
      <p>Viewed Books</p>
      …
    </div>
  </div>

Copy

Explain
Modify the Viewed Books div element in templates/profile.html so that if there are books present, their titles are displayed and linked to the individual book detail pages. This will be rendered as follows:
<a href="/books/1">Advanced Deep Learning with Keras
</a><br>

Copy

Explain
A message should be displayed if the list is empty. The entire div, including the iteration through request.session.viewed_books, will look like this:

    <div class="infocell" >
      <p>Viewed Books</p>
      <p>
      {% for book_id, book_title in
      request.session.viewed_books %}
      <a href="/books/{{ book_id }}">{{ book_title }}
        </a><br>
      {% empty %}
            No recently viewed books found.
      {% endfor %}
      </p>
    </div>

Copy

Explain
The complete profile template will look like this once all these changes have been incorporated:

templates/profile.html

  {% extends "base.html" %}
  {% block title %}Bookr{% endblock %}
  {% block heading %}Profile{% endblock %}
  {% block content %}
  <style>

Copy

Explain
You can find the complete code for this file at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter09/Exercise9.06/bookr/templates/profile.html.

This exercise has enhanced the profile page by adding a list of recently viewed books. Now, when you visit the login link at http://127.0.0.1:8000/accounts/profile/, you will see this page:

Figure 9.18 – Recently viewed books 
Figure 9.18 – Recently viewed books

We can use the sessioninfo management command that we developed in Exercise 9.05 – examining the session key, to examine the user’s session once this feature is implemented. It can be called on the command line by passing the session data as an argument:

    python manage.py sessioninfo

Copy

Explain
We can see that the book IDs and titles are listed in the viewed_books key. Remember that the encoded data is obtained by querying the django_session table in the SQLite database:

Figure 9.19 – The viewed books are stored in the session data
Figure 9.19 – The viewed books are stored in the session data

In this exercise, we used Django’s session mechanism to store ephemeral information about user interactions with the Django project. We have learned how this information can be retrieved from the user session and displayed in a view that informs users about their recent activity.

Activity 9.02 – using session storage for the Book Search page
Sessions are a useful way to store short-lived information that assists in maintaining a stateful experience on a site. Users frequently revisit pages such as search forms, and it would be convenient to store their most recently used form settings when they return to those pages. In Chapter 3, URL Mapping, Views, and Templates, we developed a book search feature for the bookr project. The Book Search page has two options for Search in – Title and Contributor. Currently, each time the page is visited, it defaults to Title:

Figure 9.20 – The Search and Search in fields of the Book Search form
Figure 9.20 – The Search and Search in fields of the Book Search form

In this activity, you will use session storage so that when the Book Search page, /book-search, is visited, it will default to the most recently used search option. You will also add a third infocell to the profile page that contains a list of links to the most recently used search terms. Follow these steps to complete this activity:

Edit the book_search view and retrieve search_history from the session.
When the form has received valid input and a user is logged in, append the search option and search text to the session’s search history list.
If the form hasn’t been filled (for example, when the page is first visited), render the form with the previously used Search in option selected – that is, either Title or Contributor (Figure 9.21):

Figure 9.21 – Selecting Contributor in the Search field
Figure 9.21 – Selecting Contributor in the Search field

In the profile template, include an additional infocell division for Search History.
List the search history as a series of links to the book search page. The links will take this form: /book-search?search=Python&search_in=title.
This activity will challenge you to apply session data to solve a usability issue in a web form. This approach will have applicability in many real-world situations and will give you some idea of the use of sessions in creating a stateful web experience. After completing this activity, the profile page will contain the third infocell, as shown in Figure 9.22:

Figure 9.22 – The profile page with the Search History infocell
Figure 9.22 – The profile page with the Search History infocell

Note

You can find the solution for this activity on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

Summary
In this chapter, we examined Django’s middleware implementation of authentication and sessions. We also learned how to incorporate authentication and permission logic into views and templates. Now, we can set permissions on specific pages and limit their access to authenticated users. We also examined how to store data in a user’s session and render it on subsequent pages.

With that, you have the skills to customize a Django project to deliver a personalized web experience. You can limit the content to authenticated or privileged users and you can personalize a user’s experience based on their prior interactions. In the next chapter, we will revisit the Admin app and learn about some advanced techniques we can use to customize our user model and apply fine-grained changes to the admin interface for our models.



| ≪ [ 08 Media Serving and File Uploads ](/packtpub/2024/422-web_development_with_django_2ed/08_media_serving_and_file_uploads) | 09 Sessions and Authentication | [ 10 Advanced Django Admin and Customizations ](/packtpub/2024/422-web_development_with_django_2ed/10_advanced_django_admin_and_customizations) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/422-web_development_with_django_2ed/09_sessions_and_authentication
> (2) Markdown
> (3) Title: 09 Sessions and Authentication
> (4) Short Description: Publication date: May 2023 Publisher Packt Pages 764
> (5) tags: Django
> Book Title: 422-Web Development with Django 2ed
> Link: https://subscription.packtpub.com/book/web-development/9781803230603/pref
> create: 2024-05-08 수 14:11:52
> Images: /packtpub/2024/422-web_development_with_django_2ed_img/09/
> .md Name: 09_sessions_and_authentication.md

