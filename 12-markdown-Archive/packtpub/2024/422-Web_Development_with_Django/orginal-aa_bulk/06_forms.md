
| ≪ [ 05 Serving Static Files ](/packtpub/2024/422-web_development_with_django_2ed/05_serving_static_files) | 06 Forms | [ 07 Advanced Form Validation and Model Forms ](/packtpub/2024/422-web_development_with_django_2ed/07_advanced_form_validation_and_model_forms) ≫ |
|:----:|:----:|:----:|

# 06 Forms

Packt Logo

Book image


Forms
This chapter introduces web forms, a method of sending information from the browser to a web server. We will start by introducing forms in general and discussing how data is encoded to be sent to the server.

So far, the views we have been building for Django have been one-way only. Our browser is retrieving data from the views we have written, but it doesn’t send any data back to them. In Chapter 4, An Introduction to Django Admin, we created model instances by using the Django admin and submitting forms, but those were using views built into Django, not created by us. In this chapter, we will use the Django Forms library to start accepting user-submitted data. The data will be provided through GET requests in the URL parameters and/or POST requests in the body of the request. But before we get into the details, first, let’s understand what forms are in Django. You’ll learn about the differences between sending form data in a GET HTTP request and sending it in a POST HTTP request and how to choose which one to use.

In this chapter, we will be covering the following topics:

What is a form?
The Django Forms library
Validating forms and retrieving Python values
Activity 1 – Book Search
By the end of this chapter, you will have learned how Django’s Forms library is used to build and validate forms automatically and how it cuts down on the amount of manual HTML to write.

Technical requirements
The complete code files for this chapter can be found at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter06.

What is a form?
When working with an interactive web app, we not only want to provide data to users but also accept data from them to either customize the responses we’re generating or to let them submit data to the site. When browsing the web, you most definitely will have used forms. Whether you’re logged into your internet banking account, surfing the web with a browser, posting a message on social media, or writing an email to an online email client, in all these cases, you’re entering data in a form. A form is made up of inputs that define key-value pairs of data to submit to the server. For example, when logging in to a website, the data being sent would have the keys username and password, with values of your username and your password, respectively. We will go into the different types of inputs in more detail in an upcoming section. Each input in the form has a name, and this is how its data is identified on the server side (in a Django view). There can be multiple inputs with the same name, whose data is available in a list containing all the posted values with this name – for example, a list of checkboxes with permissions to apply to users. Each checkbox would have the same name but a different value. The form has attributes that specify which URL the browser should submit the data to and what method it should use to submit the data (browsers only support GET or POST).

The GitHub Login page shown in the following figure is an example of a form:

Figure 6.1: The GitHub Login page is an example of a form
Figure 6.1: The GitHub Login page is an example of a form

It has three visible inputs: a text field (Username or email address), a password field (Password), and a submit button (Sign in). It also has a field that is not visible – its type is hidden, and it contains a special token for security called a CSRF token. We will discuss this later in this chapter. When you click the Sign In button, the form data is submitted with a POST request. If you entered a valid username and password, you will be logged in; otherwise, the form will display an error, as follows:

Figure 6.2: Form submitted with incorrect username or password
Figure 6.2: Form submitted with incorrect username or password

There are two states a form can have: pre-submit and post-submit. The first is the initial state when the page is first loaded. All the fields will have a default value (usually empty), and no errors will be displayed. If all the information that has been entered into a form is valid, then usually, when it is submitted, you will be taken to a page showing the results of submitting the form. This might be a search results page or a page showing you the new object that you created. In this case, you will not see the form in its post-submit state.

If you did not enter valid information into the form, then it will be rendered again in its post-submit state. In this state, you will be shown the information that you entered, as well as any errors to help you resolve the problems with the form. These errors may be field errors or non-field errors. Field errors apply to a specific field – for example, leaving a required field blank or entering a value that is too large, too small, too long, or too short. If a form required you to enter your name and you left it blank, this would be displayed as a field error next to that field.

Non-field errors either do not apply to a field or apply to multiple fields and are displayed at the top of the form. In the preceding figure, we can see a message that either the username or password may be incorrect when logging in. For security, GitHub does not reveal if a username is valid, so this is displayed as a non-field error rather than a field error for a username or password (Django also follows this convention). Non-field errors also apply to fields that depend on each other. For example, on a credit card form, if the payment is rejected, we might not know if the credit card number or security code is incorrect; therefore, we can’t show that error on a specific field. It applies to the form as a whole.

Let’s look at the different parts of an HTML form, starting with the form element itself.

The form element
All inputs used during form submission must be contained inside an <form> element. There are three HTML attributes that you must use to modify the behavior of the form:

method
This is the HTTP method for submitting the form; there’s either get or post. If omitted, this defaults to get (because this is the default method when typing in a URL in the browser and hitting Enter).

action
This refers to the URL (or path) to send the form data to. If omitted, the data gets sent back to the current page.

enctype
This sets the encoding type of the form. You only need to change this if you are using the form to upload files. The most common values are application/x-www-form-urlencoded (the default if this value is omitted) or multipart/form-data (set this if you’re uploading files). Note that you don’t have to worry about the encoding type in your view – Django handles the different types automatically.

Here is an example of a form without any of its attributes set:

<form>
    <!-- Input elements go here -->
</form>

Copy

Explain
It will submit its data using a GET request to the current URL that the form is being displayed on, using the application/x-www-form-urlencoded encoding type.

In the following example, we’ll set all three attributes on a form:

<form method="post" action="/form-submit"
enctype="multipart/form-data">
    <!-- Input elements go here -->
</form>

Copy

Explain
This form will submit its data with a POST request to the /form-submit path, encoding the data as multipart/form-data.

How do GET and POST requests differ in how the data is sent? Recall in Chapter 1, An Introduction to Django, that we discussed what the underlying HTTP request and response data that your browser sends look like. In the following two examples, we will submit the same form twice, the first time using GET and the second time using POST. The form will have two inputs: a first name and a last name.

A form submitted using GET sends its data in the URL like this:

GET /form-submit?first_name=Joe&last_name=Bloggs HTTP/1.1
Host: www.example.com

Copy

Explain
Whereas a form submitted using POST sends its data in the body of the request, like this:

POST /form-submit HTTP/1.1
Host: www.example.com
Content-Length: 31
Content-Type: application/x-www-form-urlencoded
first_name=Joe&last_name=Bloggs

Copy

Explain
You’ll notice that the form data is encoded the same way in both cases; it is just placed differently for the GET and POST requests. In the Choosing between GET or POST section, we’ll discuss how to choose between these two types of requests.

Types of inputs
We’ve seen four examples of inputs so far (text, password, submit, and hidden). Most inputs are created with a <input> tag, and their type is specified with its type attribute. Each input has a name attribute that defines the key for the key-value pairs that are sent to the server in the HTTP request.

In the next exercise, we’ll look at how we can build a form in HTML. This will allow you to get up to speed on many different form fields.

Exercise 6.01 – building a form in HTML
For the first few exercises of this chapter, we will need an HTML form to test with. We will manually code one in this exercise. This will also allow you to experiment with how different fields are validated and submitted. This will be done in a new Django project so that we don’t interfere with Bookr. You can refer to Chapter 1 to refresh your memory on creating a Django project:

We’ll start by creating the new Django project. You can reuse the Bookr virtual environment that already has Django installed. Open a new terminal and activate the virtual environment. Then, use django-admin to start a Django project named form_project. To do this, run the following command:
django-admin startproject form_project

Copy

Explain
This will scaffold the Django project in a directory named form_example.

Create a new Django app in this project by using the startapp management command. The app should be called form_example. To do this, cd into the form_project directory, then run the following:
python3 manage.py startapp form_example

Copy

Explain
This will create the form_example app directory inside the form_project directory.

Launch PyCharm, then open the form_project directory. If you already have a project open, you can do this by choosing File -> Open; otherwise, just click Open in the Welcome to PyCharm window. Navigate to the form_project directory, select it, then click Open.
If prompted, be sure to choose Trust Project.

The form_project project window should be shown like this:

Figure 6.3: form_project project open
Figure 6.3: form_project project open

Create a new run configuration to execute manage.py runserver for the project. You can reuse the Bookr virtual environment again. The Run/Debug Configurations window should look similar to the following figure when you’re done:
Figure 6.4: Run/Debug Configurations for Runserver
Figure 6.4: Run/Debug Configurations for Runserver

You can test that the configuration has been set up correctly by clicking the Run button, then visiting http://127.0.0.1:8000/ in your browser. You should see the Django welcome screen. If the debug server fails to start or you see the Bookr main page, then you probably still have the Bookr project running. Try stopping the Bookr runserver process and then starting the new one you just set up.

Open settings.py in the form_project directory and add "form_example" to the INSTALLED_APPS setting.
The last step in setting up this new project is to create a templates directory for the form_example app. Right-click on the form_example directory then select New | Directory. Name it templates.
We need an HTML template to display our form. Create one by right-clicking on the templates directory you just created, then choosing New | HTML File.
In the dialog box that appears, enter the name form-example.html and press Enter to create it.

