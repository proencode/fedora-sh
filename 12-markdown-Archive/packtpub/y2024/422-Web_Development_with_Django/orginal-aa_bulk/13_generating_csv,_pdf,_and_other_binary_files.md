
| ≪ [ 12 Building a REST API ](/packtpub/2024/422-web_development_with_django_2ed/12_building_a_rest_api) | 13 Generating CSV, PDF, and Other Binary Files | [ 14 Testing Your Django Applications ](/packtpub/2024/422-web_development_with_django_2ed/14_testing_your_django_applications) ≫ |
|:----:|:----:|:----:|

# 13 Generating CSV, PDF, and Other Binary Files

Packt Logo

Book image


Generating CSV, PDF, and Other Binary Files
So far, we have learned about the various aspects of the Django framework and explored how we can build web applications using Django with all the features and customizations we want.

Let’s say that, while building a web application, we need to do some analysis and prepare some reports. We may need to analyze user demographics about how the platform is being used or generate data that can be fed into machine learning systems to find patterns. We want our website to display some of the results of our analysis in a tabular format and other results as detailed graphs and charts. Furthermore, we want to allow our users to export the reports and peruse them further in applications such as Jupyter Notebook and Excel.

As we work our way through this chapter, we will learn how to bring these ideas to fruition and implement functionality in our web application that allows us to export records into structured formats such as tables through the use of Comma-Separated Value (CSV) files or Excel files. We will also learn how to allow our users to generate visual representations of the data we have stored inside our web application and export it in a PDF format so that it can be distributed easily for quick reference.

Let’s start our journey by learning how to work with CSV files in Python. Learning this skill will help us create functionality that allows our readers to export our data for further analysis.

In this chapter, we will be covering the following topics:

Working with CSV files inside Python
Working with Python’s csv module
Working with Excel files in Python
Working with PDF files in Python
Playing with graphs in Python
Integrating visualizations with Django
Technical requirements
The complete code files for this chapter can be found at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter13

Working with CSV files inside Python
There are several reasons we may need to export the data in our application. One of the reasons may involve analyzing that data – for example, we may need to understand the demographics of users registered on the application or extract patterns of application usage. We may also need to find out how our application is working for users to design future improvements. Such use cases require data to be in a format that can be easily consumed and analyzed. Here, the CSV file format comes to the rescue.

CSV is a handy file format that can be used to quickly export data from an application in a row-and-column format. CSV files usually have data separated by simple delimiters, which are used to differentiate one column from another, and newlines, which are used to indicate the start of a new record (or row) inside the table.

Python has great support for working with CSV files in its standard library, thanks to the csv module. This support enables the reading, parsing, and writing of CSV files. Let’s take a look at how we can leverage the csv module provided by Python to work on CSV files and read and write data from them.

Working with Python’s csv module
The csv module from Python allows us to interact with files that are in CSV format, which is nothing but a text file format – that is, the data stored inside the CSV files is human-readable.

The csv module requires that the file is opened before the methods supplied by the csv module can be applied. Let’s take a look at how we can start with the very basic operation of reading data from CSV files.

Reading data from a CSV file
Reading data from CSV files is quite easy and consists of the following steps:

First, we must open the file by running the following script:

csv_file = open('path to csv file')

Copy

Explain
Here, we are reading the file using the Python open() method, which requires the fully qualified name of the file. This should be opened so that it can be passed as the parameter to the method.

Then, we must read the data from the file object using the csv module’s reader method:

import csv
csv_data = csv.reader(csv_file)

Copy

Explain
In the first line, we imported the csv module, which contains the set of methods required to work on CSV files.

With the file opened, the next step is to create a CSV reader object by using the csv module’s reader method. This method takes in the file object as returned by the open() call and uses the file object to read the data from the CSV file:

csv_reader = csv.reader(csv_file)

Copy

Explain
The data read by the reader() method is returned as a list of a list, where every sublist is a new record and every value inside the list is a value for the specified column. Generally, the first record in the list is referred to as a header, which denotes the different columns that are present inside the CSV file, but it is not necessary to have a header field inside a CSV file.

Once the data has been read by the csv module, we can iterate over this data to perform any kind of operation we may desire. This can be done as follows:

for csv_record in csv_data:
    # do something

Copy

Explain
Once the processing is done, we can close the CSV file simply by using the close() method in Python’s file handler object:

csv_file.close()

Copy

Explain
Now, let’s look at our first exercise, where we will implement a simple module that helps us read a CSV file and output its contents on our screen.

Exercise 13.0 – reading a CSV file with Python
In this exercise, we will read and process a CSV file inside Python using Python’s built-in csv module. The CSV file contains fictitious market data of several NASDAQ-listed companies. Let’s get started with the steps:

First, download the market_cap.csv file from the GitHub repository for this book by clicking the following link: https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/blob/main/Chapter13/Exercise13.01/market_cap.csv.
Important note

The CSV file consists of randomly generated data and does not correspond to any historical market trends.

Once the file has been downloaded, open it and take a look at its contents. You will realize that the file contains a set of comma-separated values with each different record on its own line:
Figure 13.1﻿ – Contents of the market_cap CSV file
Figure 13.1 – Contents of the market_cap CSV file

