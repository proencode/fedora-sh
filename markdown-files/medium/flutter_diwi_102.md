원본 제목: Dimuthu Wickramanayake Jun 8, 2021 Flutter series — Implementing stock market watch list UI
원본 링크: https://medium.com/nerd-for-tech/flutter-series-implementing-stock-market-watch-list-ui-dccd37a9ef34
Path:
medium/flutter_diwi/102
Title:
102 Implementing stock market watch list UI
Short Description:
Dimuthu Wickramanayake 210608 주식 시장 감시 목록 UI 구현

![Figure 2.1 – this is the UI](/flutter_diwi_img/102-01-this_is_the_ui.png)
![Figure 2.2 – Scrolling Watch List](/flutter_diwi_img/102-02-scrolling_watch_list.png)
- cut line


Hi Guys. In the last tutorial, I told you guys that we are going to use Flutter to create a front end app which then we will connect to the spring boot web application we created in the early tutorials. So in this tutorial, we will be creating the UI which we need for this task. Before starting the tutorial I should give credit to 
Mohammad Azam of the Youtube channel azamsharp for the cool video tutorial about this stock market flutter app. So guys most of the design is taken from that video. Please go and support him and he is also offering so many cool courses on Udemy. So this is the UI we are going to implement.


![Figure 2.1 – this is the UI](/flutter_diwi_img/102-01-this_is_the_ui.png)

Up to now we have a hello world application which we created in the last tutorial. Find previous tutorial on this series,

https://billa-code.medium.com/flutter-series-creating-the-first-flutter-application-793e5816f816

https://billa-code.medium.com/spring-boot-series-sending-stock-market-data-in-json-form-cce978a9a90d

So in this tutorial let's change that code so we can create a cool stock market watch list UI. Now i have two .dart files in my Flutter app. main.dart and home_page.dart. home_page.dart has the code to display hello world in the center of the UI. To create this page in a descent manner i will first use Scaffold class to wrap the whole UI of home_page.dart and this will give a material design to our app’s UI. So here when creating the Scaffold class we have to add details to body parameter inside this. Inside the body, I’m first going to implement a Stack that contains the Container we are implementing and Inside the container we are adding a wrapper class called SafeArea just to get the app in to the visible zone. Inside this SafeArea class we are adding first the text “Watch List” then the date and time and then the stock value list. This list will be wrapped inside a class called StockList. And to obtain DateTime formatting options i will be using a library called “intl”. First let’s add it to our dependancy file. In the pubspec.yaml file there is section called dependencies and we are adding inlt package here.

```
environment:
    sdk: ">=2.7.0 <3.0.0"

dependencies:
    intl: ^0.16.1
    flutter:
        sdk: flutter
```

So now we have to create the StockList class where we are going to show our list of stocks. I will be creating another class called Stock to model the data to show in a item of this list. So the stock.dart file is as follows.

```
class Stock {
    String symbol;
    String company;
    String price;
    String chg;

    Stock({this.symbol, this.company, this.price, this.chg});

    static List<Stock> getStocks() {
        List<Stock> stocks = List<Stock>();
        stocks.add(new Stock(symbol: "GOOG", company: "Google", price: "220", chg: "11"));

        return stocks;
    }
}
```

Here we have a simple class which have a method to return set of stocks and it’s static so we can access it without initializing the class We are using this method to create dummy data for now. Now we have to create the stock_list.dart file and it’s as follows.

```
import 'package:flutter/material.dart';
import 'package:stock_ui/stock.dart';

class StockList extends StatelessWidget {
    final List<Stock> stocks;

    StockList({this.stocks});

    @override
    Widget build(BuildContext context) {
        return ListView.separated(
                separatorBuilder: (context, index) {
            return Divider(color: Colors.grey[400]);
        },
        itemCount: stocks.length,
                itemBuilder: (context, index) {
            final stock = stocks[index];
            bool isChgNegative = true;

            if (double.parse(stock.chg) > 0) {
                isChgNegative = false;
            }

            return ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
            Text("${stock.symbol}",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500)),
            Text("${stock.company}",
                    style: TextStyle(color: Colors.white, fontSize: 20))
              ]),
            trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
            Text(
                    "\$${stock.price}",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
            Container(
                    alignment: Alignment.center,
                    width: 75,
                    height: 20,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: isChgNegative ? Colors.red : Colors.green),
            child: Text(
                    "${stock.chg}%",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        );
        },
    );
    }
}
```

