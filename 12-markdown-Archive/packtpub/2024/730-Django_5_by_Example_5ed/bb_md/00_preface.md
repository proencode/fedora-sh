
| 🏁 730 Django 5 by Example | 00 Preface | [ 01 Building a Blog Application ](/packtpub/2024/730_django_5_by_example/01_building_a_blog_application) ≫ |
|:----:|:----:|:----:|

# 00 Preface

Django is an open-source Python web framework that encourages rapid development and clean, pragmatic design. It takes care of much of the hassle of web development and presents a relatively shallow learning curve for beginner programmers. Django follows Python’s “batteries included” philosophy, shipping with a rich and versatile set of modules that solve common web-development problems. The simplicity of Django, together with its powerful features, makes it attractive to both novice and expert programmers. Django has been designed for simplicity, flexibility, reliability, and scalability.

Nowadays, Django is used by countless start-ups and large organizations such as Instagram, Spotify, Pinterest, Udemy, Robinhood, and Coursera. It is not by coincidence that, over the last few years, Django has consistently been chosen by developers worldwide as one of the most loved web frameworks in Stack Overflow’s annual developer survey.

This book will guide you through the entire process of developing professional web applications with Django. The book focuses on explaining how the Django web framework works by building multiple projects from the ground up. This book not only covers the most relevant aspects of the framework but also explains how to apply Django to very diverse real-world situations.

This book not only teaches Django but also presents other popular technologies, such as PostgreSQL, Redis, Celery, RabbitMQ, and Memcached. You will learn how to integrate these technologies into your Django projects throughout the book to create advanced functionalities and build complex web applications.

Django 5 By Example will walk you through the creation of real-world applications, solving commonproblems, and implementing best practices, using a step-by-step approach that is easy to follow.

After reading this book, you will have a good understanding of how Django works and how to build full-fledged Python web applications.

# Who this book is for

This book should serve as a primer for programmers newly initiated to Django. The book is intended for developers with Python knowledge who wish to learn Django in a pragmatic manner. Perhaps you are completely new to Django, or you already know a little but you want to get the most out of it. This book will help you to master the most relevant areas of the framework by building practical projects from scratch. You need to have familiarity with programming concepts in order to read this book. In addition to basic Python knowledge, some previous knowledge of HTML and JavaScript is assumed.

# What this book covers

This book encompasses a range of topics of web application development with Django. The book will guide you through building four different fully-featured web applications, that are built over the course of 17 chapters.

- A blog application (chapters 1 to 3)
- An image bookmarking website (chapters 4 to 7)
- An online shop (chapters 8 to 11)
- An e-learning platform (chapters 12 to 17)

Each chapter covers several Django features.

Chapter 1, Building a Blog Application, will introduce you to the framework through a blog application. You will create the basic blog models, views, templates, and URLs to display blog posts. You will learn how to build QuerySets with the Django **object-relational mapper (ORM)**, and you will configure the Django administration site.

Chapter 2, Enhancing Your Blog with Advanced Features, will teach you how to add pagination to your blog, and how to implement Django class-based views. You will learn to send emails with Django, and handle forms and model forms. You will also implement a comment system for blog posts.

Chapter 3, Extending Your Blog Application, explores how to integrate third-party applications. This chapter will guide you through the process of creating a tagging system, and you will learn how to build complex QuerySets to recommed similar posts. The chapter will teach you how to create custom template tags and filters. You will also learn how to use the sitemap framework and create an RSS feed for your posts. You will complete your blog application by building a search engine using PostgreSQL’s full-text search capabilities.

Chapter 4, Building a Social Website, explains how to build a social website. You will learn how to implement user authentication views and learn to use the Django authentication framework. You will implement user registration and extend the user model with a custom profile model.

Chapter 5, Implementing Social Authentication, covers implementing social authentication and using the messages framework. You will create a custom authentication backend and you will integrate social authentication with Google, using OAuth 2. You will learn how to use `django-extensions` to run the development server through HTTPS and customize the social authentication pipeline to automate the user profile creation.

