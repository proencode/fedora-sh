
| ≪ [ 316 Securing Your Application ](/books/packtpub/2024/1202-Spring_Boot_3_React/316) | 317 Deploying Your Application | [ 400 Other Books You May Enjoy ](/books/packtpub/2024/1202-Spring_Boot_3_React/400) ≫ |
|:----:|:----:|:----:|

# 317 Deploying Your Application

This chapter will explain how to deploy your backend and frontend to a server. Successful deployment is a key part of the software development process, and it is important to learn how a modern deployment process works. There are a variety of cloud servers or PaaS (short for Platform-as-a-Service) providers available, such as Amazon Web Services (AWS), DigitalOcean, Microsoft Azure, Railway, and Heroku.

In this book, we are using AWS and Netlify, which support multiple programming languages that are used in web development. We will also show you how to use Docker containers in deployments.

In this chapter, we will cover the following topics:

Deploying the backend with AWS
Deploying the frontend with Netlify
Using Docker containers
Technical requirements
The Spring Boot application that we created in Chapter 5, Securing Your Backend, is required (https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-3-and-React-Fourth-Edition/tree/main/Chapter05), as is the React app that we used in Chapter 16, Securing Your Application (https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-3-and-React-Fourth-Edition/tree/main/Chapter16).

A Docker installation is necessary for the final section of the chapter.

Deploying the backend with AWS
If you are going to use your own server, the easiest way to deploy a Spring Boot application is to use an executable Java ARchive (JAR) file. With Gradle, an executable JAR file can be created using the Spring Boot Gradle wrapper. You can build your project using the following Gradle wrapper command in your project folder:

./gradlew build

Copy

Explain
Alternatively, you can run a Gradle task in Eclipse by right-clicking Project in the Project Explorer, navigating to Window | Show View | Other, and selecting Gradle | Gradle Tasks from the list. This opens a list of Gradle tasks, and you can start the build process by double clicking the build task, as illustrated in the following screenshot. If the Gradle tasks window is empty, click the root folder of the project in Eclipse:


Figure 17.1: Gradle tasks

This creates a new build/libs folder to your project, where you will find JAR files. By default, two JAR files are created:

The file with extension .plain.jar contains Java bytecode and other resources, but it doesn’t contain any application framework or dependencies.
The other .jar file is a fully executable archive that you can run using the java -jar your_appfile.jar Java command, as illustrated in the following screenshot:

Figure 17.2: Running the executable JAR file

