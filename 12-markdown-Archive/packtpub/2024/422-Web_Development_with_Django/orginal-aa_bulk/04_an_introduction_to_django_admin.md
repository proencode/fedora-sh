
| ≪ [ 03 URL Mapping, Views, and Templates ](/packtpub/2024/422-web_development_with_django_2ed/03_url_mapping,_views,_and_templates) | 04 An Introduction to Django Admin | [ 05 Serving Static Files ](/packtpub/2024/422-web_development_with_django_2ed/05_serving_static_files) ≫ |
|:----:|:----:|:----:|

# 04 An Introduction to Django Admin

Packt Logo

Book image


An Introduction to Django Admin
This chapter introduces you to the basic functionality of the Django admin app. You will start by creating superuser accounts for the Bookr app, before moving on to executing Create, Read, Update, and Delete (CRUD) operations with the admin app. You will learn how to integrate your Django app with the admin app, and you’ll also look at the behavior of ForeignKeys in the admin app. At the end of this chapter, you will see how you can customize the admin app according to a unique set of preferences by sub-classing the AdminSite and ModelAdmin classes, making its interface more intuitive and user-friendly.

In this chapter, we will cover the following topics:

Creating a superuser account
CRUD operations using the Django admin app
Managing Django users and groups
Registering models with the admin app
Customizing the admin interface
By the end of this chapter, you will be able to do the following:

Create an admin account
Create user accounts and groups, and assign permissions
Register your models with the admin app
Customize global properties of the admin app
Customize the functionality of change list pages and forms for administering your models
When developing an app, there is often a need to populate it with data and then alter that data. We have already seen in Chapter 2, Models and Migrations, how this can be done in the command line using the Python manage.py shell. In Chapter 3, URL Mapping, Views, and Templates, we learned how to develop a web form interface for our model using Django’s views and templates. But neither of these approaches is ideal for administering the data from the classes in reviews/models.py. Using the shell to manage data is too technical for non-programmers, and building individual web pages would be a laborious process as it would see us repeating the same view logic and very similar template features for each table in the model. Fortunately, a solution to this problem was devised in the early days of Django when it was still being developed.

The Django admin site is actually written as a Django app. It offers an intuitively rendered web interface to give administrative access to the model data. The admin interface is designed to be used by the website administrators. It is not intended to be used by non-privileged users who interact with the site. In our case of a book review system, the general population of book reviewers will never encounter the admin app. They will see the app pages, like those we built with views and templates in Chapter 3, URL Mapping, Views, and Templates, and will write their reviews on the pages.

Also, while developers put a lot of effort into creating a simple and inviting web interface for general users, the admin interface, aimed at administrative users, maintains a utilitarian feel that typically displays the intricacies of the model. It may have escaped your attention, but you already have an admin app in your Bookr project. Look at the list of installed apps in bookr/settings.py:

INSTALLED_APPS = [
    'django.contrib.admin',
    …
]

Copy

Explain
Now, look at the URL patterns in bookr/urls.py:

urlpatterns = [
    path('admin/', admin.site.urls),
    …
]

Copy

Explain
If we put this path into our browser, we can see that the link to the admin app on the development server is http://127.0.0.1:8000/admin/. Before we make use of it, though, we need to create a superuser through the command line.

Technical requirements
The complete code files for this chapter can be found at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter04/.

Creating a superuser account
Our Bookr application has just found a new user. Her name is Alice, and she wants to start adding her reviews right away. Bob, who is already using Bookr, has just informed us that his profile seems incomplete and needs to be updated. David no longer wants to use the application and wants his account to be deleted. For security reasons, we do not want just any user performing these tasks for us. That’s why we need to create a superuser with elevated privileges. Let’s start by doing just that.

In Django’s authorization model, a superuser is one with the Staff attribute set. We will examine this later in the chapter and learn more about this authorization model in Chapter 9, Sessions and Authentication.

We can create a superuser by using the manage.py script that we have explored in earlier chapters. Again, we need to be in the project directory when we enter the command. We will use the createsuperuser subcommand by entering the following command in the command line (if you’re using Windows you will need to type either python or py instead of python3):

python3 manage.py createsuperuser

Copy

Explain
Note

In this chapter, we will use email addresses that fall under the example.com domain. This follows an established convention to use this reserved domain for testing and documentation. You could use your own email addresses if you prefer.

Let’s go ahead and create our superuser.

Exercise 4.01 – creating a superuser account
In this exercise, you will create a superuser account that lets the user log in to the admin site. This functionality will also be used in the upcoming exercises to implement changes that only a superuser can. The following steps will help you complete this exercise:

Enter the following command to create a superuser:
python manage.py createsuperuser

Copy

Explain
On executing the preceding command, you will be prompted to create a superuser. This command will prompt you for a superuser name, an optional email address, and a password.

Add the username and email for the superuser as follows. Here, we enter bookradmin (highlighted) at the prompt and press the Enter key. Similarly, at the next prompt, which asks you to enter your email address, you can add bookradmin@example.com (highlighted). Press the Enter key to continue:
Username (leave blank to use 'django'): bookradmin
Email address: bookradmin@example.com
Password:

Copy

Explain
This will assign the name bookradmin to the superuser. Note that you won’t see any output immediately.

The next prompt in the shell is for your password. Add a strong password and press the Enter key to confirm it once again:
Password:
Password (again):

Copy

Explain
You should see the following message on your screen:

Superuser created successfully.

Copy

Explain
Note that the password is validated as per the following criteria:

It cannot be among the 20,000 most common passwords
It should have a minimum of eight characters
It cannot be only numerical characters
It cannot be derived from the username, first name, last name, or email address of the user
With this, you have created a superuser named bookradmin who can log in to the admin app. The following screenshot shows how this looks in the shell:

Figure 4.1 – Creating a superuser
Figure 4.1 – Creating a superuser

Visit the admin app at http://127.0.0.1:8000/admin and log in with the superuser account that you have created:
 Figure 4.2 – The Django administration login form
Figure 4.2 – The Django administration login form

In this exercise, you created a superuser account that we will be using for the rest of this chapter to assign or remove privileges as needed.

With a superuser account created, we are now able to log into the Django admin app and learn about the CRUD facilities that it provides.

CRUD operations using the Django admin app
Let’s get back to the requests we got from Bob, Alice, and David. As a superuser, your tasks will involve creating, updating, retrieving, and deleting various user accounts, reviews, and title names. This set of activities is collectively termed CRUD. CRUD operations are central to the behavior of the admin app. It turns out that the admin app is already aware of the models from another Django app, Authentication and Authorization – referenced in INSTALLED_APPS as 'django.contrib.auth'. When logging into http://127.0.0.1:8000/admin/, we are presented with the models from the authorization application, as shown in Figure 4.3:

Figure 4.3 – The Django administration window
Figure 4.3 – The Django administration window

When the admin app is initialized, it calls its autodiscover() method to detect whether any other installed apps contain an admin module. If so, these admin models are imported. In our case, it has discovered 'django.contrib.auth.admin'. Now that the modules are imported, and our superuser account is ready, let’s start by working on the requests from Bob, Alice, and David.

Create
Before Alice starts writing her reviews, we need to create an account for her through the admin app. Once that is done, we can look at the administration access levels we can assign to her. To Create a user, we need to click the + Add option next to Users (refer to Figure 4.3), and fill out the form, as shown in Figure 4.4.

