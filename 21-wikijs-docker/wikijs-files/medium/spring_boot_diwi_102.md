원본 제목: 210605 Spring boot series — Stock Market data End Point
원본 링크: https://medium.com/nerd-for-tech/spring-boot-series-stock-market-data-end-point-356592487254
Path:
medium/spring_boot_diwi/102
Title:
102 Stock Market data End Point
Short Description:
Dimuthu Wickramanayake 210605 주식 시장 데이터의 엔드 포인트
- cut line


So in my last tutorial, I promised you guys that I will be doing a production deployment of the spring boot application. Before doing that let's do some improvements to our codebase. Last tutorial link, https://billa-code.medium.com/create-the-first-spring-boot-app-4e930d812a22

So in this tutorial i’m going to modify the code from previous tutorial to do something meaningful. So i will be creating an end point to obtain data from Yahoo financial API and send it to the client side. For this i’m going to add the yahoo finance api package to gradle file. So our new gradle file would be like this.

```
plugins {
    id 'org.springframework.boot' version '2.4.3'
    id 'io.spring.dependency-management' version '1.0.11.RELEASE'
    id 'java'
}

group = 'com.example'
version = '0.0.1-SNAPSHOT'
sourceCompatibility = '1.8'

repositories {
    mavenCentral()
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'com.yahoofinance-api:YahooFinanceAPI:3.15.0'
    testImplementation('org.springframework.boot:spring-boot-starter-test')
}

test {
    useJUnitPlatform()
}
```

After adding it sync the project in intellij then this package will downloaded. So now lets create a service to obtain data from yahoo finance API. Create a file name StockService.java. Here when we pass the symbol to the find stock method we will be getting the stock details for that particular symbol. We have to create another class called StockWrapper.java where we are going to store the stock data. Code for the StockService.java is as follows.

```
import org.springframework.stereotype.Service;
import wrapper.StockWrapper;
import yahoofinance.YahooFinance;

@Service
public class StockService {
    public StockWrapper findStock(String symbol) {
        try {
            return new StockWrapper(YahooFinance.get(symbol));
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return null;
    }
}
```

Code for the StockWrapper.java is as follows.

```
import yahoofinance.Stock;
import java.time.LocalDateTime;

public class StockWrapper {
    private final Stock stock;
    private final LocalDateTime lastAccess;

    public StockWrapper(Stock stock) {
        this.stock = stock;
        this.lastAccess = LocalDateTime.now();
    }

    public LocalDateTime getLastAccess() {
        return lastAccess;
    }

    public Stock getStock() {
        return stock;
    }
}
```

In this wrapper we have modified the constructor to create the stock with including the access time. So now we are going to modify our StockController.java file where we have our end point written. So in our controller we are handling the get and post requests for ‘/’ request from one method. So there we are going to send the stock price of Google to from end using this service. Code for the StockController.java is as folllows.

```
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import service.StockService;
import java.math.BigDecimal;

@RestController
@EnableAutoConfiguration
public class StockController {

    @RequestMapping("/")
    BigDecimal home() {
        StockService stockService = new StockService();

        return stockService.findStock("GOOG").getStock().getQuote().getPrice();
    }

    public static void main(String[] args) {
        SpringApplication.run(StockController.class, args);
    }
}
```

Run this and access http://localhost:8080/ you will find the price of a google stock at the moment in the browser.We can modify these methods and do marvelous things. But here i’m showing you only a basic activity we can do.

So as i promised last time i will show you how to create a production build of this spring boot application we have written So far. To build a production build just type the clean build command as before.

For windows,
```
gradlew clean build
```

For Linux
```
./gradlew clean build
```

Now there will be a folder named build in your project. Go there and inside that folder there is another folder named libs, inside it you will find a .jar file. So copy that jar file name and type this in the terminal.

```
java -jar build/libs/JARFILE.jar
```

Now you are running a production build of the spring boot. So next time lets improve our stock market app by using some other cool technologies. Happy coding guys.

