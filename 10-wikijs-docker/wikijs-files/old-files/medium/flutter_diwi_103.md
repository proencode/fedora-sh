원본 제목: DDimuthu Wickramanayake Jun 8, 2021 Flutter series — Connecting UI to spring boot backend
원본 링크: https://medium.com/nerd-for-tech/flutter-series-connecting-ui-to-spring-boot-backend-f9874dc3dcd5
Path:
medium/flutter_diwi/103
Title:
103 Connecting UI to spring boot backend
Short Description:
Dimuthu Wickramanayake 210608 스프링 부트 백엔드에 UI 연결하기

![Figure 3.1 – final result](/flutter_diwi_img/103-01-final_result.png)
- cut line


Hi Guys, So this is the final tutorial of the Stock market app creation tutorials. In future if possible i will try to modify this by introducing you guys about web sockets and get real time market data to our app. but no worries guys because up until now we have come in a path to create a complete market watch list.

In this tutorial i will be discussing how to connect spring boot rest API to our Flutter UI which we almost finished in the last tutorial. So for now we have most of the things we need covered. Our backend returns the data we need and in the front we have a model to use when we get the data. So all we have to do is just connect these dots.

https://billa-code.medium.com/flutter-series-implementing-stock-market-watch-list-ui-dccd37a9ef34

https://billa-code.medium.com/flutter-series-creating-the-first-flutter-application-793e5816f816

https://billa-code.medium.com/spring-boot-series-sending-stock-market-data-in-json-form-cce978a9a90d

https://billa-code.medium.com/spring-boot-series-unit-testing-basics-3ce566250465

https://billa-code.medium.com/spring-boot-series-stock-market-data-end-point-356592487254

https://billa-code.medium.com/create-the-first-spring-boot-app-4e930d812a22

In the Flutter app we will be using a library called ‘http’ to get the utilities to connect to our spring boot rest API. For this i will update the dependencies in the pubspec.yaml file.

```
dependencies:
  http: "0.13.3"
  intl: ^0.16.1
  flutter:
    sdk: flutter
```

Now let’s create a new class called HttpService to do the data handling part. For this i will create a file called http_service.dart. This class will be used to connect to the spring boot app which is running in the URL http://localhost:8080 and to access the particular end point which is sending us the data, we will access http://localhost:8080/getStock. So if you take a look at the last tutorial in the spring boot series (URL is shown above) this end point returns a set of data in JSON format. Using this HttpService class lets access those data. Code for the file http_service.dart is as follows.

```
import 'dart:convert';
import 'package:http/http.dart';
import 'package:stock_ui/stock.dart';

class HttpService {
  final String stockURL = "http://localhost:8080/getStock";

  Future<List<Stock>> getStocks() async {
    Response res = await get(Uri.parse(stockURL));

    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      print(obj['stock'][0]['symbol']);
      List<Stock> stocks =  new List<Stock>();

      for (int i = 0; i < obj['stock'].length; i++) {
        Stock stock = new Stock(company: obj['stock'][i]['name'], symbol: obj['stock'][i]['symbol'], price: obj['stock'][i]['price'], chg: obj['stock'][i]['chg']);
        stocks.add(stock);
      }

      return stocks;
    } else {
      throw "Unable to retrieve stock data.";
    }
  }
}
```

Here in Flutter when we are using a async method, the results are stored to a data type called Future. So to show these data in the UI i will have to use a wrapper called FutureBuilder. If we quickly look at the code above, first we are getting the response using the get function then we decode that data. After that we are looping the list of data coming in the stock parameter and map these values to our Stock object and return a list of stocks in the Future data type.

Now for the UI part right now we are adding stocks data from the home_page.dart file. if you quickly go through the last tutorial you can see when we are initializing the StockList in the home_page.dart we add these stocks dummy data taken from getStocks method. Now we will have to change here to show our real data.

As i mentioned before as we are using Future data type will have to create a FutureBuilder wrapper first and then inside it we will take the data we get from HttpService class and show here. Code for the home_page.dart is as follows.

```
import 'package:flutter/material.dart';
import 'package:stock_ui/http_service.dart';
import 'package:stock_ui/stock.dart';
import 'package:stock_ui/stock_list.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatelessWidget {
  final title;
  HttpService httpService = HttpService();

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
                child: FutureBuilder(
                  future: httpService.getStocks(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Stock>> snapshot) {
                    if (snapshot.hasData) {
                      List<Stock> stocks = snapshot.data;
                      return SizedBox(
                          height: MediaQuery.of(context).size.height - 310,
                          child: StockList(
                            stocks: stocks,
                          ));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )
            ],
          ),
        ),
      )
    ]));
  }
}
```

Here we have first initialize the HttpService class and then in the FutureBuilder we have get the set of stocks returning from HttpService class as the future variable. Until the data is loaded we are showing a CircularProgressIndicator(In built widget) by simply using a if condition to check whether data is there or not. So now when you run the flutter app you will get the real time data for the set of symbols we hard coded in the spring boot app. Final result will look like this.

![Figure 3.1 – final result](/flutter_diwi_img/103-01-final_result.png)

I think you have learn some practical knowledge about creating a web application using spring boot and Flutter with these tutorials. Please give a clap follow me here and i will continue to post tutorials of these type of cool projects.

Happy Coding guys !!!