Note

We don’t want any random user to have access to the Bookr users’ accounts. Therefore, it is imperative that we choose strong, secure passwords.

Figure 4.4 – The Add user page
Figure 4.4 – The Add user page

There are three buttons at the bottom of the form:

Save and add another: This creates the user and renders the same Add user page again, with blank fields.
Save and continue editing: This creates the user and loads the Change user page. The Change user page lets you add additional information that wasn’t present on the Add user page, such as First name, Last name, and more (see Figure 4.5). Note that Password does not have an editable field on the form. Instead, it shows information about the hashing technique that the password is stored with, in addition to a link to a separate change password form:
Figure 4.5 – The Change user page presented after clicking Save and continuing editing
Figure 4.5 – The Change user page presented after clicking Save and continuing editing

SAVE: This creates the user and lets the user navigate to the Select user to change list page, as depicted in Figure 4.6.
Activity 4.01 – creating a user account
We have now seen how to create user accounts through the Django admin interface.

It is time to put your knowledge into practice to create an account for a new user David Green, using the email address david.green@example.com.

As was the case with Alice White’s account, just set this one as an active user without ticking the Staff Status or Superuser Status boxes.

Note

The solution for this activity can be found https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

Now that you have created a user through the Django admin interface, we can examine the other three CRUD operations – retrieve, update, and delete.

Retrieve
The administrative tasks need to be divided among some users, and for this, the admin (the person with the superuser account) would like to view those users whose email addresses end with n@example.com and assign the tasks to these users. This is where the retrieve functionality can come in handy. After we have clicked the SAVE button on the Add user page (refer to Figure 4.4), we are taken to the Select user to change list page (as shown in Figure 4.6), which carries out the retrieve operation. Note that the Create form is also reachable by clicking on the ADD USER + button on the Select user to change list page. So, after we have added a few more users, the change list will look something like this:

Figure 4.6 – The Select user to change page
Figure 4.6 – The Select user to change page

At the top of the form is a Search bar that searches the content such as username, email address, and first and last names of users. On the right-hand side is a FILTER panel that narrows down the selection based on the values of By staff status, By superuser status, and By active. In Figure 4.7, you can see what happens when we search the string n@example.com. This will return only the names of the users whose email addresses consist of a username ending with an n and a domain starting with example.com. We can only see three users with email addresses matching this requirement – bookradmin@example.com, carol.brown@example.com, and david.green@example.com:

Figure 4.7 – Searching for users by a portion of their email address
Figure 4.7 – Searching for users by a portion of their email address

Retrieve functionality, such as the list page and search bar, allows us to obtain records for update and delete operations.

Update
Remember that Bob wanted his profile to be updated. Let’s update Bob’s unfinished profile by clicking the bob username link in the Select user to change list:

Figure 4.8 – Selecting bob from the Select user to change list
Figure 4.8 – Selecting bob from the Select user to change list

This will take us back to the Change user form where the values for First name, Last name, and Email address can be entered:

Figure 4.9 – Adding personal info
Figure 4.9 – Adding personal info

As can be seen from Figure 4.9, we are adding personal information about Bob here – his name, surname, and email address, specifically.

Another type of update operation is “soft deleting.” The Active Boolean property allows us to deactivate a user rather than deleting the entire record and losing all the data that has dependencies on the account. This practice of using a Boolean flag to denote a record as inactive or removed (and subsequently filtering these flagged records out of queries) is referred to as a soft delete. Similarly, we can upgrade the user to Staff status or Superuser status by ticking the respective checkboxes for those:

Figure 4.10 – The Active, Staff status, and Superuser status Booleans
Figure 4.10 – The Active, Staff status, and Superuser status Booleans

Delete
David no longer wants to use the Bookr application and has requested that we delete his account. The auth admin caters to this too. Select a user or user records on the Select user to change list page and choose the Delete selected users option from the Action drop-down menu. Then, hit the Go button (Figure 4.11):

Figure 4.11 – Deleting from the Select user to change list page
Figure 4.11 – Deleting from the Select user to change list page

You will be presented with a confirmation screen and taken back to the Select user to change list once you have deleted the object:

Figure 4.12 – User deletion confirmation
Figure 4.12 – User deletion confirmation

You will see the following message once the user is deleted:

Figure 4.13 – User deletion notification
Figure 4.13 – User deletion notification

After that confirmation, you will find that David’s account no longer exists.

So far, we have learned how we can add a new user, get the details of another user, make changes to the data for a user, and delete a user. These skills helped us cater to Alice, Bob, and David’s requests. As the number of users of our app grows, managing requests from hundreds of users will eventually become quite difficult. One way around this problem would be to delegate some of the administrative responsibilities to a selected set of users. We’ll learn how to do that in the section that follows.

Managing Django users and groups
Django’s authentication model consists of users, groups, and permissions. Users can belong to many groups, which is a way of categorizing users. It also streamlines the implementation of permissions by allowing permissions to be assigned to collections of users as well as individuals.

In Exercise 4.01, Creating a superuser account, we saw how we could cater to Alice, David, and Bob’s requests to make modifications to their profiles. It was quite easy to do, and our application seems well equipped to handle their requests.

What will happen when the number of users grows? Will the admin user be able to manage 100 or 150 users at once? As you can imagine, this can be quite a complicated task. To overcome this, we can give elevated permissions to a certain set of users, and they can help ease the admin’s tasks. And that’s where groups come in handy. Though we’ll learn more about users, groups, and permissions in Chapter 9, Sessions and Authentication, we can start understanding groups and their functionality by creating a Help Desk user group that contains accounts that have access to the admin interface but lack many powerful features, such as the ability to add, edit, or delete groups or to add or delete users.

Exercise 4.02 – adding and modifying users and groups through the admin app
In this exercise, we will grant a certain level of administrative access to one of our Bookr users, Carol. First, we will define the level of access for a group, and then we will add Carol to the group. This will allow Carol to update user profiles and check user logs. The following steps will help you implement this exercise:

Visit the admin interface at http://127.0.0.1:8000/admin/ and log in as bookradmin using the account set up with the superuser command.
In the admin interface, follow the links to Home | AUTHENTICATION AND AUTHORIZATION | Groups:
Figure 4.14 – The Groups and Users options on the AUTHENTICATION AND AUTHORIZATION page
Figure 4.14 – The Groups and Users options on the AUTHENTICATION AND AUTHORIZATION page

Use ADD GROUP + in the top right-hand corner to add a new group:
Figure 4.15 – Adding a new group
Figure 4.15 – Adding a new group

Name the group Help Desk User and give it the following permissions, as shown in Figure 4.16:
Can view log entry
Can view permission
Can change user
Can view user
Figure 4.16 – Selecting permissions
Figure 4.16 – Selecting permissions

This can be done by selecting the permissions from Available permissions and clicking the right arrow in the middle so that they appear under Chosen permissions. Note that to add multiple permissions at a time, you can hold down the Ctrl key (or Command for Macintosh) to select more than one:

Figure 4.17 – Adding selected permissions into Chosen permissions
Figure 4.17 – Adding selected permissions into Chosen permissions

Once you click the SAVE button, you will see a confirmation message stating The group “Help Desk User” was added successfully:

Figure 4.18 – The group Help Desk User was added successfully
Figure 4.18 – The group Help Desk User was added successfully

Now, navigate to Home | AUTHENTICATION AND AUTHORIZATION | Users and click the link of the user with the first name carol:
Figure 4.19 – Clicking on the username carol
Figure 4.19 – Clicking on the username carol

Scroll down to the Permissions fields set and select the Staff status checkbox. This is required for Carol to be able to log in to the admin app:
Figure 4.20 – Clicking the Staff status checkbox
Figure 4.20 – Clicking the Staff status checkbox

Add Carol to the Help Desk User group that we created in the previous steps by selecting it from the Available groups selection box (refer to Figure 4.20) and clicking the right arrow to shift it into her list of Chosen groups (as shown in Figure 4.21). Note that unless you do this, Carol won’t be able to log in to the admin interface using her credentials:
Figure 4.21 – Shifting the Help Desk User group into the list of Chosen groups for Carol
Figure 4.21 – Shifting the Help Desk User group into the list of Chosen groups for Carol

Let’s test whether what we’ve done up till now has yielded the right outcome. To do this, log out of the admin site and log in again as Carol. Upon logging out, you should see the following on your screen:
Figure 4.22 – The Logged out screen
Figure 4.22 – The Logged out screen

Note

If you don’t recall the password that you initially gave her, you can change the password in the command line by typing python3 manage.py changepassword carol.

Upon successful login, on the admin dashboard, you can see that there is no link to Groups:

Figure 4.23 – The admin dashboard
Figure 4.23 – The admin dashboard

As we did not assign any group permissions, not even auth | group | Can view group, to the Help Desk User group, when Carol logs in, the Groups admin interface is not available to her. Similarly, when you navigate to Home | AUTHENTICATION AND AUTHORIZATION | Users and click a user link, you will see that there are no options to edit or delete the user. This is because of the permissions that were granted to the Help Desk User group, of which Carol is a member. The members of the group can view and edit users but cannot add or delete any user.

In this exercise, we learned how to grant a certain amount of administrative privileges to users of our Django app.

Now that we have an understanding of how the admin app works with the AUTHENTICATION AND AUTHORIZATION models for Users and Groups, we can turn our attention to registering the models that we have developed in the reviews app.

Registering models with the admin app
The Django admin app produces workable CRUD interfaces to Django objects based on the characteristics of the models, with a minimal amount of coding. In this section, we will first look at how to register the models with the admin app and how elements of the interface, such as change lists and change pages, are derived from the model properties. We will conclude with an important exercise that demonstrates how foreign key settings in the model determine the behavior of the object deletion process.

Registering the reviews model
Let’s say that Carol is tasked with improving the Reviews section in Bookr; that is, only the most relevant and comprehensive reviews should be shown, and duplicate or spam entries should be removed. For this, she will need access to the reviews model. As we have seen previously with our investigation of groups and users, the admin app already contains admin pages for the models from the Authentication and Authorization app, but it does not yet reference the models in our Reviews app. To make the admin app aware of the models, we need to explicitly register them with the admin app. Fortunately, we don’t need to modify the admin app’s code to do so, as we can instead import the admin app into our project and use its API to register our models. This has already been done in the Authentication and Authorization app, so let’s try it with our Reviews app. Our aim is to be able to use the admin app to edit the data in our reviews model.

Take a look at the reviews/admin.py file. It is a placeholder file that was generated with the startapp subcommand that we used in Chapter 1, An Introduction to Django, and currently contains these lines:

from django.contrib import admin
# Register your models here.

Copy

Explain
Now we can try to expand this. To make the admin app aware of our models, we can modify the reviews/admin.py file and import the models. Then we can register the models with the AdminSite object, admin.site. The AdminSite object contains the instance of the Django admin application (later, we will learn how to subclass this AdminSite and override many of its properties). Then, reviews/admin.py will look as follows:

from django.contrib import admin
from reviews.models import (Publisher, Contributor,
                            Book, BookContributor, Review)
# Register your models here.
admin.site.register(Publisher)
admin.site.register(Contributor)
admin.site.register(Book)
admin.site.register(BookContributor)
admin.site.register(Review)

Copy

Explain
The admin.site.register method makes the models available to the admin app by adding it to a registry of classes contained in admin.site._registry. If we chose not to make a model accessible through the admin interface, we would simply not register it. When you reload http://127.0.0.1:8000/admin/ in your browser, you will see the following on the admin app landing page:

Figure 4.24 – Admin app landing page
Figure 4.24 – Admin app landing page

Note the change in the appearance of the admin page after the reviews model has been imported.

With the five models of the Reviews app registered with the admin app, we can examine some of the default interfaces that it has created for us.

Change lists
We now have change lists populated for our models. If we click the Publishers link, we will be taken to http://127.0.0.1:8000/admin/reviews/publisher and see a change list containing links to the publishers. These links are designated by the id field of the Publisher objects. If your database has been populated with the script in Chapter 3, URL Mapping, Views, and Templates, you will see a list with seven publishers, as shown in Figure 4.25.

Note

Depending on the state of your database and based on the activities you have completed, the object IDs, URLs, and links in these examples may be numbered differently from those listed here.

Figure 4.25 – The Select publisher to change list
Figure 4.25 – The Select publisher to change list

We can follow one of the links in the change list and examine the Change publisher page.

The Change publisher page
The Change publisher page at http://127.0.0.1:8000/admin/reviews/publisher/1 contains what we might expect (see Figure 4.26). There is a form for editing the publisher’s details. These details have been derived from the reviews.models.Publisher class:

Figure 4.26 – The Change publisher page
Figure 4.26 – The Change publisher page

If we had clicked the ADD PUBLISHER + button, the admin app would have returned a similar form for adding a publisher. The beauty of the admin app is that it gives us all of this CRUD functionality with just one line of coding – admin.site.register(Publisher) – using the definition of the reviews.models.Publisher attributes as a schema for the page content:

  class Publisher(models.Model):
      """A company that publishes books."""
      name = models.CharField(max_length=50,
          help_text="The name of the Publisher.")
      website = models.URLField(
          help_text="The Publisher's website.")
      email = models.EmailField(
          help_text="The Publisher's email address.")

Copy

Explain
The publisher Name field is constrained to 50 characters as specified in the model. The help text that appears in gray below each field is derived from the help_text attributes specified on the model. We can see that models.CharField, models.URLField, and models.EmailField are rendered in HTML as input elements of the text, url, and email types, respectively.

The fields in the form come with validation where appropriate. Unless model fields are set to blank=True or null=True, the form will throw an error if the field is left blank, as is the case for the Publisher.name field. Similarly, as Publisher.website and Publisher.email are respectively defined as instances of models.URLField and models.EmailField, they are validated accordingly. In Figure 4.27, we can see the validation of Name as a required field, validation of Website as a URL, and validation of Email as an email address:

Figure 4.27 – Field validation
Figure 4.27 – Field validation

It is useful to examine how the admin app renders elements of the models to understand how it functions. In your browser, right-click View Page Source and examine the HTML that has been rendered for this form. You will see a browser tab displaying something like this:

