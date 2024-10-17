
지데포 알로메누 2023년 9월 7일 https://medium.com/@calormenu/building-a-personal-expense-tracker-with-python-and-sqlite-571e1b04b802
```
git clone https://github.com/Dzidefo123/family-expense-tracker.git
```

## 1. 환경 설정하기

1. python-3.12.5-amd64.exe
1. pycharm-community-2024.2.0.1.exe

## 2. 초기 생각과 디자인

### 어떤 기능을 원하나?

1. 품목 pum, 금액 kum, 매장 shop, 년월일 date, 시분 time, 분류 jong, 입력시각 keyin 항목을 사용
1. 품목, 매장, 기간, 분류별 출금 집계할수 있도록

### 데이터 저장 방법

1. .csv 파일에 저장 (1차)
1. SQLite 데이터베이스에 저장 (2차)

## 3. .csv 파일에 데이터 저장

`cat expense_tracker_csv.py`
```
import csv

# Initialize the CSV file for storing expenses
CSV_FILE = "expense.csv"

# Check if the CSV file exists; if not, create it with headers
def initialize_csv():
    try:
        with open(CSV_FILE, mode='x', newline='') as file:
            writer = csv.writer(file)
            writer.writerow(["Date", "Category", "Description", "Amount"])
    except FileExistsError:
        pass

# Call the initialization function when the script runs
initialize_csv()

def add_expense(date, category, description, amount):
    with open(CSV_FILE, mode='a', newline='') as file:
        writer = csv.writer(file)
        writer.writerow([date, category, description, amount])

def add_expense_menu():
    date = input("Enter the date (YYYY-MM-DD): ")
    category = input("Enter the category: ")
    description = input("Enter the description: ")
    amount = float(input("Enter the amount: "))

    add_expense(date, category, description, amount)
    print("Expense added successfully!")

# Function to view expenses
def view_expenses():
    print("\nView Expenses")
    with open(CSV_FILE, mode='r', newline='') as file:
        reader = csv.reader(file)
        next(reader)  # Skip the header row
        for row in reader:
            date, category, description, amount = row
            print(f"Date: {date}, Category: {category}, Description: {description}, Amount: {amount}")

def calculate_totals():
    total_daily = 0.0
    total_monthly = 0.0
    total_yearly = 0.0

    with open(CSV_FILE, mode='r', newline='') as file:
        reader = csv.reader(file)
        next(reader)  # Skip the header row

        for row in reader:
            _, _, _, amount = row
            amount = float(amount)

            # Calculate daily, monthly, and yearly totals
            total_daily += amount
            total_monthly += amount
            total_yearly += amount

    # Display the totals
    print("\nExpense Totals")
    print(f"Daily Total: {total_daily}")
    print(f"Monthly Total: {total_monthly}")
    print(f"Yearly Total: {total_yearly}")

def calculate_totals_menu():
    calculate_totals()

def main_menu():
    while True:
        print("\nPersonal Expense Tracker")
        print("1. Add Expense")
        print("2. View Expenses")
        print("3. Calculate Totals")
        print("4. Exit")

        choice = input("Enter your choice: ")
        if choice == '1':
            add_expense_menu()
        elif choice == '2':
            view_expenses()
        elif choice == '3':
            calculate_totals_menu()
        elif choice == '4':
            print("Exiting Expense Tracker. Goodbye!")
            break
        else:
            print("Invalid choice. Please choose a valid option")

if __name__ == "__main__":
    main_menu()
```

## 4. SQLite 데이터베이스에 데이터 저장