Chapter 6, Sharing Content on Your Website, will teach you how to transform your social application into an image bookmarking website. You will define many-to-many relationships for models, and you will create a JavaScript bookmarklet that integrates into your project. The chapter will show you how to generate image thumbnails. You will also learn how to implement asynchronous HTTP requests using JavaScript and Django and you will implement infinite scroll pagination.

Chapter 7, Tracking User Actions, will show you how to build a follower system for users. You will complete your image bookmarking website by creating a user activity stream application. You will learn how to create generic relations between models and optimize QuerySets.

You will work with signals and implement denormalization. You will use Django Debug Toolbar to obtain relevant debug information. Finally, you will integrate Redis into your project to count image views and you will create a ranking of the most viewed images with Redis.

Chapter 8, Building an Online Shop, explores how to create an online shop. You will build models for a product catalog, and you will create a shopping cart using Django sessions. You will build a context processor for the shopping cart and will learn how to manage customer orders. The chapter will teach you how to send asynchronous notifications using Celery and RabbitMQ. You will also learn to monitor Celery using Flower.

Chapter 9, Managing Payments and Orders, explains how to integrate a payment gateway into your shop. You will integrate Stripe Checkout and receive asynchronous payment notifications in your application. You will implement custom views in the administration site and you will also customize the administration site to export orders to CSV files. You will also learn how to generate PDF invoices dynamically.

Chapter 10, Extending Your Shop, will teach you how to create a coupon system to apply discounts to the shopping cart. You will update the Stripe Checkout integration to implement coupon discounts and you will apply coupons to orders. You will use Redis to store products that are usually bought together, and use this information to build a product recommendation engine.

Chapter 11, Adding Internationalization to Your Shop, will show you how to add internationalization to your project. You will learn how to generate and manage translation files and translate strings in Python code and Django templates. You will use Rosetta to manage translations and implement per-language URLs. You will learn how to translate model fields using `django-parler` and how to use translations with the ORM. Finally, you will create a localized form field using `django-localflavor`.

Chapter 12, Building an E-Learning Platform, will guide you through creating an e-learning platform. You will add fixtures to your project, and create initial models for the content management system. You will use model inheritance to create data models for polymorphic content. You will learn how to create custom model fields by building a field to order objects. You will also implement authentication views for the CMS.

Chapter 13, Creating a Content Management System, will teach you how to create a CMS using class-based views and mixins. You will use the Django groups and permissions system to restrict access to views and implement formsets to edit the content of courses. You will also create a drag-and-drop functionality to reorder course modules and their content using JavaScript and Django.

Chapter 14, Rendering and Caching Content, will show you how to implement the public views for the course catalog. You will create a student registration system and manage student enrollment on courses. You will create the functionality to render different types of content for the course modules. You will learn how to cache content using the Django cache framework and configure the Memcached and Redis cache backends for your project. Finally, you will learn how to monitor Redis using the administration site.

Chapter 15, Building an API, explores building a RESTful API for your project using Django REST framework. You will learn how to create serializers for your models and build custom API views. You will handle API authentication and implement permissions for API views.

You will learn how to build API viewsets and routers. The chapter will also teach you how to consume your API using the Requests library.

Chapter 16, Building a Chat Server, explains how to use Django Channels to create a real-time chat server for students. You will learn how to implement functionalities that rely on asynchronous communication through WebSockets. You will create a WebSocket consumer with Python and implement a WebSocket client with JavaScript. You will use Redis to set up a channel layer and you will learn how to make your WebSocket consumer fully asynchronous. You will also implement a chat history by persisting chat messages into the database.

Chapter 17, Going Live, will show you how to create settings for multiple environments and how to set up a production environment using PostgreSQL, Redis, uWSGI, NGINX, and Daphne with Docker Compose. You will learn how to serve your project securely through HTTPS and use the Django system check framework. The chapter will also teach you how to build a custom middleware and create custom management commands.

# To get the most out of this book

- You must possess a good working knowledge of Python.
- You should be comfortable with HTML and JavaScript.
- It is recommended that you go through parts 1 to 3 of the tutorial in the official Django documentation at https://docs.djangoproject.com/en/5.0/intro/tutorial01/.

## Download the example code files

