원본 제목: 210603 Create the first spring boot app
원본 링크: https://medium.com/nerd-for-tech/create-the-first-spring-boot-app-4e930d812a22
Path:
medium/spring_boot_diwi/101
Title:
101 Create the first spring boot app
Short Description:
Dimuthu Wickramanayake 210603 스프링부트 첫 앱 만들기

![Figure 1.1 – Create a empty gradle project using intellij](/spring_boot_diwi_img/101-01-intellij_gradle.png)
![Figure 1.2 – src_main folder](/spring_boot_diwi_img/101-02-src_main_folder.png)
- cut line


I’m not going to go in to many of the features and descriptions but just dive in to the world of Spring boot by creating a new application. To initialize the spring boot application we can either use gradle or maven. If you face any problem type it in comments i will personally look in to it. Final tutorial for this series,

https://billa-code.medium.com/flutter-series-connecting-the-spring-boot-web-socket-market-data-real-time-market-data-976a07022109


- IDE : Intelij
- Build tool : Gradle
- Java — 1.8

So first lets create a empty gradle project using intellij as follows.

![Figure 1.1 – Create a empty gradle project using intellij](/spring_boot_diwi_img/101-01-intellij_gradle.png)

After creating the project we will get a project with just two files. build.gradle and settings.gradle. So these are the files which we are going to configure to make this a spring boot application. First step we replace the code in build.gradle using following code.

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
    testImplementation('org.springframework.boot:spring-boot-starter-test')
}
 
test {
    useJUnitPlatform()
}
```

So after we add this code we have to press ctrl + shift + o to sync the gradle changes. The the dependencies we have specifiied in the build.gradle will be downloaded. After the syncing now lets build the project and then run it. I will take some time to download dependencies.

![Figure 1.2 – src_main folder](/spring_boot_diwi_img/101-02-src_main_folder.png)

here inside the main folder we can find two folders called java and resources. These folders are the place where we are going to do our most of the coding.

Now we have to create a controller for this program. I will create a controller called StockController.java file inside java folder.

```
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
 
@RestController
@EnableAutoConfiguration
public class StockController {
 
    @RequestMapping("/")
    String home() {
        return "Hello World!";
    }
 
    public static void main(String[] args) {
        SpringApplication.run(StockController.class, args);
    }
}
```

Now we can see a file called gradlew is created. So if you are using Windows then we have to use gradlew.bat if we are using linux we have to use gradlew file to build and run. Thing is in linux we can’t use this file at once from terminal. First we have to change the read write permission for the file for that use the following command.

```
sudo chmod +x gradlew
```

Now in the command line or the terminal we have to build the spring boot project. For windows type the following command.

```
gradlew clean build
```

For Linux

```
./gradlew clean build
```

Now to run the application just type

```
./gradlew bootRun
```

So the program is running on 8080 port in your local computer. Here as we have mapped a simple request mapping “/” it will give an output in the browser if we run http://localhost:8080 on browser. Let me know if you were able to see Hello World in browser.

Happy coding. In next lesson lets see how we can create a simple project and how we are going to deploy it in to a production environment.