`cat expense_tracker_sqlite.py`
```
import sqlite3

# Create or connect to the SQLite database
conn = sqlite3.connect('expense_tracker.db')
cursor = conn.cursor()

# Create an 'expenses' table if it doesn't exist
cursor.execute('''
    CREATE TABLE IF NOT EXISTS expenses (
        id INTEGER PRIMARY KEY,
        date TEXT,
        category TEXT,
        description TEXT,
        amount REAL
     )
''')

# Save the changes and close the connection
conn.commit()
conn.close()

def add_expense(date, category, description, amount):
    # Connect to the SQLite database
    conn = sqlite3.connect('expense_tracker.db')
    cursor = conn.cursor()

    # Insert the expense data into the 'expenses' table
    cursor.execute('''
        INSERT INTO expenses (date, category, description, amount)
        VALUES (?, ?, ?, ?)
    ''', (date, category, description, amount))

    # Save the changes and close the connection
    conn.commit()
    conn.close()

def view_expenses():
    # Connect to the SQLite database
    conn = sqlite3.connect('expense_tracker.db')
    cursor = conn.cursor()

    # Retrieve and display all expenses
    cursor.execute('SELECT * FROM expenses')
    expenses = cursor.fetchall()

    print("\nView Expenses")
    for expense in expenses:
        id, date, category, description, amount = expense
        print(f"ID: {id}, Date: {date}, Category: {category}, Description: {description}, Amount: {amount}")

    # Close the connection
    conn.close()

def calculate_totals():
    # Connect to the SQLite database
    conn = sqlite3.connect('expense_tracker.db')
    cursor = conn.cursor()

    # Calculate daily, monthly, and yearly totals
    cursor.execute('SELECT SUM(amount) FROM expenses WHERE date = DATE()')
    daily_total = cursor.fetchone()[0]

    cursor.execute('SELECT SUM(amount) FROM expenses WHERE strftime("%Y-%m", date) = strftime("%Y-%m", DATE())')
    monthly_total = cursor.fetchone()[0]

    cursor.execute('SELECT SUM(amount) FROM expenses WHERE strftime("%Y", date) = strftime("%Y", DATE())')
    yearly_total = cursor.fetchone()[0]

    # Display the totals
    print("\nExpense Totals")
    print(f"Daily Total: {daily_total}")
    print(f"Monthly Total: {monthly_total}")
    print(f"Yearly Total: {yearly_total}")

    # Close the connection
    conn.close()

def main_menu():
    while True:
        print("\nPersonal Expense Tracker")
        print("1. Add Expense")
        print("2. View Expenses")
        print("3. Calculate Totals")
        print("4. Exit")

        choice = input("Enter your choice: ")
        if choice == '1':
            # Collect input from the user for adding an expense
            date = input("Enter the date (YYYY-MM-DD): ")
            category = input("Enter the category: ")
            description = input("Enter the description: ")
            amount = float(input("Enter the amount: "))

            # Call the add_expense() function with the collected input
            add_expense(date, category, description, amount)

            print("Expense added successfully!")
        elif choice == '2':
            view_expenses()
        elif choice == '3':
            calculate_totals()
        elif choice == '4':
            print("Exiting Expense Tracker. Goodbye!")
            break
        else:
            print("Invalid choice. Please choose a valid option")

if __name__ == "__main__":
    main_menu()
```

## 5. GUI 환경 추가

### tkinter 라이브러리

### expense_tracker_gui.py

`cat expense_tracker_gui.py`
```
import tkinter as tk
from expense_tracker import add_expense

def add_expense_button_clicked():
    # Capture input from the GUI elements
    date = date_entry.get()
    category = category_entry.get()
    description = description_entry.get()
    amount = float(amount_entry.get())

    # Call the add_expense() function with the captured input
    add_expense(date, category, description, amount)

    # Clear the input fields
    date_entry.delete(0, tk.END)
    category_entry.delete(0, tk.END)
    description_entry.delete(0, tk.END)
    amount_entry.delete(0, tk.END)

# Create the main window
root = tk.Tk()
root.title("Expense Tracker")

# Create and place GUI elements (labels, entry fields, and buttons)

date_label = tk.Label(root, text="Date:")
date_label.pack()

date_entry = tk.Entry(root)
date_entry.pack()

category_label = tk.Label(root, text="Category:")
category_label.pack()

category_entry = tk.Entry(root)
category_entry.pack()

description_label = tk.Label(root, text="Description:")
description_label.pack()

description_entry = tk.Entry(root)
description_entry.pack()

amount_label = tk.Label(root, text="Amount:")
amount_label.pack()

amount_entry = tk.Entry(root)
amount_entry.pack()

add_button = tk.Button(root, text="Add Expense", command=add_expense_button_clicked)
add_button.pack()

# Start the GUI main loop
root.mainloop()
```

