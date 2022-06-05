원본 제목: 210606 Spring boot series — Sending Stock market data in JSON form
원본 링크: https://medium.com/nerd-for-tech/spring-boot-series-sending-stock-market-data-in-json-form-cce978a9a90d
Path:
medium/spring_boot_diwi/104
Title:
104 Sending Stock market data in JSON form
Short Description:
Dimuthu Wickramanayake 210606 주식 시장 데이터를 JSON 형식으로 보내기
- cut line


Hi Guys. So we have created our Stock data service to get data for a single stock and in this tutorial i will be discussing how we can improve our code to send a set of data in JSON form. Tutorials up to now in this series,

https://billa-code.medium.com/spring-boot-series-unit-testing-basics-3ce566250465

https://billa-code.medium.com/spring-boot-series-stock-market-data-end-point-356592487254

https://billa-code.medium.com/create-the-first-spring-boot-app-4e930d812a22

So we will be writing a new end point “/getStock” for this. So the code is as follows.

```
@GetMapping(value="/getStock")
List<StockModel> getStocks() {
    StockService stockService = new StockService();
    List<StockModel> stocks = new ArrayList<>();
    String[] symbolArr = {"A", "AA", "AAC", "GOOG", "AMZN", "AAT", "AAN", "T", "TD", "TARO", "TM"};

    for (String s : symbolArr) {
        Stock stock = stockService.findStock(s).getStock();
        StockModel stockModel = new StockModel(s, stock.getName(), stock.getQuote().getAsk().toString(), stock.getQuote().getChangeInPercent().toString());
        stocks.add(stockModel);
    }

    return stocks;
}
```

So if your run this as we did for the other end point you will get the data in an array without a problem. Run the program after including this and access http://localhost:8080/getStock in the browser and you will see the data. So what we have done here is we have created a Model to encapsulate the Stock data which we need to return. So this model is in the StockModel.java file.

```
public class StockModel {
    private final String symbol;
    private final String name;
    private final String price;
    private final String chg;

    public StockModel(String symbol, String name, String price, String chg) {
        this.symbol = symbol;
        this.name = name;
        this.price = price;
        this.chg = chg;
    }
}
```

We are looping a set of hard coded symbols and we obtain values of name, price and change percentage values for the stock and create the StockModel object using those values. So now our requirement is to make sure the data we sending are in JSON format. So for that we will be adding the “produces” parameter and set it to JSON type in the GetMapping annotation. So now the code look like this.

```
@GetMapping(value="/getStock", produces= MediaType.APPLICATION_JSON_VALUE)
List<StockModel> getStocks() {
    StockService stockService = new StockService();
    List<StockModel> stocks = new ArrayList<>();
    String[] symbolArr = {"A", "AA", "AAC", "GOOG", "AMZN", "AAT", "AAN", "T", "TD", "TARO", "TM"};

    for (String s : symbolArr) {
        Stock stock = stockService.findStock(s).getStock();
        StockModel stockModel = new StockModel(s, stock.getName(), stock.getQuote().getAsk().toString(), stock.getQuote().getChangeInPercent().toString());
        stocks.add(stockModel);
    }

    return stocks;
}
```

Now we run in to an error when running the app. Exception trigger in run time where the spring boot cant find JSON mapping for out StockModel class. So we have to let spring boot detect it. For that we have to change the StockModel class like this.

```
import com.fasterxml.jackson.annotation.JsonAutoDetect;

@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.ANY)
public class StockModel {
    private final String symbol;
    private final String name;
    private final String price;
    private final String chg;

    public StockModel(String symbol, String name, String price, String chg) {
        this.symbol = symbol;
        this.name = name;
        this.price = price;
        this.chg = chg;
    }
}
```

Now the code is Ok and we can check data from the browser or we can check data using Postman. But to support this to another front end application we have to loose the cross origin policy. For that we can use the @CrossOrigin annotation. Now the controller would look like this.

```
@CrossOrigin(origins = "*")
@GetMapping(value="/getStock", produces= MediaType.APPLICATION_JSON_VALUE)
List<StockModel> getStocks() {
    StockService stockService = new StockService();
    List<StockModel> stocks = new ArrayList<>();
    String[] symbolArr = {"A", "AA", "AAC", "GOOG", "AMZN", "AAT", "AAN", "T", "TD", "TARO", "TM"};

    for (String s : symbolArr) {
        Stock stock = stockService.findStock(s).getStock();
        StockModel stockModel = new StockModel(s, stock.getName(), stock.getQuote().getAsk().toString(), stock.getQuote().getChangeInPercent().toString());
        stocks.add(stockModel);
    }

    return stocks;
}
```

Here the * mark means we have enabled any URL to communicate with this. So now we are sending a list of data in JSON format but again when used with a front end app we face a problem when decoding the JSON as the list produce some errors. To avoid this I’m using another model called StockResponseModel.java and the code is as follows.

```
import com.fasterxml.jackson.annotation.JsonAutoDetect;

import java.util.List;

@JsonAutoDetect
public class StockResponseModel {
    private String stockExg;
    private List<StockModel> stock;

    public String getStockExg() {
        return stockExg;
    }

    public void setStockExg(String stockExg) {
        this.stockExg = stockExg;
    }

    public List<StockModel> getStock() {
        return stock;
    }

    public void setStock(List<StockModel> stock) {
        this.stock = stock;
    }
}
```

Now i will change my controller and store the stock list in one parameter and exchange name in another parameter. So my final StockController.java look like this.

```
import models.StockModel;
import models.StockResponseModel;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import service.StockService;
import yahoofinance.Stock;
import java.util.ArrayList;
import java.util.List;

@RestController
@EnableAutoConfiguration
public class StockController {

    @RequestMapping(value="/", produces= MediaType.APPLICATION_JSON_VALUE)
    StockModel home() {
        StockService stockService = new StockService();
        Stock stock = stockService.findStock("GOOG").getStock();
        StockModel stockModel = new StockModel("GOOG", stock.getName(), stock.getQuote().getAsk().toString(), stock.getQuote().getChangeInPercent().toString());

        return stockModel;
    }

    @CrossOrigin(origins = "*")
    @GetMapping(value="/getStock", produces= MediaType.APPLICATION_JSON_VALUE)
    StockResponseModel getStocks() {
        StockService stockService = new StockService();
        List<StockModel> stocks = new ArrayList<>();
        String[] symbolArr = {"A", "AA", "AAC", "GOOG", "AMZN", "AAT", "AAN", "T", "TD", "TARO", "TM"};

        for (String s : symbolArr) {
            Stock stock = stockService.findStock(s).getStock();
            StockModel stockModel = new StockModel(s, stock.getName(), stock.getQuote().getAsk().toString(), stock.getQuote().getChangeInPercent().toString());
            stocks.add(stockModel);
        }

        StockResponseModel res = new StockResponseModel();
        res.setStock(stocks);
        res.setStockExg("US");

        return res;
    }

    public static void main(String[] args) {
        SpringApplication.run(StockController.class, args);
    }
}
```

So we have successfully created an end point to use in a front end application to obtain stock market data. In the up coming tutorials i would use this end point to get data to a Flutter front end application. So check for the upcoming posts and Happy Coding.