The code bundle for the book is hosted on GitHub at https://github.com/PacktPublishing/Django-5-by-Example. We also have other code bundles from our rich catalog of books and videos available at https://github.com/PacktPublishing/. Check them out!

## Download the color images

We also provide a PDF file that has color images of the screenshots/diagrams used in this book. You can download it here: https://packt.link/gbp/9781805125457.

## Conventions used

There are a number of text conventions used throughout this book.

`CodeInText`: Indicates code words in text, database table names, folder names, filenames, file extensions, pathnames, dummy URLs, user input, and Twitter handles. For example: “Edit the `models.py` file of the `shop` application.”

A block of code is set as follows:

```python
from django.contrib import admin
from .models import Post 
admin.site.register(Post) 
```

When we wish to draw your attention to a particular part of a code block, the relevant lines or items are set in bold:

```python
INSTALLED_APPS = [
'django.contrib.admin',
'django.contrib.auth',
'django.contrib.contenttypes',
'django.contrib.sessions',
'django.contrib.messages',
'django.contrib.staticfiles',
'blog.apps.BlogConfig',
]
```

Any command-line input or output is written as follows:

```bash
python manage.py runserver
```

**Bold**: Indicates a new term, an important word, or words that you see on the screen. For instance, words in menus or dialog boxes appear in the text like this. For example: “Select **System info** from the **Administration** panel.”

> Warnings or important notes appear like this.

> Tips and tricks appear like this.
{.is-info}

## Get in touch

Feedback from our readers is always welcome.

**General feedback**: Email `feedback@packtpub.com` and mention the book’s title in the subject of your message. If you have questions about any aspect of this book, please email us at `questions@packtpub.com`.

**Errata**: Although we have taken every care to ensure the accuracy of our content, mistakes do happen. If you have found a mistake in this book, we would be grateful if you reported this to us. Please visit http://www.packtpub.com/submit-errata, click **Submit Errata**, and fill in the form.

**Piracy**: If you come across any illegal copies of our works in any form on the internet, we would be grateful if you would provide us with the location address or website name. Please contact us at `copyright@packtpub.com` with a link to the material.

**If you are interested in becoming an author**: If there is a topic that you have expertise in and you are interested in either writing or contributing to a book, please visit http://authors.packtpub.com.

## Join us on Discord!

Read this book alongside other users, Django development experts, and the author himself. Ask questions, provide solutions to other readers, chat with the author via Ask Me Anything sessions, and much more.Scan the QR code or visit the link to join the community.

https://packt.link/Django5ByExample



## Visit the book’s dedicated website

Head to https://djangobyexample.com/ to find out more about the book and what past readers thought about it.

# Share your thoughts

Once you’ve read Django 5 By Example, Fifth Edition, we’d love to hear your thoughts! Please click here to go straight to the Amazon review page for this book and share your feedback.

Your review is important to us and the tech community and will help us make sure we’re delivering excellent quality content.

# Download a free PDF copy of this book

Thanks for purchasing this book!

Do you like to read on the go but are unable to carry your print books everywhere?

Is your eBook purchase not compatible with the device of your choice?

Don’t worry, now with every Packt book you get a DRM-free PDF version of that book at no cost.

Read anywhere, any place, on any device. Search, copy, and paste code from your favorite technical books directly into your application.

The perks don’t stop there, you can get exclusive access to discounts, newsletters, and great free content in your inbox daily.

Follow these simple steps to get the benefits:

1. Scan the QR code or visit the link below:

https://packt.link/free-ebook/9781805125457

1. Submit your proof of purchase.
1. That’s it! We’ll send your free PDF and other benefits to your email directly.



| 🏁 730 Django 5 by Example | 00 Preface | [ 01 Building a Blog Application ](/packtpub/2024/730_django_5_by_example/01_building_a_blog_application) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/730_django_5_by_example/00_preface
> (2) Markdown
> (3) Title: 00 Preface
> (4) Short Description: By Antonio Melé Publication Date: 2024-04-30
> (5) tags: Django
> Book Title: 730 Django 5 by Example
> Link: https://subscription.packtpub.com/book/web-development/9781805125457/1
> create: 2024-07-30 화 15:30:44
> Images: /packtpub/img/00/
> .md Name: 00_preface.md