`more README.md`
```
# Building a Personal Expense Tracker with Python and SQLite

Introduction

Managing personal expenses is an essential part of financial responsibility. In this article, we'll guid
e you through the process of creating a simple but effective Personal Expense Tracker using Python and S
QLite. We'll explore how to start from scratch, gradually building the application and addressing common
 questions that arise along the way.

Setting Up the Environment

Before we start coding, we need to set up our development environment. We'll use Python for programming
and SQLite for database storage. Here's what we need:

    Python: Ensure that you have Python installed on your computer. If not, download and install it from
 the Python website.

    Text Editor or Integrated Development Environment (IDE): You can use any text editor or IDE of your
choice. For this project, we recommend using Visual Studio Code (VSCode) for its simplicity and excellen
t Python support.

Initial Thoughts and Design

Before writing a single line of code, it's essential to plan our project and answer some critical questi
ons:

    What Features Do We Want?

    Our Expense Tracker should be able to:
        Add a new expense with a date, category, description, and amount.
        View all expenses recorded.
        Calculate daily, monthly, and yearly expense totals.
        Allow the user to exit the program.

    How Should We Store Data?

    Initially, we'll start by storing data in a CSV file. Later, we'll transition to using an SQLite dat
abase for improved data management.

    How Will the User Interact with the Program?

    We'll create a menu-driven interface where the user can choose actions by entering a corresponding n
umber.

Phase 1: Storing Data in a CSV File

Our initial implementation will use a CSV file to store expenses. Here's the thought process as we imple
ment each feature:

Feature 1: Adding an Expense

    We'll collect expense details (date, category, description, amount) from the user.
    The program will append this data to a CSV file.

Feature 2: Viewing Expenses

    We'll read the CSV file and display all recorded expenses.

Feature 3: Calculating Totals

    To calculate totals, we'll parse the CSV file, summing expenses based on date.
    We'll present daily, monthly, and yearly totals to the user.

Feature 4: Exiting the Program

    We'll add an option for the user to exit the program gracefully.

Phase 2: Transitioning to SQLite Database

After completing the initial version, we'll address the need for a more robust and efficient data storag
e solution. We'll transition to using an SQLite database.

    We'll create an SQLite database named expense_tracker.db.
    We'll create a table called expenses to store expense data.

The SQLite database will provide better data management, including faster queries and greater flexibilit
y.

Conclusion

Building a Personal Expense Tracker is a practical way to learn Python and database management. We start
ed with a basic version using CSV files and then transitioned to a more robust SQLite database. Along th
e way, we addressed questions about program design and user interaction.

You can further enhance this Expense Tracker by adding more features or improving the user interface. Ad
ditionally, consider expanding your knowledge by exploring more advanced database management systems and
 Python libraries for data analysis.
```

> `Page Info:`
> `(1) Title:` 0903 Python+SQLite 개인비용 추적기
> `(2) Short Description:` 2024-09-03
> `(3) Path:` medium/2024/0903-python_sqlite_expense_tracker
> `제목:` Python+SQLite 개인비용 추적기
> `작성:` Dzidefo Alomenu 2023년 9월 7일
> `링크:` https://medium.com/@calormenu/building-a-personal-expense-tracker-with-python-and-sqlite-571e1b04b802
> `수정:` 2024-09-10 화 1409
> `파일:` 0903-python_sqlite_expense_tracker.md

