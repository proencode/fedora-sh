
| ≪ [ 06 Forms ](/packtpub/2024/422-web_development_with_django_2ed/06_forms) | 07 Advanced Form Validation and Model Forms | [ 08 Media Serving and File Uploads ](/packtpub/2024/422-web_development_with_django_2ed/08_media_serving_and_file_uploads) ≫ |
|:----:|:----:|:----:|

# 07 Advanced Form Validation and Model Forms



Book image


Advanced Form Validation and Model Forms
Continuing your journey with the form_project application you started in the previous chapter, you’ll begin this chapter by adding a new form to your app with custom multi-field validation and form cleaning. You’ll learn how to set the initial values on your form and customize the widgets (the HTML input elements that are being generated). Then, you’ll be introduced to the ModelForm class, which allows a form to be automatically created from a model. You’ll use it in a view to automatically save the new or changed Model instance.

In this chapter, we will take our knowledge of Django form validation further by introducing concepts that form the fundamentals of most production websites.

For instance, a certain field might only be required if another field is set. Let’s say we want to add a checkbox to allow users to sign up for our monthly newsletter. It has a text box below it that lets them enter their email address. With some basic validation, we can check the following:

Whether the user has checked the checkbox
Whether the user has entered their email address
When the user clicks the Submit button, we’ll be able to validate whether both fields are actioned. But what if the user doesn’t want to sign up for our newsletter? If they click the Submit button, ideally, both fields should be blank. That’s where validating each field might not work.

Another example could be a case where we have two fields where each has a maximum value of, say, 50. But the total values added to each one must be less than 75. We’ll start this chapter by looking at how to write custom validation rules to solve such problems.

Later, as we progress in this chapter, we will look at how to set initial values on a form. This can be useful when automatically filling out information that is already known to the user. For example, we can automatically put a user’s contact information into a form if that user is logged in.

We’ll finish this chapter by looking at model forms, which will let us automatically create a form from a Django Model class. This cuts down the amount of code that needs to be written to create a new Model instance.

In this chapter, we will cover the following topics:

Custom field validation and cleaning
Adding placeholders and initila values
Creating or editing Django models
By the end of this chapter, you will know how to add extra multi-field validation to Django forms, how to customize and set form widgets for fields, how to use ModelForms to automatically create a form from a Django model, and how to automatically create Model instances from ModelForms.

Technical requirements
The complete code files for this chapter can be found at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter07

Custom field validation and cleaning
We have seen how a Django form converts values from an HTTP request, which are strings, into Python objects. In a non-custom Django form, the target type is dependent on the field class. For example, the Python type derived from IntegerField is int, and string values are given to us verbatim, as the user entered them. But, we can also implement methods on our Form class to alter the output values from our fields in any way we choose. This allows us to clean or filter the user’s input data to fit what we expect better. We could round an integer to the nearest multiple of 10 so that it fits into a batch size for ordering specific items. Or, we could transform an email address into lowercase so that the data is consistent for searching.

We can also implement some custom validators. We’ll look at a couple of different ways of validating fields: by writing a custom validator, and by writing a custom clean method for the field. Each method has its pros and cons: a custom validator can be applied to different fields and forms, so you don’t have to write the validation logic for each field; a custom clean method must be implemented on each form you want to clean, but is more powerful and allows validation since you can use other fields in the form or change the cleaned value that the field returns.

Custom validators
A validator is simply a function that accepts a value and raises django.core.exceptions.ValidationError if the value is invalid – the validity is determined by the code you write. The value is a Python object (that is, cleaned_data, which has already been converted from the POST request string).

Here’s a simple example that validates whether a value is in lowercase:

from django.core.exceptions import ValidationError
def validate_lowercase(value):
    if value.lower() != value:
        raise ValidationError("{} is not lowercase."
                               .format(value))

Copy

Explain
Notice the function does not return anything, for either success or failure. It will just raise ValidationError if the value is not valid.

Note

Note that the behavior and handling of ValidationError are different than how we’ve seen other exceptions behave in Django. Normally, if you raise an exception in your view, you’ll end up with an HTTP response with a 500 status code from Django (if you don’t handle the exception in your code).

When raising ValidationError in your validation/cleaning code, the Django form class will catch the error for you; then, the is_valid method of form will return False. You don’t have to write try/except handlers around the code that might raise ValidationError.

The validator can be passed to the validators argument of a field constructor on a form, inside a list; for example, to our text_input field from our ExampleForm:

class ExampleForm(forms.Form):
    text_input =
        forms.CharField(validators=[validate_lowercase])

Copy

Explain
Now, if we submit the form and the fields contain uppercase values, we’ll get an error, as shown in the following figure:

Figure 7.1 – Lowercase text validator in action
Figure 7.1 – Lowercase text validator in action

The validator function can be used on any number of fields. In our example, if we wanted lots of fields to have lowercase enforced, validate_lowercase could be passed to all of them. Now, let’s look at how we could implement this another way, with a custom clean method.

Cleaning methods
A clean method is created on the Form class and is named in the clean_field_name format. For example, the clean method for text_input would be called clean_text_input, the clean method for books_you_own would be called clean_books_you_own, and so on.

Cleaning methods take no arguments; instead, they should use the cleaned_data attribute on self to access the field data. This dictionary will contain the data after being cleaned in the standard Django way, as we saw in the previous example. The clean method must return the cleaned value, which will replace the original value in the cleaned_data dictionary. Even if the method does not change the value, a value must be returned. You can also use the clean method to raise ValidationError, and the error will be attached to the field (the same as with a validator).

Let’s re-implement the lowercase validator as a clean method, like this:

class ExampleForm(forms.Form):
    text_input = forms.CharField()
    …
    def clean_text_input(self):
        value = self.cleaned_data["text_input"]
        if value.lower() != value:
            raise ValidationError("{} is not lowercase."
                                   .format(value))
        return value

Copy

Explain
You can see that the logic is essentially the same, except we must return the validated value at the end. If we submit the form, we will get the same result as the previous time we tried (Figure 7.1).

Let’s look at one more cleaning example. Instead of raising an exception when the value is invalid, we could just convert the value into lowercase. We would implement that with this code:

class ExampleForm(forms.Form):
    text_input = forms.CharField()
    …
    def clean_text_input(self):
        value = self.cleaned_data['text_input']
        return value.lower()

Copy

Explain
Now, let’s say we enter text into the input as uppercase:

Figure 7.2 – ALL UPPERCASE text entered
Figure 7.2 – ALL UPPERCASE text entered

If we were to examine the cleaned data using our debug output from the view, we would see that it is lowercase:

Figure 7.3 – The cleaned data has been transformed into lowercase
Figure 7.3 – The cleaned data has been transformed into lowercase

These were just a couple of simple examples of how to validate fields using both validators and clean methods. You can, of course, make each type of validation much more complex if you wish and transform the data in more complex ways using a clean method.

So far, you’ve only learned simple methods for form validation, where you’ve treated each field independently. A field is valid (or not) based only on the information it contains and nothing else. What if the validity of one field depends on what the user entered into another field? An example of this might be that you have an email field to collect someone’s email address if they want to be signed up for a mailing list. The field is only required if they check a checkbox that indicates they wanted to be signed up. Neither of these fields is required on their own – we do not want the checkbox to be required to be checked, but if it is checked, then the email field should be required too.

In the next section, we will show how you can validate a form whose fields depend on each other by overriding the clean method in your form.

Multi-field validation
We’ve just looked at the clean_field_name methods that can be added to a Django form, to clean a specific field. Django also allows us to override the clean method, in which we can access all cleaned_data from all fields, and we know that all custom field methods have been called. This allows the fields to be validated based on another field’s data.

Referring to our previous example with a form that has an email address that is only required if a checkbox is checked, we’ll see how we can implement this using the clean method.

First, create a Form class and add two fields – make them both optional with the required=False argument:

class NewsletterSignupForm(forms.Form):
    signup = forms.BooleanField(label="Sign up to
    newsletter?", required=False)
    email = forms.EmailField(help_text="Enter your email
    address to subscribe", required=False)

Copy

Explain
We’ve also introduced two new arguments that can be used for any field:

label
This allows you to set the label text for a field. As we’ve seen, Django will automatically generate label text from the field name. If you set the label argument, you can override this default. Use this argument if you want to have a more descriptive label.

help_text
If you need more information to be displayed regarding what input a field requires, you can use this argument. By default, it’s displayed after the field.

When rendered, the form looks like this:

Figure 7.4 – Email signup form with a custom label and help text
Figure 7.4 – Email signup form with a custom label and help text

If we were to submit the form now, without entering any data, nothing would happen. Neither field is required, so the form validates fine.

Now, we can add the multi-field validation to the clean method. We will check whether the Sign up to newsletter checkbox is checked, and then check that the Email field has a value. The built-in Django methods have already validated that the email address is valid at this point, so we just need to check that a value exists for it. We will then use the add_error method to set an error for the email field. This is a method you haven’t seen before but it’s very simple; it takes two arguments – the name of the field to set the error on, and the text of the error.

Here’s the code for the clean method:

class NewsletterSignupForm(forms.Form):
    …
    def clean(self):
        cleaned_data = super().clean()
        if cleaned_data["signup"] and not
        cleaned_data.get("email"):
            self.add_error("email", "Your email address is
            required if signing up for the newsletter.")

Copy

Explain
Your clean method must always call the super().clean() method to retrieve the cleaned data. When add_error is called to add errors to the form, the form will no longer validate (the is_valid method returns False).

Now, if we submit the form without the checkbox checked, still, no error is generated, but if you check the checkbox without an email address, you will receive the error we just wrote the code for:

Figure 7.5 – Error displayed when attempting to sign up with no email address
Figure 7.5 – Error displayed when attempting to sign up with no email address

You might notice that we are retrieving the email from the cleaned_data dictionary using the get method. The reason for doing this is that if the email value in the form is invalid, then the email key will not exist in the dictionary. The browser should prevent the user from submitting the form if an invalid email has been entered, but a user might be using an older browser that does not support this client-side validation, so, for safety, we use the get method. Since the signup field is BooleanField, and not required, it will only be invalid if a custom validation function is used. We’re not using one here, so it’s safe to access its value using square bracket notation.

There’s one more validation scenario to consider before moving on to our first exercise, and that’s adding errors that are not specific to any field. Django calls these non-field errors. There are many scenarios where you might want to use these when multiple fields are dependent on each other.

Take, for example, a shopping website. Your order form could have two numeric fields whose totals can’t exceed a certain value. If the total were exceeded, the value of either field could be decreased to bring the total below the maximum value, so the error is not specific to either of the fields. To add a non-field error, call the add_error method with None as the first argument.

Let’s look at how to implement this. In this example, we’ll have a form where the user can specify a certain number of items to order, for item A or item B. The user cannot order more than 100 items in total. The fields will have a max_value of 100, and a min_value of 0, but custom validation in the clean method will need to be written to handle the validation of the total amount:

class OrderForm(forms.Form):
    item_a = forms.IntegerField(min_value=0, max_value=100)
    item_b = forms.IntegerField(min_value=0, max_value=100)
    def clean(self):
        cleaned_data = super().clean()
        if cleaned_data.get("item_a", 0) +
        cleaned_data.get("item_b", 0) > 100:
            self.add_error(None, "The total number of items
            must be 100 or less.")

Copy

Explain
The fields (item_a and item_b) are added in the normal way, with standard validation rules. You can see that we have used the clean method the same way we used it before. Moreover, we have implemented the maximum item logic inside this method. The following line is what registers the non-field error if the maximum items are exceeded:

self.add_error(None, "The total number of items must be 100
               or less.")

Copy

Explain
Once again, we access the values of item_a and item_b using the get method, with a default value of 0. This is in case the user has an older browser (from 2011 or earlier) and was able to submit the form with invalid values.

In a browser, the field-level validation ensures values between 0 and 100 have been entered in each field, and prevents the form from being submitted otherwise:

Figure 7.6 – The form cannot be submitted if one field exceeds the maximum value
Figure 7.6 – The form cannot be submitted if one field exceeds the maximum value

However, if we put in two values that sum to more than 100, we can see how Django displays the non-field error:

Figure 7.7 – Django non-field error displayed at the start of the form
Figure 7.7 – Django non-field error displayed at the start of the form

Django non-field errors are always displayed at the start of a form, before other fields or errors.

In the following exercise, we will build a form that implements a validation function, a field clean method, and a form clean method.

Exercise 7.01 – custom clean and validation methods
In this exercise, you will build a new form that allows the user to create an order for books or magazines. It must have the following validation criteria:

The user may order up to 80 magazines and/or 50 books, but the total number of items must not be more than 100
The user can choose to receive an order confirmation, and if they do, they must enter an email address
The user should not enter an email address if they have not chosen to receive an order confirmation
To ensure they are part of our company, the email address must be part of our company domain (in our case, we’ll just use example.com)
For consistency with other email addresses in our fictional company, the address should be converted into lowercase
This sounds like a lot of rules, but with Django, it’s simple if we tackle them one by one. We’ll carry on with the form_project app you started in Chapter 6, Forms. If you haven’t completed Chapter 6, Forms, you can download the code from https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter06/final/form_project:

In PyCharm, open the form_example app’s forms.py file.
Note

Make sure the Django dev server is not running; otherwise, it may crash as you make changes to this file, causing PyCharm to jump into the debugger.

Since our work with ExampleForm is done, you can remove it from this file.

Create a new class called OrderForm that inherits from forms.Form:
class OrderForm(forms.Form):

Copy

Explain
Add four fields to the class, as follows:
magazine_count, IntegerField with a min_value of 0 and a max_value of 80
book_count, IntegerField with a min_value of 0 and a max_value of 50
send_confirmation, BooleanField, which is not required
email, EmailField, which is also not required
The class should look like this:

class OrderForm(forms.Form):
    magazine_count = forms.IntegerField(min_value=0,
                                        max_value=80)
    book_count = forms.IntegerField(min_value=0,
                                    max_value=50)
    send_confirmation =
        forms.BooleanField(required=False)
    email = forms.EmailField(required=False)

Copy

Explain
Add a validation function to check that the user’s email address is on the right domain. First, ValidationError needs to be imported; add this line to the top of the file:
from django.core.exceptions import ValidationError

Copy

Explain
Then, write this function after the import line (before the OrderForm class implementation):

def validate_email_domain(value):
    if value.split("@")[-1].lower() != "example.com":
        raise ValidationError("The email address must
            be on the domain example.com.")

Copy

Explain
The function splits the email address on the @ symbol, then checks whether the part after it is equal to example.com. This function alone would validate non-email addresses. For example, the not-valid@some other domain@example.com string would not cause a ValidationError to be raised in this function. This is acceptable in our case because, since we’re using EmailField, the other standard field validators will check the email address’s validity.

Add the validate_email_domain function as a validator to the email field on OrderForm. Update the EmailField constructor call to add a validators argument, passing in a list containing the validation function:
class OrderForm(forms.Form):
    …
    email = forms.EmailField(required=False,
        validators=[validate_email_domain])

Copy

Explain
Add a clean_email method to the form to make sure the email address is lowercase:
class OrderForm(forms.Form):
    # truncated for brevity
    def clean_email(self):
        return self.cleaned_data['email'].lower()

Copy

Explain
Now, add the clean method to perform all the cross-field validation. First, we will just add the logic for making sure that an email address is only entered if an order confirmation is requested:
class OrderForm(forms.Form):
    # truncated for brevity
    def clean(self):
        cleaned_data = super().clean()
        if cleaned_data["send_confirmation"] and not
        cleaned_data.get("email"):
            self.add_error("email", "Please enter an
            email address to receive the confirmation
            message.")
        elif cleaned_data.get("email") and not
        cleaned_data["send_confirmation"]:
            self.add_error("send_confirmation",
            "Please check this if you want to receive
            a confirmation email.")

Copy

Explain
This will add an error to the Email field if Send confirmation is checked but no email address is added:

Figure 7.8 – Error if Send confirmation is checked but no email address is added
Figure 7.8 – Error if Send confirmation is checked but no email address is added

Similarly, an error will be added to Email if an email address is entered but Send confirmation is not checked:

Figure 7.9 – Error because an email has been entered but the user has not chosen to receive confirmation
Figure 7.9 – Error because an email has been entered but the user has not chosen to receive confirmation

Add the final check, also inside the clean method. The total number of items should not be more than 100. We will add a non-field error if the sum of magazine_count and book_count is greater than 100:
class OrderForm(forms.Form):
    …
    def clean(self):
        …
        item_total =
            cleaned_data.get("magazine_count", 0) +
            cleaned_data.get("book_count", 0)
        if item_total > 100:
            self.add_error(None, "The total number of
            items must be 100 or less.")

Copy

Explain
This will add a non-field error by passing None as the first argument to the add_error call.

Note

Refer to https://raw.githubusercontent.com/PacktPublishing/Web-Development-with-Django-Second-Edition/main/Chapter07/Exercise7.01/form_project/form_example/forms.py for the complete code.

Save forms.py.

Open the reviews app’s views.py file. We will change the form’s import so that OrderForm is being imported instead of ExampleForm. Consider the following import line:
from .forms import ExampleForm

Copy

Explain
Change it as follows:

from .forms import OrderForm

Copy

Explain
In the form_example view, change the two lines that use ExampleForm to use OrderForm instead. Consider the following line of code:
form = ExampleForm(request.POST)

Copy

Explain
Change this as follows:

form = OrderForm(request.POST)

Copy

Explain
Similarly, consider the following line of code:

form = ExampleForm()

Copy

Explain
Change this as follows:

form = OrderForm()

Copy

Explain
The rest of the function can stay as-is.

We don’t have to make changes to the template. Start the Django dev server and navigate to http://127.0.0.1:8000/form-example/ in your browser. You should see the form rendered similarly to what’s shown in Figure 7.10:

Figure 7.10 – OrderForm in the browser
Figure 7.10 – OrderForm in the browser

Try submitting the form with a Magazine count of 80 and a Book count of 50. The browser will allow this but since they sum to more than 100, an error will be triggered by the clean method in the form and displayed on the page:
Figure 7.11 – A non-field error displayed on the form when the maximum number of allowed items is exceeded
Figure 7.11 – A non-field error displayed on the form when the maximum number of allowed items is exceeded

Try submitting the form with Send confirmation checked but the Email field blank. Then, fill in the Email text box but uncheck Send confirmation. Either combination will give an error stating that both must be present. The error will differ based on which field is missing:
Figure 7.12 – Error message if no email address is present
Figure 7.12 – Error message if no email address is present

Now, try submitting the form with Send confirmation checked, and an email address that is on the example.com domain. You should receive a message that your email address must have the example.com domain. You should also receive a message that email must be set – this is because the email does not end up in the cleaned_data dictionary. After all, it is not valid:
Figure 7.13 – The error message that’s shown when the email domain is not example.com
Figure 7.13 – The error message that’s shown when the email domain is not example.com

Finally, enter valid values for Magazine count and Book count (such as 20 and 20). Check Send confirmation and enter UserName@Example.Com as the email (make sure you match the letter case, including the mixed uppercase and lowercase characters):
Figure 7.14 – The form after being submitted with valid values
Figure 7.14 – The form after being submitted with valid values

Switch to PyCharm and look in the debug console. You’ll see that the email is converted into lowercase when it is printed by our debug code:
Figure 7.15 – Email in lowercase, as well as other fields
Figure 7.15 – Email in lowercase, as well as other fields

This is our clean_email method in action – even though we entered data in both uppercase and lowercase, it has been converted into all lowercase.

In this exercise, we created a new OrderForm that implemented form and field clean methods. We used a custom validator to ensure that the Email field met our specific validation rules – only a specific domain was allowed. We used a custom field cleaning method (clean_email) to convert the email address into lowercase. We then implemented a clean method to validate the forms that were dependent on each other. In this method, we added both field and non-field errors.

So far, we have learned about multi-field validations, and how to implement them to make sure that we can validate the form in one go rather than highlighting errors one by one.

In the next section, we will cover how to add placeholders and initial values to the form.

Adding placeholders and initial values
There are two things our first manually built form had that our current Django form still does not have – placeholders and initial values. Adding placeholders is simple; they are just added as attributes to the widget constructor for the form field. This is similar to what we’ve already seen for setting the type of DateField in our previous examples.

Here’s an example:

class ExampleForm(forms.Form):
    text_field = forms.CharField(
        widget=forms.TextInput(attrs={"placeholder": "Text
        Placeholder"})
    )
    password_field = forms.CharField(
        widget=forms.PasswordInput(attrs={"placeholder":
        "Password Placeholder"})
    )
    email_field = forms.EmailField(
        widget=forms.EmailInput(attrs={"placeholder":
        "Email Placeholder"})
    )
    text_area = forms.CharField(
        widget=forms.Textarea(attrs={"placeholder": "Text
        Area Placeholder"})
    )

Copy

Explain
Here is what the preceding form looks like when rendered in the browser:

Figure 7.16 – Django form with placeholders
Figure 7.16 – Django form with placeholders

Of course, if we’re manually setting Widget for each field, we need to know which Widget class to use. The ones that support placeholders are TextInput, NumberInput, EmailInput, URLInput, PasswordInput, and Textarea.

While we’re examining the Form class itself, we’ll look at the first of two ways of setting an initial value for a field. We can do this by using the initial argument on a Field constructor, like this:

text_field = forms.CharField(initial="Initial Value", …)

Copy

Explain
The other method is to pass in a dictionary of data when instantiating the form in our view. The keys are the field names. The dictionary should have zero or more items (that is, an empty dictionary is valid). Any extra keys are ignored. This dictionary should be supplied as the initial argument in our view, as follows:

initial = {"text_field": "Text Value", "email_field": "user@example.com"}
form = ExampleForm(initial=initial)

Copy

Explain
Or, for a POST request, pass in request.POST as the first argument, as usual:

initial = {"text_field": "Text Value", "email_field": "user@example.com"}
form = ExampleForm (request.POST, initial=initial)

Copy

Explain
Values in request.POST will override values in initial. This means that even if we have an initial value for a required field, if it’s left blank when submitted, then it will not validate. The field will not fall back to the value in initial.

Whether you decide to set initial values in the Form class itself or the view is up to you and depends on your use case. If you had a form that was used in multiple views but usually had the same value, it would be better to set the initial value in the form. Otherwise, it can be more flexible to use setting in the view.

In the next exercise, we will add placeholders and initial values to the OrderForm class from the previous exercise.

Exercise 7.02 – placeholders and initial values
In this exercise, you will enhance the OrderForm class by adding placeholder text. You will simulate passing an initial email address to the form. It will be a hardcoded address but once the user can log in, it could be an email address associated with their account – you will learn about sessions and authentication in Chapter 9, Sessions and Authentication:

In PyCharm, open the reviews app’s forms.py file. You will add placeholders to the magazine_count, book_count, and email fields on the OrderForm, which means also setting widget.
To the magazine_count field, add a NumberInput widget with placeholder in the attrs dictionary. This placeholder should be set to Number of Magazines. Write the following code:

magazine_count = forms.IntegerField(
    min_value=0,
    max_value=80,
    widget=forms.NumberInput(attrs={"placeholder":
    "Number of Magazines"}),
)

Copy

Explain
Add a placeholder to the book_count field in the same manner. The placeholder text should be Number of Books:
book_count = forms.IntegerField(
    min_value=0,
    max_value=50,
    widget=forms.NumberInput(attrs={"placeholder":
    "Number of Books"}),
)

Copy

Explain
The final change to OrderForm is to add a placeholder to the email field. This time, the widget is EmailInput. The placeholder text should be Your company email address:
email = forms.EmailField(
    required=False,
    validators=[validate_email_domain],
    widget=forms.EmailInput(attrs={"placeholder":
    "Your company email address"}),
)

Copy

Explain
Note that the clean_email and clean methods should remain as they were in Exercise 7.01 – custom clean and validation methods. Save the file.

Open the form_project app’s views.py file. In the form_example view function, create a new dictionary variable called initial with one key, email, like this:
initial = {"email": "user@example.com"}

Copy

Explain
In the two places that you are instantiating OrderForm, also pass in the initial variable using the initial kwarg. The first instance is as follows:
form = OrderForm(request.POST, initial=initial)

Copy

Explain
The second instance is as follows:

form = OrderForm(initial=initial)

Copy

Explain
The complete code for views.py can be found at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/blob/main/Chapter07/Exercise7.02/form_project/form_example/views.py.

Save the views.py file.

Start the Django dev server if it is not already running. Browse to http://127.0.0.1:8000/form-example/ in your browser. You should see that your form now has placeholders and an initial value set:
Figure 7.17 – Order form with initial values and placeholders
Figure 7.17 – Order form with initial values and placeholders

In this exercise, we added placeholders to form fields. This was done by setting a form widget when defining the form field on the form class and setting a placeholder value in the attrs dictionary. We also set an initial value for the form using a dictionary and passed it to the form instance using the initial kwarg.

In the next section, we will talk about how to work with Django models using data from forms, and how ModelForm makes this easier.

Creating or editing Django models
We’ve seen how to define a form, and in Chapter 2, Models and Migrations, you learned how to create Django model instances. By using these things together, you can build a view that displays a form and also saves a model instance to the database. This gives you an easy way to save data without having to write a lot of boilerplate code or create custom forms. In Bookr, we will use this method to allow users to add reviews without requiring access to the Django admin site. Without using ModelForm, you can do something like this:

You can create a form based on an existing model; for example, Publisher. The form would be called PublisherForm.
You can manually define the fields on PublisherForm, using the same rules defined on the Publisher model, as shown here:
class PublisherForm(forms.Form):
    name = forms.CharField(max_length=50)
    website = forms.URLField()
    …

Copy

Explain
In the view, the initial values would be retrieved from the model queried from the database, then passed to the form using the initial argument. If you were creating a new instance, the initial value would be blank – something like this:
if create:
    initial = {}
else:
    publisher = Publisher.objects.get(pk=pk)
    initial = {"name": publisher.name, "website":
    publisher.website, …}
form = PublisherForm(initial=initial)

Copy

Explain
Then, in the POST flow of the view, you can either create or update the model based on cleaned_data:
form = PublisherForm(request.POST, initial=initial)
if create:
    publisher = Publisher()
else:
    publisher = Publisher.objects.get(pk=pk)
publisher.name = form.cleaned_data['name']
publisher.website = forms.cleaned_data['website']
…
publisher.save()

Copy

Explain
This is a lot of work, and we have to consider how much duplicated logic we have. For example, we’re defining the length of the name in the name form field. If we made a mistake here, we could allow a longer name in the field than the model allows. We also have to remember to set all the fields in the initial dictionary, as well as set the values on the new or updated model with cleaned_data from the form. There are many opportunities to make mistakes here, as well as remembering to add or remove field setting data for each of these steps if the model changes. All this code would have to be duplicated for each Django model you work with as well, expounding the duplication problem.

The ModelForm class
Luckily, Django provides a method of building Model instances from forms much more simply, with the ModelForm class. A ModelForm is a form that is built automatically from a particular model. It will inherit the validation rules from the model (such as whether fields are required or the maximum length of CharField instances, and so on). It provides an extra __init__ argument (called instance) for automatically populating the initial values from an existing model. It also adds a save method to automatically persist the form data to the database. All you need to do to set up ModelForm is specify its model and what fields should be used: this is done on the class Meta attribute of the form class. Let’s see how to build a form from Publisher.

Inside the file that contains the form (for example, the forms.py file we have been working with), the only change is that the model must be imported:

from .models import Publisher

Copy

Explain
Then, the Form class can be defined. The class requires a class Meta attribute, which, in turn, must define a model attribute and either the fields or excludes attributes:

class PublisherForm(forms.ModelForm):
    class Meta:
        model = Publisher
        fields = ("name", "website", "email")

Copy

Explain
fields is a list or tuple of the fields to include in the form. When manually setting the list of fields, if you add extra fields to the model, you must also add their name here to have them displayed on the form.

You can also use the special __all__ value instead of a list or tuple to automatically include all the fields, like this:

class PublisherForm(forms.ModelForm):
    class Meta:
        model = Publisher
        fields = "__all__"

Copy

Explain
If the model field has its editable attribute set to False, then it will not be automatically included.

On the contrary, the exclude attribute sets the fields to not display in the form. Any fields added to the model will automatically be added to the form. We could define the preceding form using exclude with any empty tuple since we want all the fields. The code is like this:

class PublisherForm(forms.ModelForm):
    class Meta:
        model = Publisher
        exclude = ()

Copy

Explain
This saves you some work because you don’t need to add a field to both the model and the fields list; however, it is not as safe since you might automatically expose fields to the end user that you don’t want to. For example, if you had a User model with UserForm, you might add an is_admin field to the User model to give admin users extra privileges. If this field was not in exclude, it would be displayed to the user. A user would then be able to make themselves an administrator, which is something you probably wouldn’t want.

Whichever of these three approaches to choosing the forms to display that we decide to use, in our case, they will display the same in the browser. This is because we are choosing to display all the fields. They all look like this when rendered in the browser:

Figure 7.18 – PublisherForm
Figure 7.18 – PublisherForm

Note that help_text from the Publisher model is automatically rendered as well.

Usage in a view is similar to the other forms we have seen. Also, as mentioned, there is an extra argument that can be provided, called instance. This can be set to None, which will render an empty form.

Assuming, in your view function, you have some method of determining whether you are creating or editing a model instance (we will discuss how to do this later), this will determine a variable called is_create (True if creating an instance, or False if editing an existing one). Your view function to create the form could then be written like this:

if is_create:
    instance = None
else:
    instance = get_object_or_404(Publisher, pk=pk)
if request.method == "POST":
    form = PublisherForm(request.POST, instance=instance)
    if form.is_valid():
        # we'll cover this branch soon
else:
    form = PublisherForm(instance=instance)

Copy

Explain
As you can see, in either branch, the instance is passed to the PublisherForm constructor, although it is None if we’re in create mode.

If the form is valid, we can save the model instance. This can be done simply by calling the save method on the form. This will automatically create the instance, or simply save changes to the old one:

if form.is_valid():
    form.save()
    return redirect(success_url)

Copy

Explain
The save method returns the model instance that was saved. It takes one optional argument, commit, which determines whether the changes should be written to the database. You can pass False instead, which allows you to make additional changes to the instance before manually saving the changes. This would be required to set attributes that have not been included in the form. As we mentioned, maybe you would set the is_admin flag to False on a User instance:

if form.is_valid():
    new_user = form.save(False)
    new_user.is_admin = False
    new_user.save()
    return redirect(success_url)

Copy

Explain
In Activity 7.02 – Review Creation UI, at the end of this chapter, we will be using this feature as well.

If your model uses ManyToMany fields, and you also call form.save(False), you should also call form.save_m2m() to save any many-to-many relationships that have been set. It’s not necessary to call this method if you call the form save method with commit set to True (that is, the default).

Model forms can be customized by making changes to their Meta attributes. The widgets attribute can be set. It can contain a dictionary keyed on the field names, with widget classes or instances as the values. For example, this is how to set up PublisherForm to have placeholders:

class PublisherForm(forms.ModelForm):
    class Meta:
        model = Publisher
        fields = "__all__"
        widgets = {
            "name": forms.TextInput(attrs={
                "placeholder": "The publisher's name."
            })
        }

Copy

Explain
The values behave the same as setting the kwarg widget in the field definition; they can be a class or an instance. For example, to display CharField as a password input, the PasswordInput class can be used; it does not need to be instantiated:

widgets = {
    "password": forms.PasswordInput
}

Copy

Explain
Model forms can also be augmented with extra fields added in the same way as they are added to a normal form. For example, suppose we wanted to provide the option of sending a notification email after saving a Publisher. We can add an email_on_save field to PublisherForm like this:

class PublisherForm(forms.ModelForm):
    email_on_save = forms.BooleanField(required=False,
    help_text="Send notification email on save")
    class Meta:
        model = Publisher
        fields = "__all__"

Copy

Explain
When rendered, the form looks like this:

Figure 7.19 – PublisherForm with an additional field
Figure 7.19 – PublisherForm with an additional field

Additional fields are placed after the Model fields. The extra fields are not handled automatically – they do not exist on the model, so Django won’t attempt to save them on the model instance. Instead, you should handle how their values are saved by examining the cleaned_data values of the form, as you would with a standard form, for example (inside your view function):

if form.is_valid():
    if form.cleaned_data.get("email_on_save"):
        send_email()  # assume this function is defined
        elsewhere
    form.save()  # save the instance regardless of sending
    the email or not
    return redirect(success_url)

Copy

Explain
In the following exercise, you will write a new view function in Bookr that will allow you to create and edit a Publisher.

Exercise 7.03 – creating and editing a publisher
In this exercise, we will return to Bookr. We want to add the ability to create and edit a Publisher without using the Django admin. To do this, we’ll add a ModelForm for the Publisher model. It will be used in a new view function. This view function will take an optional argument, pk, which will either be the ID of the Publisher object being edited or None to create a new Publisher. We will add two new URL maps to facilitate this. When this is complete, we will be able to see and update any publisher using their ID. For example, information for Publisher 1 will be viewable/editable at the /publishers/1 URL path:

In PyCharm, open the reviews app’s forms.py file. After the forms import, import the Publisher model:
from .models import Publisher

Copy

Explain
Create a PublisherForm class, inheriting from forms.ModelForm:
class PublisherForm(forms.ModelForm):

Copy

Explain
Define the class Meta attribute on PublisherForm. The attributes that Meta requires are the model (Publisher) and fields ("__all__"):
class PublisherForm(forms.ModelForm):
    class Meta:
        model = Publisher
        fields = "__all__"

Copy

Explain
Save forms.py.

Note

The full file can be found at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/blob/main/Chapter07/Exercise7.03/bookr/reviews/forms.py.

Open the reviews app’s views.py file. At the top of the file, import PublisherForm:
from .forms import PublisherForm, SearchForm

Copy

Explain
Make sure you import the get_object_or_404 and redirect functions from django.shortcuts, if you aren’t already:
from django.shortcuts import render, get_object_or_404, redirect

Copy

Explain
Also, make sure you’re importing the Publisher model if you aren’t already. You may already be importing this and other models:
from .models import Book, Contributor, Publisher

Copy

Explain
The final import you will need is the messages module. This will allow us to register a message letting the user know that a Publisher object was edited or created:
from django.contrib import messages

Copy

Explain
Once again, add this import if you do not already have it.

Create a new view function called publisher_edit. It takes two arguments: request and pk (the ID of the Publisher object to edit). This is optional, and if it is None, then a Publisher object will be created instead:
def publisher_edit(request, pk=None):

Copy

Explain
Inside the view function, we need to try to load the existing Publisher instance if pk is not None. Otherwise, publisher should be None:
def publisher_edit(request, pk=None):
    if pk is not None:
        publisher = get_object_or_404(Publisher,
        pk=pk)
    else:
        publisher = None

Copy

Explain
After getting a Publisher instance or None, complete the branch for a POST request. Instantiate the form in the same way as you saw earlier in this chapter, but now, make sure that it takes instance as a kwarg. Then, if the form is valid, save it using the form.save() method. This method will return the updated Publisher instance, which is stored in the updated_publisher variable. Then, register a different success message depending on whether the Publisher was created or updated. Finally, redirect back to this publisher_edit view, since updated_publisher will always have an ID at this point:
def publisher_edit(request, pk=None):
    …
    if request.method == "POST":
        form = PublisherForm(request.POST,
        instance=publisher)
        if form.is_valid():
            updated_publisher = form.save()
            if publisher is None:
                messages.success(request, "Publisher
                "{}" was created."
                .format(updated_publisher))
            else:
                messages.success(request, "Publisher
                "{}" was updated."
                .format(updated_publisher))
            return redirect("publisher_edit",
            updated_publisher.pk)

Copy

Explain
If the form is not valid, the execution will fall through and just return the render function call with the invalid form (this will be implemented in step 12). The redirect uses a named URL map, which will be added later in this exercise.

Next, fill in the non-POST branch of the code. In this case, just instantiate the form with your instance:
def publisher_edit(request, pk=None):
    …
    if request.method == "POST":
        …
    else:
        form = PublisherForm(instance=publisher)

Copy

Explain
In step 14, you’ll create a form-example.html file to render, but we can add the call to the render function now. Render it in the view with the render function by passing in the HTTP method and form as the context:
def publisher_edit(request, pk=None):
    …
    return render(request, "form-example.html",
    {"method": request.method, "form": form})

Copy

Explain
Save this file. You can refer to this at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/blob/main/Chapter07/Exercise7.03/bookr/reviews/views.py.

Open urls.py in the reviews directory. Add two new URL maps; they will both go to the publisher_edit view. One will capture the ID of Publisher, which we will want to edit and pass into the view as the pk argument. The other will use new instead, and will not pass the pk, which will indicate we want to create a new Publisher.
To your urlpatterns variable, add the "publishers/<int:pk>/" path mapping to the reviews.views.publisher_edit view with the name "publisher_edit".

Also, add the "publishers/new/" path mapping to the reviews.views.publisher_edit view with the name "publisher_create":

urlpatterns = [
    …
    path("publishers/<int:pk>/",views.publisher_edit,
    name="publisher_edit"),
    path("publishers/new/",views.publisher_edit,
    name="publisher_create")
]

Copy

Explain
Since the second mapping does not capture anything, whichever pk that is passed to the publisher_detail view function is None.

Save the urls.py file. The completed version for reference is at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/blob/main/Chapter07/Exercise7.03/bookr/reviews/urls.py.

Create a form-example.html file inside the reviews app’s templates directory by using the New HTML File function in PyCharm. Since this is a standalone template (it does not extend any other templates), we need to render the messages inside it. Add this code just after the opening <body> tag to iterate through all the messages and display them:
{% for message in messages %}
<p><em>{{ message.level_tag|title }}:</em>
{{ message }}</p>
{% endfor %}

Copy

Explain
This will loop over the messages we have added and display the tag (in our case, Success) and then the message.

Then, add the normal form rendering and submission code:
<form method="post">
    {% csrf_token %}
    {{ form.as_p }}
    <p>
        <input type="submit" value="Submit">
    </p>
</form>

Copy

Explain
Save and close this file.

You can refer to the full version of this file at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/blob/main/Chapter07/Exercise7.03/bookr/reviews/templates/form-example.html.

Start the Django dev server, then navigate to http://127.0.0.1:8000/publishers/new/. You should see a blank PublisherForm being displayed:
Figure 7.20 – Blank publisher form
Figure 7.20 – Blank publisher form

The form has inherited the model’s validation rules, so you cannot submit the form with too many characters for Name or with an invalid Website or Email. Put in some valid information, then submit the form. After submission, you should see the success message; the form will be populated with information that was saved to the database:
Figure 7.21 – Form after submission
Figure 7.21 – Form after submission

Notice that the URL has also been updated and now includes the ID of the publisher that was created. In this case, it is http://127.0.0.1:8000/publishers/10/; the ID in your setup will depend on how many Publisher instances were already in your database.

Notice that if you refresh the page, you will not receive a message confirming whether you want to re-send the form data. This is because we redirected after saving, so it is safe to refresh this page as many times as you want and no new Publisher instances will be created. If you had not redirected it, then every time the page was refreshed, a new Publisher instance would be created.

If you have other Publisher instances in your database, you can change the ID in the URL to edit other ones. Since the ID in this instance is 3, we can assume that Publisher 1 and Publisher 2 already exist and can substitute their IDs to see the existing data. Here is the view of the existing Publisher 1 information (at http://127.0.0.1:8000/publishers/1/) – your information may be different:

Figure 7.22 – Existing Publisher 1 information
Figure 7.22 – Existing Publisher 1 information

Try making changes to the existing Publisher instance. Notice that after you save, the message is different – it is telling the user that the Publisher instance was updated rather than created:

Figure 7.23 – Publisher after updating instead of creating
Figure 7.23 – Publisher after updating instead of creating

In this exercise, we implemented a ModelForm from a model (PublisherForm was created from Publisher) and saw how Django automatically generated the form fields with the correct validation rules. We then used the form’s built-in save method to save changes to the Publisher instance (or automatically create it) inside the publisher_edit view. We mapped two URLs to the view. The first was for editing an existing Publisher and passing a pk to the view. The other did not pass this pk to the view, indicating that the Publisher instance should be created. Finally, we used the browser to experiment with creating a new Publisher instance and then editing an existing one.

Activity 7.01 – styling and integrating the publisher form
In Exercise 7.03 – creating and editing a publisher, you added PublisherForm to create and edit Publisher instances. You built this with a standalone template that did not extend any other templates, so it lacked the global styles. In this activity, you will build a generic form detail page that will display a Django form, similar to form-example.html but extending from a base template. The template will accept a variable to display the type of model being edited. You will also update the main base.html template to render the Django messages, using Bootstrap styling.

These steps will help you complete this activity:

Start by editing the project’s base.html file. Wrap the content block in a div container for a nicer layout with some spacing. Surround the existing content block with an <div> element with class="container-fluid".
Render each message in messages (similar to step 14 of Exercise 7.03 – creating and editing a publisher). Add the {% for %} block after the <div> container you just created but before the content block. You should use the Bootstrap framework classes – this snippet will help you:
<div class="alert alert-{% if message.level_tag == 'error' %}danger{% else %}{{ message.level_tag }}{% endif %}"
    role="alert">
    {{ message }}
</div>

Copy

Explain
The Bootstrap class and Django message tags have corresponding names for the most part (for example, success and alert-success). The exception is Django’s error tag. The corresponding Bootstrap class is alert-danger. See more information about Bootstrap alerts at https://getbootstrap.com/docs/4.0/components/alerts/. This is why you need to use the if template tag in this snippet.

Create a new template called instance-form.html, inside the reviews app’s namespaced templates directory.
instance-form.html should extend from the reviews app’s base.html.
The context that’s being passed to this template will contain a variable called instance. This will be the Publisher instance being edited, or None if we are creating a new Publisher instance. The context will also contain a model_type variable, which is a string indicating the model type (in this case, Publisher). Use these two variables to populate the title block template tag:
If the instance is None, the title should be New Publisher
Otherwise, the title should be Editing Publisher <Publisher Name>
instance-form.html should contain a content block template tag, to override the base.html content block.
Add an <h2> element inside the content block and populate it using the same logic as the title. For better styling, wrap the publisher name in an <em> element.
Add an <form> element to the template with a method of post. Since we are posting back to the same URL, an action does not need to be specified.
Include the CSRF token template tag in the <form> body.
Render the Django form (its context variable will be form) inside <form>, using the as_p method.
Add a submit <button> to the form. Its text should depend on whether you’re editing or creating. Use the Save text for editing or Create for creating. You can use the Bootstrap classes for the button styling here. It should have the class="btn btn-primary" attribute.
In reviews/views.py, the publisher_edit view does not need many changes. Update the render call to render instance-form.html instead of form-example.html.
Update the context dictionary being passed to the render call. It should include the Publisher instance (the publisher variable that was already defined) and the model_type string. The context dictionary already includes form (a PublisherForm instance). You can remove the method key.
Since we’re finished with the form-example.html template, it can be deleted.
When you’ve finished, the Publisher creation page (at http://127.0.0.1:8000/publishers/new/) should look like what’s shown in Figure 7.24:

Figure 7.24 – The Publisher creation page
Figure 7.24 – The Publisher creation page

When editing a Publisher (for example, at http://127.0.0.1:8000/publishers/1/), your page should look like what’s shown in Figure 7.25:

Figure 7.25 – The Editing Publisher page
Figure 7.25 – The Editing Publisher page

After saving a Publisher instance, whether creating or editing, you should see a success message at the top of the page (Figure 7.26):

Figure 7.26 – Success message rendered as a Bootstrap alert
Figure 7.26 – Success message rendered as a Bootstrap alert

Note

The solution for this activity can be found on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

Activity 7.02 – Review Creation UI
Activity 7.01 – styling and integrating the Publisher form, was quite extensive; however, by completing it, you have created a foundation that makes it easier to add other edit and create views. You will experience this first-hand in this activity when you will build forms for creating and editing reviews. Because the instance-form.html template was made generically, you can reuse it in other views.

In this activity, you will create a review ModelForm, then add a review_edit view to create or edit a Review instance. You can reuse instance-form.html from Activity 7.01 – styling and integrating the Publisher form, and pass in different context variables to make it work with the Review model. When working with reviews, you’ll operate within the context of a book – that is, the review_edit view must accept a Book PK as an argument. You’ll fetch this Book separately and assign it to the Review instance that you create.

These steps will help you complete this activity:

In forms.py, add a ReviewForm subclass of ModelForm; its model should be Review (make sure you import the Review model).
ReviewForm should exclude the date_edited and book fields since the user should not be setting these in the form. The database allows any rating, but we can override the rating field with an IntegerField that requires a minimum value of 0 and a maximum value of 5.

Create a new view called review_edit. It should accept two arguments after request: book_pk, which is required, and review_pk, which is optional (defaults to None). Fetch the Book instance and Review instance using the get_object_or_404 shortcut (call it once for each type). When fetching the review, make sure the review belongs to the book. If review_pk is None, then the Review instance should be None too.

If the request method is POST, then instantiate a ReviewForm using request.POST and the review instance. Make sure you import this ReviewForm.
If the form is valid, save the form but set the commit argument from save to False. Then, set the book attribute on the returned Review instance to the book that was fetched in step 2.

If the Review instance is being updated instead of created, then you should also set the date_edited attribute to the current date and time. Use the from django.utils.timezone.now() function. Then, save the Review instance.

Finish the valid form branch by registering a success message and redirecting back to the book_detail view. Since the Review model doesn’t contain a meaningful text description, use the Book title in the message – for example, Review for “<book title>” created.
If the request method is not POST, instantiate a ReviewForm and just pass in the Review instance.
Render the instance-form.html template. In the context dictionary, include the same items as were used in publisher_view: form, instance, and model_type (Review). Include two extra items – related_model_type, which should be Book, and related_instance, which will be the Book instance.
Edit instance-form.html to add a place to display the related instance information added in step 6. Under the <h2> element, add an <p> element that is only displayed if both related_model_type and related_instance are set. It should show the text For <related_model_type> <related_instance> – for example, For Book Advanced Deep Learning with Keras. Put the related_instance output in an <em> element for better readability.
In the reviews app’s urls.py, add URL maps to the review_edit view. The /books/ and /books/<pk>/ URLs have already been configured. Add /books/<book_pk>/reviews/new/ to create a review and /books/<book_pk>/reviews/<review_pk>/ to edit a review. Make sure you give these names such as review_create and review_edit.
Inside the book_detail.html template, add links that a user can click on to create or edit a review. Add a link inside the content block, just before the endblock closing template tag. It should use the url template tag to link to the review_edit view when in creation mode. Also, use the class="btn btn-primary" attribute to make the link display like a Bootstrap button. The link text should be Add Review.
Finally, add a link to edit a review, inside the for loop that iterates over Reviews for Book. After all the instances of text-info <span>, add a link to the review_edit view using the url template tag. You will need to provide book.pk and review.pk as arguments. The text of the link should be Edit Review.
When you’re finished, the Review Comments page should look like what’s shown in Figure 7.27:

Figure 7.27 – The Book Details page with the added Add Review button
Figure 7.27 – The Book Details page with the added Add Review button

You will see the Add Review button. Clicking it will take you to the Create Book Review page, which should look like what’s shown in Figure 7.28:

Figure 7.28 – The Create Book Review page
Figure 7.28 – The Create Book Review page

Enter some details in the form and click Create. You’ll be redirected to the Book Details page. You should see the success message and your review, as shown in Figure 7.29:

Figure 7.29 – The Book Details page with a review added
Figure 7.29 – The Book Details page with a review added

You will also see the Edit Review link. If you click it, you will be taken to a form that has been pre-populated with your review data (see Figure 7.30):

Figure 7.30 – Review form when editing a review
Figure 7.30 – Review form when editing a review

After saving an existing review, you should see that the Modified on date has been updated on the Book Details page (Figure 7.31):

Figure 7.31 – The Modified on: date field has now been populated
Figure 7.31 – The Modified on: date field has now been populated

Note

The solution for this activity can be found on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

Summary
This chapter provided a deep dive into forms. We saw how to enhance Django forms with custom validation advanced rules for cleaning data and validating fields. We also saw how custom cleaning methods can transform the data that we get out of forms. A nice feature we saw that can be added to forms is the ability to set initial and placeholder values on fields so that the user does not have to fill them out.

We then looked at how to use the ModelForm class to automatically create a form from a Django model. We saw how to only show some fields to the user and how to apply custom form validation rules to the ModelForm. We also saw how Django can automatically save the new or updated model instance to the database inside the view. In the activities for this chapter, we enhanced Bookr some more by adding forms for creating and editing publishers and submitting reviews.

In the next chapter, we will continue with the theme of submitting user input, and we’ll discuss how Django handles file uploads and downloads.



| ≪ [ 06 Forms ](/packtpub/2024/422-web_development_with_django_2ed/06_forms) | 07 Advanced Form Validation and Model Forms | [ 08 Media Serving and File Uploads ](/packtpub/2024/422-web_development_with_django_2ed/08_media_serving_and_file_uploads) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/422-web_development_with_django_2ed/07_advanced_form_validation_and_model_forms
> (2) Markdown
> (3) Title: 07 Advanced Form Validation and Model Forms
> (4) Short Description: Publication date: May 2023 Publisher Packt Pages 764
> (5) tags: Django
> Book Title: 422-Web Development with Django 2ed
> Link: https://subscription.packtpub.com/book/web-development/9781803230603/pref
> create: 2024-05-08 수 14:11:52
> Images: /packtpub/2024/422-web_development_with_django_2ed_img/07/
> .md Name: 07_advanced_form_validation_and_model_forms.md