So here to the StockList class constructor we are passing the list of Stocks and then inside this class its iterated and shown as a list. So after adding these changes now we can change our home_page.dart file to show this list in it. So the code for that is as follows.

```
import 'package:flutter/material.dart';
import 'package:stock_ui/stock.dart';
import 'package:stock_ui/stock_list.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatelessWidget {
    final title;

    MyHomePage({this.title});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
                body: Stack(children: <Widget>[
        Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: SafeArea(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
        Row(
                children: <Widget>[
        Expanded(
                flex: 1,
                child: Text(
                "Watch List",
                style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold),
                    ),
                  ),
        Expanded(
                flex: 1,
                child: Text(
                DateFormat('dd MMMM yyyy').format(DateTime.now()),
                textAlign: TextAlign.right,
                style: TextStyle(
                color: Colors.grey[500],
                fontSize: 24,
                fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
        Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
        Text(
                DateFormat().add_jm().format(DateTime.now()),
                textAlign: TextAlign.right,
                style: TextStyle(
                color: Colors.grey[500],
                fontSize: 24,
                fontWeight: FontWeight.bold),
                  ),
                ],
              ),
        Padding(
                padding: const EdgeInsets.only(top: 15),
        child: SizedBox(
                height: MediaQuery.of(context).size.height - 310,
                child: StockList(
                stocks: Stock.getStocks(),
                    )),
              )
            ],
          ),
        ),
      )
    ]));
    }
}
```

Now when we run this we will get an exact output like the image shown above. So to see whether the list work properly lets add some more dummy data to Stock class getStocks() method and check.

```
class Stock {
    String symbol;
    String company;
    String price;
    String chg;

    Stock({this.symbol, this.company, this.price, this.chg});

    static List<Stock> getStocks() {
        List<Stock> stocks = List<Stock>();
        stocks.add(new Stock(symbol: "GOOG", company: "Google", price: "220", chg: "11"));
        stocks.add(new Stock(symbol: "GOOG", company: "Google", price: "220", chg: "11"));
        stocks.add(new Stock(symbol: "GOOG", company: "Google", price: "220", chg: "11"));
        stocks.add(new Stock(symbol: "GOOG", company: "Google", price: "220", chg: "11"));
        stocks.add(new Stock(symbol: "GOOG", company: "Google", price: "220", chg: "11"));
        stocks.add(new Stock(symbol: "GOOG", company: "Google", price: "220", chg: "11"));
        stocks.add(new Stock(symbol: "GOOG", company: "Google", price: "220", chg: "11"));
        stocks.add(new Stock(symbol: "GOOG", company: "Google", price: "220", chg: "11"));
        stocks.add(new Stock(symbol: "GOOG", company: "Google", price: "220", chg: "11"));
        stocks.add(new Stock(symbol: "GOOG", company: "Google", price: "220", chg: "11"));
        stocks.add(new Stock(symbol: "GOOG", company: "Google", price: "220", chg: "11"));
        stocks.add(new Stock(symbol: "GOOG", company: "Google", price: "220", chg: "11"));
        stocks.add(new Stock(symbol: "GOOG", company: "Google", price: "220", chg: "11"));
        stocks.add(new Stock(symbol: "GOOG", company: "Google", price: "220", chg: "11"));

        return stocks;
    }
}
```

Okay cool, Scrolling also works fine.

![Figure 2.2 – Scrolling Watch List](/flutter_diwi_img/102-02-scrolling_watch_list.png)

So guys if there are any places you don’t understand please mention it in a comment i will clarify ASAP. Happy Coding!!! and in the next tutorial we will get the data from the Spring boot to this and then show those real stock market values.

