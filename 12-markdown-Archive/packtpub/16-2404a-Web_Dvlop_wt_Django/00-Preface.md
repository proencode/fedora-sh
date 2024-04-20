
# Preface

Do you want to develop reliable and secure applications that stand out from the crowd without spending hours on boilerplate code? You’ve made the right choice by trusting the Django framework, and this book will tell you why. Often referred to as a “batteries included” web development framework, Django comes with all the core features needed to build a standalone application. Web Development with Django will take you through all the essential concepts and help you explore its power to build real-world applications using Python. Throughout the book, you’ll get to grips with the major features of Django by building a website called Bookr – a repository for book reviews. This end-to-end case study is split into a series of bitesize projects presented as exercises and activities, allowing you to challenge yourself in an enjoyable and attainable way. As you advance, you’ll acquire various practical skills, including how to serve static files to add CSS, JavaScript, and images to your application, implement forms to accept user input, and manage sessions to ensure a reliable user experience. You’ll cover everyday tasks that are part of the development cycle of a real-world web application. By the end of this Django book, you’ll have the skills and confidence to creatively develop and deploy your own projects.

# Who this book is for

This book is for programmers looking to enhance their web development skills using the Django framework. To fully understand the concepts explained in this book, basic knowledge of Python programming as well as familiarity with JavaScript, HTML, and CSS, is assumed.

# What this book covers

Chapter 1, An Introduction to Django, starts by getting a Django project set up almost immediately. You’ll learn how to bootstrap a Django project, respond to web requests, and use HTML templates.

Chapter 2, Models and Migrations, introduces Django data models, the method of persisting data to a SQL database.

Chapter 3, URL Mapping, Views, and Templates, builds on the techniques that were introduced in Chapter 1, An Introduction to Django, and explains in greater depth how to route web requests to Python code and render HTML templates.

Chapter 4, An Introduction to Django Admin, shows how to use Django’s built-in Admin GUI to create, update, and delete data stored by your models.

Chapter 5, Serving Static Files, explains how to enhance your website with styles and images and how Django makes managing these files easier.

Chapter 6, Forms, shows you how to collect user input through your website by using Django’s Forms module.

Chapter 7, Advanced Form Validation and Model Forms, builds upon Chapter 6, Forms, by adding more advanced validation logic to make your forms more powerful.

Chapter 8, Media Serving and File Uploads, shows how to further enhance sites by allowing your users to upload files and serve them with Django.

Chapter 9, Sessions and Authentication, introduces the Django session and shows you how to use it to store user data and authenticate users.

Chapter 10, Advanced Django Admin and Customization, continues from Chapter 4, An Introduction to Django Admin. Now that you know more about Django, you can customize the Django admin with advanced features.

Chapter 11, Advanced Templating and Class-Based Views, lets you see how to reduce the amount of code you need to write using some of Django’s advanced templating features and classes.

Chapter 12, Building a REST API, looks at how to add a REST API to Django to allow programmatic access to your data from different applications.

Chapter 13, Generating CSV, PDF, and Other Binary Files, further expands the capabilities of Django by showing how you can use it to generate more than just HTML.

Chapter 14, Testing Your Django Applications, is an important part of real-world development. This chapter shows how to use the Django and Python testing frameworks to validate your code.

Chapter 15, Django Third-Party Libraries, exposes you to some of the many community-built Django libraries, showing how to use existing third-party code to add functionality to your project quickly.

Chapter 16, Using a Frontend JavaScript Library with Django, brings interactivity to your website by integrating with React and the REST API created in Chapter 12, Building a REST API.

Chapter 17, Deploying a Django Application (Part 1 – Server Setup), begins the process of deploying the application by setting up your own server. This is a bonus chapter and is downloadable from the GitHub repository for this book.

Chapter 18, Deploying a Django Application (Part 2 – Configuration and Code Deployment), finishes the project by showing you how to deploy your project to a virtual server. This is also a bonus chapter and is downloadable from the GitHub repository for this book.

# To get the most out of this book

| Software/hardware covered in the book | Operating system requirements |
|:----|:----|
| Python 3.8 | Windows, macOS, or Linux
| Django 4.0 |  |
| React 16 |  |

If you are using the digital version of this book, we advise you to type the code yourself or access the code from the book’s GitHub repository (a link is available in the next section). Doing so will help you avoid any potential errors related to the copying and pasting of code.

# Download the example code files

You can download the example code files for this book from GitHub at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition. If there’s an update to the code, it will be updated in the GitHub repository.

We also have other code bundles from our rich catalog of books and videos available at https://github.com/PacktPublishing/. Check them out!

# Download the color images

We also provide a PDF file that has color images of the screenshots and diagrams used in this book. You can download it here: https://packt.link/5pZtF.

# Conventions used

There are a number of text conventions used throughout this book.

`Code in text`: Indicates code words in text, database table names, folder names, filenames, file extensions, pathnames, dummy URLs, user input, and Twitter handles. Here is an example: “First, create a new file named `inclusion_tag.py` under the `filter_demo/templatetags` directory.”

A block of code is set as follows:

```
from django.http import HttpResponse
from django.views import View
class IndexView(View):
    def get(self, request):
        return HttpResponse("Hey there!")
```

When we wish to draw your attention to a particular part of a code block, the relevant lines or items are set in bold:

```
from django.shortcuts import render
def index(request):
    names = "john,doe,mark,swain"
    return render(request, "index.html", {'names': names})
```

Any command-line input or output is written as follows:

```
POST /form-submit HTTP/1.1 Host: www.example.com Content-Length: 31 Content-Type: application/x-www-form-urlencoded first_name=Joe&last_name=Bloggs
```

**Bold**: Indicates a new term, an important word, or words that you see onscreen. For instance, words in menus or dialog boxes appear in **bold**. Here is an example: “On filling the data and clicking **Save record**, Django will save the data to the database.”

Tips or important notes

Appear like this.

# Get in touch

Feedback from our readers is always welcome.

**General feedback**: If you have questions about any aspect of this book, email us at customercare@packtpub.com and mention the book title in the subject of your message.

**Errata**: Although we have taken every care to ensure the accuracy of our content, mistakes do happen. If you have found a mistake in this book, we would be grateful if you would report this to us. Please visit www.packtpub.com/support/errata and fill in the form.

**Piracy**: If you come across any illegal copies of our works in any form on the internet, we would be grateful if you would provide us with the location address or website name. Please contact us at copyright@packt.com with a link to the material.

**If you are interested in becoming an author**: If there is a topic that you have expertise in and you are interested in either writing or contributing to a book, please visit authors.packtpub.com.

# Share Your Thoughts

Once you’ve read Web Development with Django – Second Edition, we’d love to hear your thoughts! Please [ click here to go straight to the Amazon review page ](https://packt.link/r/1800560788) for this book and share your feedback.

Your review is important to us and the tech community and will help us make sure we’re delivering excellent quality content.

# Download a free PDF copy of this book

Thanks for purchasing this book!

Do you like to read on the go but are unable to carry your print books everywhere? Is your eBook purchase not compatible with the device of your choice?

Don’t worry, now with every Packt book you get a DRM-free PDF version of that book at no cost.

Read anywhere, any place, on any device. Search, copy, and paste code from your favorite technical books directly into your application.

The perks don’t stop there, you can get exclusive access to discounts, newsletters, and great free content in your inbox daily

Follow these simple steps to get the benefits:

1. Scan the QR code or visit the link below

https://packt.link/free-ebook/9781803230603

2. Submit your proof of purchase
3. That’s it! We’ll send your free PDF and other benefits to your email directly