Once the file has been downloaded, you can write the first piece of code. For this, create a new file named csv_reader.py in the same directory where the CSV file was downloaded and add the following code to it:
import csv
def read_csv(filename):
    """Read and output the details of CSV file."""
    try:
        with open(filename, newline='') as csv_file:
            csv_reader = csv.reader(csv_file)
            for record in csv_reader:
                print(record)
    except (IOError, OSError) as file_read_error:
        print("Unable to open the csv file. Exception:
               {}".format(file_read_error))
if __name__ == '__main__':
    read_csv('market_cap.csv')

Copy

Explain
Let’s try to understand what you just implemented in the preceding snippet of code.

After importing the csv module, to keep the code modular, you created a new method named read_csv() that takes in a single parameter – the filename to read the data from:

try:
    with open(filename, newline='') as csv_file:

Copy

Explain
Now, if you are not familiar with the approach of opening the file shown in the preceding snippet, this is also known as the try-with-resources approach. In this case, any block of code that is encapsulated in the scope of the with block will have access to the file object, and once the code exits the scope of the with block, the file will be closed automatically.

Important note

It is a good habit to encapsulate file I/O operations within a try-except block since file I/O can fail for several reasons and showing stack traces to the users is not a good option.

The reader() method returns a reader object over which you can iterate to access the values, as we saw in the Reading data from a CSV file section:

for record in csv_reader:
    print(record)

Copy

Explain
Once this is done, you must write the entry point method, from which your code will begin executing, by calling the read_csv() method and passing the name of the CSV file to read:

if __name__ == '__main__':
    read_csv(market_cap.csv')

Copy

Explain
With this, you are done and ready to parse your CSV file. You can do this by running your Python file in a Terminal or Command Prompt, as shown here:
python3 csv_reader.py

Copy

Explain
Once the code executes, you should see the following output:

Figure 13.2: Output from the CSV reader program
Figure 13.2: Output from the CSV reader program

With this, you now know how to read CSV file contents. Also, as you can see from the output of Exercise 13.01 – reading a CSV file with Python, the output for individual rows is represented in the form of a list.

Now, let’s look at how we can use the Python csv module to create new CSV files.

Writing to CSV files using Python
In the previous section, we explored how we can use the csv module in Python to read the contents of CSV-formatted files. Now, let’s learn how we can write CSV data to files.

Writing CSV data follows a similar approach as reading from a CSV file, with some minor differences. The following steps outline the process of writing data to CSV files:

Open the file in writing mode by running the following script:

csv_file = open('path to csv file', 'w')

Copy

Explain
Obtain a CSV writer object, which can help us write data that is correctly formatted in CSV format. This can be done by calling the writer() method of the csv module, which returns a writer object, which can be used to write CSV format-compatible data to a CSV file:

csv_writer = csv.writer(csv_file)

Copy

Explain
Once the writer object is available, we can start writing the data. This is facilitated by the write_row() method of the writer object. The write_row() method takes in a list of values that it writes to the CSV file. The list itself indicates a single row and the values inside the list indicate the values of columns:

record = ['value1', 'value2', 'value3']
csv_writer.writerow(record)

Copy

Explain
If you want to write multiple records in a single call, you can also use the writerows() method of the CSV writer. The writerows() method behaves similarly to the writerow() method but takes a list of lists and can write multiple rows in one go:

records = [['value11', 'value12', 'value13'], ['value21', 'value22', 'value23']]
csv_writer.writerows(records)

Copy

Explain
Once the records have been written, we can close the CSV file:

csv_file.close()

Copy

Explain
Now, let’s apply what we’ve learned to the next exercise and implement a program that will help us write values to CSV files.

Exercise 13.02 – generating a CSV file using Python’s csv module
In this exercise, you will use the Python csv module to create new CSV files:

Create a new file named csv_writer.py, inside which you will write the code for the CSV writer. Inside this file, add the following code:
import csv
def write_csv(filename, header, data):
    """Write the provided data to the CSV file.
    :param str filename: The name of the file to which
        the data should be written
    :param list header: The header for the columns in
        csv file
    :param list data: The list of list mapping the
        values to the columns
    """
    try:
        with open(filename, 'w') as csv_file:
            csv_writer = csv.writer(csv_file)
            csv_writer.writerow(header)
            csv_writer.writerows(data)
    except (IOError, OSError) as csv_file_error:
        print("Unable to write the contents to csv
               file. Exception:
               {}".format(csv_file_error))

Copy

Explain
With this code, you should now be able to create new CSV files easily. Now, going step by step, let’s understand what we are trying to do in this code.

We defined a new method called write_csv(), which takes three parameters: the name of the file to which the data should be written (filename), the list of column names that should be used as headers (header), and a list of a list that contains the data that needs to be mapped to individual columns (data):

 def write_csv(filename, header, data):

Copy

Explain
Now, with the parameters in place, the next step is to open the file to which the data needs to be written and map it to an object:

with open(filename, 'w') as csv_file:

Copy

Explain
Once the file is opened, we perform three main steps:

First, we obtain a new CSV writer object by using the writer() method from the csv module and pass it to the file handler that holds a reference to our opened file:
csv_writer = csv.writer(csv_file)

Copy

Explain
The next step involves using the CSV writer’s writerow() method to write our dataset’s header fields into the file:
csv_writer.writerow(header)

Copy

Explain
Once we have written the header, the last step is to write the data to the CSV file for the individual columns that are present. For this, we can use the csv module’s writerows() method to write multiple rows at once:
csv_writer.writerows(data)

Copy

Explain
Important note

While the preceding steps outline the verbose version of writing to a CSV file to provide better clarity of the underlying working of how CSV files should be structured, we could have merged the step of writing the header and data into a single line of code by having the header list as the first element of the data list and calling the writerows() method with the data list as a parameter.

Once we have created the methods that can write the provided data to a CSV file, we must write the code for the entry point call, and inside it, set up the values for the header, data, and filename fields, and finally call the write_csv() method that we defined earlier:
if __name__ == '__main__':
    header = ['name', 'age', 'gender']
    data = [['Richard', 32, 'M'], ['Mumzil', 21, 'F'],
           ['Melinda', 25, 'F']]
    filename = 'sample_output.csv'
    write_csv(filename, header, data)

Copy

Explain
Now, with the code in place, execute the file we just created and see whether it creates the CSV file. To execute it, run the following command:
python3 csv_writer.py

Copy

Explain
Once the execution finishes, you will see that a new file has been created in the same directory as the one in which you executed the command. When you open the file, the contents should resemble what you can see in the following figure:

Figure 13.3: Output from the CSV writer sample_output.csv
Figure 13.3: Output from the CSV writer sample_output.csv

Now, we are well equipped to read and write the contents of CSV files.

With this exercise, we have learned how to write data to a CSV file. Now, it is time to look at some enhancements that can make reading and writing data to CSV files as a developer more convenient.

A better way to read and write CSV files
Now, there is one important thing that needs to be taken care of. As you may recall, the data read by the CSV reader usually maps values to a list. Now, if you want to access the values of individual columns, you need to use list indexes to access them. This is not natural and causes a higher degree of coupling between the program responsible for writing the file and the one responsible for reading the file. For example, what if the writer program shuffled the order of the rows? In this case, you now have to update the reader program to make sure it identifies the correct rows. So, the question arises, do we have a better way to read and write values that, instead of using list indexes, uses column names while preserving the context?

The answer to this is yes, and the solution is provided by another set of CSV modules known as DictReader and DictWriter, which provide the functionality of mapping objects in a CSV file to dict, rather than to a list.

This interface is easy to implement. Let’s revisit the code you wrote in Exercise 13.01 – reading a CSV file with Python. If you wanted to parse the code as dict, the implementation of the read_csv() method would need to be changed, as shown here:

def read_csv(filename):
    """Read and output the details of CSV file."""
    try:
        with open(filename, newline='') as csv_file:
            csv_reader = csv.DictReader(csv_file)
            for record in csv_reader:
                print(record)
    except (IOError, OSError) as file_read_error:
       print("Unable to open the csv file. Exception:
              {}".format(file_read_error))

Copy

Explain
As you will notice, we only changed csv.reader() to csv.DictReader(), which should represent individual rows in the CSV file as OrderedDict. You can also verify this by making this change and executing the following command:

python3 csv_reader.py

Copy

Explain
This should result in the following output:

Figure 13.4: Output with DictReader
Figure 13.4: Output with DictReader

As you can see in the preceding figure, the individual rows are mapped as key-value pairs in the dictionary. To access these individual fields in rows, we can use this:

print(record.get('stock_symbol'))

Copy

Explain
That should give us the value of the stock_symbol field from our individual records.

Similarly, you can also use the DictWriter() interface to operate on CSV files as dictionaries. To see this, let’s take a look at the write_csv() method from Exercise 13.02 – generating a CSV file using Python’s csv module, and modify it as follows:

def write_csv(filename, header, data):
    """Write the provided data to the CSV file.
    :param str filename: The name of the file to which the
        data should be written
    :param list header: The header for the columns in csv
        file
    :param list data: The list of dicts mapping the values
        to the columns
    """
    try:
        with open(filename, 'w') as csv_file:
            csv_writer = csv.DictWriter(csv_file,
                                        fieldnames=header)
            csv_writer.writeheader()
            csv_writer.writerows(data)
    except (IOError, OSError) as csv_file_error:
        print("Unable to write the contents to csv file.
               Exception: {}".format(csv_file_error))

Copy

Explain
In the preceding code, we replaced csv.writer() with csv.DictWriter(), which provides a dictionary-like interface to interact with CSV files. DictWriter() also takes in a fieldnames parameter, which is used to map the individual columns in a CSV file before writing.

Next, to write this header, call the writeheader() method, which writes the fieldname header to the CSV file.

The final call involves the writerows() method, which takes in a list of dictionaries and writes them to the CSV file. For the code to work correctly, you also need to modify the data list to resemble the one shown here:

data = [{'name': Richard, 'age': 32, 'gender': 'M'},
        {'name': Mumzil', 'age': 21, 'gender':'F'},
        {'name': 'Melinda', 'age': 25, 'gender': 'F'}]

Copy

Explain
With this, you have enough knowledge to work with CSV files inside Python.

With this section, we have learned about how to work with CSV files in Python using the standard library-provided csv module.

Since we are talking about how to deal with tabular data, specifically reading and writing it to files, let’s take a look at one of the more well-known file formats used by one of the most popular tabular data editors – Microsoft Excel.

Working with Excel files in Python
Microsoft Excel is a world-renowned software in the field of bookkeeping and tabular record management. Similarly, the XLSX file format that was introduced with Excel has seen rapid and widespread adoption and is now supported by all the major product vendors.

You will find that Microsoft Excel and its XLSX format are used quite a lot in the marketing and sales departments of many companies. Let’s say, for one such company’s marketing department, you are building a web portal in Django that keeps track of the products purchased by users. It also displays data about the purchases, such as the time of purchase and the location where the purchase was made. The marketing and sales teams are planning to use this data to generate leads or to create relevant advertisements.

The marketing and sales teams also use Excel quite a lot. You might want to export the data available inside your web application in XLSX format, which is native to Excel.

Soon, we will look at how we can make our website work with the XLSX format. But before that, let’s quickly take a look at the usage of binary file formats.

Binary file formats for data exports
Until now, we have worked mainly with textual data and how we can read and write it from text files. But often, text-based formats are not enough. For example, imagine you want to export an image or a graph. How will you represent an image or a graph as text, and how will you read and write to these images?

To help us in these situations, binary file formats come into the picture, which can help us read and write to and from a rich and diverse set of data. All commercial operating systems provide native support for working with both text and binary file formats, and it comes as no surprise that Python provides one of the most versatile implementations to work on binary data files. A simple example of this is the open command, which you can use to state the format you would like to open a file in:

file_handler = open('path to file', 'rb')

Copy

Explain
Here, b indicates binary.

Starting from this section, we will now be dealing with how we can work on binary files and use them to represent and export data from our Django web application. The first of the formats we are going to look at is the XLSX file format made popular by Microsoft Excel.

So, let’s dive into handling XLSX files with Python.

Working with XLSX files using the XlsxWriter package
In this section, we will learn more about the XLSX file format and understand how we can work with it using the XlsxWriter package.

XLSX files
XLSX files are binary files that are used to store tabular data. These files can be read by any software that implements support for this format. The XLSX format arranges data into two logical partitions:

Workbooks: Each XLSX file is called a workbook and is supposed to contain datasets related to a particular domain. In Figure 13.5, Examplefile.xlsx is a workbook (1):
Figure 13.5: Workbooks and worksheets in Excel
Figure 13.5: Workbooks and worksheets in Excel

Worksheets: Inside each workbook, there can be one or more worksheets, which are used to store data about different but logically related datasets in a tabular format. In Figure 13.5, Sheet1 and Sheet2 are two worksheets (2).
When working with XLSX format, these are the two units that we generally work on. If you know about relational databases, you can think of workbooks as databases and worksheets as tables.

Now, let’s try to understand how we can start working on XLSX files inside Python.

The XlsxWriter Python package
Python does not provide native support for working with XLSX files through its standard library. But thanks to the vast community of developers within the Python ecosystem, it is easy to find several packages that can help us manage our interaction with XLSX files. One popular package in this category is XlsxWriter.

XlsxWriter is an actively maintained package by the developer community that provides support for interacting with XLSX files. The package provides a lot of useful functionalities and supports the creation and management of workbooks as well as worksheets in individual workbooks. You can install it by running the following command in a Terminal or Command Prompt:

pip install XlsxWriter

Copy

Explain
Once installed, you can import the xlsxwriter module as follows:

import xlsxwriter

Copy

Explain
So, let’s look at how we can start creating XLSX files with the support of the XlsxWriter package.

Creating a workbook
To start working on XLSX files, we first need to create them. An XLSX file is also known as a workbook and can be created by calling the Workbook class from the xlsxwriter package, as follows:

workbook = xlsxwriter.Workbook(filename)

Copy

Explain
The call to the Workbook class opens a binary file, specified with the filename argument, and returns an instance of workbook that can be used to further create worksheets and write data.

Creating a worksheet
Before we can start writing data to an XLSX file, we first need to create a worksheet. This can be done easily by calling the add_worksheet() method of the workbook object we obtained in the previous section:

worksheet = workbook.add_worksheet()

Copy

Explain
The add_worksheet() method creates a new worksheet, adds it to the workbook, and returns an object mapping the worksheet to a Python object, through which we can write data to the worksheet.

Writing data to the worksheet
Once a reference to the worksheet is available, we can start writing data to it by calling the write method of the worksheet object, as shown here:

worksheet.write(row_num, col_num, col_value)

Copy

Explain
As you can see, the write() method takes three parameters: a row number (row_num), a column number (col_num), and the data that belongs to the [row_num, col_num] pair, as represented by col_value. This call can be repeated to insert multiple data items into the worksheet.

Writing data to the workbook
Once all the data has been written, to finalize the written datasets and cleanly close the XLSX file, you must call the close() method on the workbook:

workbook.close()

Copy

Explain
This method writes any data that may be in the file buffer and finally closes the workbook. Now, let’s use this knowledge to implement our own code, which will help us write data to an XLSX file.

Important note

It’s not possible to cover all the methods and features the XlsxWriter package provides in this chapter. For more information, you can read the official documentation: https://xlsxwriter.readthedocs.io/contents.html.

Exercise 13.03 – creating XLSX files in Python
In this exercise, we will use the XlsxWriter package to create a new Excel (XLSX) file and add data to it from Python:

Install the XlsxWriter package on your system by running the following command in your Terminal app or Command Prompt:
pip install XlsxWriter

Copy

Explain
Once the command finishes, you will have the package installed on your system.

With the package installed, we can start writing the code that will create the Excel file.

Create a new file named xlsx_demo.py and add the following code to it:
import xlsxwriter
def create_workbook(filename):
    """Create a new workbook on which we can work."""
    workbook = xlsxwriter.Workbook(filename)
    return workbook

Copy

Explain
In the preceding code snippet, we created a new function that will assist us in creating a new workbook in which we can store your data. Once we have created a new workbook, the next step is to create a worksheet that provides us with the tabular format needed for us to organize the data to be stored inside the XLSX workbook.

With the workbook created, create a new worksheet by adding the following code snippet to your xlsx_demo.py file:
def create_worksheet(workbook):
    """Add a new worksheet in the workbook."""
    worksheet = workbook.add_worksheet()
    return worksheet

Copy

Explain
In the preceding code snippet, we created a new worksheet using the add_worksheet() method of the workbook object provided by the XlsxWriter package. This worksheet will be used to write the data for the objects.

The next step is to create a helper function that can assist us in writing the data to the worksheet in a tabular format defined by the row and column numbering. For this, add the following snippet of code to your xlsx_writer.py file:
def write_data(worksheet, data):
    """Write data to the worksheet."""
    for row in range(len(data)):
        for col in range(len(data[row])):
            worksheet.write(row, col, data[row][col])

Copy

Explain
In the preceding code snippet, we created a new function named write_data() that takes two parameters: the worksheet object to which the data needs to be written and the data object represented by a list of lists that needs to be written to the worksheet. The function iterates over the data passed to it and then writes the data to the row and column it belongs to.

With all the core methods now implemented, we can add the method that can help close the workbook object cleanly so that the data is written to the file without any file corruption happening. For this, implement the following code snippet in the xlsx_demo.py file:

def close_workbook(workbook):
    """Close an opened workbook."""
    workbook.close()

Copy

Explain
The last step is to integrate all the methods we have implemented in the previous steps. For this, create a new entry point method in your xlsx_demo.py file:

if __name__ == '__main__':
    data = [['John Doe', 38], ['Adam Cuvver', 22],
           ['Stacy Martin', 28], ['Tom Harris', 42]]
    workbook = create_workbook('sample_workbook.xlsx')
    worksheet = create_worksheet(workbook)
    write_data(worksheet, data)
    close_workbook(workbook)

Copy

Explain
In the preceding code snippets, we created a dataset that we want to write to the XLSX file in the form of a list of lists. Once that was done, we obtained a new workbook object, which will be used to create an XLSX file. Inside this workbook object, we created a worksheet to organize our data in a row-and-column format, wrote the data to the worksheet, and closed the workbook to persist the data to the disk.

Now, let’s see whether the code you wrote works the way it is expected to work. For this, run the following command:
python3 xlsx_demo.py

Copy

Explain
Once the command has finished executing, you will see that a new file called sample_workbook.xlsx has been in the directory where the command was executed. To verify whether it contains the correct results, open this file with either Microsoft Excel or Google Sheets and view its contents. It should resemble what you can see here:

Figure 13.6: Excel sheet generated using xlsxwriter
Figure 13.6: Excel sheet generated using xlsxwriter

With the help of the xlsxwriter module, you can also apply formulas to your columns. For example, if you wanted to add another row that shows the average age of the people in the spreadsheet, you can do that simply by modifying the write_data() method, as shown here:

def write_data(worksheet, data):
    """Write data to the worksheet."""
    for row in range(len(data)):
        for col in range(len(data[row])):
            worksheet.write(row, col, data[row][col])
    worksheet.write(len(data), 0, "Avg. Age").
    # len(data) will give the next index to write to
    avg_formula = "=AVERAGE(B{}:B{})".format(
        1, len(data))
    worksheet.write(len(data), 1, avg_formula)

Copy

Explain
In the preceding code snippet, we added an additional write call to the worksheet and used the AVERAGE function provided by Excel to calculate the average age of the people in the worksheet.

With this, you now know how we can generate Microsoft Excel-compatible XLSX files using Python and how to export tabular content that’s easily consumable by the different teams in your organization.

Now, let’s cover another interesting file format that is widely used across the world: PDF.

Working with PDF files in Python
Portable Document Format or PDF is one of the most common file formats in the world. You must have encountered PDF documents at some point. These documents can include business reports, digital books, and more.

Do you remember encountering websites that have a button that reads Print page as PDF? A lot of websites for government agencies readily provide this option, which allows you to print the web page directly as a PDF. So, the question arises, how can we do this for our web app? How should we add the option to export certain content as a PDF?

Over the years, a huge community of developers has contributed a lot of useful packages to the Python ecosystem. One of those packages can help us achieve PDF file generation.

Converting web pages into PDFs
Sometimes, we may run into situations where we want to convert a web page into a PDF. For example, we may want to print a web page to store it as a local copy. This also comes in handy when trying to print a certificate that is natively displayed as a web page.

To help us in such efforts, we can leverage a simple library known as weasyprint, which is maintained by a community of Python developers and allows web pages to be quickly and easily converted into PDFs. So, let’s take a look at how we can generate a PDF version of a web page.

Exercise 13.04 – generating a PDF version of a web page in Python
In this exercise, we will generate a PDF version of a website using Python. We will use a community-contributed Python module known as weasyprint that will help us generate the PDF. Let’s get started:

To make the code in the upcoming steps work correctly, install the weasyprint module on your system by running the following command:
pip install weasyprint

Copy

Explain
Important note

weasyprint depends on the cairo library. If you haven’t installed it yet, using weasyprint might raise an error with a message stating libcairo-2.dll file not found. To resolve this error, follow the steps mentioned in the weasyprint installation link at https://weasyprint.readthedocs.io/en/stable/install.html#windows.

With the package now installed, create a new file named pdf_demo.py that will hold the PDF generation logic. Inside this file, write the following code:
from weasyprint import HTML
def generate_pdf(url, pdf_file):
    """Generate PDF version of the provided URL."""
    print("Generating PDF...")
    HTML(url).write_pdf(pdf_file)

Copy

Explain
Now, let’s try to understand what this code does. In the first line, we imported the HTML class from the weasyprint package, which you installed in step 1:

from weasyprint import HTML

Copy

Explain
This HTML class provides us with a mechanism through which we can read the HTML content of a website if we have its URL.

In the next step, we created a new method named generate_pdf() that takes in two parameters – the URL that should be used as the source URL for generating the PDF and the pdf_file parameter, which takes in the name of the file to which the document should be written:

def generate_pdf(url, pdf_file):

Copy

Explain
Next, we passed the URL to the HTML class object we imported earlier. This caused the URL to be parsed by the weasyprint library and caused its HTML content to be read. Once this was done, we called the write_pdf() method of the HTML class object and provided the name of the file to which the content should be written:

HTML(url).write_pdf(pdf_file)

Copy

Explain
After this, write the entry point code that sets up the URL (for this exercise, we will use the text version of the National Public Radio (NPR) website) that should be used for your demo and the filename that should be used to write the PDF content to. Once that has been set, the code calls the generate_pdf() method to generate the content:
if __name__ == '__main__':
    url = 'http://text.npr.org'
    pdf_file = 'demo_page.pdf'
    generate_pdf(url, pdf_file)

Copy

Explain
Now, to see the code in action, run the following command:
python3 pdf_demo.py

Copy

Explain
Once the command finishes executing, you will have a new PDF file named demo_page.pdf that has been saved in the same directory where the command was executed. When you open the file, it should resemble what you can see here:

Figure 13.7: Web page converted into a PDF using weasyprint
Figure 13.7: Web page converted into a PDF using weasyprint

In the PDF file that was generated, we can see that the content seems to lack the formatting that the actual website has. This has happened because the weasyprint package reads the HTML content but does not parse the attached CSS stylesheets for the page, so the page formatting is lost.

weasyprint also makes it quite easy to change the formatting of a page. This can be done simply by introducing the stylesheets parameter to the write_pdf() method. A simple modification to our generate_pdf() method is shown here:

from weasyprint import CSS, HTML
def generate_pdf(url, pdf_file):
    """Generate PDF version of the provided URL."""
    print("Generating PDF...")
    css = CSS(string='body{ font-size: 8px; }')
    HTML(url).write_pdf(pdf_file, stylesheets=[css])

Copy

Explain
Now, when the preceding code is executed, we will see that the font size for all the text inside the HTML body content of the page has a size of 8px in the printed PDF version.

Important note

The HTML class in weasyprint is also capable of taking any local files as well as raw HTML string content and using those files to generate PDFs. For further information, please visit the weasyprint documentation at https://weasyprint.readthedocs.io.

So far, we have learned how we can generate different types of binary files with Python, which can help us export our data in a structured manner or help us print PDF versions of our pages. Next, we will learn how to generate graph representations of our data using Python.

Playing with graphs in Python
Graphs are a great way to visually represent data that changes within a specific dimension. We come across graphs quite frequently in our day-to-day lives, be it weather charts for a week, stock market movements, or student performance report cards.

Similarly, graphs can come in quite handy when we are working with our web applications. For Bookr, we can use graphs as a visual medium to show how many books users read each week. Alternatively, we can show them the popularity of a book over time based on how many readers were reading the given book at a specific time. Now, let’s look at how we can generate plots with Python and have them show up on our web pages.

Generating graphs with plotly

Graphs can come in quite handy when trying to visualize patterns in the data maintained by our applications. There are a lot of Python libraries that support developers in generating static or interactive graphs.

For this book, we will use plotly, a community-supported Python library that generates graphs and renders them on web pages. plotly is particularly interesting to us due to its ease of integration with Django.

To install it on your system, you can run the following command:

pip install plotly

Copy

Explain
Now that you’ve done that, let’s take a look at how we can generate a graph visualization using plotly.

Setting up a figure
Before we can start generating a graph, we need to initialize a plotly Figure object, which essentially acts as a container for our graph. A plotly Figure object is quite easy to initialize; it can be done by using the following code snippet:

from plotly.graph_objs import graphs
figure = graphs.Figure()

Copy

Explain
The Figure() constructor from the graph_objs module of the plotly library returns an instance of the Figure graph container, inside which a graph can be generated. Once the Figure object is in place, we must generate a plot.

Generating a plot
A plot is a visual representation of a dataset. This plot could be a scatter plot, a line graph, a chart, and so on. For example, to generate a scatter plot, you can use the following code snippet:

scatter_plot = graphs.Scatter(x_axis_values, y_axis_values)

Copy

Explain
The Scatter constructor takes in the values for the X-axis and Y-axis and returns an object that can be used to build a scatter plot. Once the scatter_plot object has been generated, the next step is to add this plot to our Figure. This can be done as follows:

figure.add_trace(scatter_plot)

Copy

Explain
The add_trace() method is responsible for adding a plotting object to the figure and generating its visualization inside the figure.

Rendering a plot on a web page
Once the plot has been added to the figure, it can be rendered on a web page by calling the plot() method from the offline plotting module of the plotly library. This is shown in the following code snippet:

from plotly.offline import plot
visualization_html = plot(figure, output_type='div')

Copy

Explain
The plot() method takes two primary parameters: the first is the figure that needs to be rendered and the second is the HTML tag of the container inside which the figure HTML will be generated. The plot method returns fully integrated HTML that can be embedded in any web page or made a part of the template to render a graph.

Now, with this understanding of how graph plotting works, let’s try a hands-on exercise where we will generate a graph for our sample dataset.

Exercise 13.05 – generating graphs in Python

In this exercise, we will generate a graph plot using Python. It will be a scatter plot that represents two-dimensional data:

For this exercise, we will be using the plotly library. To use this library, we need to install it on the system by running the following command:
pip install plotly

Copy

Explain
With the library now installed, create a new file named scatter_plot_demo.py and add the following import statements to it:
from plotly.offline import plot
import plotly.graph_objs as graphs

Copy

Explain
Once the imports have been sorted, create a method named generate_scatter_plot() that takes in two parameters – the values for the X-axis and the values for the Y-axis:
def generate_scatter_plot(x_axis, y_axis):
    """Generate a scatter plot for the provided x and
        y-axis values."""

Copy

Explain
Inside this method, first, create an object to act as a container for the graph:
    figure = graphs.Figure()

Copy

Explain
Once the container for the graph has been set up, create a new Scatter object with the values for the X-axis and Y-axis and add it to the graph’s Figure container:
    scatter = graphs.Scatter(x=x_axis, y=y_axis)
    figure.add_trace(scatter)

Copy

Explain
Once the scatter plot is ready and has been added to the figure, the last step is to generate the HTML, which can be used to render this plot inside a web page. To do this, call the plot() method and pass the graph container object to it. Then, render the HTML inside an HTML div tag:
    return plot(figure, output_type='div')

Copy

Explain
The complete generate_scatter_plot() method should look like this now:

def generate_scatter_plot(x_axis, y_axis):
    figure = graphs.Figure()
    scatter = graphs.Scatter(x=x_axis, y=y_axis)
    figure.add_trace(scatter)
    return plot(figure, output_type='div')

Copy

Explain
Once the HTML for the plot has been generated, it needs to be rendered somewhere. For this, create a new method named generate_html(), which will take in the plot HTML as its parameter and render an HTML file consisting of the plot:
def generate_html(plot_html):
    """Generate an HTML page for the provided plot."""
    html_content = "<html><head><title>Plot Demo
        </title></head><body>{}</body></html>"
            .format(plot_html)
    try:
        with open('plot_demo.html', 'w') as plot_file:
            plot_file.write(html_content)
    except (IOError, OSError) as file_io_error:
        print("Unable to generate plot file.
               Exception: {}".format(file_io_error))

Copy

Explain
Once the method has been set up, the last step is to call it. For this, create a script entry point that will set up the values for the X-axis list and the Y-axis list and then call the generate_scatter_plot() method. With the value returned by the method, make a call to the generate_html() method, which will create an HTML page consisting of the scatter plot:
if __name__ == '__main__':
    x = [1,2,3,4,5]
    y = [3,8,7,9,2]
    plot_html = generate_scatter_plot(x, y)
    generate_html(plot_html)

Copy

Explain
With the code in place, run the file and see what output is generated. To run the code, execute the following command:
python3 scatter_plot_demo.py

Copy

Explain
Once the execution completes, there will be a new plot_demo.html file in the same directory in which the script was executed. Upon opening the file, you should see the following:

Figure 13.8: Graph generated in the browser using plotly
Figure 13.8: Graph generated in the browser using plotly

With this, we have generated our first scatter plot, where different points are connected by a line.

In this exercise, we used the plotly library to generate a graph that can be rendered inside a browser for your readers to visualize data.

Now, you know how you can work with graphs in Python and how to generate HTML pages from them.

But as a web developer, how you can use these graphs in Django? Let’s find out.

Integrating plotly with Django
The graphs generated by plotly are quite easy to embed in Django templates. Since the plot() method returns a fully contained HTML that can be used to render a graph, we can use the HTML returned as a template variable in Django and pass it as-is. The Django templating engine will then take care of adding this generated HTML to the final template before it is shown in the browser.

Some sample code for doing this is shown here:

def user_profile(request):
    username = request.user.get_username()
    scatter_plot_html = scatter_plot_books_read(username)
    return render(request, 'user_profile.html',
                  context={'plt_div': scatter_plot_html})

Copy

Explain
The preceding code will cause the {{ plt_div }} content used inside the template to be replaced by the HTML stored inside the scatter_plot_demo variable, and the final template to render the scatter plot of the number of books read per week.

Now, let’s take a deep dive into how to handle adding visualizations to Django and enhancing the experience of our applications with plots and graphs.

Integrating visualizations with Django
In the preceding sections, you learned how data can be read and written in different formats that cater to the different needs of users. But how can we use what we’ve learned to integrate with Django?

For example, in Bookr, we might want to allow the user to export a list of books that they have read or visualize their book-reading activity over a year. How can that be done? The next exercise focuses on this aspect. You will learn how the components that we have seen so far can be integrated into Django web applications.

Exercise 13.06 – visualizing a user’s reading history on the user’s profile page
In this exercise, we will modify the user’s profile page so that the user can visualize their book-reading history when they visit their profile page on Bookr.

Let’s look at how this can be done:

To start integrating the ability to visualize the reading history of the user, you need to install the plotly library. To do this, run the following command in your Terminal:
pip install plotly

Copy

Explain
Once the library has been installed, the next step is to write the code that will fetch the total books read by the user as well as the books read by the user on a per-month basis. For this, create a new file named utils.py under the bookr application directory and add the required imports, which will be used to fetch the book-reading history of the user from the Review model of the reviews application:
import datetime
from django.db.models import Count
from reviews.models import Review

Copy

Explain
Next, create a new utility method named get_books_read_by_month() that takes in the username of the user for whom the reading history needs to be fetched.
Inside this method, we will query the Review model and return a dictionary of books read by the user on a per-month basis:
def get_books_read_by_month(username):
    """Get the books read by the user on per month
        basis.
    :param: str The username for which the books needs
        to be returned
    :return: dict of month wise books read
    """
    current_year = datetime.datetime.now().year
    books = Review.objects.filter(
        creator__username__contains=username,
        date_created__year=current_year)
        .values('date_created__month')
        .annotate(book_count=Count('book__title'))
    return books

Copy

Explain
Now, let’s examine the following query, which is responsible for fetching the results of books read this year every month:

Review.objects.filter(
    creator__username__contains=username,
    date_created__year=current_year)
    .values('date_created__month')
    .annotate(book_count=Count('book__title'))

Copy

Explain
This query can be broken down into the following components:

Filtration
Review.objects.filter(
    creator__username__contains=username,
    date_created__year=current_year)

Copy

Explain
Here, you filter the review records to choose all the records that belong to the current user, as well as the current year. The year field can be easily accessed from our date_created field by appending __year.

Projection
Once the review records have been filtered, you are not interested in all the fields that might be there. What you are mainly interested in is the month and the number of books read each month. For this, use the values() call to select only the month field from the date_created attribute of the Review model on which you are going to run the group by operation.

Group By
Here, you select the total number of books read in a given month. This is done by applying the annotate method to the QuerySet instance returned by the values() call.

Once you have the utilities file in place, you must write the view function, which is going to help in showing the books-read-per-month plot on the user’s profile page. For this, open the views.py file under the bookr directory and start by adding the following imports to it:
from plotly.offline import plot
import plotly.graph_objects as graphs
from .utils import get_books_read_by_month

Copy

Explain
Once you have done this, you must modify the view function that renders the profile page. Currently, the profile page is being handled by the profile() method inside the views.py file. Modify the method so that it resembles the one shown here
@login_required
def profile(request):
    user = request.user
    permissions = user.get_all_permissions()
    # Get the books read in different months this year
    books_read_by_month =
        get_books_read_by_month(user.username)
    # Initialize the Axis for graphs, X-Axis is
      months, Y-axis is books read
    months = [i+1 for i in range(12)]
    books_read = [0 for _ in range(12)]
    # Set the value for books read per month on Y-Axis
    for num_books_read in books_read_by_month:
        list_index =
           num_books_read['date_created__month'] - 1
        books_read[list_index] =
           num_books_read['book_count']
    # Generate a scatter plot HTML
    figure = graphs.Figure()
    scatter = graphs.Scatter(x=months, y=books_read)
    figure.add_trace(scatter)
    figure.update_layout(xaxis_title="Month",
        yaxis_title="No. of books read")
    plot_html = plot(figure, output_type='div')
    # Add to template
      return render(request, 'profile.html',
          {'user': user, 'permissions': permissions,
              'books_read_plot': plot_html})

Copy

Explain
In this method, you did a couple of things. First, you called the get_books_read_by_month() method and provided it with the username of the currently logged-in user. This method returns the list of books read by a given user on a per-month basis in the current year:

books_read_by_month =
    get_books_read_by_month(user.username)

Copy

Explain
The next thing you did was pre-initialize the X-axis and Y-axis for the graph with some default values. For this visualization, use the X-axis to display months and the Y-axis to display the number of books read.

Now, since you already know that a year is going to have only 12 months, pre-initialize the X-axis with a value between 1 and 12:

months = [i+1 for i in range(12)]

Copy

Explain
For the books read, initialize the Y-axis with all the 12 indexes set to 0, as follows:

books_read = [0 for _ in range(12)]

Copy

Explain
Now, with the pre-initialization done, fill in some actual values for the books read per month. For this, iterate upon the list you got as a result of the call made to get_books_read_by_month(user.username) and extract the month and the book count for the month from it.

Once the book count and month have been extracted, the next step is to assign the book_count value to the books_read list at the month index:

    for num_books_read in books_read_by_month:
        list_index =
            num_books_read['date_created__month'] - 1
        books_read[list_index] =
            num_books_read['book_count']

Copy

Explain
Now, with the values for the axes set, generate a scatter plot using the plotly library:

figure = graphs.Figure()
scatter = graphs.Scatter(x=months, y=books_read)
figure.add_trace(scatter)
figure.update_layout(xaxis_title="Month",
                     yaxis_title="No. of books read")
plot_html = plot(figure, output_type='div')

Copy

Explain
Once the HTML for the plot has been generated, pass it to the template using the render() method so that it can be visualized on the profile page:

return render(request, 'profile.html',
    {'user': user, 'permissions': permissions,
        'books_read_plot': plot_html})

Copy

Explain
With the view function created, the next step is to modify the template to render this graph. For this, open the profile.html file under the templates directory and add the following highlighted code to the file, just before the last {% endblock %} statement:
{% extends "base.html" %}
{% block title %}Bookr{% endblock %}
{% block heading %}Profile{% endblock %}
{% block content %}
  <ul>
      <li>Username: {{ user.username }} </li>
      <li>Name: {{ user.first_name }} {{
          user.last_name }}</li>
      <li>Date Joined: {{ user.date_joined }} </li>
      <li>Email: {{ user.email }}</li>
      <li>Last Login: {{ user.last_login }}</li>
      <li>Groups: {{ groups }}{% if not groups
          %}None{% endif %} </li>
  </ul>
  {% autoescape off %}
      {{ books_read_plot }}
  {% endautoescape %}
{% endblock %}

Copy

Explain
This code snippet adds the books_read_plot variable that’s passed in the view function to be used inside our HTML template. Also, note that autoescape is set to off for this variable. This is required because this variable contains HTML generated by the plotly library. If you allow Django to escape the HTML, you will only see raw HTML on the profile page and not a graph visualization.

With this, you have successfully integrated the plot into the application.

To try the visualization, run the following command and then navigate to your user profile by visiting http://localhost:8080/accounts/profile
python manage.py runserver localhost:8080

Copy

Explain
You should see a page that resembles the one shown here:

Figure 13.9: User book reading history scatter plot
Figure 13.9: User book reading history scatter plot

In this exercise, you learned how to integrate a plotting library with Django to visualize the reading history of a user. Similarly, Django allows you to integrate any generic Python code into a web application, with the only constraint being that the data generated as a result of the integration should be transformed into a valid HTTP response that can be handled by any standard HTTP-compatible tool, such as a web browser or command-line tools such as curl.

Activity 13.01 – exporting the books read by a user as an XLSLX file
In this activity, you will implement a new API endpoint inside Bookr that will allow your users to export and download a list of books they have read as an XLSX file:

Install the XlsxWriter library.
Inside the utils.py file you created under the bookr application, create a new function that will help in fetching the list of books that have been read by the user.
Inside the views.py file under the bookr directory, create a new view function that will allow the user to download their reading history in XLSX format.
To create an XLSX file inside the view function, first, create a BytesIO-based in-memory file that can be used to store the data from the XlsxWriter library.
Read the data stored inside the in-memory file using the getvalue() method of the temporary file object.
Finally, create a new HttpResponse instance with the 'application/vnd.ms-excel' content type header, and then write the data obtained in step 5 to the response object.
With the response object prepared, return the response object from the view function.
With the view function ready, map it to a URL endpoint that can be visited by a user to download their book-reading history.
Once you have mapped the URL endpoint, start the application and log in to it with your user account. Once you’ve done this, visit the URL endpoint you just created, and if upon visiting the URL endpoint your browser starts to download an Excel file, you have successfully completed the activity.

Important note

The solution for this activity can be found on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

Summary
In this chapter, we looked at how we can deal with binary files and how Python’s standard library, which comes pre-loaded with the necessary tools, allows us to handle commonly-used file formats such as CSV. We then moved on to learning how to read and write CSV files in Python using Python’s csv module. Later, we worked with the XlsxWriter package, which allows us to generate Microsoft Excel-compatible files right from our Python environment without us having to worry about the internal formatting of the file.

The second half of this chapter was dedicated to learning how to use the weasyprint library to generate PDF versions of HTML pages. This skill can come in handy when we want to provide our users with an easy option to print the HTML version of our page with any added CSS styling of our choosing. The last section of this chapter discussed how we can generate interactive graphs in Python and render them as HTML pages that can be viewed inside the browser using the plotly library.

In the next chapter, we will look at how we can test the different components we have been implementing in the previous chapters to make sure that code changes do not break our website’s functionality.



| ≪ [ 12 Building a REST API ](/packtpub/2024/422-web_development_with_django_2ed/12_building_a_rest_api) | 13 Generating CSV, PDF, and Other Binary Files | [ 14 Testing Your Django Applications ](/packtpub/2024/422-web_development_with_django_2ed/14_testing_your_django_applications) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/422-web_development_with_django_2ed/13_generating_csv,_pdf,_and_other_binary_files
> (2) Markdown
> (3) Title: 13 Generating CSV, PDF, and Other Binary Files
> (4) Short Description: Publication date: May 2023 Publisher Packt Pages 764
> (5) tags: Django
> Book Title: 422-Web Development with Django 2ed
> Link: https://subscription.packtpub.com/book/web-development/9781803230603/pref
> create: 2024-05-08 수 14:11:52
> Images: /packtpub/2024/422-web_development_with_django_2ed_img/13/
> .md Name: 13_generating_csv,_pdf,_and_other_binary_files.md

