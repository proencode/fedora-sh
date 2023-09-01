
| First Chapter | 👈 00 Preface 👉 |  [ 01.c1 Preparing a Local ](/packtpub/2203a_wordpress_plugin_development_230901/01_c1-preparing_a_local) |
|:---:|:---:|:---:|

Book Title:` WordPress Plugin Development Cookbook `
Short Description:` By Yannick Lefebvre Mar 2022 420 pages `
Link:` https://subscription.packtpub.com/book/web-development/9781801810777/pref `
create:` 2023-09-01 금 16:43:18 `

PAGE INFO Title:` 00 Preface `
Book Path:` packtpub/2203a_wordpress_plugin_development_230901/00-preface `
md Name:` 00-preface.md `


00 Preface
01.c1 Getting Started with Modern Android Development Skills
02.c1 Preparing a Local Development Environment
03.c2 Plugin Framework Basics
04.c3 User Settings and Administration Pages
05.c4 The Power of Custom Post Types
06.c5 Customizing Post and Page Editors
07.c6 Extending the Block Editor
08.c7 Accepting User Content Submissions
09.c8 Customizing User Data
10.c9 Leveraging JavaScript, jQuery, and AJAX Scripts
11.10 Adding New Widgets to the WordPress Library
12.11 Fetching, Caching, and Regularly Updating External Site Data
13.12 Enabling Plugin Internationalization
14.13 Distributing Your Plugin on WordPress.org
15 Other Books You May Enjoy


# Preface

As it approaches the twentieth anniversary of its initial release, WordPress continues to be one of the most widely used, powerful, and open **content management systems (CMSs)**. Whether you're a site owner trying to find the right extension, a developer who wants to contribute to the community, or a website developer working to fulfill a client's needs, learning how to extend WordPress' capabilities will help you to unleash its full potential.

This book will help you become familiar with API functions to create secure plugins with easy-to-use administration interfaces. Complete with new recipes and up-to-date code samples, including new chapters on the creation of custom blocks for the Block Editor and interacting with external data sources, this third-edition WordPress plugin development book teaches you how to create plugins of varying complexity ranging from using just a few lines of code to complex extensions that provide intricate new capabilities.

Starting with WordPress' basic mechanism for creating plugins, the book covers recipes to show you how to design administration panels, enhance the post editor with custom fields, store custom data, and even create custom blocks. You'll safely incorporate dynamic elements into web pages using scripting languages, learn how to integrate data from external sources, and build new widgets that can be added to WordPress sidebars and widget areas. By the end of this book, you'll be able to create WordPress plugins to perform almost any task you can imagine.

# Who this book is for

This book is for WordPress users, developers, and site integrators interested in creating new plugins to address their personal needs, fulfill client requirements, and bring new capabilities to the WordPress community. Basic knowledge of PHP and WordPress is expected.

What this book covers
Chapter 1, Preparing a Local Development Environment, shows plugin developers how to install and configure an efficient development environment.

Chapter 2, Plugin Framework Basics, explains the basic mechanics of registering user functions with WordPress to be executed at key points when web pages are displayed, forming the basis of plugin creation.

Chapter 3, User Settings and Administration Pages, covers the creation of administration pages that will allow users to configure the plugins you create.

Chapter 4, The Power of Custom Post Types, empowers developers to add whole new content management sections to the WordPress environment.

Chapter 5, Customizing Post and Page Editors, demonstrates how to alter the default administration post and page editing environment to add new capabilities.

Chapter 6, Extending the Block Editor, shows how to create new content blocks for the new Block Editor and facilitate building websites.

Chapter 7, Accepting User Content Submissions, allows users to submit their own content to new content sections that will be managed by your plugins.

Chapter 8, Customizing User Data, explains how to store additional information for users and how to modify site output based on this data.

Chapter 9, Leveraging JavaScript, jQuery, and AJAX Scripts, makes plugin output very dynamic by using a number of popular script libraries.

Chapter 10, Adding New Widgets to the WordPress Library, shows how to add new widgets that users will be able to easily drag and drop to add content to their web pages.