<fieldset class="module aligned ">
  <div class="form-row errors field-name">
    <ul class="errorlist"><li>This field is
      required.</li></ul>
    <div>
      <label class="required" for="id_name">Name:</label>
        <input type="text" name="name" class="vTextField"
          maxlength="50" required="" id="id_name">
      <div class="help">The name of the Publisher.</div>
    </div>
  </div>
  <div class="form-row errors field-website">
    <ul class="errorlist"><li>Enter a valid URL.</li></ul>
    <div>
      <label class="required"
        for="id_website">Website:</label>
          <input type="url" name="website" value="packtcom"
            class="vURLField" maxlength="200" required=""
              id="id_website">
      <div class="help">The Publisher's website.</div>
    </div>
  </div>
  <div class="form-row errors field-email">
    <ul class="errorlist"><li>Enter a valid email
      address.</li></ul>
    <div>
      <label class="required" for="id_email">Email:</label>
        <input type="email" name="email"
          value="infoatpackt.com"
            class="vTextField" maxlength="254"
              required="" id="id_email">
      <div class="help">The Publisher's email
        address.</div>
    </div>
  </div>
</fieldset>

Copy

Explain
The form has a publisher_form ID and it contains a fieldset with HTML elements corresponding to the data structure of the Publisher model in reviews/models.py, shown as follows:

  class Publisher(models.Model):
      """A company that publishes books."""
      name = models.CharField(max_length=50,
          help_text="The name of the Publisher.")
      website = models.URLField(
          help_text="The Publisher's website.")
      email = models.EmailField(
          help_text="The Publisher's email address.")

Copy

Explain
Note that for the name, the input field is rendered like this:

<input type="text" name="name" value="Packt Publishing"
  class="vTextField" maxlength="50"
    required="" id="id_name">

Copy

Explain
It is a required field, and it has a text type and maxlength of 50, as defined by the max_length parameter in the model definition:

  name = models.CharField(max_length=50,
      help_text="The name of the Publisher.")

Copy

Explain
Similarly, we can see the website and email being defined in the model as URLField and EmailField are rendered in HTML as input elements of the url and email types, respectively:

<input type="url" name="website"
  value="https://www.packtpub.com/"
    class="vURLField" maxlength="200" required=""
      id="id_website">
<input type="email" name="email" value="info@packtpub.com"
   class="vTextField" maxlength="254"
     required="" id="id_email">

Copy

Explain
We have learned that the Django admin app derives sensible HTML representations of Django models based on the model definitions that we have provided.

Now let’s examine the Book change page.

The Book change page
Similarly, there is a change page that can be reached by selecting Books from the Site administration page and then selecting a specific book from the change list:

Figure 4.28 – Selecting Books from the Site administration page
Figure 4.28 – Selecting Books from the Site administration page

After clicking Books, as shown in the preceding screenshot, you will see the following on your screen:

Figure 4.29 – The Book change page
Figure 4.29 – The Book change page

In this instance, selecting the book Architects of Intelligence will take us to the URL http://127.0.0.1:8000/admin/reviews/book/3/change/. In the previous example, all the model fields were rendered as simple HTML text widgets. The rendering of some other subclasses of django.db.models.Field used in models.Book are worthy of closer examination:

Figure 4.30 – The Change book page
Figure 4.30 – The Change book page

Here, publication_date is defined using models.DateField. It is rendered using a date selection widget. The visual representation of the widgets will vary between different operating systems and choices of browser:

Figure 4.31 – Date selection widget
Figure 4.31 – Date selection widget

As Publisher is defined as a foreign key relation, it is rendered as a Publisher drop-down menu with a list of the Publisher objects:

Figure 4.32 – Publisher drop-down menu
Figure 4.32 – Publisher drop-down menu

This brings us to how the admin app handles deletion. The admin app takes its cue from the models’ foreign key constraints when determining how to implement deletion functionality. In the BookContributor model, Contributor is defined as a foreign key. The code in reviews/models.py looks as follows:

contributor = models.ForeignKey(Contributor,
    on_delete=models.CASCADE)

Copy

Explain
By setting on_delete=CASCADE on a foreign key, the model specifies the database behavior required when a record is deleted; the deletion is cascaded to other objects that are referenced by the foreign key.

It is important to understand the impact of foreign key settings on the flow of the deletion process, and the following exercise examines this.

Exercise 4.03 – foreign keys and deletion behavior in the admin app
At present, all the ForeignKey relations in the reviews models are defined with an on_delete=CASCADE behavior. For instance, think of a case wherein an admin deletes one of the publishers. This would delete all the books that are associated with the publisher. We do not want that to happen, and that is precisely the behavior that we will be changing in this exercise:

Visit the Contributors change list at http://127.0.0.1:8000/admin/reviews/contributor/ and select a contributor to delete. Make sure that the contributor is the author of a book.
Click the Delete button, but don’t click Yes, I’m sure on the confirmation dialog. You will see a message like the one in Figure 4.33:
Figure 4.33 – Cascading delete confirmation dialog
Figure 4.33 – Cascading delete confirmation dialog

In accordance with the on_delete=CASCADE argument to the foreign key, we are warned that deleting this Contributor object will have a cascading effect on a BookContributor object.

In the reviews/models.py file, modify the Contributor attribute of BookContributor to the following and save the file:
contributor = models.ForeignKey(Contributor,
    on_delete=models.PROTECT)

Copy

Explain
Now, try deleting the Contributor object again. You will see a message similar to the one in Figure 4.34:
Figure 4.34 – Foreign key protection error
Figure 4.34 – Foreign key protection error

Because the on_delete argument is PROTECT, our attempt to delete the object with dependencies will throw an error. If we used this approach in our model, we would need to delete objects in the ForeignKey relation before we deleted the original object. In this case, it would mean deleting the BookContributor object before deleting the Contributor object.

Now that we have learned about how the admin app handles the ForeignKey relations, let’s revert the ForeignKey definition in the BookContributor class to the following:
contributor = models.ForeignKey(Contributor,
    on_delete=models.CASCADE)

Copy

Explain
We have examined how the admin app’s behavior adapts to the ForeignKey constraints that are expressed in model definitions. If the on_delete behavior is set to models.PROTECT, the admin app returns an error explaining why a protected object is blocking the deletion. This functionality can come in handy while building real-world apps, as there is often a chance of a manual error inadvertently leading to the deletion of important records. In the next section, we will look at how we can customize our admin app interface for a smoother user experience.

Customizing the admin interface
When first developing an application, the convenience of the default admin interface is excellent for building a rapid prototype of the app. Indeed, for many simpler applications or projects that require minimal data maintenance, this default admin interface may be entirely adequate. However, as the application matures to the point of release, the admin interface will generally need to be customized to facilitate more intuitive use and to robustly control data, subject to user permissions. You might want to retain certain aspects of the default admin interface and, at the same time, make some tweaks to certain features to better suit your purposes. For example, you would want the publisher list to show the complete names of the publishing houses instead of Publisher(1), Publisher(2), and so on. In addition to the aesthetic appeal, this makes it easier to use and navigate through the app.

In this section, we will be examining the AdminSite object and learning about some of its important properties that can be used to modify the global appearance of the admin app. Then we will examine approaches to subclassing AdminSite within our project so that we can customize it instead of using its default appearance. We will end by testing our knowledge of these techniques by creating a new project and customizing its admin interface.