The form-example.html file should now be open in the editor pane of PyCharm. Start by creating the form element. We’ll set its method attribute to post. The action attribute will be omitted, which means the form will submit back to the same URL on which it was loaded.
Insert this code between the <body> and </body> tags:

<form method="post">
</form>

Copy

Explain
Now, let’s add a few inputs. To add a little bit of spacing between each input, we’ll wrap them inside <p> tags. We will start with a text field and a password field. This code should be inserted between the <form> tags you just created:
<p>
    <label for="id_text_input">Text Input</label><br>
    <input id="id_text_input" type="text"
       name="text_input" value="" placeholder=
       "Enter some text">
</p>
<p>
    <label for="id_password_input">Password Input
      </label><br>
    <input id="id_password_input" type="password"
      name="password_input" value="" placeholder="Your
      password">
</p>

Copy

Explain
Next, we will add two checkboxes and three radio buttons. Insert this code after the HTML you added in the previous step; it should come before the </form> tag:
<p>
    <input id="id_checkbox_input" type="checkbox"
      name="checkbox_on" value="Checkbox Checked"
      checked>
    <label for="id_checkbox_input">Checkbox</label>
</p>
<p>
    <input id="id_radio_one_input" type="radio"
      name="radio_input" value="Value One">
    <label for="id_radio_one_input">Value One</label>
    <input id="id_radio_two_input" type="radio"
      name="radio_input" value="Value Two" checked>
    <label for="id_radio_two_input">Value Two</label>
    <input id="id_radio_three_input" type="radio"
      name="radio_input" value="Value Three">
    <label for="id_radio_three_input">Value Three
      </label>
</p>

Copy

Explain
Next is a drop-down select menu, for choosing a favorite book. Add this code after that of the previous step but before the </form> tag:
<p>
    <label for="id_favorite_book">Favorite Book
      </label><br>
    <select id="id_favorite_book" name=
      "favorite_book">
        <optgroup label="Non-Fiction">
            <option value="1">Deep Learning with
              Keras</option>
            <option value="2">Web Development with
              Django</option>
        </optgroup>
        <optgroup label="Fiction">
            <option value="3">Brave New World</option>
            <option value="4">The Great
              Gatsby</option>
        </optgroup>
    </select>
</p>

Copy

Explain
It will display four options that are split into two groups. The user will only be able to select one option.

The next is a multiple select (achieved by using the multiple attribute). Add this code after that of the previous step but before the </form> tag:
<p>
    <label for="id_books_you_own">Books You Own
      </label><br>
    <select id="id_books_you_own" name="books_you_own"
      multiple>
        <optgroup label="Non-Fiction">
            <option value="1">Deep Learning with
              Keras</option>
            <option value="2">Web Development with
              Django</option>
        </optgroup>
        <optgroup label="Fiction">
            <option value="3">Brave New World</option>
            <option value="4">The Great Gatsby
              </option>
        </optgroup>
    </select>
</p>

Copy

Explain
The user can select zero or more options from the four. They are displayed in two groups.

Next is a textarea. It is like a text field but has multiple lines. This code should be added, like in the previous steps, before the closing </form> tag:
<p>
    <label for="id_text_area">Text Area</label><br>
    <textarea name="text_area" id="id_text_area"
      placeholder="Enter multiple lines of text">
      </textarea>
</p>

Copy

Explain
Next, we’ll add some fields for specific data types: number, email, and date inputs. Add this all before the </form> tag:
<p>
    <label for="id_number_input">Number Input
      </label><br>
    <input id="id_number_input" type="number"
      name="number_input" value="" step="any"
      placeholder="A number">
</p>
<p>
    <label for="id_email_input">Email Input
      </label><br>
    <input id="id_email_input" type="email"
      name="email_input" value="" placeholder="Your
      email address">
</p>
<p>
    <label for="id_date_input">Date Input</label><br>
    <input id="id_date_input" type="date"
      name="date_input" value="2019-11-23">
</p>

Copy

Explain
We’ll now add some buttons to submit the form. Once again, insert this before the closing </form> tag:
<p>
    <input type="submit" name="submit_input"
      value="Submit Input">
</p>
<p>
    <button type="submit" name="button_element"
      value="Button Element">Button With<strong>
      Styled</strong> Text
    </button>
</p>

Copy

Explain
This will demonstrate two ways of creating submit buttons, either as an <input> or <button>.

Finally, we’ll add a hidden field. Insert this before the closing </form> tag:
<input type="hidden" name="hidden_input" value="Hidden
Value">

Copy

Explain
This field can’t be seen or edited, so it has a fixed value.

You can now save and close form-example.html.

As with any template, we can’t see it unless we have a view to render it. Open the form_example app’s views.py file and add a new view called form_example. It should render and return the template you just created, like so:
def form_example(request):
    return render(request, "form-example.html")

Copy

Explain
You can now save and close views.py.

You should be familiar with the next step now, which is to add a URL mapping to the view. Open the urls.py file in the form_project package directory. Add a mapping for the form-example path to your form_example view, to the urlpatterns variable. It should look like this:
path('form-example/', form_example.views.form_example)

Copy

Explain
Make sure you also add an import of form_example.views. Save and close urls.py.

Start the Django Dev Server (if it is not already running), then load your new view in your web browser; the address is http://127.0.0.1:8000/form-example/. Your page should look like this:
Figure 6.5: Example inputs page
Figure 6.5: Example inputs page

You can now familiarize yourself with the behavior of the web forms and see how they are generated from the HTML you specified. One activity to try is to enter invalid data into the number, date, or email inputs and click the submit button – the built-in HTML validation should prevent the form from being submitted:

Figure 6.6: Browser error due to an invalid number
Figure 6.6: Browser error due to an invalid number

We have not yet set up everything for form submission, so if you correct all the errors in the form and try to submit it (by clicking either of the submit buttons), you will receive an error stating CSRF verification failed, as we can see in the following figure. We will talk about what this means and how to fix it later in this chapter:

Figure 6.7: CSRF verification error
Figure 6.7: CSRF verification error

If you do receive an error, just go Back in your browser to return to the input example page.
In this exercise, you created an example page showcasing many HTML inputs, then created a view to render it and a URL to map to it. You loaded the page in your browser and experimented with changing data and trying to submit the form when it contained errors.

We just saw an example of Django’s CSRF protection. In the next section, we’ll learn what CSRF is and how Django’s protection works.

Form security with Cross-Site Request Forgery Protection
Throughout this book, we have mentioned features that Django includes to prevent certain types of security exploits. One of these features is protection against Cross-Site Request Forgery (CSRF).

The CSRF attack exploits the fact that a form on a website can be submitted to any other website. The action attribute of this form just needs to be set appropriately. Let’s look at an example for Bookr. We don’t have this set up yet, but we will be adding a view and a URL that allows us to post a review for a book. To do this, we’ll have a form for posting the review content and selecting the rating. Its HTML is like this:

<form method="post" action=
"http://127.0.0.1:8000/books/4/reviews/">
    <p>
        <label for="id_review_text">Your Review
          </label><br/>
        <textarea id="id_review_text" name="review_text"
          placeholder="Enter your review"></textarea>
    </p>
    <p>
        <label for="id_rating">Rating</label><br/>
        <input id="id_rating" type="number" name="rating"
          placeholder="Rating 1-5">
    </p>
    <p>
        <button type="submit">Create Review</button>
    </p
 </form>

Copy

Explain
And on a web page, it would look like this:

Figure 6.8: Example review create form
Figure 6.8: Example review create form

Someone could take this form, make a few changes, and host it on their website. For example, they could make the inputs hidden and hardcode a good review and rating for a book, and then make it look like some other kind of form, like this:

<form method="post"
action="http://127.0.0.1:8000/books/4/reviews/">
    <input type="hidden" name="review_text" value="This
      book is great!">
    <input type="hidden" name="rating" value="5">
    <p>
        <button type="submit">Enter My Website</button>
    </p>
</form>

Copy

Explain
Of course, the hidden fields don’t display, so the form looks like this on the malicious website:

Figure 6.9: Hidden inputs are not visible
Figure 6.9: Hidden inputs are not visible

The user would think they were clicking a button to enter a website, but while clicking it, they would submit the hidden values to the original view on Bookr. Of course, a user could check the source code of the page they were on to check what data is being sent and where, but most users are unlikely to inspect every form they come across. The attacker could even have the form with no submit button and just use JavaScript to submit it, which means the user would be submitting the form without even realizing it.

You may think that requiring the user to log in to Bookr will prevent this type of attack, and it does limit its effectiveness somewhat, as the attack would then only work for logged-in users. But because of the way authentication works, once a user is logged in, they have a cookie set in their browser that identifies them to the Django application. This cookie is sent on every request so that the user does not have to provide their login credentials on every page. Because of the way web browsers work, they will include the server’s authentication cookie in all requests they send to that particular server. Even though our form is hosted on a malicious site, ultimately, it is sending a request to our application, so it will send through our server’s cookies.