Nowadays, cloud servers are the principal means of providing your application to end users. We are going to deploy our backend to Amazon Web Services (AWS) (https://aws.amazon.com/). The AWS Free Tier offers users an opportunity to explore products for free.

Create a Free Tier account and log in to AWS. You have to enter your contact information, including a functioning mobile phone number. AWS will send you an SMS confirmation message to verify your account. You must add a valid credit card, debit card, or another payment method for your accounts covered under the AWS Free Tier.

You can read about the reasons why a payment method is needed at https://repost.aws/knowledge-center/free-tier-payment-method.

Deploying our MariaDB database
In this first section, we will deploy our MariaDB database to AWS. Amazon Relational Database Service (RDS) can be used to set up and operate relational databases. Amazon RDS supports several popular databases, including MariaDB. The following steps will take you through the process that creates a database in RDS:

After you have created a Free Tier account with AWS, log in to the AWS website. The AWS dashboard contains a search bar that you can use to find different services. Type RDS into the search bar and find RDS, as illustrated in the following screenshot. Click on RDS in the Services list:

Figure 17.3: RDS

Click the Create database button to begin the database creation process:

Figure 17.4: Create database

Select MariaDB from the database engine options:

Figure 17.5: Engine options

Select Free tier from the templates.
Type a name for your database instance and the password for the database master user. You can use the default username (admin):

Figure 17.6: Database instance name

Select Yes under the Public access section to allow public access to your database:

Figure 17.7: Public access

In the Additional configuration section at the bottom of the page, name your database cardb:

Figure 17.8: Additional configuration

Note! The database will not be created if the name is left empty.

Finally, click the Create database button. RDS will start to create your database instance, which might take a few minutes.
After your database is successfully created, you can press the View connection details button to open a window that shows the connection details to your database. The Endpoint is the address of your database. Copy the connection details for later use:

Figure 17.9: Connection details

Now, we are ready to test our database. In this phase, we will use our local Spring Boot application. For this, we have to allow access to our database from outside. To change this, click on your database in the RDS database list. Then, click VPC security groups, as shown in the next screenshot:

Figure 17.10: Connectivity & security

On the opening page, click the Edit inbound rules button from the Inbound rules tab. Click the Add rule button to add a new rule. For the new rule, select the MySQL/Aurora type and the My IP destination under the Source column. The My IP destination automatically adds the current IP address of your local computer as an allowed destination:

Figure 17.11: Inbound rules

After you have added a new rule, press the Save rules button.
Open the Spring Boot application that we created in Chapter 5, Securing Your Backend. Change the url, username, and password database settings in the application.properties file to match your Amazon RDS database. The format of the spring.datasource.url property value is jdbc:mariadb://your_rds_db_domain:3306/your_db_name, as shown in the following screenshot:

Figure 17.12: The application.properties file

Now, if you run your application, you can see from the console that database tables are created and demo data is inserted into our Amazon RDS database:

Figure 17.13: Console

In this phase, you should build your Spring Boot application. Run a Gradle build task in Eclipse by right-clicking Project in the Project Explorer, navigating to Window | Show View | Other, and selecting Gradle | Gradle Tasks from the list. This opens a list of Gradle tasks, and you can start the build process by double-clicking the build task. It will create a new JAR file in the build/libs folder.
We now have proper database settings, and we can use our newly built application when we deploy our application to AWS.

Deploying our Spring Boot application
After we have deployed our database to Amazon RDS, we can start to deploy our Spring Boot application. The Amazon service that we are using is Elastic Beanstalk, which can be used to run and manage web apps in AWS. There are other alternatives, such as AWS Amplify, that can be used as well. Elastic Beanstalk is available for the Free Tier, and it also supports a wide range of programming languages (for example, Java, Python, Node.js, and PHP).

The following steps will take you through the process of deploying our Spring Boot application to Elastic Beanstalk:

First, we have to create a new role for our application deployment. The role is needed to allow Elastic Beanstalk to create and manage your environment. You can create a role using the Amazon IAM (Identity and Access Management) service. Use the AWS search bar to navigate to the IAM service. In the IAM service, select Roles and press the Create role button. Select AWS Service and EC2, as shown in the following screenshot, and press the Next button:

Figure 17.14: Create role

In the Add Permissions step, select the following permission policies: AWSElasticBeanstalkWorkerTier, AWSElasticBeanstalkWebTier, and AWSElasticBeanstalkMulticontainerDocker, then press the Next button. You can use the search bar to find the correct policies:

Figure 17.15: Add permissions

You can read more about managing Elastic Beanstalk instance profiles and policies at https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/iam-instanceprofile.html.

Type a name for your role, as illustrated in the next screenshot, and finally press the Create role button:

Figure 17.16: Role name

The new role that we just created allows Elastic Beanstalk to create and manage our environment. Now, we can start to deploy our Spring Boot application.

Use the AWS dashboard search bar to find the Elastic Beanstalk service. Click the service to navigate to the Elastic Beanstalk page:

Figure 17.17: Elastic Beanstalk service

Click Applications in the left side menu, and press the Create application button to create a new application. Type a name for your application, as shown in the following screenshot, and press the Create button:

Figure 17.18: Create application

Next, we have to create an environment for our application. An environment is a collection of AWS resources running an application version. You can have multiple environments for one application: for example, development, production, and testing environments. Click the Create new environment button to configure a new environment:

Figure 17.19: Create new environment

In the environment configuration, you first have to set the platform. In the Platform type section, select Java and the first version 17 for the branch, as shown in the following screenshot. The Platform version is a combination of specific versions of an operating system, runtime, web server, application server, and Elastic Beanstalk components. You can use the recommended Platform version:

Figure 17.20: Platform type

Next, go to the Application code section in the configuration page. Select Upload your code and Local file. Click the Choose file button and select the Spring Boot .jar file that we built earlier. You also have to type in a unique Version label. Finally, press the Next button:

Figure 17.21: Create new environment

In the Configuration service access step, select the role that you created earlier from the EC2 instance profile dropdown list, as shown in the following screenshot. Then, press the Next button:

Figure 17.22: Service access

You can skip the optional Set up networking, database, and tags and Configure instance traffic and scaling steps.
Next, move to the Configure updates, monitoring, and logging step. In the Environment properties section, we have to add the following environment properties. You can add new properties by pressing the Add environment property button at the bottom of the page. There are already some predefined properties that you don’t have to modify (GRADLE_HOME, M2 and M2_HOME):
SERVER_PORT: 5000 (Elastic beans have a Nginx reverse proxy that will forward incoming requests to internal port 5000).
SPRING_DATASOURCE_URL: The database URL you need to use here is identical to the database URL value we previously configured in the 'application.properties' file when we initially tested the AWS database integration.
SPRING_DATASOURCE_USERNAME: The username of your database.
SPRING_DATASOURCE_PASSWORD: The password of your database.
The following screenshot shows the new properties:


Figure 17.23: Environment properties

Finally, in the Review step, press the Submit button, and your deployment will start. You have to wait until your environment is successfully launched, as illustrated in the next screenshot. The Domain in the Environment overview is the URL of your deployed REST API:
A screenshot of a computer  Description automatically generated
Figure 17.24: Environment successfully launched

Now, we have deployed our Spring Boot application, but the application can’t access the AWS database yet. For this, we have to allow access from the deployed application to our database. To do this, navigate to Amazon RDS and select your database from the RDS database list. Then, click VPC security groups and click the Edit inbound rules button, like we did earlier. Delete the rule that allows access from your local IP address.
Add a new rule whose Type is MySQL/Aurora. In the Destination field, type in sg. This will open a list of environments, as shown in the following screenshot. Select the environment where your Spring Boot application is running (it begins with the “awseb” text and has a subtitle that shows the name of your environment) and press the Save rules button:

Figure 17.25: Inbound rules

Now, your application is properly deployed, and you can log in to your deployed REST API using Postman and the URL that you got from the domain in step 12. The following screenshot shows the POST request that is sent to the aws_domain_url/login endpoint:

Figure 17.26: Postman authentication

You can also configure a custom domain name for your Elastic Beanstalk environment, and then you can use HTTPS to allow users to connect to your website securely. If you don’t own a domain name, you can still use HTTPS with a self-signed certificate for development and testing purposes. You can find the configuration instructions in the AWS documentation: https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/configuring-https.html.

Note! You should delete AWS resources that you have created to avoid being charged unexpectedly. You will get a reminder email from AWS to delete resources before the end of your Free Tier period.

Now, we are ready to deploy our frontend.

Deploying the frontend with Netlify
Before we deploy with Netlify, we will learn how you can build your React project locally. Move to your frontend project folder and execute the following npm command:

npm run build

Copy

Explain
By default, your project is built in the /dist folder. You can change the folder by using the build.outDir property in your Vite configuration file.

First, the build process compiles your TypeScript code; therefore, you have to fix all TypeScript errors or warnings, if there are any. A commonly encountered error occurs when you forget to remove unused imports, as illustrated in the example error below:

src/components/AddCar.tsx:10:1 - error TS6133: 'Snackbar' is declared but its value is never read.
10 import Snackbar from '@mui/material/Snackbar';

Copy

Explain
This indicates that the AddCar.tsx file imports the Snackbar component, but the component isn’t actually utilized. Therefore, you should remove this unused import. Once all errors have been resolved, you can proceed to rebuilding your project.

Vite uses Rollup (https://rollupjs.org/) to bundle your code. Test files and development tools are not included in the production build. After you have built your app, you can test your local build using the following npm command:

npm run preview

Copy

Explain
The command starts a local static web server that serves your built app. You can test your app in a browser by using the URL that is shown in the terminal.

You could deploy your frontend to AWS as well, but we will use Netlify (https://www.netlify.com/) for our frontend deployment. Netlify is a modern web development platform that is easy to use. You can use the Netlify command-line interface (CLI) or GitHub to deploy your project. In this section, we will use Netlify’s GitHub integration to deploy our frontend:

First, we have to change our REST API URL. Open your frontend project with VS Code and open the .env file in the editor. Change the VITE_API_URL variable to match your backend’s URL, as follows, and save the changes:
VITE_API_URL=https:// carpackt-env.eba-whufxac5.eu-central-2.
  elasticbeanstalk.com

Copy

Explain
Create a GitHub repository for your frontend project. Execute the following Git commands in your project folder using the command line. These Git commands create a new Git repository, make an initial commit, set up a remote repository on GitHub, and push the code to your remote repository:
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin <YOUR_GITHUB_REPO_URL>
git push -u origin main

Copy

Explain
Sign up and log in to Netlify. We will use a free Starter account that has limited features. With this account, you can build one concurrent build for free, and there is some limitation in bandwidth.
You can read more about the Netlify free account features at https://www.netlify.com/pricing/.

Open the Sites from the left side menu and you should see the Import an existing project panel, as shown in the following screenshot:

Figure 17.27: Import an existing project

Click the Import from Git button and select Deploy with GitHub. In this phase, you have to authorize your GitHub to get access to your repositories. After you have authorized successfully, you should see your GitHub username and repository search field, as shown in the following screenshot:

Figure 17.28: GitHub repository

Search for your frontend repository and click it.
Next, you will see the deployment settings. Continue with the default settings by pressing the Deploy <your_repository_name> button:

Figure 17.29: Deployment settings

After the deployment has finished, you will see the following dialog. Press the View site deploy button, as shown in the following figure, and you will be redirected to the Deploys page. Netlify generates a random site name for you, but you can use your own domain as well:

Figure 17.30: Deploy success

On the Deploys page, you will see your deployed site, and you can access your frontend by clicking the Open production deploy button:

Figure 17.31: Deploys

Now, you should see the login form, as follows:

Figure 17.32: Login screen

You can delete your Netlify deployment from the Site configuration in the left side menu.

We have now deployed our frontend, and we can move on to learning about containers.

Using Docker containers
Docker (https://www.docker.com/) is a container platform that makes software development, deployment, and shipping easier. Containers are lightweight and executable software packages that include everything that is needed to run software. Containers can be deployed to cloud services, such as AWS, Azure, and Netlify, and they offer many benefits for deploying applications:

Containers are isolated, which means each container runs independently of the host system and other containers.
Containers are portable because they contain everything an application needs to run.
Containers can also be used to ensure consistency between development and production environments.
Note! To run Docker containers on Windows, you need the Windows 10 or 11 Professional or Enterprise versions. You read more about this in the Docker installation documentation: https://docs.docker.com/desktop/install/windows-install/.

In this section, we will create a container for our MariaDB database and Spring Boot application, as follows:

Install Docker on your workstation. You can find installation packages for multiple platforms at https://www.docker.com/get-docker. If you have a Windows operating system, you can go through the installation wizard using the default settings.
If you are having problems with the installation, you can read the Docker troubleshooting documentation at https://docs.docker.com/desktop/troubleshoot/topics.

After the installation, you can check the current version by typing the following command in the terminal. Note! When you run Docker commands, you should start Docker Engine if it is not running (on Windows and macOS, you start Docker Desktop):

docker --version

Copy

Explain
First, we create a container for our MariaDB database. You can pull the latest MariaDB database image version from Docker Hub using the following command:
docker pull mariadb:latest

Copy

Explain
After the pull command has finished, you can check that a new mariadb image exists by typing the docker image ls command, and the output should look as follows. A Docker image is a template that contains instructions for creating a container:

Figure 17.33: Docker images

Next, we will run the mariadb container. The docker run command creates and runs a container based on the given image. The following command sets the root user password and creates a new database, called cardb, that we need for our Spring Boot application (Note! Use your own MariaDB root user password that you are using in your Spring Boot application):
docker run --name cardb -e MYSQL_ROOT_PASSWORD=your_pwd -e MYSQL_
  DATABASE=cardb mariadb

Copy

Explain
Now, we have created our database container, and we can start to create a container for the Spring Boot application. First, we have to change the data source URL of our Spring Boot application. Open the application.properties file of your application and change the spring.datasource.url value to the following:
spring.datasource.url=jdbc:mariadb://mariadb:3306/cardb

Copy

Explain
This is because our database is now running in the cardb container and the port is 3306.

Then, we have to create an executable JAR file from our Spring Boot application, just as we did at the beginning of this chapter. You can also run a Gradle task in the Eclipse by right-clicking Project in the Project Explorer, selecting Window | Show View | Gradle and then Gradle Tasks from the list. This opens a list of Gradle tasks, and you can start the build process by double clicking the build task. Once the build is finished, you can find the executable JAR file from the build/libs folder inside your project folder.
Containers are defined by using Dockerfiles. Create a new Dockerfile using Eclipse in the root folder of your project (cardatabase) and name it Dockerfile. The following lines of code show the contents of the Dockerfile:
FROM eclipse-temurin:17-jdk-alpine
VOLUME /tmp
EXPOSE 8080
COPY build/libs/cardatabase-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]

Copy

Explain
Let’s examine each line:

FROM defines the Java Development Kit (JDK) version, and you should use the same version that you used to build your JAR file. We are using Eclipse Temurin, which is an open-source JDK, and version 17, which we used when we developed our Spring Boot application.
Volumes are used for persistent data generated by and used by Docker containers.
EXPOSE defines the port that should be published outside of the container.
COPY copies the JAR file to the container’s filesystem and renames it app.jar.
Lastly, ENTRYPOINT defines the command-line arguments that the Docker container runs.
You can read more about the Dockerfile syntax at https://docs.docker.com/engine/reference/builder/.

Build an image with the following command in the folder where your Dockerfile is located. With the -t argument, we can give a friendly name to our container:
docker build -t carbackend .

Copy

Explain
At the end of the build, you should see a Building [...] FINISHED message, as illustrated in the following screenshot:
Figure 15.25 – Docker build 
Figure 17.34: Docker build

Check the list of images using the docker image ls command. You should see two images now, as shown in the following screenshot:

Figure 17.35: Docker images

Now, we can run our Spring Boot container and link the MariaDB container to it using the following command. This command specifies that our Spring Boot container can access the MariaDB container using the mariadb name:
docker run -p 8080:8080 --name carapp --link cardb:mariadb -d
  carbackend

Copy

Explain
When our application and database are running, we can access the Spring Boot application logs using the following command:
docker logs carapp

Copy

Explain
We can see here that our application is up and running:


Figure 17.36: Application log

Our application has started successfully, and the demonstration data has been inserted into the database that exists in the MariaDB container. Now, you can use your backend, as seen in the following screenshot:


Figure 17.37: Application login

We have learned a few different ways to deploy your full-stack application and how to containerize your Spring Boot application. As a next step, you could study how to deploy Docker containers. For example, AWS has a guide to deploying containers on Amazon ECS: https://aws.amazon.com/getting-started/hands-on/deploy-docker-containers/.

Summary
In this chapter, you learned how to deploy our application. We deployed the Spring Boot application to AWS Elastic Beanstalk. Next, we deployed our React frontend using Netlify. Finally, we used Docker to create containers for our Spring Boot application and the MariaDB database.

As we reach the final pages of this book, I hope you’ve had an exciting journey through the world of full-stack development with Spring Boot and React. As you continue your full-stack development journey, remember that technologies are evolving all the time. For a developer, life is constant learning and innovation – so stay curious and keep building.

Questions
How should you create a Spring Boot executable JAR file?
What AWS services you can use to deploy a database and Spring Boot application to AWS?
What command can you use to build your Vite React project?
What is Docker?
How should you create a Spring Boot application container?
How should you create a MariaDB container?
Further reading
Packt Publishing has other resources available for learning about React, Spring Boot, and Docker. A few of them are listed here:

Docker Fundamentals for Beginners [Video], by Coding Gears | Train Your Brain (https://www.packtpub.com/product/docker-fundamentals-for-beginners-video/9781803237428)
Docker for Developers, by Richard Bullington-McGuire, Andrew K. Dennis, andMichael Schwartz (https://www.packtpub.com/product/docker-for-developers/9781789536058)
AWS, JavaScript, React - Deploy Web Apps on the Cloud [Video], by YouAccel Training (https://www.packtpub.com/product/aws-javascript-react-deploy-web-apps-on-the-cloud-video/9781837635801)
Learn more on Discord
To join the Discord community for this book – where you can share feedback, ask the author questions, and learn about new releases – follow the QR code below:

https://packt.link/FullStackSpringBootReact4e





| ≪ [ 316 Securing Your Application ](/books/packtpub/2024/1202-Spring_Boot_3_React/316) | 317 Deploying Your Application | [ 400 Other Books You May Enjoy ](/books/packtpub/2024/1202-Spring_Boot_3_React/400) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 317 Deploying Your Application
> (2) Short Description: Spring Boot 3 React
> (3) Path: books/packtpub/2024/1202-Spring_Boot_3_React/317_Deploying_Your_Application
> Book Jemok: Full Stack Development with Spring Boot 3 and React 4Ed
> AuthorDate: Juha Hinkula / Oct 2023 / 454 pages 4Ed
> Link: https://subscription.packtpub.com/book/web-development/9781805122463/pref
> create: 2024-12-02 월 14:31:22
> .md Name: 317_deploying_your_application.md

