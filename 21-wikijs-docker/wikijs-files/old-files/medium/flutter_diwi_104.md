원본 제목: Dimuthu Wickramanayake Jun 12, 2021 Flutter series — Connecting the spring boot web socket market data (Real time market data)
원본 링크: https://medium.com/nerd-for-tech/flutter-series-connecting-the-spring-boot-web-socket-market-data-real-time-market-data-976a07022109
Path:
medium/flutter_diwi/104
Title:
104 Connecting the spring boot web socket market data (Real time market data)
Short Description:
Dimuthu Wickramanayake 210612 스프링 부트 웹 소켓 시장 데이터 연결 (실시간 시장 데이터)

![Figure 4.1 – 210612 final result](/flutter_diwi_img/104-01-210612_final_result.png)
- cut line


![Figure 4.1 – 210612 final result](/flutter_diwi_img/104-01-210612_final_result.png)

Hi Guys. So in the last tutorial i showed you guys how to create web socket using spring boot application to send market data to front end in real time. So in this tutorial i will be showing how to show that data in our flutter app. To get to know how we created our flutter app so far you can read the latest post of the flutter series.

https://billa-code.medium.com/spring-boot-series-creating-a-web-socket-to-send-real-time-market-data-ee5273b3204b

https://billa-code.medium.com/flutter-series-connecting-ui-to-spring-boot-backend-f9874dc3dcd5

https://billa-code.medium.com/flutter-series-implementing-stock-market-watch-list-ui-dccd37a9ef34

https://billa-code.medium.com/flutter-series-creating-the-first-flutter-application-793e5816f816

https://billa-code.medium.com/spring-boot-series-sending-stock-market-data-in-json-form-cce978a9a90d

https://billa-code.medium.com/spring-boot-series-unit-testing-basics-3ce566250465

https://billa-code.medium.com/spring-boot-series-stock-market-data-end-point-356592487254

https://billa-code.medium.com/create-the-first-spring-boot-app-4e930d812a22

As you may remember from our previous tutorials, we created a class called HomePage and then inside it we showed our StockList class to show the stock data taken from the Rest API. So in this tutorial i will be creating a new class called HomeStockSocket in a file named home_stock_socket.dart. Inside this class i will show the StockList class where i will send the stock list taken from the web socket to StockList class.

So first of all we have to install the dependencies needed for this task. Here we need to have the StompCLient in our application so we have to add stomp_dart_client to our app. Now the dependency section in pubsec.yaml file will be like this.

```
dependencies:
     http: "0.13.3"
     stomp_dart_client: ^0.3.8
     intl: ^0.16.1
     flutter:
         sdk: flutter
```

So the HomeStockSocket class is created as a stateful class because we are using the stockList in the state so the changes coming from the web socket applies to our StockList class. We are connecting to the web socket in the initState() of the stateful class and in the onConnect method we are subscribing to the /topic/message and then we send a message to /app/hello. Now the web socket will get triggered and the stock data will be send in real time using a scheduler in 2 seconds intervals. Therefore we will get a market data feed every 2 seconds to the front end. If you look at the last tutorial you will see we have created a thread pool and used it in the scheduler so that our backend don’t go out of resources and crash.

Code for the home_stock_socket.dart is as follows.

```
import 'package:flutter/material.dart';
import 'package:stock_ui/stock.dart';
import 'package:stock_ui/stock_list.dart';
import 'package:intl/intl.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'dart:convert';
class HomeStockSocket extends StatefulWidget {
  HomeStockSocket({Key key, this.title}) : super(key: key);
final String title;
@override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<HomeStockSocket> {
  StompClient stompClient;
  final socketUrl = 'http://localhost:8080/ws-message';
String message = '';
  List<Stock> stockList;
void onConnect(StompClient client, StompFrame frame) {
    client.subscribe(
        destination: '/topic/message',
        callback: (StompFrame frame) {
          if (frame.body != null) {
            Map<String, dynamic> obj = json.decode(frame.body);
            List<Stock> stocks = new List<Stock>();
for (int i = 0; i < obj['stock'].length; i++) {
              Stock stock = new Stock(
                  company: obj['stock'][i]['name'],
                  symbol: obj['stock'][i]['symbol'],
                  price: obj['stock'][i]['price'],
                  chg: obj['stock'][i]['chg']);
              stocks.add(stock);
            }
setState(() => stockList = stocks);
          }
        });
client.send(destination: '/app/hello', body: "dimuthu");
  }
@override
  void initState() {
    super.initState();
if (stompClient == null) {
      stompClient = StompClient(
          config: StompConfig.SockJS(
        url: socketUrl,
        onConnect: onConnect,
        onWebSocketError: (dynamic error) => print(error.toString()),
      ));
stompClient.activate();
    }
  }
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
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        hintText: "Search",
                        prefix: Icon(Icons.search),
                        fillColor: Colors.grey[800],
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, style: BorderStyle.none),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16)))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height - 310,
                    child: StockList(
                      stocks: stockList,
                    )),
              )
            ],
          ),
        ),
      )
    ]));
  }
@override
  void dispose() {
    if (stompClient != null) {
      stompClient.deactivate();
    }
super.dispose();
  }
}
```

Now we have to add this to main.dart file and replace the HomePage class which was shown before. Now the code for main.dart file will look like below.

```
import 'package:flutter/material.dart';
import 'package:stock_ui/home_stock_socket.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeStockSocket(title: 'Flutter Demo Home Page'),
    );
  }
}
```

In the very beginning, Flutter app will give an error because stockList is null at the beginning. So to handle that i have changed the stock_list.dart file as shown below.

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
      itemCount: stocks != null ? stocks.length : 0,
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

Now lets run this using,

```
flutter run -d chrome --web-port 8000
```

And please remember to run the spring boot app we created last time to get the real time market data feed.

So guys enjoy your real time market data app made with Yahoo finance API, spring boot and Flutter. So from this tutorial i will conclude this Stock Market application development. In the next tutorial let’s create another cool application from basics. So until next time Happy coding guys !!!.