How can we prevent CSRF attacks? Django uses something called a CSRF token, which is a small random string that is unique to each site visitor – in general, you can consider a visitor to be one browser session. Different browsers on the same computer would be different visitors, and the same Django user logged in at two different browsers would also be different visitors. When the form is read, Django puts the token into the form as a hidden input. The CSRF token must be included in all POST requests being sent to Django, and it must match the token Django has stored on the server side for the visitor; otherwise, a 403 status HTTP response is returned. This protection can be disabled – either for the whole site or for an individual view – but it is not advisable to do so unless you need to. The CSRF token must be added into the HTML for every form being sent and is done with the {% csrf_token %} template tag. We’ll add it to our example review form now; the code in the template will look like this:

<form method="post" action=
"http://127.0.0.1:8000/books/4/reviews/">
    {% csrf_token %}
    <p>
        <label for="id_review_text">Your Review
          </label><br/>
        <textarea id="id_review_text" name="review_text"
          placeholder="Enter your review"></textarea>
    </p>
    <p>
        <label for="id_rating">Rating</label><br/>
        <input id="id_rating" type="number" name="rating"
          placeholder="Rating 1-5">
    </p>
    <p>
        <button type="submit">Enter My Website</button>
    </p>
</form>

Copy

Explain
When the template gets rendered, the template tag is interpolated, so the output HTML ends up like this (note that the inputs are still in the output – they have just been removed here for brevity):

<form method="post" action=
"http://127.0.0.1:8000/books/4/reviews/">
    <input type="hidden" name="csrfmiddlewaretoken"
      value="tETZjLDUXev1tiYqGCSbMQkhWiesHCnutxpt6mutHI6YH6
      4F0nin5k2JW3B68IeJ">
     …
</form>

Copy

Explain
Since this is a hidden field, the form on the page does not look any different from how it did before.

The CSRF token is unique to every visitor on the site. If an attacker were to copy the HTML from our site, they would get their own CSRF token, which would not match that of any other user, so Django would reject the form when it was posted by someone else.

CSRF tokens also change periodically. This limits how long the attacker would have to take advantage of a particular user and token combination. Even if they were able to get the CSRF token of a user that they were trying to exploit, they would have a short window of time to use it.

Now that you know what a CSRF token is used for, we will be adding it to our example form in the next exercise. Before we get to that, let’s have a quick refresh about accessing data in a request using QueryDict objects.

Accessing data in the View
As we discussed in Chapter 1, Django provides two QueryDict objects on the HTTPRequest instances that are passed to the view function. These are request.GET, which contains parameters passed in the URL, and request.POST, which contains parameters in the HTTP request body. Even though request.GET has GET in its name, this variable is populated even for non-GET HTTP requests. This is because the data it contains is parsed from the URL. Since all HTTP requests have a URL, all HTTP requests may contain GET data, even if they are POST or PUT, and so on.

In the next exercise, we will add code to our view to read and display the POST data.

Exercise 6.02 – working with POST data in a view
We will now add some code to our example view to print out the received POST data to the console. We will also insert the HTTP method that was used to generate the page, into the HTML output. This will allow us to be sure of what method was used to generate the page (GET or POST) and see how the form differs for each type:

First, in PyCharm, open the form_example app’s views.py file. Alter the form_example view so that it prints each value in the POST to the console by adding this code inside the function:
    for name in request.POST:
        print("{}: {}".format(name,
        request.POST.getlist(name)))

Copy

Explain
This code iterates over each key in the request POST data’s QueryDict and prints the key and list of values to the console. We already know that each QueryDict can have multiple values for a key, so we use the getlist function to get them all.

Pass the template’s request.method into a context variable named method. Do this by updating the call to render in the view so that it’s like this:
return render(request, "form-example.html", {"method":
request.method})

Copy

Explain
We will now display the method variable in the template. Open the form-example.html template and use a <h4> tag to show the method variable. Put this just after the opening <body> tag, like so:
<body>
    <h4>Method: {{ method }}</h4>

Copy

Explain
Note that we could access the method directly inside the template without passing it in a context dictionary, by using the request.method variable. We know from Chapter 3, URL Mapping, Views, and Templates, that by using the render shortcut function, the request is always available in the template. We just demonstrated how to access the method in the view here because later on, we will change the behavior of the page based on the method.

We also need to add the CSRF token to the form HTML. We do this by putting the {% csrf_token %} template tag after the opening <form> tag. The start of the form should look like this:
<form method="post">
    {% csrf_token %}

Copy

Explain
Now, save the file.