Site-wide Django admin customizations
We have seen a page titled Log in | Django site admin containing a Django Administration form. However, an administrative user of the Bookr application may be somewhat perplexed by all this Django jargon, and it would be very confusing and a recipe for error if they had to deal with multiple Django apps that all had identical admin apps. As a developer of an intuitive and user-friendly application, you should customize this. Global properties such as these are specified as attributes of the AdminSite object. The following table details some of the simplest customizations to improve the usability of your app’s admin interface:

AdminSite Attribute

Base Value

Description

site_title

"Django site admin"

Populates the <title> tag on each page of the admin interface.

site_header

"Django administration"

Sets the header on the login form.

index_title

"Site administration"

Sets the heading on the admin index page (where the models are listed).

index_template

None

Provides the path to find the admin index template. If unset, the admin/index.html template is used.

app_index_template

None

Provides the path to find the app admin index template. If unset, the admin/app_index.html template is used.

login_template

None

Provides the path to find the login template.

If unset, the admin/login.html template is used.

logout_template

None

Provides the path to find the logout template. If unset, the registration/logged_out.html template is used.

password_change_template

None

Provides the path to find the password change template. If unset, the registration/password_change_form.html template is used.

password_change_done_template

None

Provides the path to find the password change done template. If unset, the registration/password_change_done.html template is used.

Figure 4.35 – Important AdminSite attributes

If this seems a little abstract, it might help if we examine the properties in this table using the Django shell.

Examining the AdminSite object from the Python shell
Let’s take a deeper look at the AdminSite class. We have already encountered an object of the AdminSite class. It is the admin.site object that we used in the previous Registering the reviews model section. If the development server is not running, start it now with the runserver subcommand as follows (use python instead of python3 for Windows):

python3 manage.py runserver

Copy

Explain
We can examine the admin.site object by importing the admin app in the Django shell, using the manage.py script again:

python3 manage.py shell
>>> from django.contrib import admin

Copy

Explain
We can interactively examine the default values of site_title, site_header, and index_title and see that they match the expected values of 'Django site admin', 'Django administration', and 'Site administration' that we have already observed on the rendered web pages of the Django admin app:

>>> admin.site.site_title
'Django site admin'
>>> admin.site.site_header
'Django administration'
>>> admin.site.index_title
'Site administration'

Copy

Explain
The AdminSite class also specifies which forms and views are used to render the admin interface and determine its global behavior.

Now that we have examined the object’s properties, we will attempt to subclass it so that we can customize them in our Django project.

Subclassing AdminSite – a first approach
We can make some modifications to the reviews/admin.py file. Instead of importing the django.contrib.admin module and using its site object, we will import AdminSite, subclass it, and instantiate our customized admin_site object. Consider the following code snippet. Here, BookrAdminSite is a subclass of AdminSite that contains custom values for site_title, site_header, and index_title; admin_site is an instance of BookrAdminSite, and we can use this instead of the default admin.site object to register our models. The reviews/admin.py file will look as follows:

from django.contrib.admin import AdminSite
from reviews.models import (Publisher, Contributor, Book,
    BookContributor, Review)
class BookrAdminSite(AdminSite):
    title_header = 'Bookr Admin'
    site_header = 'Bookr administration'
    index_title = 'Bookr site admin'
admin_site = BookrAdminSite(name='bookr')
# Register your models here.
admin_site.register(Publisher)
admin_site.register(Contributor)
admin_site.register(Book)
admin_site.register(BookContributor)
admin_site.register(Review)

Copy

Explain
Now we have created our own admin_site object that overrides the behavior of the admin.site object, we need to remove the existing references in our code to the admin.site object. In bookr/urls.py, we need to point admin to the new admin_site object and update our URL patterns. Otherwise, we would still be using the default admin site, and our customizations would be ignored. The change will look as follows:

from reviews.admin import admin_site
import reviews.views
from django.urls import include, path
urlpatterns = [
    path("admin/", admin_site.urls),
    path("book-search", reviews.views.book_search),
    path("", include("reviews.urls")),
]

Copy

Explain
This produces the expected results on the login screen:

Figure 4.36 – Customizing the login screen
Figure 4.36 – Customizing the login screen

However, now there is a problem; we have lost the interface for auth objects. Previously, the admin app discovered the models registered in reviews/admin.py and django.contrib.auth.admin through the auto-discovery process, but now we have overridden this behavior by creating a new AdminSite:

Figure 4.37 – Customized AdminSite is missing Authentication and Authorization
Figure 4.37 – Customized AdminSite is missing Authentication and Authorization

We could go down the path of referencing both the AdminSite objects to URL patterns in bookr/urls.py, but this approach would mean that we would end up with two separate admin apps for authentication and reviews. So, the URL http://127.0.0.1:8000/admin will take you to the original admin app derived from the admin.site object, while http://127.0.0.1:8000/bookradmin will take you to our BookrAdminSite, admin_site. This is not what we want to do, as we are still left with the admin app without the customizations that we added when we subclassed BookrAdminSite:

from django.contrib import admin
from reviews.admin import admin_site
from django.urls import path
urlpatterns = [path('admin/', admin.site.urls),
               path('bookradmin/', admin_site.urls),]

Copy

Explain
To avoid this problem, let’s see what we can do in the next subsection.

Subclassing AdminSite – a better way
This has been a clumsy problem with the Django admin interface that has led to a lot of ad hoc solutions in earlier versions. However, since Django 2.1 came out, there has been a simple way of integrating a customized interface for the admin app without breaking auto-discovery or any of its other default features. Let’s see how to do this with the following steps:

As BookrAdminSite is project-specific, the code does not really belong under our reviews folder. So, move BookrAdminSite to a new file called admin.py at the top level of the Bookr project directory:
from django.contrib import admin
class BookrAdminSite(admin.AdminSite):
    title_header = 'Bookr Admin'
    site_header = 'Bookr administration'
    index_title = 'Bookr site admin'

Copy

Explain
The URL settings path in bookr/urls.py changes to path('admin/', admin.site.urls) and we define our ReviewsAdminConfig.

Add a file called reviews/adminconfig.py containing these lines:
from django.contrib.admin.apps import AdminConfig
class ReviewsAdminConfig(AdminConfig):
    default_site = 'admin.BookrAdminSite'

Copy

Explain
Replace django.contrib.admin with reviews.apps.ReviewsAdminConfig, so that INSTALLED_APPS in the bookr/settings.py file will look as follows:
INSTALLED_APPS = [
    'reviews. adminconfig.ReviewsAdminConfig',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'reviews']

Copy

Explain
With the ReviewsAdminConfig specification of default_site, we no longer need to replace references to admin.site with a custom AdminSite object, admin_site. We can replace those admin_site calls with the admin.site calls that we had originally. Now, reviews/admin.py reverts to the following:

from django.contrib import admin
from reviews.models import (Publisher, Contributor,
    Book, BookContributor, Review)
# Register your models here.
admin.site.register(Publisher)
admin.site.register(Contributor)
admin.site.register(Book, BookAdmin)
admin.site.register(BookContributor)
admin.site.register(Review)

Copy

Explain
There are other aspects of AdminSite that we can customize, but we will revisit these in Chapter 9, Sessions and Authentication, once we have a fuller understanding of Django’s templates and forms.

The following activity is aimed at testing the skills that you have learned to configure and customize the Django admin app for a new Django project.