Chapter 11, Fetching, Caching, and Regularly Updating External Site Data, explains how to extract data from external sites and locally cache that data for efficient use.

Chapter 12, Enabling Plugin Internationalization, prepares your plugin to be translated into any language to make it easier to be used by non-English speakers.

Chapter 13, Distributing Your Plugin on WordPress.org, shows you how to prepare your plugin for sharing with the global WordPress community.

To get the most out of this book
All code examples in this book have been tested against WordPress 5.9 using the Twenty Twenty-Two theme, unless otherwise noted. As WordPress always strives for backward compatibility, they will likely work with future versions as well. All other software tools needed are covered in Chapter 1, Preparing a Local Development Environment.


If you are using the digital version of this book, we advise you to type the code yourself or access the code from the book's GitHub repository (a link is available in the next section). Doing so will help you avoid any potential errors related to the copying and pasting of code.

Download the example code files
You can download the example code files for this book from GitHub at https://github.com/PacktPublishing/WordPress-Plugin-Development-Cookbook-Third-Edition. If there's an update to the code, it will be updated in the GitHub repository.

We also have other code bundles from our rich catalog of books and videos available at https://github.com/PacktPublishing/. Check them out!

Download the color images
We also provide a PDF file that has color images of the screenshots and diagrams used in this book. You can download it here: https://static.packt-cdn.com/downloads/9781801810777_ColorImages.pdf

Conventions used
There are a number of text conventions used throughout this book.

Code in text: Indicates code words in text, database table names, folder names, filenames, file extensions, pathnames, dummy URLs, user input, and Twitter handles. Here is an example: "The widget method starts by calling the standard PHP extract function on the first parameter received, an array named $args, which contains a list of styling tidbits to render the widget."

A block of code is set as follows:

class Book_Reviews extends WP_Widget {
    function __construct () {
        parent::__construct( 'book_reviews', 
            'Book Reviews',
            array( 'description' =>
                   'Displays list of recent book reviews' ) );
    }
} 

Copy

Explain
When we wish to draw your attention to a particular part of a code block, the relevant lines or items are set in bold:

</tr><tr>
<td colspan="2">
<div class="g-recaptcha"
data-sitekey="[my-site-key]"></div>
</td>

Copy

Explain
Any command-line input or output is written as follows:

npm install --save-dev --save-exact @wordpress/scripts

Copy

Explain
Bold: Indicates a new term, an important word, or words that you see onscreen. For instance, words in menus or dialog boxes appear in bold. Here is an example: "Publish the new page and click on View Page to see the block on your development site."

Tips or Important Notes

Appear like this.

Sections
In this book, you will find several headings that appear frequently (Getting ready, How to do it..., How it works..., There's more..., and See also).

To give clear instructions on how to complete a recipe, use these sections as follows:

Getting ready
This section tells you what to expect in the recipe and describes how to set up any software or any preliminary settings required for the recipe.

How to do it…
This section contains the steps required to follow the recipe.

How it works…
This section usually consists of a detailed explanation of what happened in the previous section.

There's more…
This section consists of additional information about the recipe in order to make you more knowledgeable about the recipe.

See also
This section provides helpful links to other useful information for the recipe.

Get in touch
Feedback from our readers is always welcome.

General feedback: If you have questions about any aspect of this book, email us at customercare@packtpub.com and mention the book title in the subject of your message.

Errata: Although we have taken every care to ensure the accuracy of our content, mistakes do happen. If you have found a mistake in this book, we would be grateful if you would report this to us. Please visit www.packtpub.com/support/errata and fill in the form.

Piracy: If you come across any illegal copies of our works in any form on the internet, we would be grateful if you would provide us with the location address or website name. Please contact us at copyright@packt.com with a link to the material.

If you are interested in becoming an author: If there is a topic that you have expertise in and you are interested in either writing or contributing to a book, please visit authors.packtpub.com.

Share Your Thoughts
Once you've read WordPress Plugin Development Cookbook, we'd love to hear your thoughts! Please click here to go straight to the Amazon review page for this book and share your feedback.

Your review is important to us and the tech community and will help us make sure we're delivering excellent quality content.

Previous Chapter
Next Chapter








Annotate