Start the Django Dev Server if it’s not already running. Load the example page (http://127.0.0.1:8000/form-example/) in your browser; you should see it now displays the method at the top of the page (GET):
Figure 6.10: Method at the top of the page
Figure 6.10: Method at the top of the page

Enter some text or data in each of the inputs and submit the form by clicking the Submit Input button:
Figure 6.11: Clicking the Submit Input to submit the form
Figure 6.11: Clicking the Submit Input to submit the form

You should see the page reload and the method display change to POST:

Figure 6.12: Method updated to POST after form submitted
Figure 6.12: Method updated to POST after form submitted

Switch back to PyCharm and look in the Run console at the bottom of the window. If the console is not visible, click the Run button at the bottom of the window to show it:
Figure 6.13: Clicking the Run button at the bottom of the window to display the console
Figure 6.13: Clicking the Run button at the bottom of the window to display the console

If you’re running the dev server in Debug mode, click Debug instead.

Inside the Run console, the list of the values that were posted to the server should be displayed:

Figure 6.14: Input values shown in the Run console
Figure 6.14: Input values shown in the Run console

Here are some things you should note:

All values are sent as text, even number and date inputs
For the select inputs, the selected value attributes of the selected options are sent, not the text content of the option tag.
If you select multiple options for books_you_own, then you will see multiple values in the request. This is why we use the getlist method since multiple values are sent for the same input name.
If the checkbox was checked, you will have a checkbox_on input in the debug output. If it was not checked, then the key will not exist at all (that is, there is no key instead of having the key existing with an empty string or None value).
We have a value for the submit_input name, which is the text Submit Input. You submitted the form by clicking the Submit Input button, so we receive its value. Notice that no value is set for the button_element input since that button was not clicked.
We will experiment with two other ways of submitting the form, first by pressing Enter on the keyboard when your cursor is in a text-like input (text, password, date, email, but not text area as pressing Enter will add a new line).
If you submit a form in this way, the form will act as though you had clicked the first submit button on the form, so the submit_input input value will be included. The output you see should match that of the previous figure.

The other way to submit the form is by clicking the button element submit input. We will try clicking this button to submit the form. You should see that submit_button is no longer in the list of posted values, while button_element is now present:

Figure 6.15: submit_button is now gone from the inputs, and button_element has been added
Figure 6.15: submit_button is now gone from the inputs, and button_element has been added

You can use this multiple-submit technique to alter how your view behaves, depending on which button was clicked. You can even have multiple submit buttons with the same name attribute to make the logic easier to write.

In this exercise, you added a CSRF token to your form element by using the {% csrf_token %} template tag. This means that your form can be submitted to Django successfully without it generating an HTTP Permission Denied response. We then added some code to output the values that our form contained when it was submitted. We tried submitting the form with various values to see how they are parsed into Python variables on the request.POST part of QueryDict. We will now discuss some more of the theory around the difference between GET and POST requests, then move on to the Django Forms library, which makes designing and validating forms easier.

Choosing between GET or POST
Choosing when to use a GET or POST request requires you to consider several factors. The most important is deciding whether the request should be idempotent. A request can be said to be idempotent if it can be repeated and produce the same result each time. Let’s look at some examples.

If you type in any web address into your browser (such as any of the Bookr pages we have built so far), it will do a GET request to fetch the information. You can refresh the page, and no matter how many times you click to refresh, you will get the same data back. The request you make does not affect the content on the server. We call these requests idempotent.

Now, remember when you added data through the Django admin interface (in Chapter 4). You typed the information for the new book into a form, then clicked Save. Your browser made a POST request to create a new book on the server. If you repeated that POST request, the server would create another Book and would do so each time you repeated the request. Since the request is updating information, it is not idempotent. Your browser will warn you about this. If you’ve ever tried to refresh a page that you were sent to after submitting a form, you may have received a message asking if you want to “Repost form data?” (or something more verbose, as shown in the following figure). This is a warning that you’re sending the form data again, which might cause the action you just undertook to be repeated:

Figure 6.16: Firefox confirming if information should be resent
Figure 6.16: Firefox confirming if information should be resent

This is not to suggest that all GET requests are idempotent and all POST requests are not – your backend application can be designed in any way you want. Although it is not best practice, a developer might have decided to make data get updated during a GET request in their web application. When you are building your applications, you should try to make sure GET requests are idempotent and leave data-altering to POST requests only. Stick to these principles unless you have a good reason not to.

Another point to consider is that Django only applies CSRF projection to POST requests. Any GET request, including one that alters data, can be accessed without a CSRF token.

Sometimes, it can be hard to decide if a request is idempotent or not – for example, a login form. Before you submitted your username and password, you were not logged in, and afterward, the server considered you to be logged in, so could we consider that non-idempotent as it changed your authentication status with the server? On the other hand, once logged in, if you were able to send your credentials again, you would remain logged in. This implies that the request is idempotent and repeatable. So, should the request be a GET or a POST? This brings us to the second point to consider when choosing what method to use: form data visibility.

If sending form data with a GET request, the form parameters will be visible in the URL. For example, if we made a login form using a GET request, the login URL might be https://www.example.com/login?username=user&password=password1. The username, and worse, the password, are visible in the web browser’s address bar. It would also be stored in the browser history, so anyone who used the browser after the real user could log in to the site. The URL is often stored in web server log files as well, meaning the credentials would be visible there too. In short, regardless of the idempotency of a request, don’t pass sensitive data through URL parameters.

Sometimes, knowing that the parameter will be visible in the URL might be something you desire. For example, when searching with a search engine, usually, the search parameter will be visible in the URL. To see this in action, try visiting https://www.google.com and searching for something. You’ll notice that the page with the results has your search term as the q parameter in the URL. For example, a search for “Django” will take you to the URL https://www.google.com/search?q=Django. This allows you to share search results with someone else by sending them this URL. In Activity 1, you will add a search form that passes a parameter similarly.

Another consideration is that the maximum length of a URL allowed by a browser can be short compared to the size of a POST body – sometimes, only around 2,000 characters (or about 2 KB) compared to many megabytes or gigabytes that a POST body can be (assuming your server is set up to allow these size requests).

As we mentioned earlier, URL parameters are available in request.GET, regardless of the type of request being made (GET, POST, PUT, and so on). You might find it useful to send some data in URL parameters and others in the request body (available in request.POST). For example, you could specify a format argument in the URL that sets what format some output data will be transformed to, but the input data is provided in the POST body.

Setting parameters in the GET query string might seem redundant when values can be passed as part of the URL path and then parsed by Django to route the URL. Next, we’ll look at some reasons why you might prefer using the query string.

Why use GET when we can put parameters in the URL mappings?
Django allows us to easily define URL maps that contain variables. We could, for example, set up a URL mapping for a search view like this:

path("/search/<str:search>/", reviews.views.search)

Copy

Explain
This probably looks like a good approach at first, but when we start wanting to customize the results view with arguments, it can get complicated quickly. For example, we might want to be able to move from one results page to the next, so we’ll add a page argument:

path("/search/<str:search>/<int:page>", reviews.views.search)

Copy

Explain
And then, we might also want to order the search results by a specific category, such as author name or date of publishing, so we’ll add another argument for that:

path("/search/<str:search>/<int:page>/<str:order >", reviews.views.search)

Copy

Explain
You might be able to see the problem with this approach – we can’t order the results without providing a page. If we wanted to add a results_per_page argument too, we wouldn’t be able to use that without setting a page and order key.

Contrast this to using query parameters – all of them are optional, so you could search like this:

?search=search+term:

Copy

Explain
Or you could set a page like this:

?search=search+term&page=2

Copy

Explain
Or just set the results ordering like this:

?search=search+term&order=author

Copy

Explain
Or you could combine them all:

?search=search+term&page=2&order=author

Copy

Explain
Another reason to use URL query parameters is that when submitting a form, the browser always sends the input values in this manner – it cannot be changed so that parameters are submitted as path components in the URL. Therefore, when submitting a form using GET, the URL query parameters must be used as the input data.

Now that we’ve introduced the fundamentals of forms in HTTP requests and HTML, let’s look at the Django Forms library, which makes dealing with forms and requests much easier.

The Django Forms library
We’ve looked at how to manually write forms in HTML and how to access the data on the request object using QueryDict. We saw that the browser provides some validation for us for certain field types (such as email or numbers), but we have not tried validating the data in the Python view. We should validate the form in the Python view for two reasons:

It is not safe to rely solely on browser-based validation of input data. A browser may not implement certain validation features, meaning the user could post any type of data. For example, older browsers don’t validate number fields, so a user can type in a number outside the range we are expecting. Further, a malicious user could try to send harmful data without using a browser at all. The browser validation should be considered a nicety for the user and that’s all.
The browser does not allow us to do cross-field validation. For example, we can use the required attribute for inputs that are mandatory to be filled in. Often, though, we want to set the required attribute based on the value of another input. For example, the email address input should only be set as required if the user has checked the Register My Email checkbox.
The Django Forms library allows you to quickly define a form using a Python class. This is done by creating a subclass of the base Django Form class. You can then use an instance of this class to render the form in your template and validate the input data. We refer to our classes as forms, similar to how we subclass Django Models to create Model classes. Forms contain one or more fields of a certain type (such as text fields, number fields, or email fields). You’ll notice this sounds like Django Models, and forms are similar to Models but use different field classes. You can even automatically create a form from a Model – we will cover this in Chapter 7.

Defining a form
Creating a Django form is similar to creating a Django model: you define a class that inherits from the django.forms.Form class. The class has attributes that are instances of different django.forms.Field subclasses. When rendered, the attribute name in the class corresponds to its input name in HTML. To give you a quick idea of what fields there are, some examples are CharField, IntegerField, BooleanField, ChoiceField, and DateField. Each field generally corresponds to one input when rendered in HTML, but there’s not always a one-to-one mapping between a form field class and an input type. Form fields are more coupled to the type of data they collect rather than how they are displayed.

To illustrate this, consider a text input and a password input. They both accept some typed-in text data, but the main difference between them is that the text is displayed in a text input whereas, with a password input, the text is obscured. In a Django form, both of these fields are represented using a CharField. Their difference in how they are displayed is set by changing the widget the field is using.

Note

If you’re not familiar with the word widget, it’s a term to describe the actual input that is being interacted with and how it is displayed. Text inputs, password inputs, select menus, checkboxes, and buttons are all examples of different widgets. The inputs we have seen in HTML correspond one-to-one with widgets. In Django, this is not the case, and the same type of Field class can be rendered in multiple ways, depending on the widget that is specified.

Django defines several widget classes that define how a field should be rendered as HTML. They inherit from django.forms.widgets.Widget. A widget can be passed to the Field constructor to change how it is rendered. For example, a CharField renders as a text <input> by default. If we use the PasswordInput widget, it will instead render as a password <input>. The other widgets we will use are as follows:

RadioSelect, which renders a ChoiceField as radio buttons instead of a <select> menu
Textarea, which renders a CharField as a <textarea>
HiddenInput, which renders a field as a hidden <input>
We’ll look at an example form and add fields and features one by one. First, let’s just create a form with a text input and a password input:

from django import forms
class ExampleForm(forms.Form):
    text_input = forms.CharField()
    password_input =
        forms.CharField(widget=forms.PasswordInput)

Copy

Explain
The widget argument can be just a widget subclass, which can be fine a lot of the time. If you want to further customize the display of the input and its attributes, you can set the widget argument to an instance of the widget class instead. We will look at customizing the widget displays further soon. In this case, we’re using just the PasswordInput class, since we are not customizing beyond changing the type of input being displayed.

When the form is rendered in a template, it looks like this:

Figure 6.17: Django form rendered in the browser
Figure 6.17: Django form rendered in the browser

Note that the inputs do not contain any content when the page loads; the text has been entered to illustrate the different input types.

If we examine the page source, we will see the HTML that Django generates. For the first two fields, it looks like this (some spacing has been added for readability):

<p>
    <label for="id_text_input">Text input:</label>
    <input type="text" name="text_input" required
      id="id_text_input">
</p>
<p>
    <label for="id_password_input">Password input:</label>
    <input type="password" name="password_input" required
      id="id_password_input">
</p>

Copy

Explain
Notice that Django has automatically generated a label with text derived from the field name. The name and id attributes have been set automatically. Django also automatically adds the required attribute to the input. Similar to model fields, form field constructors also accept a required argument – this defaults to True. Setting this to False removes the required attribute from the generated HTML.

Next, we’ll look at how a checkbox is added to the form.

A checkbox is represented with a BooleanField as it can have only two values: checked or unchecked. It’s added to the form in the same way as the other field:

class ExampleForm(forms.Form):
    …
    checkbox_on = forms.BooleanField()

Copy

Explain
The HTML Django generates for this new field is similar to the previous two fields:

<label for="id_checkbox_on">Checkbox on:</label>
<input type="checkbox" name="checkbox_on" required
  id="id_checkbox_on">

Copy

Explain
Next are select inputs:

We need to provide a list of choices to display in the <select> dropdown.
The field class constructor takes a choices argument. The choices are provided as a tuple of two-element tuples. The first element in each sub-tuple is the value of the choice, while the second element is the text or description of the choice. For example, choices could be defined like this:
BOOK_CHOICES = (
    ("1", "Deep Learning with Keras"),
    ("2", "Web Development with Django"),
    ("3", "Brave New World"),
    ("4", "The Great Gatsby")
)

Copy

Explain
Note that you can use lists instead of tuples if you want (or a combination of the two). This can be useful if you want your choices to be mutable:

BOOK_CHOICES = (
    ["1", "Deep Learning with Keras"],
    ["2", "Web Development with Django"],
    ["3", "Brave New World"],
    ["4", "The Great Gatsby"]
]

Copy

Explain
To implement an optgroup, we can nest the choices. To implement the choices as we did in our previous examples, we can use a structure like this:
BOOK_CHOICES = (
    (
        "Non-Fiction", (
            ("1", "Deep Learning with Keras"),
            ("2", "Web Development with Django")
        )
    ),
    (
        "Fiction", (
            ("3", "Brave New World"),
            ("4", "The Great Gatsby")
        )
    )
)

Copy

Explain
The select is added to the form by using a ChoiceField. The widget defaults to a select input so that no configuration is necessary apart from setting choices:

class ExampleForm(forms.Form):
    …
    favorite_book =
        forms.ChoiceField(choices=BOOK_CHOICES)

Copy

Explain
This is the HTML that is generated:

<label for="id_favorite_book">Favorite book:</label>
<select name="favorite_book" id="id_favorite_book">
    <optgroup label="Non-Fiction">
        <option value="1">Deep Learning with Keras
          </option>
        <option value="2">Web Development with Django
          </option>
    </optgroup>
    <optgroup label="Fiction">
        <option value="3">Brave New World</option>
        <option value="4">The Great Gatsby</option>
    </optgroup>
</select>

Copy

Explain
Making a multiple select requires the use of MultipleChoiceField. It takes a choices argument in the same format as the regular ChoiceField for single selects:
class ExampleForm(forms.Form):
    …
    books_you_own =
       forms.MultipleChoiceField(choices=BOOK_CHOICES)

Copy

Explain
And its HTML is similar to that of the single select, except it has the multiple attribute added:

<label for="id_books_you_own">Books you own:</label>
<select name="books_you_own" required
id="id_books_you_own" multiple>
    <optgroup label="Non-Fiction">
        <option value="1">Deep Learning with Keras
          </option>
        <option value="2">Web Development with Django
          </option>
    </optgroup>
    <optgroup label="Fiction">
        <option value="3">Brave New World</option>
        <option value="4">The Great Gatsby</option>
    </optgroup>
</select>

Copy

Explain
Choices can also be set after the form has been instantiated. You may want to generate the list/tuple choice inside your view dynamically and then assign it to the field’s choices attribute, like so:
form = ExampleForm()
form.fields["books_you_own"].choices = [("1", "Deep
Learning with Keras"), …]

Copy

Explain
Next are radio inputs, which are similar to selects:

Like selects, radio inputs use ChoiceField, as they provide a single choice between multiple options.
The options to choose between are passed into the field constructor with the choices argument.
The choices are provided as a tuple of two-element tuples, also like selects:
choices = (
    ("1", "Option One"),
    ("2", "Option Two"),
    ("3", "Option Three")
)

Copy

Explain
ChoiceField defaults to displaying as a select input, so the widget must be set to RadioSelect to have it render as radio buttons. Putting the choice setting together with this, we can add radio buttons to the form like this:
RADIO_CHOICES = (
    ("Value One", "Value One"),
    ("Value Two", "Value Two"),
    ("Value Three", "Value Three")
)
class ExampleForm(forms.Form):
    …
    radio_input =
        forms.ChoiceField(choices=RADIO_CHOICES,
        widget=forms.RadioSelect)

Copy

Explain
Here is the HTML that is generated:

<label for="id_radio_input_0">Radio input:</label>
<ul id="id_radio_input">
<li>
    <label for="id_radio_input_0">
        <input type="radio" name="radio_input"
          value="Value One" required
          id="id_radio_input_0">
        Value One
    </label>
</li>
<li>
    <label for="id_radio_input_1">
        <input type="radio" name="radio_input"
          value="Value Two" required
          id="id_radio_input_1">
        Value Two
    </label>
</li>
<li>
    <label for="id_radio_input_2">
        <input type="radio" name="radio_input"
          value="Value Three" required
          id="id_radio_input_2">
        Value Three
    </label>
</li>
</ul>

Copy

Explain
Django automatically generates a unique label and ID for each of the three radio buttons.

To create a textarea, use a CharField with a Textarea widget:
class ExampleForm(forms.Form):
    …
    text_area = forms.CharField(widget=forms.Textarea)

Copy

Explain
You might notice that this textarea is much larger than the previous ones we have seen (see the following figure):

Figure 6.18: Normal textarea (top) versus Django default textarea (bottom)
Figure 6.18: Normal textarea (top) versus Django default textarea (bottom)

This is because Django automatically adds cols and rows attributes. These set the number of columns and rows that the text field displays, respectively:

<label for="id_text_area">Text area:</label>
<textarea name="text_area" cols="40" rows="10"
required id="id_text_area"></textarea>

Copy

Explain
Note that the cols and rows settings do not affect the amount of text that can be entered into a field, only the amount that is displayed at a time. Also, note that the size of textarea can be set using CSS (for example, the height and width properties). This will override the cols and rows settings.
To create number inputs, you might expect Django to have a NumberField type, but it does not.

Remember that the Django form fields are data-centric rather than display-centric, so instead, Django provides different Field classes, depending on what type of numeric data you want to store.
For integers, use an IntegerField.
For floating point numbers, use FloatField or DecimalField. The latter two differ in how they convert their data into a Python value.
FloatField will convert into a float, while a DecimalField is a decimal.
Decimal values offer better accuracy in representing numbers than float values but may not integrate well into your existing Python code.
We’ll add all three fields to the form at once:

class ExampleForm(forms.Form):
    …
    integer_input = forms.IntegerField()
    float_input = forms.FloatField()
    decimal_input = forms.DecimalField()

Copy

Explain
Here’s the HTML for all three:

<p>
    <label for="id_integer_input">Integer input:</label>
    <input type="number" name="integer_input" required
      id="id_integer_input">
</p>
<p>
    <label for="id_float_input">Float input:</label>
    <input type="number" name="float_input" step="any"
      required id="id_float_input">
</p>
<p>
    <label for="id_decimal_input">Decimal input:</label>
    <input type="number" name="decimal_input" step="any"
      required id="id_decimal_input">
</p>

Copy

Explain
The IntegerField’s generated HTML is missing the step attribute that the other two have, which means the widget will only accept integer values.
The other two fields (FloatField and DecimalField) generate very similar HTML, their behavior is the same in the browser, and they differ only when their values are used in Django code.
As you might have guessed, an email input can be created with an EmailField:

class ExampleForm(forms.Form):
    …
    email_input = forms.EmailField()

Copy

Explain
Its HTML is similar to the email input we created manually:

<label for="id_email_input">Email input:</label>
<input type="email" name="email_input" required
id="id_email_input">

Copy

Explain
Continuing with our manually created form, the next field we will look at is DateField:

By default, Django will render a DateField as a text input, and the browser will not show a calendar popup when the field is clicked on
We can add DateField to the form with no arguments, like this:

class ExampleForm(forms.Form):
    …
    date_input = forms.DateField()

Copy

Explain
When rendered, it just looks like a normal text input:

Figure 6.19: Default DateField display in the form
Figure 6.19: Default DateField display in the form

Here is the HTML generated by default:

<label for="id_date_input">Date input:</label>
<input type="text" name="date_input" required
id="id_date_input">

Copy

Explain
The reason for using a text input is that it allows the user to enter the date in several different formats. For example, by default, the user can type in the date in Year-Month-Day (dash-separated) or Month/Day/Year (slash-separated) formats.

The accepted formats can be specified by passing a list of formats to the DateField constructor using the input_formats argument. For example, we could accept dates in the Day/Month/Year or Day/Month/Year-with-century format, like this:

DateField(input_formats = ["%d/m/%y", "%d/%m/%Y"])

Copy

Explain
We can override any attributes on a field’s widget by passing the attrs argument to the widget constructor. This accepts a dictionary of attribute keys/values that will be rendered into the input’s HTML.

We have not used this yet, but we will see it again in the next chapter when we customize the field rendering further. For now, we’ll just set one attribute, type, that will overwrite the default input type:

class ExampleForm(forms.Form):
    …
    date_input =
    forms.DateField(widget=forms.DateInput(attrs={"type":
    "date"}))

Copy

Explain
When rendered, it now looks like the date field we had before, and clicking on it brings up the calendar date picker:

Figure 6.20: DateField with date input
Figure 6.20: DateField with date input

Examining the generated HTML now, we can see it uses the date type:

<label for="id_date_input">Date input:</label>
<input type="date" name="date_input" required
id="id_date_input">

Copy

Explain
The final input that we are missing is the hidden input:

Once again, due to the data-centric nature of Django forms, there is no HiddenField.
Instead, we choose the type of field that needs to be hidden and set its widget to a HiddenInput. We can then set the value of the field using the field constructor’s initial argument:
class ExampleForm(forms.Form):
    …
    hidden_input =
    forms.CharField(widget=forms.HiddenInput,
    initial="Hidden Value")

Copy

Explain
Here is the generated HTML:

<input type="hidden" name="hidden_input" value="Hidden
Value" id="id_hidden_input">

Copy

Explain
Note that as this is a hidden input, Django does not generate a label or surrounding p elements.
There are other form fields that Django provides that work in similar ways. These range from DateTimeField (for capturing a date and a time), to GenericIPAddressField (for either IPv4 or IPv6 addresses) and URLField (for URLs). A full list of fields is available at https://docs.djangoproject.com/en/4.0/ref/forms/fields/.

Rendering a form in a template
We’ve now seen how to create a form and add fields, and we’ve seen what the form looks like and what HTML is generated. But how is the form rendered in the template? We simply instantiate the form class and pass it to the render function in a view, using the context, just like any other variable.

For example, here’s how we can pass our ExampleForm to a template:

def view_function(request):
    form = ExampleForm()
    return render(request, "template.html", {"form": form})

Copy

Explain
Django does not add the <form> element or submit button(s) for you when rendering the template; you should add these around where your form is placed in the template. The form can be rendered like any other variable.

We mentioned briefly earlier that the form was being rendered in the template using the as_p method. This layout method was chosen as it most closely matches the example form we built manually. Django offers three layout methods that can be used:

as_table
The form is rendered as table rows, with each input on its own row. Django does not generate the surrounding table element, so you should wrap the form yourself; for example:

<form method="post">
    <table>
        {{ form.as_table }}
    </table>
</form>

Copy

Explain
as_table is the default rendering method, so {{ form.as_table }} and {{ form }} are equivalent.

When rendered, the form looks like this:

Figure 6.21: Form rendered as a table
Figure 6.21: Form rendered as a table

Here is a small sample of HTML that is generated:

<tr>
    <th>
        <label for="id_text_input">Text input:</label>
    </th>
    <td>
        <input type="text" name="text_input" required
          id="id_text_input">
    </td>
</tr>
<tr>
    <th>
        <label for="id_password_input">Password input:
          </label>
    </th>
    <td>
        <input type="password" name="password_input"
          required id="id_password_input">
    </td>
</tr>

Copy

Explain
as_ul
This renders the form fields as list items (li) inside either a ul or ol element. Like with as_table, the containing element (<ul> or <ol>) is not created by Django and must be added by you:

<form method="post">
    <ul>
        {{ form.as_ul }}
    </ul>
</form>

Copy

Explain
Here’s how the form renders using as_ul:

Figure 6.22: Form rendered using as_ul
Figure 6.22: Form rendered using as_ul

And here’s a sample of the generated HTML:

<li>
    <label for="id_text_input">Text input:</label>
    <input type="text" name="text_input" required
      id="id_text_input">
</li>
<li>
    <label for="id_password_input">Password input:
      </label>
    <input type="password" name="password_input"
      required id="id_password_input">
</li>

Copy

Explain
as_p
Finally, there’s the as_p method, which we used in our previous examples. Each input is wrapped within p tags, which means that you don’t have to wrap the form manually (in a <table> or <ul>) as you did with the previous methods:

<form method="post">
    {{ form.as_p }}
</form>

Copy

Explain
Here’s what the rendered form looks like:

Figure 6.23: Form rendered using as_p
Figure 6.23: Form rendered using as_p

You’ve seen this before, but once again, here’s a sample of the HTML generated:

<p>
    <label for="id_text_input">Text input:</label>
    <input type="text" name="text_input" required
      id="id_text_input">
</p>
<p>
    <label for="id_password_input">Password input:
      </label>
    <input type="password" name="password_input"
      required id="id_password_input">
</p>

Copy

Explain
It is up to you to decide which method you want to use to render your form, depending on which suits your application best. In terms of their behavior and use in your view, they are all identical. In Chapter 15, we will also introduce a method of rendering forms that will make use of the Bootstrap CSS classes.

Now that you have been introduced to Django forms, we can update our example form page to use a Django form instead of manually writing all HTML. We’ll do this in the next exercise by replacing hand-written HTML with a Django form.

Exercise 6.03 – building and rendering a Django form
In this exercise, you will build a Django form using all the fields we have seen. The form and view will behave similarly to the form built manually; however, you will be able to see how much less code is required when writing forms using Django. Your form will also automatically get field validation, and if we make changes to the form, we don’t have to then make changes to the HTML as it will update dynamically based on the form definition:

In PyCharm, create a new file called forms.py inside the form_example app directory.
Import the Django forms library at the top of your forms.py file:
from django import forms

Copy

Explain
Define the choices for the radio buttons by creating a RADIO_CHOICES variable. Populate it as follows:
RADIO_CHOICES = (
    ("Value One", "Value One Display"),
    ("Value Two", "Text For Value Two"),
    ("Value Three", "Value Three's Display Text")
)

Copy

Explain
You will use this soon when you create a ChoiceField called radio_input.

Define the nested choices for the book and select inputs by creating a BOOK_CHOICES variable. Populate it as follows:
BOOK_CHOICES = (
    (
        "Non-Fiction", (
            ("1", "Deep Learning with Keras"),
            ("2", "Web Development with Django")
        )
    ),
    (
        "Fiction", (
            ("3", "Brave New World"),
            ("4", "The Great Gatsby")
        )
    )
)

Copy

Explain
Create a class called ExampleForm, which inherits from the forms.Form class:
class ExampleForm(forms.Form):

Copy

Explain
Add the following fields as attributes to the class:

    text_input = forms.CharField()
    password_input =
        forms.CharField(widget=forms.PasswordInput)
    checkbox_on = forms.BooleanField()
    radio_input =
        forms.ChoiceField(choices=RADIO_CHOICES,
        widget=forms.RadioSelect)
    favorite_book =
        forms.ChoiceField(choices=BOOK_CHOICES)
    books_you_own =
        forms.MultipleChoiceField(choices=BOOK_CHOICES
        )
    text_area = forms.CharField(widget=forms.Textarea)
    integer_input = forms.IntegerField()
    float_input = forms.FloatField()
    decimal_input = forms.DecimalField()
    email_input = forms.EmailField()
    date_input =
        forms.DateField(widget=forms.DateInput(attrs=
        "type": "date"}))
    hidden_input =
        forms.CharField(widget=forms.HiddenInput,
        initial="Hidden Value")

Copy

Explain
Save the file.

Open your form_example app’s views.py file. At the top of the file, add a line to import ExampleForm from your forms.py file:
from .forms import ExampleForm

Copy

Explain
Inside the form_example view, instantiate the ExampleForm class and assign it to the form variable:
    form = ExampleForm()

Copy

Explain
Add the form variable to the context dictionary using the form key. The return line should look like this:
    return render(request, "form-example.html",
    {"method": request.method, "form": form})

Copy

Explain
Save the file.

Make sure you haven’t removed the code that prints out the data the form has sent, as we will use it again later in this exercise.

Open the form-example.html file inside the form_example app’s templates directory. You can remove nearly all of the contents of the form element, except the {% csrf_token %} template tag and the submit buttons. When you’re done, it should look like this:
<form method="post">
    {% csrf_token %}
    <p>
        <input type="submit" name="submit_input"
          value="Submit Input">
    </p>
    <p>
        <button type="submit" name="button_element"
          value="Button Element">
          Button With <strong>Styled</strong> Text
        </button>
    </p>
</form>

Copy

Explain
Add a rendering of the form variable using the as_p method. Put this on the line after the {% csrf_token %} template tag. The whole form element should now look like this:
<form method="post">
    {% csrf_token %}
    {{ form.as_p }}
    <p>
        <input type="submit" name="submit_input"
          value="Submit Input">
    </p>
    <p>
        <button type="submit" name="button_element"
          value="Button Element">
          Button With <strong>Styled</strong> Text
        </button>
    </p>
</form>

Copy

Explain
Start the Django Dev Server if it is not already running, then visit the form example page in your browser, at http://127.0.0.1:8000/form-example/. It should look as follows:
Figure 6.24: Django ExampleForm rendered in the browser
Figure 6.24: Django ExampleForm rendered in the browser

Enter some data into the form – since Django marks all fields as required, you will need to enter some text or select values for all fields, including ensuring that the checkbox is checked. Submit the form.
Switch back to PyCharm and look in the Debug Console at the bottom of the window. You should see that all the values being submitted by the form are printed out to the console, similar to in Exercise 6.02:
Figure 6.25: Values as submitted by the Django form
Figure 6.25: Values as submitted by the Django form

You can see that the values are still strings, and the names match those of the attributes of the ExampleForm class. Notice that the submit button that you clicked is included, as well as the CSRF token. The form you submit can be a mix of Django form fields and arbitrary fields you add; both will be contained in the request.POST QueryDict object.

In this exercise, you created a Django form with many different types of form fields. You instantiated it into a variable in your view, then passed it to form-example.html, where it was rendered as HTML. Finally, you submitted the form and looked at the values it posted. Notice that the amount of code we had to write to generate the same form was greatly reduced. We did not have to manually code any HTML, and we now have one place that defines how the form will display and how it will validate.

In the next section, we will examine how Django forms can automatically validate the submitted data, as well as how the data is converted from strings into Python objects.

Validating forms and retrieving Python values
So far, we have seen how Django forms make it much simpler to define a form using Python code and have it automatically rendered. We will now look at the other part of what makes Django forms useful: their ability to automatically validate the form and then retrieve native Python objects and values from them.

In Django, a form can either be unbound or bound. These terms describe whether or not the form has had the submitted POST data sent to it for validation. So far, we have only seen unbound forms – they are instantiated without arguments, like this:

form = ExampleForm()

Copy

Explain
A form is bound if it is called with some data to be used for validation, such as the POST data. A bound form can be created like this:

form = ExampleForm(request.POST)

Copy

Explain
A bound form allows us to start using built-in validation-related tools on the form instance. First, there’s the is_valid method, which checks the form validity, then the cleaned_data attribute, which contains the values converted from strings into Python objects. The cleaned_data attribute is only available after the form has been cleaned, which is the process of cleaning up the data and converting it from strings into Python objects. The cleaning process runs during the is_valid call. An AttributeError will be raised if you try to access cleaned_data before calling is_valid.

A short example of how to access the cleaned data of ExampleForm looks like this:

form = ExampleForm(request.POST)
if form.is_valid(): # cleaned_data is only populated if the
                      form is valid
    if form.cleaned_data["integer_input"] > 5:
        do_something()

Copy

Explain
In this example, form.cleaned_data["integer_input"] is the integer value 10, so it can be compared to the number 5. Compare this to the value that was posted, which is the string 10. The cleaning process performs this conversion for us. Other fields such as dates or Booleans are converted accordingly.

The cleaning process also sets any errors on the form and fields, which will be displayed when the form is rendered again. Let’s see all this in action. Modern browsers provide a large amount of client-side validation, so they prevent forms from being submitted unless their basic validation rules are met. You might have already seen this if you tried to submit the form in the previous exercise with empty fields:

Figure 6.26: Form submission prevented by the browser
Figure 6.26: Form submission prevented by the browser

Figure 6.26 shows the browser preventing form submission. Since the browser is preventing the submission, Django never gets the opportunity to validate the form itself. To allow the form to be submitted, we need to add some more advanced validation that the browser is unable to validate itself. We will discuss the different types of validations that can be applied to form fields in the next section, but for now, we will just add a max_digits setting of 3 to decimal_input of our ExampleForm. This means the user should not enter more than three digits in the form.

Note

Why should Django validate the form if the browser is already doing this and preventing submission? A server-side application should never trust input from the user: the user might be using an older browser or other HTTP clients to send the request, thus not receiving any errors from their browser. Also, as we have just mentioned, there are types of validation that the browser does not understand, so Django must validate these on its end.

ExampleForm can be updated like this:

class ExampleForm(forms.Form):
    …
    decimal_input = forms.DecimalField(max_digits=3)
    …

Copy

Explain
Now, the view should be updated to pass request.POST to the form class when the method is POST, for example, like this:

if request.method == "POST":
    form = ExampleForm(request.POST)
else:
    form = ExampleForm()

Copy

Explain
If you pass request.POST into the form constructor when the method is not POST, then the form will always contain errors when first rendered as request.POST will be empty.

Now, the browser will let us submit the form, but we will get an error displayed if decimal_input contains more than three digits:

Figure 6.27: An error displayed when a field is not valid
Figure 6.27: An error displayed when a field is not valid

Django automatically renders the form differently in the template when it has errors. But how can we make the view behave differently depending on the validity of the form? As we mentioned earlier, we should use the form’s is_valid method. A view using this check might contain code like this:

form = ExampleForm(request.POST)
if form.is_valid():
    # perform operations from with data from
      form.cleaned_data
    return redirect("/success-page")  # redirect to a
    success page

Copy

Explain
In this example, we are redirecting to a success page if the form is valid. Otherwise, we assume the execution flow continues as before and pass the invalid form back to the render function to be displayed to the user with errors.

Note

Why do we return a redirect on success? For two reasons: first, an early return prevents the execution of the rest of the view (that is, the failure branch); second, it prevents the message about resending the form data if the user then reloads the page.

In the next exercise, we will see the form validation in action and change the view’s execution flow based on the validity of the form.

Exercise 6.04 – validating forms in a view
In this exercise, we will update the example view to instantiate the form differently depending on the HTTP method. We will also change the form so that it prints out the cleaned data instead of the raw POST data, but only if the form is valid:

In PyCharm, open the forms.py file inside the form_example app directory. Add a max_digits=3 argument to the ExampleForm’s decimal_input:
class ExampleForm(forms.Form):
    …
    decimal_input = forms.DecimalField(max_digits=3)

Copy

Explain
Once this argument has been added, we can submit the form since the browser does not know how to validate this rule, but Django does.

Open the reviews app’s views.py file. We need to update the form_example view so that if the request’s method is POST, ExampleForm is instantiated with the POST data; otherwise, it’s instantiated without arguments. Replace the current form initialization with this code:
def form_example(request):
    if request.method == "POST":
        form = ExampleForm(request.POST)
    else:
        form = ExampleForm()

Copy

Explain
Next, also for the POST request method, we will check if the form is valid using the is_valid method. If the form is valid, we will print out all the cleaned data. Add a condition after the ExampleForm instantiation to check form.is_valid(), then move the debug print loop inside this condition. Your POST branch should look like this:
    if request.method == "POST":
        form = ExampleForm(request.POST)
        if form.is_valid():
            for name in request.POST:
                print("{}: {}".format(name,
                request.POST.getlist(name)))

Copy

Explain
Instead of iterating over the raw request.POST QueryDict (in which all the data is strings), we will iterate over the form’s cleaned_data. This is a normal dictionary and contains the values converted into Python objects. Replace the for line and print line with these two:
            for name, value in
            form.cleaned_data.items():
                print("{}: ({}) {}".format(name,
                type(value), value))

Copy

Explain
We don’t need to use getlist() anymore since cleaned_data has already converted multi-value fields into lists.

Start the Django Dev Server, if it’s not already running. Switch to your browser and browse to the example form page at http://127.0.0.1:8000/form-example/. The form should look as it did before. Fill in all the fields, but make sure that you enter four or more numbers into the Decimal input field to make the form invalid. Submit the form; you should see the error message for the Decimal input field show up when the page refreshes:
Figure 6.28: Decimal Input error displayed after the form is submitted
Figure 6.28: Decimal Input error displayed after the form is submitted

Fix the form errors by making sure only three digits are in the Decimal input field, then submit the form again. Switch back to PyCharm and check the Debug Console. You should see that all the cleaned data has been printed out:
Figure 6.29: The cleaned data from the form has been printed out
Figure 6.29: The cleaned data from the form has been printed out

Notice the conversions that have taken place. The CharFields have been converted into str, BooleanField into bool, and IntegerField, FloatField, and DecimalField to int, float, and Decimal, respectively. DateField becomes a datetime.date and the choice fields will retain the string values of their initial choice values. Notice that books_you_own is automatically converted into a list of str.

Also, note that unlike when we iterated over all of the POST data, cleaned_data only contains form fields. The other data (such as the CSRF token and the submit button that was clicked) is present in the POST’s QueryDict but is not included as they are not form fields.

In this exercise, you updated ExampleForm so that the browser allowed it to be submitted even though Django would consider it to be invalid. This allowed Django to perform its validation on the form. You then updated the form_example view to instantiate the ExampleForm class differently, depending on the HTTP method, passing in the request’s POST data for a POST request. The view also had its debug output code updated to print out the cleaned_data dictionary. Finally, you tested submitting valid and invalid form data to see the different execution paths and the types of data that the form generated. We saw that Django automatically converted the POST data from strings into Python types based on the field class.

Next, we will look at how to add more validation options to fields, which will allow us to more tightly control the values that can be entered.

Built-in field validation
We have not yet discussed the standard validation arguments that can be used on fields. Although we already mentioned the required argument (which is True by default), many others can be used to control the data being entered into a field more tightly. Here are a few useful ones:

max_length
Sets the maximum number of characters that can be entered into the field, available on a CharField (and FileField – which we will cover in Chapter 8).

min_length
Sets the minimum number of characters that must be entered into the field, available on CharField (and FileField – again, more about it in Chapter 8).

max_value
Sets the maximum value that can be entered into a numeric field, available on IntegerField, FloatField, and DecimalField.

min_value
Sets the minimum value that can be entered into a numeric field, available on IntegerField, FloatField, and DecimalField.

max_digits
This sets the maximum number of digits that can be entered. This includes before and after a decimal point (if one exists). For example, the number 12.34 has four digits, while the number 56.7 has three. This is used in a DecimalField.

decimal_places
This sets the maximum number of digits that can be after the decimal point. This is used in conjunction with max_digits, and the number of decimal places will always count toward the number of digits, even if that number of decimals has not been entered after the decimal place. For example, using max_digits of four and decimal_places of three: if the number 12.34 was entered, it would be interpreted as the value 12.340 – that is, zeroes are appended until the number of digits after the decimal point is equal to the decimal_places setting. Since we set three as the value for decimal_places, the total number of digits ends up being five, which exceeds the max_digits setting of four. The number 1.2 would be valid since even after expanding to 1.200, the total number of digits is only four.

You can mix and match the validation rules (provided the fields support them). CharField can have a max_length and a min_length; numeric fields can have both a min_value and max_value, and so on.

If you need more validation options, you can write custom validators, which we will cover in the next section. Right now, we will add some validators to our ExampleForm to see them in action.

Exercise 6.05 – adding extra field validation
In this exercise, we will add and modify the validation rules on the fields of ExampleForm. We will then see how these changes affect how the form behaves, both in the browser and when Django validates the form:

In PyCharm, open the forms.py file inside the form_example app directory.
We will make text_input require at most three characters. Add a max_length=3 argument to the CharField constructor:
text_input = forms.CharField(max_length=3)

Copy

Explain
Make password_input more secure by requiring a minimum of eight characters. Add a min_length=8 argument to the CharField constructor:
password_input = forms.CharField(min_length=8,
widget=forms.PasswordInput)

Copy

Explain
The user may have no books, so the books_you_own field should not be required. Add a required=False argument to the MultipleChoiceField constructor:
books_you_own =
forms.MultipleChoiceField(required=False,
choices=BOOK_CHOICES)

Copy

Explain
The user should only be able to enter a value between 1 and 10 in integer_input. Add min_value=1 and max_value=10 arguments to the IntegerField constructor:
integer_input = forms.IntegerField(min_value=1,
max_value=10)

Copy

Explain
Finally, add max_digits=5 and decimal_places=3 to the DecimalField constructor:
decimal_input = forms.DecimalField(max_digits=5,
decimal_places=3)

Copy

Explain
Save the file.

Start the Django Dev Server if it’s not already running. We do not have to make any changes to any other files to get these new validation rules since Django automatically updates the HTML generation and validation logic. This is a great benefit you get from using Django Forms. Just visit or refresh http://127.0.0.1:8000/form-example/ in your browser and the new validation will be automatically added. The form should not look any different until you try to submit it with incorrect values, in which case your browser can automatically show errors. Some things to try are as follows:
Enter more than three characters into the Text input field is something you will not be able to do.
Type less than eight characters into the password field and then clicking away from it might cause your browser to show an error indicating that this is not valid (only some browsers support this).
Do not select any values for the Books you own field. This will not prevent you from submitting the form anymore.
Use the stepper buttons on Integer input. You will only be able to enter a value between 1 and 10. If you type in a value outside this range, your browser should show an error.
Decimal input is the only field that does not validate the Django rules in the browser. You will need to type in an invalid value (such as 123.456) and submit the form before an error (generated by Django) is displayed.
The following figure shows some of the fields that the browser can use to validate itself:

Figure 6.30: Some browsers highlight invalid fields
Figure 6.30: Some browsers highlight invalid fields

Figure 6.31 shows an alternate way that validation errors might be presented by the browser – by placing an error message next to a particular field on form submit:

Figure 6.31: Browsers might show messages next to fields on submit
Figure 6.31: Browsers might show messages next to fields on submit

Figure 6.32 shows an error that can only be generated by Django as the browser does not understand the DecimalField validation rules:

Figure 6.32: The browser considers the form valid, but Django does not
Figure 6.32: The browser considers the form valid, but Django does not

In this exercise, we implemented some basic validation rules on our form fields. We then loaded the form example page in the browser without having to make any changes to our template or view. We tried to submit the form with different values to check how the browser can validate the form compared to Django.

In the activity for this chapter, we will implement the Book Search view using a Django Form.

Activity 1 – Book Search
In this activity, you will finish the Book Search view that was started in Chapter 1. You will build a SearchForm that submits and accepts a search string from request.GET. It will have a select field to choose to search for a title or contributor. It will then search for all books containing the given text in their title or contributor’s first_names or last_names. You will then render this list of books in the search-results.html template. The search term should not be required, but if it exists, it should have a length of more than three characters. Since the view will search even when using the GET method, the form will always have its validation checked. If we made the field required, it would always show an error whenever the page loads.

There will be two ways of performing the search. The first is by submitting the search form that is in the base.html template and thus in the top-right corner of every page. This will only search through Book titles. The other method is by submitting a SearchForm that is rendered on the search-results.html page. This form will display a ChoiceField for selecting between title or contributor search.

These steps will help you complete this activity:

Create a forms.py file, import the Django forms library, then create a SearchForm class.
SearchForm should have two fields. The first is a CharField with the name search. This field should not be required but should have a minimum length of 3.
The second field on SearchForm is a ChoiceField named search_in. This will allow you to select between title and contributor (with labels of Title and Contributor, respectively). It should not be required.
Update the book_search view so that it instantiates a SearchForm using data from request.GET.
Add code to search for Book models using title__icontains (for case-insensitive searching). This should be done if searching by title. The search should only be performed if the form is valid and contains some search text. The search_in value should be retrieved from cleaned_data using the GET method since it might not exist as it’s not required. Default it to title.
When searching for contributors, use first_names__icontains or last_names__icontains, then iterate the contributors and retrieve the books for each contributor. This should be done if you’re searching by contributor. The search should only be performed if the form is valid and contains some search text. There are many ways to combine the search results for first or last names. The easiest method using the techniques that you have been introduced to so far is to perform two queries, one for matching first names and then for last names, and iterating them separately.
Update the render call so that it includes the form variable and books that were retrieved in the context (as well as search_text, which was already being passed). The location of the template was changed in Chapter 3, so update the second argument to render accordingly.
The search-results.html template we created in Chapter 1 is essentially redundant now, so you can clear its content. Update search-results.html so that it extends from base.html instead of being a standalone template file.
Add a title block that will display Search Results for <search_text> if the form is valid and search_text was set; otherwise, just display Book Search. This block will also be added to base.html later in this activity.
Add a content block, which should show a <h2> heading with the text Search for Books under the <h2> render the form. The <form> element can have no attributes and it will default to making a GET request to the same URL it’s on. Add a submit button, as we have used in previous activities, with the btn btn-primary class.
Under the form, show a message stating Search results for <search_text> if the form is valid and search text was entered; otherwise, show no message. This should be displayed in <h3> tags, and the search text should be wrapped in <em> tags.
Iterate over the search results and render each one. Show the book title and any contributors' first and last names. The book title should link to the book_detail page. If the books list is empty, show the text No results found. You should wrap the results in <ul> tags with a class called list-group; each result should be a <li> item with a class of list-group-item. This will be like the book_list page, but we won’t show as much information (just the title and contributors).
Update base.html so that it includes an action attribute in the search <form> tag. Use the url template tag to generate the URL for this attribute.
Set the name attribute of the search field to search, and the value attribute to the entered search_text. Also, ensure the minimum length of the field is 3.
While in base.html, add a title block to the title tag that was overridden by other templates (as in step 9). Add a block template tag inside the <title> HTML element. It should contain the content Bookr.
After completing this activity, you should be able to open the Book Search page at http://127.0.0.1:8000/book-search/; it will look like Figure 6.33:

Figure 6.33: The Book Search page without a search
Figure 6.33: The Book Search page without a search

When searching for something using just two characters, your browser should prevent you from submitting either of the search fields.

If you search for something that returns no results, you will see a message that there were no results. Searching by title (this can be done with either field) will show matching results:

Figure 6.34: Title search
Figure 6.34: Title search

Similarly, when searching by contributor (although this can only be done in the lower form), you’ll see matching results:

Figure 6.35: A contributor search
Figure 6.35: A contributor search

Note

The solution for this activity can be found on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

Summary
This chapter provided an introduction to forms in Django. We introduced several HTML inputs for entering data onto a web page. We talked about how data is submitted to a web application and when to use GET and POST requests. We then looked at how Django’s form classes can make generating the form HTML simpler, as well as allow us to automatically build forms using models. Finally, we enhanced Bookr some more by building the Book Search functionality.

In the next chapter, we will dive deeper into forms and learn how to customize the display of form fields, how to add more advanced validation to a form, and how to automatically save model instances by using the ModelForm class.



| ≪ [ 05 Serving Static Files ](/packtpub/2024/422-web_development_with_django_2ed/05_serving_static_files) | 06 Forms | [ 07 Advanced Form Validation and Model Forms ](/packtpub/2024/422-web_development_with_django_2ed/07_advanced_form_validation_and_model_forms) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/422-web_development_with_django_2ed/06_forms
> (2) Markdown
> (3) Title: 06 Forms
> (4) Short Description: Publication date: May 2023 Publisher Packt Pages 764
> (5) tags: Django
> Book Title: 422-Web Development with Django 2ed
> Link: https://subscription.packtpub.com/book/web-development/9781803230603/pref
> create: 2024-05-08 수 14:11:52
> Images: /packtpub/2024/422-web_development_with_django_2ed_img/06/
> .md Name: 06_forms.md