Activity 4.02 – customizing the AdminSite object
You have learned how to modify attributes of the AdminSite object in a Django project. This activity will challenge you to use these skills to customize a new project and override its site title, site header, and index header. Also, you will replace the logout message by creating a project-specific template and setting it in our custom AdminSite object. You are developing a Django project that implements a message board called Comment8or. Comment8or is geared toward a technical demographic, so you need to make the phraseology succinct and abbreviated:

The Comment8or admin site will be referred to as c8admin. This will appear on the site header and index title.
For the title header, it will say c8 site admin.
The default Django admin logout message is Thanks for spending some quality time with the Web site today. In Comment8or, it will say Bye from c8admin.
These are the steps that you need to follow to complete this activity:

Following the process that you learned in Chapter 1, An Introduction to Django, create a new Django project called comment8or, an app called messageboard, and run the migrations. Create a superuser called c8admin.
In the Django source code, there is a template for the logout page located in django/contrib/admin/templates/registration/logged_out.html. Make a copy of it in your project’s directory under comment8or/templates/comment8or and modify the message in the template following the requirements.
Inside the project, create an admin.py file that implements a custom AdminSite object. Set the appropriate values for the index_title, title_header, site_header, and logout_template, attributes based on the requirements.
Add a custom AdminConfig subclass to messageboard/adminconfig.py.
Replace the admin app with the custom AdminConfig subclass in comment8or/settings.py.
Configure the TEMPLATES setting so that the project’s template is discoverable.
When the project was first created, the login page looked like this:

Figure 4.38 – Login page for the project
Figure 4.38 – Login page for the project

The app index page looked like this:

Figure 4.39 – App index page for the project
Figure 4.39 – App index page for the project

Finally, the logout page looked like this:

Figure 4.40 – Logout page for the project
Figure 4.40 – Logout page for the project

After you have completed this activity with all the customizations, the login page will look like this:

Figure 4.41 – Login page after customization
Figure 4.41 – Login page after customization

The app index page will look like this:

Figure 4.42 – App index page after customization
Figure 4.42 – App index page after customization

Finally, the logout page will look like this:

Figure 4.43 – Logout page after customization
Figure 4.43 – Logout page after customization

You have successfully customized the admin app by subclassing AdminSite.

Note

The solution for this activity can be found on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

In the next section, we will examine the AdminSite object and learn about some of its important properties that can be used to modify the global appearance of the admin app. Then we will examine approaches to subclassing AdminSite within our project so that we can customize it away from its default appearance. We will end by testing our knowledge of these techniques by creating a new project and customizing its admin interface.

Customizing the ModelAdmin classes
Now that we’ve learned how a subclassed AdminSite can be used to customize the global appearance of the admin app, we will look at how to customize the admin app’s interface to individual models. Owing to the admin interface being generated automatically from the models’ structure, it has an overly generic appearance and needs to be customized for the sake of aesthetics and usability. Click one of the Books links in the admin app and compare it to the Users link. Both links take you to change list pages. These are the pages that a Bookr administrator visits when they want to add new books or add or alter the privileges of a user. As explained previously, a change list page presents a list of model objects with the option of selecting a group of them for bulk deletion (or other bulk activity), examining an individual object to edit it, or adding a new object. Notice the difference between the two change list pages with a view to making our vanilla Books page as fully featured as the Users page. The following screenshot from the Authentication and Authorization app contains useful features such as a search bar, sortable column headers for important user fields, and a result filter:

Figure 4.44 – The Users change list contains the customized ModelAdmin features
Figure 4.44 – The Users change list contains the customized ModelAdmin features

In this section, we will learn how the ModelAdmin classes can be developed to customize the fields on the change list page and to implement filters and search bars. We will look at how model fields can be grouped in admin CRUD forms or be excluded from the form if the fields should retain a default or system-generated value.

The list display fields
On the Users change list page, you will see the following:

There is a list of user objects presented, summarized by their USERNAME, EMAIL ADDRESS, FIRST NAME, LAST NAME, and STAFF STATUS attributes.
These individual attributes are sortable. The sorting order can be changed by clicking the headers.
There is a search bar at the top of the page.
In the right-hand column, there is a selection filter that allows the selection of several user fields, including some not appearing in the list display.
However, the behavior for the Books change list page is a lot less helpful. The books are listed by their titles but not in alphabetical order. The title column is not sortable and there are no filter or search options present:

Figure 4.45 – The Books change list
Figure 4.45 – The Books change list

Recall from Chapter 2, Models and Migrations, that we defined the __str__ methods on the Publisher, Book, and Contributor classes. In the case of the Book class, it had a __str__() representation that returns the book object’s title:

class Book(models.Model):
    …
    def __str__(self):
        return self.title

Copy

Explain
If we had not defined the __str__() method on the Book class, it would have inherited it from the base Model class, django.db.models.Model.

This base class provides an abstract way to give a string representation of an object. For example, when we have Book with a primary key, in this case, the id field, with a value of 17, then we will end up with a string representation of Book object (17):

Figure 4.46 – The Books change list using the Model __str__ representation
Figure 4.46 – The Books change list using the Model __str__ representation

It could be useful in our application to represent a Book object as a composite of several fields. For example, if we wanted the books to be represented as Title (ISBN), the following code snippet would produce the desired results:

class Book(models.Model):
    …
    def __str__(self):
        return "{} ({})".format(self.title, self.isbn)

Copy

Explain
This is a useful change in and of itself as it makes the representation of the object more intuitive in the app:

Figure 4.47 – A portion of the Books change list with the custom string representation
Figure 4.47 – A portion of the Books change list with the custom string representation

We are not limited to using the __str__ representation of the object in the list_display field. The columns that appear in the list display are determined by the ModelAdmin class of the Django admin app. In the Django shell, we can import the ModelAdmin class and examine its list_display attribute:

python manage.py shell
>>> from django.contrib.admin import ModelAdmin
>>> ModelAdmin.list_display
('__str__',)

Copy

Explain
This explains why the default behavior of list_display is to display a single-columned table of the objects’ __str__ representations so that we can customize the list display by overriding this value. The best practice is to subclass ModelAdmin for each object. If we wanted the book list display to contain two separate columns for Title and ISBN, rather than having a single column containing both values, as in Figure 4.47, we would subclass ModelAdmin as BookAdmin and specify the custom list_display. The benefit of doing this is that we are now able to sort books by Title and by ISBN. We can add this class to reviews/admin.py:

class BookAdmin(admin.ModelAdmin):
    list_display = ('title', 'isbn')

Copy

Explain
Now that we’ve created a BookAdmin class, we should reference it when we register our reviews.models.Book class with the admin site. In the same file, we also need to modify the model registration to use BookAdmin instead of the default value of admin.ModelAdmin, so the admin.site.register call now becomes the following:

admin.site.register(Book, BookAdmin)

Copy

Explain
Once these two changes have been made to the reviews/admin.py file, we will get a Books change list page that looks like this:

Figure 4.48 – A portion of the Books change list with a two-column list display
Figure 4.48 – A portion of the Books change list with a two-column list display

This gives us a hint as to how flexible list_display is. It can take four types of values:

It takes field names from the model, such as title or isbn.
It takes a function that takes the model instance as an argument, such as this function that gives an initialized version of a person’s name:
def initialled_name(obj):
    """ obj.first_names='Jerome David',
    obj.last_names='Salinger'=> 'Salinger, JD' """
    initials = ''.join([name[0] for name in
                        obj.first_names.split(' ')])
    return "{}, {}".format(obj.last_names, initials)
class ContributorAdmin(admin.ModelAdmin):
    list_display = (initialled_name,)

Copy

Explain
It takes a method from the ModelAdmin subclass that takes the model object as a single argument. Note that this needs to be specified as a string argument as it would be out of scope and undefined within the class:
class BookAdmin(admin.ModelAdmin):
    list_display = ('title', 'isbn13')
    def isbn13(self, obj):
        """ '9780316769174' => '978-0-31-676917-4' """
        return "{}-{}-{}-{}-{}".format(obj.isbn[0:3],
            obj.isbn[3:4], obj.isbn[4:6],
            obj.isbn[6:12], obj.isbn[12:13])

Copy

Explain
It takes a method (or a non-field attribute) of the model class, such as __str__, as long as it accepts the model object as an argument. For example, we could convert isbn13 to a method on the Book model class:
class Book(models.Model):
    def isbn13(self):
        """ '9780316769174' => '978-0-31-676917-4' """
        return "{}-{}-{}-{}-{}".format(self.isbn[0:3],
            self.isbn[3:4], self.isbn[4:6],
            self.isbn[6:12], self.isbn[12:13])

Copy

Explain
Now when viewing the Books change list at http://127.0.0.1:8000/admin/reviews/book, we can see the hyphenated ISBN13 field:

Figure 4.49 – A portion of the Books change list with the hyphenated ISBN13
Figure 4.49 – A portion of the Books change list with the hyphenated ISBN13

It is worth noting that computed fields such as __str__ or our isbn13 methods do not make for sortable fields on the summary page. Also, we cannot include fields of the ManyToManyField type in list_display.

While columns that are derived from model attributes derive their column headers and properties from the field attributes, we can specify properties of display columns that are computed fields using the display decorator.

The display decorator
When using a callable in the list_display, as in the cases of initialled_name and isbn13, we can use the admin.display decorator to specify the column name that will appear in the header of the change list using the description argument. We can also use it to get around the limitation of calculated fields not being sortable by specifying ordering on the callable. The empty_value argument can be used to specify how a None value or empty string is displayed. The default empty_value display is a single dash character:

    @admin.display(
        ordering='isbn',
        description='ISBN-13',
        empty_value='-/-'
    )
    def isbn13(self, obj):
        """ '9780316769174' => '978-0-31-676917-4' """
        return "{}-{}-{}-{}-{}".format(obj.isbn[0:3],
            obj.isbn[3:4], obj.isbn[4:6], obj.isbn[6:12],
            obj.isbn[12:13])

Copy

Explain
The boolean argument to admin.display can be used to flag a value to be represented in Boolean form:

    @admin.display(
        boolean=True,
        description='Has ISBN',
    )
    def has_isbn(self, obj):
        """ '9780316769174' => True """
        return bool(obj.isbn)

Copy

Explain
Together these display decorator settings will give us display columns that look like this:

Figure 4.50 – The Books change list with the admin display settings
Figure 4.50 – The Books change list with the admin display settings

The filter
Once the admin interface needs to deal with a significant number of records, it is convenient to narrow down the results that appear on change list pages. The simplest filters select individual values. For example, the user filter depicted in Figure 4.6 allows the selection of users by choosing By staff status, By superuser status, and By active. We’ve seen on the user filter that BooleanField can be used as a filter. We can also implement filters on CharField, DateField, DateTimeField, IntegerField, ForeignKey, and ManyToManyField. In this case, by adding publisher as a ForeignKey of Book, it is defined on the Book class as follows:

publisher = models.ForeignKey(Publisher,
                              on_delete=models.CASCADE)

Copy

Explain
Filters are implemented using the list_filter attribute of a ModelAdmin subclass. In our Bookr app, filtering by book title or ISBN would be impractical as it would produce a large list of filter options that return only one record. The filter that would occupy the right-hand side of the page would take up more space than the actual change list. A practical option would be to filter books by publisher. We defined a custom __str__ method for the Publisher model that returns the publisher’s name attribute, so our filter options will be listed as publisher names.

We can specify our change list filter in reviews/admin.py in the BookAdmin class like so:

    list_filter = ('publisher',)

Copy

Explain
Here is how the Books change list page should look now:

Figure 4.50 – The Books change list page with the publisher filter
Figure 4.50 – The Books change list page with the publisher filter

With that line of code, we have implemented a useful publisher filter on the Books change list page.

In order to consolidate our knowledge of filters, we will add further filters to the Books change list page.

Exercise 4.04 – adding the date list_filter and date_hierarchy filters
We have seen that the admin.ModelAdmin class provides useful attributes to customize filters on change list pages. For example, filtering by date is a crucial functionality for many applications and can also help us make our app more user-friendly. In this exercise, we will examine how date filtering can be implemented by including a date field in the filter and look at the date_hierarchy filter:

Edit the reviews/admin.py file and modify the list_filter attribute in the BookAdmin class to include 'publication_date':
class BookAdmin(admin.ModelAdmin):
    list_display = ('title', 'isbn13')
    list_filter = ('publisher', 'publication_date')

Copy

Explain
Reload the Books change list page and confirm that the filter now includes date settings:
Figure 4.51 – Confirming that the Books change list page includes date settings
Figure 4.51 – Confirming that the Books change list page includes date settings

This publication date filter would be convenient if the Bookr project was receiving a lot of new releases, and we wanted to filter books by what was published in the last seven days or a month. Sometimes though, we might like to filter by a specific year or a specific month in a specific year. Fortunately, the admin.ModelAdmin class comes with a custom filter attribute geared towards navigating hierarchies of temporal information. It is called date_hierarchy.

Add a date_hierarchy attribute to BookAdmin and set its value to publication_date:
class BookAdmin(admin.ModelAdmin):
    date_hierarchy = 'publication_date'
    list_display = ('title', 'isbn13')
    list_filter = ('publisher', 'publication_date')

Copy

Explain
Reload the Books change list page and confirm that the date hierarchy appears above the Action drop-down menu:
Figure 4.52 – Confirming that the date hierarchy appears above the Action drop-down menu
Figure 4.52 – Confirming that the date hierarchy appears above the Action drop-down menu

Select a year from the date hierarchy and confirm that it contains a list of months in that year containing book titles and a total list of books:
Figure 4.53 – Confirming that the selection of a year from the date hierarchy shows the books published that year
Figure 4.53 – Confirming that the selection of a year from the date hierarchy shows the books published that year

Confirm that selecting one of these months further filters down to days in the month:
Figure 4.54 – Filtering months down to days in the month
Figure 4.54 – Filtering months down to days in the month

The date_hierarchy filter is a convenient way of customizing a change list that contains a large set of time-sortable data in order to facilitate faster record selection, as we saw in this exercise.

Let’s now look at the implementation of a search bar in our app.

The search bar
This brings us to the remaining piece of functionality that we wanted to implement – the search bar. Like filters, a basic search bar is quite simple to implement. We only need to add the search_fields attribute to the ModelAdmin class. The obvious character fields in our Book class to search on are title and isbn. At present, the Books change list appears with a date hierarchy across the top of the change list. The search bar will appear above this:

Figure 4.55 – The Books change list before the search bar is added
Figure 4.55 – The Books change list before the search bar is added

We can start by adding this attribute to BookAdmin in reviews/admin.py and examine the result:

    search_fields = ('title', 'isbn')

Copy

Explain
The result would look like this:

Figure 4.56 – The Books change list with the search bar
Figure 4.56 – The Books change list with the search bar

Now we can perform a simple text search on fields that match the title field or ISBN. This search requires precise string matches, so “color” won’t match “colour.” It also lacks the deep semantic processing that we expect from more sophisticated search facilities such as Elasticsearch. ISBN lookup is a very good feature if you happen to have a barcode scanner. Limiting our search to fields on the Books model is quite restrictive. We might want to search by publisher name too. Fortunately, search_fields is flexible enough to accomplish this. To search on ForeignKeyField or ManyToManyField, we just need to specify the field name on the current model and the field on the related model separated by two underscores. In this case, Book has a foreign key, publisher, and we want to search on the Publisher.name field so it can be specified as 'publisher__name' on BookAdmin.search_fields:

    search_fields = ('title', 'isbn', 'publisher__name')

Copy

Explain
If we wanted to restrict a search field to an exact match rather than return results that contain the search string, then the field can be suffixed with '__exact'. So, replacing 'isbn' with 'isbn__exact' will require the complete ISBN to be matched, and we won’t be able to get a match using a portion of the ISBN.

Similarly, we constrain the search field to only return results that start with the search string by using the '__startswith' suffix. Qualifying the publisher name search field as 'publisher__name__startswith' means that we will get results searching for “pack” but not for “ackt.”

This concludes our examination of common customizations of the change list pages. We may also want to customize the behavior of the create and update forms in our app.

Excluding and grouping fields
There are occasions when it is appropriate to restrict the visibility of some of the fields in the model in the admin interface. This can be achieved with the exclude attribute.

This is the review form screen with the Date edited field visible. Note that the Date created field does not appear – it is already a hidden view because date_created is defined on the model with the auto_now_add parameter:

Figure 4.57 – The review form
Figure 4.57 – The review form

If we wanted to exclude the Date edited field from the review form, we would do this in the ReviewAdmin class:

exclude = ('date_edited',)

Copy

Explain
Then the review form would appear without Date edited:

Figure 4.58 – The review form with the Date edited field excluded
Figure 4.58 – The review form with the Date edited field excluded

Conversely, it might be more prudent to restrict the admin fields to those that have been explicitly permitted. This is achieved with the fields attribute. The advantage of this approach is that if new fields are added in the model, they won’t be available in the admin form unless they have been added to the fields tuple in the ModelAdmin subclass:

fields = ('content', 'rating', 'creator', 'book')

Copy

Explain
This will give us the same result that we saw earlier.

Another option is to use the fieldsets attribute of the ModelAdmin subclass to specify the form layout as a series of grouped fields. Each grouping in fieldsets consists of a title followed by a dictionary containing a 'fields' key pointing to a list of field name strings:

    fieldsets = (
        ("Linkage", {"fields": ("creator", "book")}),
        ("Review content", {"fields": ("content",
        "rating")}),
    )

Copy

Explain
The review form should look as follows:

Figure 4.59 – The review form with fieldsets
Figure 4.59 – The review form with fieldsets

If we want to omit the title on a fieldset, we can do so by assigning the None value to it:

    fieldsets = (
        (None, {'fields': ('creator', 'book')}),
        ('Review content', {'fields': ('content',
        'rating')}))

Copy

Explain
Now, the review form should appear as shown in the following screenshot:

Figure 4.60 – The review form with the first fieldset untitled
Figure 4.60 – The review form with the first fieldset untitled

Now that we have learned about change lists and form customizations, we can put our knowledge into practice with a comprehensive activity.

Activity 4.03 – customizing the Model admins
In our data model, the Contributor class is used to store data for book contributors; they can be authors, contributors, or editors. This activity focuses on modifying the Contributor class and adding a ContributorAdmin class to improve the user-friendliness of the admin app. At present, the Contributor change list defaults to a single column, FirstNames, based on the __str__ method created in Chapter 2, Models and Migrations. We will investigate some alternative ways of representing this. These steps will help you complete the activity:

Edit reviews/models.py to add additional functionality to the Contributor model.
Add an initialled_name method to Contributor that takes no arguments (like the Book.isbn13 method).
The initialled_name method will return a string containing Contributor.last_names followed by a comma and the initials of the given names. For example, for a Contributor object with first_names of Jerome David and last_names of Salinger, initialled_name will return Salinger, JD.
Replace the __str__ method for Contributor with one that calls initialled_name().
At this point, the Contributors display list will look like this:

Figure 4.61 – The Contributors display list
Figure 4.61 – The Contributors display list

Edit the reviews/admin.py file. We will modify ContributorAdmin that was subclassed from admin.ModelAdmin in the The list display fields section.
Modify it so that on the Contributors change list, records are displayed with two sortable columns: Last Names and First Names. We can remove the existing list_display attribute from ContributorAdmin along with the initialled_name function.
Add a search bar that searches on Last Names and First Names. Modify it so that it only matches the start of Last Names.
Add a filter on Last Names.
By completing the activity, you should see something like this:

Figure 4.62 – Expected output
Figure 4.62 – Expected output

Changes such as these can be made to improve the functionality of the admin user interface. By implementing the First Names and Last Names columns as separate columns in the Contributors change list, we give the user an option to sort on either of the fields. By considering what columns are most useful in search retrieval and filter selections, we can improve the efficient retrieval of records.

Note

The solution for this activity can be found on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

Summary
In this chapter, we saw how to create superusers through the Django command line and how to use them to access the admin app. Then, after a brief tour of the admin app’s basic functionality, we examined how to register our models with it to produce a CRUD interface for our data.

Then we learned how to refine this interface by modifying site-wide features. We altered how the admin app presents model data to the user by registering custom model admin classes with the admin site. This allowed us to make fine-grained changes to the representation of our models’ interfaces. These modifications included customizing change list pages by adding additional columns, filters, date hierarchies, and search bars. We also modified the layout of the model admin pages by grouping and excluding fields.

This was only a very shallow dive into the functionality of the admin app. We will revisit the rich functionality of AdminSite and ModelAdmin in Chapter 10, Advanced Django Admin and Customization. But first, we need to learn some more intermediate features of Django. In the next chapter, we will learn how to organize and serve static content, such as CSS, JavaScript, and images, from a Django app.



| ≪ [ 03 URL Mapping, Views, and Templates ](/packtpub/2024/422-web_development_with_django_2ed/03_url_mapping,_views,_and_templates) | 04 An Introduction to Django Admin | [ 05 Serving Static Files ](/packtpub/2024/422-web_development_with_django_2ed/05_serving_static_files) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/422-web_development_with_django_2ed/04_an_introduction_to_django_admin
> (2) Markdown
> (3) Title: 04 An Introduction to Django Admin
> (4) Short Description: Publication date: May 2023 Publisher Packt Pages 764
> (5) tags: Django
> Book Title: 422-Web Development with Django 2ed
> Link: https://subscription.packtpub.com/book/web-development/9781803230603/pref
> create: 2024-05-08 수 14:11:52
> Images: /packtpub/2024/422-web_development_with_django_2ed_img/04/
> .md Name: 04_an_introduction_to_django_admin.md

