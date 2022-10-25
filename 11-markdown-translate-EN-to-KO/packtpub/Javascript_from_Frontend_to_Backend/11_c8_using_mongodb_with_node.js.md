
@ Q -> # 붙이고 줄 띄우기 => 0i### ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i```^M^[/^Copy$^[ddk0C```^M^[
@ E -> 찾은 글자 ~ SPACE 앞뒤로 backtick(`) 붙이기 => i`^[/ ^[i`^[/EEEEEEEEEE^[
@ R -> 찾은 글자 ~ POINT 앞뒤로 backtick(`) 붙이기 => i`^[/\.^[i`^[/RRRRRRRRRR^[
@ T -> 찾은 글자 ~ COMMA 앞뒤로 backtick(`) 붙이기 => i`^[/,^[i`^[/TTTTTTTTTT^[
@ Y -> 찾은 글자 ~   ;   앞뒤로 backtick(`) 붙이기 => i`^[/;^[i`^[/YYYYYYYYYY^[
@ U -> 찾은 글자~닫은괄호앞뒤로 backtick(`) 붙이기 => i`^[/)^[i`^[/UUUUUUUUUU^[
@ I -> 찾은 글자 ~ COLON 앞뒤로 backtick(`) 붙이기 => i`^[/:^[i`^[/CCCCCCCCCC^[

@ A -> 빈 줄에 블록 시작하기 => 0C```^[^Mk0
@ S -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 => 0i```^M-^[^M0i```^[0
@ D -> 줄 아래에 블록 마감하고 한줄 더 띄우기 => 0^Mi```^M^M^[kk
@ F -> 이 줄을 타이틀로 만들기 => 0i#### ^[^M^[
    마크다운 입력시 vi 커맨드 표시 ; (^[)=Ctrl+[ ; (^M)=Ctrl+M
    인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
    https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
    blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------

> [ 10 C7 Using Express with Node.js ](/packtpub/javascript_from_frontend_to_backend/10_c7_using_express_with_node.js) <---> [ 12 C9 Integrating Vue.js with Node.js ](/packtpub/javascript_from_frontend_to_backend/12_c9_integrating_vue.js_with_node.js)

# Chapter 8: Using MongoDB with Node.js

MongoDB is the database traditionally associated with Node.js. It is a NoSQL type database, which means that SQL will not be used to access the information it contains.

MongoDB is a document-oriented database in which we store so-called documents; that is, a data structure of any type, such as information written on a sheet of paper (which is then equivalent to a document). Several sheets of paper, thus corresponding to several documents, form what is called a collection.

An example of a document is, for example, the first name, the last name, and the address of a customer. Aggregated information from multiple customers would be called a collection.

In this chapter, we’ll study how to use MongoDB in conjunction with Node.js in order to store, read, delete, or update information in the database.

Inserting, searching, updating, or deleting data are the main actions that can be performed in a database. Therefore, in this chapter, we’ll see how to perform these operations with the MongoDB database.

Here are the topics covered in this chapter:

- Installing MongoDB and the mongoose module
- Connecting to the MongoDB database
- Creating documents
- Searching documents
- Updating documents
- Deleting documents

Let’s start by installing MongoDB and the mongoose module, which will allow MongoDB to be used in Node.js programs.

# Technical requirements

You can find the code files for this chapter on GitHub at: https://github.com/PacktPublishing/JavaScript-from-Frontend-to-Backend/blob/main/Chapter%208.zip.

# Installing MongoDB

The MongoDB database is independent of Node.js, which requires installing it separately. To do this, go to the site https://www.mongodb.com/docs/manual/administration/install-community/. Download the version suitable for your system.

Once MongoDB is installed, verify that the installation is correct by typing the `mongo -h` command in a command interpreter. The `mongo` command is located in the `Server/x.x/bin` directory of MongoDB, where `x.x` is the version number of MongoDB installed.

Note

At the time of writing, the `mongo` utility is available directly when installing MongoDB. However, it is possible that this utility will soon be available separately and called `mongosh`. In this case, download this utility from https://www.mongodb.com/docs/mongodb-shell/install/.

The `mongo` command will simply be replaced by the equivalent `mongosh` command. Both commands work identically.

After installing MongoDB, we will look into the mongo (or mongosh) utility. The mongo utility makes it easy to see the contents of database collections, without having to write program lines. It is therefore useful for checking, for example, whether a document has been correctly inserted into a collection, or that its deletion has been successful. Let’s see how to use the mongo utility.

## Using the mongo utility

The mongo utility enables you to easily view databases and the collections they contain. The mongo utility is launched by simply typing the `mongo` command in a command interpreter. The program then waits for database access commands, or the `exit` command to exit.

Here is the list of the main commands available in the mongo utility:

- `show dbs`: This shows a list of existing databases. A database will be visible here only if it contains at least one collection.
- `db=connect("mydb_test")`: This is to connect to the database `mydb_test`. The `db` variable will then be used to access the database collections.
- `show collections`: This shows the collections of the connected database. A collection will be present if it contains at least one document.
- `db.clients.find()`: This shows all documents in the `clients` collection.
- `db.clients.find({name:"Clinton"})`: This lists documents in the `clients` collection whose name is `Clinton`.
- `db.clients.find().sort({name:1})`: This sorts documents in ascending order of the `name` field. Use `{name:-1}` for descending sort.
- `db.clients.count()`: This counts the number of documents found in the `clients` collection.
- `db.clients.renameCollection("clients2")`: This renames the `clients` collection to `clients2`.
- `db.clients.drop()`: This drops the `clients` collection (all documents are dropped).
- `db.dropDatabase()`: This drops the connected database (all collections are removed).

Other commands exist, in particular, for inserting, updating, or deleting documents in a collection. But since these actions are performed through the mongoose module instead, we will describe them using the mongoose module.

## Installing the mongoose module

To establish the relationship between MongoDB and Node.js, several npm modules have been created. The most widely used one currently is the mongoose module. It is installed in the node_modules directory of the current directory by typing the npm install mongoose command.

![ 1100 8.1 Installing the mongoose ](/packtpub/javascript_from_frontend_to_backend_img/1100_8.1_installing_the_mongoose.webp
)
Figure 8.1 – Installing the mongoose module

Once mongoose has been downloaded by npm, we check whether it is accessible for our programs. Let’s display the mongoose version for our programs. We write this snippet in the file `test.js`:

Displaying mongoose version (test.js file)

```
var mongoose = require("mongoose");
console.log("mongoose version =", mongoose.version);
```

Let’s use the node test.js command to run the previous program:

![ 1101 8.2 Checking that mongoose ](/packtpub/javascript_from_frontend_to_backend_img/1101_8.2_checking_that_mongoose.webp
)
Figure 8.2 – Checking that mongoose is accessible

Warning

If you get an error loading the mongoose module, it’s probably because you installed it globally (with the `-g` option). In this case, just type the `npm link mongoose` command in the terminal to get rid of the error.

The mongoose module will allow us to use the MongoDB database to create documents, search them, update them, or destroy them. These are the classic operations that can be performed on a database.

But to be able to perform these operations, it is necessary to first connect to the database.

# Connecting to the MongoDB database

All operations to access MongoDB require establishing a connection with it. Now let’s see how to establish a connection with MongoDB.

The `mongoose.connect(url)` instruction connects the mongoose module to the database specified in the `url` parameter. The `url` parameter is of the form `"mongodb://localhost/mydb_test"` to connect to the `mydb_test` database on the localhost server.

The database will actually be created (and visible with the execution of the `show dbs` command of the mongo utility) when the first document is inserted into it:

Connecting to the mydb_test database (test.js file)

```
var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/mydb_test");
console.log("Connecting to mydb_test database in progress...");
```

Let’s run the previous program:

![ 1102 8.3 Database connection ](/packtpub/javascript_from_frontend_to_backend_img/1102_8.3_database_connection.webp
)
Figure 8.3 – Database connection

To know whether the connection to the database has actually been made, mongoose sends the `open` event (if the connection was successful) or the error event (if the connection fails) on the `mongoose.connection` object.

Next, we will take these two events into account and integrate them into the previous program. This is done using the `on(event, callback)` method defined on the `mongoose.connection` object:

Note

The `on(event, callback)` method is used to process the reception of the event and to associate it with the processing described in the callback function.

Using open and error events on database connection (test.js file)

```
var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/mydb_test");
mongoose.connection.on("error", function() {
 console.log("mydb_test database connection error")
});
mongoose.connection.on("open", function() {
 console.log("Successful connection to mydb_test 
 database");
});
console.log("Connecting to mydb_test database in progress...");
```

Let’s run the previous program:

![ 1103 8.4 Successful connection ](/packtpub/javascript_from_frontend_to_backend_img/1103_8.4_successful_connection.webp
)
Figure 8.4 – Successful connection to the database

We have seen how to connect to the database. We will therefore be able to create documents in a collection of the database.

# Creating documents in MongoDB

Once the database has been accessed, you can create documents in it.

A document will be inserted into a collection. A collection will therefore group together a set of documents. The database will therefore be a set of collections, each containing documents.

In order to be able to insert documents, mongoose asks us to describe the structure of these documents. For this, we will use schemas and models.

## Describing document structure using schemas and models

To access the documents in the database, the documents must be described by means of schemas and models.

Definitions

A schema allows you to define the structure of a document that is stored in a collection. The structure is defined according to MongoDB data types.

A model is the representation of a schema as a JavaScript class. It links a schema to a MongoDB collection.

Let’s look at how to create a schema and then a model.

### Creating a schema

A schema defines the fields of a document using Node.js internal object classes. These are the following classes:

- `String`: This defines a string of characters.
- `Number`: This defines a numeric field.
- `Boolean`: This defines a Boolean.
- `Array`: This defines an array.
- `Buffer`: This defines a buffer of bytes.
- `Date`: This defines a date.
- `Object`: This defines a JavaScript object.

The `mongoose.Schema(format)` method is used to define the schema associated with the document. The `format` parameter is a JavaScript object that associates each field in the document with the type (in the above list) that represents it.

Let’s create the schema defining a client. A client is characterized by its `lastname`, `firstname`, and `address`. All these fields are of type `String`:

Defining the schema associated with a client (test.js file)

```
var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/mydb_test");
var clientSchema = mongoose.Schema({
 lastname : String,
 firstname : String,
 address : String
});
```

Now let’s explain how to create a model from the schema.

### Creating a model

The schema is then used to define the model associated with the document. The model corresponds to a JavaScript class that will be used to create the documents in a collection.

The `mongoose.model(collection, schema)` method returns a JavaScript class associated with the schema. This class is called a model.

Documents created with this class will be inserted into the specified `collection`. The collection may not exist before inserting a document. A collection requires at least one document within it.

### Summary

A schema specifies the format of a document stored in a collection, while a model is a JavaScript class used to create each such document. We associate a document schema with a collection using the `mongoose.model(collection, schema)` method call. This returns a JavaScript class that can then be used to generate individual document instances.

Let’s create the `Client` class, which will create the clients that will be stored in the `clients` collection. It is traditional to name the collection based on the name of the model, in lowercase and in plural:

Creating the Client model from the schema (test.js file)

```
var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/mydb_test");
var clientSchema = mongoose.Schema({
 lastname : String,
 firstname : String,
 address : String
});
// creation of the Client class associated with the clients 
// collection
var Client = mongoose.model("clients", clientSchema);
```

The `Client` class is now available to create the documents that will be inserted into the `clients` collection.

## Creating the document

There are two methods for creating the documents in a collection. These are the `doc.save(callback)` instance method and the `create(doc, callback)` class method. Let’s look at these two ways to create documents in a collection.

Let’s start by using the `doc.save(callback)` instance method.

### Using the doc.save(callback) instance method

The client document is created in memory from the previously created class (by means of `var client = new Client()`), then saved in the `clients` collection by means of the `client.save()` method.

The callback function allows processing when the document has finished being inserted into the collection. This is especially useful if it is necessary to wait for the document to be inserted into the database before continuing processing:

Using the save() instance method to save document (test.js file)

```
var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/mydb_test");
var clientSchema = mongoose.Schema({
 lastname : String,
 firstname : String,
 address : String
});
// creation of the Client class associated with the clients 
// collection
var Client = mongoose.model("clients", clientSchema);
// create the document in memory
var c = new Client({lastname :"Clinton", firstname:"Bill", address:"Washington"});
console.log("Before the save() statement");
// save the document in the database (clients collection)
c.save(function(err) {
  if (!err) console.log("The client is inserted into the 
  collection");
});
console.log("After the save() statement");
```

The callback function takes the `err` parameter, which corresponds to a possible error message (otherwise, it is `null`).

We get the following result:

![ 1104 8.5 Using the doc.save ](/packtpub/javascript_from_frontend_to_backend_img/1104_8.5_using_the_doc.save.webp
)
Figure 8.5 – Using the doc.save() instance method

Using the traces displayed in the console, we can see that the message `The client is inserted into the collection` is displayed after the other messages, which means that inserting a document is not blocking other tasks (i.e., other tasks can be done while waiting for insertion in the database).

The `save()` method can also be used as a `Promise` object (see Chapter 2, Exploring the Advanced Concepts of JavaScript). For this, we use the `then(callback)` method afterward, possibly followed by the `catch(callback)` method to process the cases of error when calling the `save()` method.

In this case, we write the following:

Using the save() method as a Promise objet

```
c.save().then(function(doc) {
  console.log(doc);
  console.log("The client is inserted into the collection");
}).catch(function(err) {
  console.log(err);  // display the error
});
```

Now let’s see the other method of `creating a document with the create(doc, callback)` class method.

### Using the create(doc, callback) class method

A class method means that we can use the method without having instantiated an object, unlike an instance method, which requires that the object of the class be created (with `c = new Client()`).

To create the document associated with the client identified by `{lastname:"Obama", firstname:"Barack", address:"Washington"}`, we would write the following:

Using the Client.create(doc, callback) class method to save document (test.js file)

```
var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/mydb_test");
var clientSchema = mongoose.Schema({
 lastname : String,
 firstname : String,
 address : String
});
// creation of the Client class associated with the clients 
// collection
var Client = mongoose.model("clients", clientSchema);
console.log("Before the create() statement");
// save the document in the database (clients collection)
Client.create({lastname:"Obama", firstname:"Barack", address:"Washington"}, function(err, doc) {
  console.log("The client is inserted into the collection", 
  doc);
});
console.log("After the create() statement");
```

The `create(doc, callback)` class method is used by prefixing it with the name of the JavaScript class (here, the `Client` class).

The document to be saved is written in the form of a JavaScript object (JSON format) but can also be an object instantiated with `c = new Client()`.

The callback function of the form `callback(err, doc)` is executed at the end of saving the document in the database. This callback function is useful if you want to perform a process while being certain that the document has been saved in the collection.

Note

Note that the callback function `callback(err, doc)` of the `create(doc, callback)` method has the two parameters `err` and `doc`, which are the possible error and the document saved in the database, respectively.

Let’s run the previous program:

![ 1105 8.6 Using the Client.create ](/packtpub/javascript_from_frontend_to_backend_img/1105_8.6_using_the_client.create.webp
)
Figure 8.6 – Using the Client.create() class method

The saved document has the fields indicated in the format associated with the model (here, the `lastname`, `firstname`, and `address` fields), but also the `_id` and `__v` fields, added automatically by MongoDB:

- The `_id` field is a field used by MongoDB to give a unique identifier to each document in a collection. It plays the role of a primary key.
- The `__v` field is a field added by mongoose, associated with the document version number. We will not use it here.

As with the `save()` instance method, the `create(doc)` class method can be used as a `Promise` object. For this, we do not use the `callback` parameter in the `create(doc)` method and instead use the `then(callback)` and `catch(callback)` methods following the `create(doc)` method call.

For example, we could also write the following:

Using create() method as a Promise object

```
Client.create({lastname:"Obama", firstname:"Barack", address:"Washington"}).then(function(doc) {
  console.log("The client is inserted into the collection", 
  doc);
});
```

In the previous examples, we have inserted two documents into the `clients` collection. Let’s use the mongo utility to display the inserted documents and verify the documents that are present in the collection.

### Using the mongo utility to view inserted documents

To display the inserted documents, use the mongo utility and type the following commands:

1. `db=connect("mydb_test")` to connect to the database
1. `show collections` to show the collections already present
1. `db.clients.find()` to display documents from the clients collection

![ 1106 8.7 Using the mongo utility ](/packtpub/javascript_from_frontend_to_backend_img/1106_8.7_using_the_mongo_utility.webp
)
Figure 8.7 – Using the mongo utility to view documents

We thus check that the two documents of the `clients` collection are indeed present.

Let’s see how to search for them with mongoose module methods.

# Searching for documents in MongoDB

Once the documents have been inserted into the collection, they can be searched for using the `find()` class method.

Note

The `find()` method is a class method, which means that it is used by prefixing it with the class name associated with the model, for example, `Client.find()`.

The `find(conditions, callback)` method is used to perform a search in the collection associated with the model, then to retrieve the results of the search in the callback function indicated as a parameter.

Let’s take an in-depth look at the parameters:

- The `conditions` parameter is a JavaScript object used to specify search conditions. If no condition is specified, do not indicate anything (or indicate an empty object `{}`).
- The callback function is of the form `callback(err, results)` where `err` is an error message (`null` otherwise) and `results` is an array containing the search results (empty `[]` if none).

There is also the `findOne(conditions, callback)` class method, which allows you, on the same principle, to find only the first document that satisfies the search. The callback function is of the form `callback(err, result)` where `result` is the first document found.

Note

The `findOne(conditions, callback)` method will be useful if you are looking for a single document, for example, from its identifier `_id`.

You can also use the `find(conditions)` and `findOne(conditions)` methods without specifying the callback function as a parameter. For this, we use the `then(callback)` and `catch(callback)` methods to perform the processing on the documents found or in the event of an error. We can also use the `exec(callback)` method, as explained in the following section.

Let us now examine how to write the `conditions` parameter used in the two methods `find()` and `findOne()`.

## Writing search conditions

In the `conditions` parameter, we indicate an object whose properties are the fields of the documents in the collection, and the associated values are the values sought for the field, of the form `{field1:value1, field2:value2...}`, for example, `{lastname:"Clinton", firstname:"Bill"}`.

Other properties can be used as keywords to express conditions. They start with the `$` sign, such as: `$or`, `$exists`, `$type`, `$where`, `$gt`, and `$lt`.

Note

A list of possible keywords can be found here: https://docs.mongodb.com/manual/reference/operator/query/.

Here are some examples of conditions:

- `{ }`: All documents in the collection. You can also write `find()`, which is equivalent to `find({})`.
- `{ lastname: "Clinton" }`: All documents whose lastname is `Clinton`.
- `{ lastname: "Clinton", firstname: "Bill" }`: All documents whose lastname is `Clinton` and first name is `Bill`.
- `{ $or: [{ lastname: "Clinton"}, { firstname: "Jimmy" }] }`: All documents whose lastname is `Clinton` or first name is `Jimmy`.
- `{ lastname: /obama/i }`: All documents whose lastname contains the string `obama` regardless of case (regular expression).
- `{ address: { $exists: true} }`: All documents whose `address` field exists, regardless of its type (String, Object, etc.).
- `{ address: { $exists: true, $type: 2 } }`: All documents whose `address` field exists, and which is of type `2` (String).
- `{"address.city": "Washington" }`: All documents containing the `address` field that itself has a city field whose value is `Washington`.
- `{lastname:{$type:2}, $where:"this.lastname.match(/^Clinton|carter$/i)"}`: All documents whose lastname is a string (type = 2) and whose lastname begins with `Clinton` or ends with `carter`, regardless of case. You must indicate that the lastname is a character string, otherwise you may have an error with names that are not in this form.
- `{lastname: { $gt: "J", $lt: "S" }}`: All documents whose lastname is greater than `"J"` and less than `"S"`.
- `{lastname: { $in:["Clinton", "Carter", "Obama"] }}`: All documents whose lastname is `Clinton`,` Carter`, or `Obama`.

Once the search conditions have been expressed, the results found must be retrieved and displayed. Let’s see how to do it.

## Retrieving and displaying the results

Whatever the condition expressed, the corresponding results can be retrieved in the callback function associated with the `find()` method, of the form `callback(err, results)`. We will also see that it is possible to use the `exec(callback)` method to retrieve the results.

Let’s look at these two ways to retrieve search results.

### Using the callback parameter of the find(conditions, callback) method

Let’s find all clients whose lastname is `Clinton` or firstname is `Barack`. The result will be displayed in the callback function:

Displaying clients whose lastname is “Clinton” or firstname is “Barack” (test.js file)

```
var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/mydb_test");
var clientSchema = mongoose.Schema({
 lastname : String,
 firstname : String,
 address : String
});
// creation of the Client class associated with the clients 
// collection
var Client = mongoose.model("clients", clientSchema);
Client.find({ $or : [ { lastname : "Clinton" }, { firstname : "Barack"} ] }, function(err, clients) {
  console.log(clients);
});
```

We obtain the result shown in the following figure:

![ 1107 8.8 Displaying search results ](/packtpub/javascript_from_frontend_to_backend_img/1107_8.8_displaying_search_results.webp
)
Figure 8.8 – Displaying search results with find(conditions, callback)

The callback function can be expressed in the `find()` method as before, or be specified in the `exec()` method used after the `find()` method. Let us now examine this second possibility.

### Using the exec(callback) method

Another way to retrieve results is to use the `exec(callback)` method following the `find(conditions)` method. The `find(conditions)` method is used here without indicating a callback function in its parameters because the callback function is indicated in the `exec(callback)` method.

The advantage of this is that we can insert new methods between the `find()` method and the `exec()` method. For example, if we want to add as additional conditions that the `lastname` field must be equal to `Clinton`, we can write the following:

Adding as search conditions that lastname is “Clinton” (test.js file)

```
var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/mydb_test");
var clientSchema = mongoose.Schema({
 lastname : String,
 firstname : String,
 address : String
});
// creation of the Client class associated with the clients 
// collection
var Client = mongoose.model("clients", clientSchema);
Client.find({ $or : [ { lastname : "Clinton" }, { firstname : "Barack"} ] })
.where("lastname")
.eq("Clinton")
.exec(function(err, clients) {
  console.log(clients);
});
```

Note

Methods such as `where(field)` and `eq(value)` can be chained after the `find()` method. The execution of the search will be effective when calling the `exec()` method. Other usage possibilities are described here: https://mongoosejs.com/docs/api/query.html#query_Query-where.

You can also use the `exec(callback)` method without specifying the callback function as a parameter. For this, we use the `then(callback)` and `catch(callback)` methods to perform the processing on the documents found or in the event of an error.

We write the following for this:

Using exec() method as a Promise object

```
Client.find({ $or : [ { lastname : "Clinton" }, { firstname : "Barack"} ] })
.where("lastname")
.eq("Clinton")
.exec()
.then(function(clients) {
  console.log(clients);  // display the clients
})
.catch(function(err) {
  console.log(err);  // display the error
});
```

The result is displayed in the following figure.

![ 1108 8.9 Using the exec ](/packtpub/javascript_from_frontend_to_backend_img/1108_8.9_using_the_exec.webp
)
Figure 8.9 – Using the exec(callback) method

We’ve learned how to create documents, then search for them. Now let’s look at how to update them.

# Updating documents in MongoDB

It is possible to modify one or more documents of a collection. The `updateOne()` and `updateMany()` class methods are used respectively to modify the first document found or all of the documents found.

These two methods have similar parameters:

- `updateMany(conditions, update, callback)` indicates modifying the data indicated in the `update` object on the documents specified by the indicated `conditions`. The callback function of the form `callback(err, response)` is called after the update.
- `updateOne(conditions, update, callback)` indicates modifying the data indicated in the `update` object on the first document found by the indicated `conditions`. The callback function of the form `callback(err, response)` is called after the update.
- Only the `conditions` and `update` parameters are mandatory in the two methods.Warning
If the callback is not present in the method, you must use the `then()` or `exec()` method afterward, otherwise the update is not done.

Let’s modify the address of `Clinton`, which will now be `New York`:

Using updateOne() to modify the address of “Clinton” (test.js file)

```
var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/mydb_test");
var clientSchema = mongoose.Schema({
 lastname : String,
 firstname : String,
 address : String
});
// creation of the Client class associated with the clients 
// collection
var Client = mongoose.model("clients", clientSchema);
Client.updateOne({ lastname : "Clinton" }, { address : "New York" }, function(err, response) {
  console.log("response =", response);
});
```

Here, we use the callback function to display the content of the `response` parameter returned by the function. We get the following result:

![ 1109 8.10 Updating a document ](/packtpub/javascript_from_frontend_to_backend_img/1109_8.10_updating_a_document.webp
)
Figure 8.10 – Updating a document

Note

The `response.modifiedCount` field indicates the number of modified documents.

If you do not want to perform any processing at the end of the update, you can omit the callback function, but in this case, you must use the `then()` or `exec()` method afterward, otherwise, the update will not take place.

Let’s use the `exec()` method to perform the update:

Performing update using exec() method (test.js file)

```
var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/mydb_test");
var clientSchema = mongoose.Schema({
 lastname : String,
 firstname : String,
 address : String
});
// creation of the Client class associated with the clients 
// collection
var Client = mongoose.model("clients", clientSchema);
Client.updateOne({ lastname : "Clinton" }, 
                 { address : "New York" })
.exec();    // exec() mandatory!
```

Once you know how to create, search for, and then modify documents, you just have to know how to delete them. Let’s look at how to do it.

# Deleting documents in MongoDB

Similar to `updateOne()` and `updateMany()`, there are the two class methods, namely `deleteOne(conditions, callback)` and `deleteMany(conditions, callback)` that allow you to delete the first document (`deleteOne()`) or all the documents (deleteMany()) that satisfy the conditions expressed.

In addition, the instance method `doc.remove(callback)` also makes it possible to delete the `doc` document when it is in memory.

Let’s remove `Clinton` from the collection by using the `deleteOne()` method, then display the new contents of the collection:

Using deleteOne() to delete client “Clinton” (test.js file)

```
var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/mydb_test");
var clientSchema = mongoose.Schema({
 lastname : String,
 firstname : String,
 address : String
});
// creation of the Client class associated with the clients 
// collection
var Client = mongoose.model("clients", clientSchema);
Client.deleteOne({ lastname : "Clinton" }, function(err, response) {
  console.log("After Clinton's removal");
  console.log("response = ", response);
  Client.find(function(err, clients) {
    console.log("clients = ", clients);
  });
});
```

In the same way as for the `updateOne()` and `updateMany()` methods, it is the presence of the callback function that triggers the update of the database. If you do not indicate a callback function, you must in this case use the `then()` or `exec()` method following the `deleteOne()` or `deleteMany()` method.

The result is displayed in the following figure:

![ 1110 8.11 Deleting the Clinton ](/packtpub/javascript_from_frontend_to_backend_img/1110_8.11_deleting_the_clinton.webp
)
Figure 8.11 – Deleting the “Clinton” client with deleteOne()

The `response` object returned in the callback of the `deleteOne()` (or `deleteMany()`) method indicates the `deletedCount` field, which contains the number of documents deleted.

We have successively studied the four possible operations on documents in a MongoDB database, namely inserting, searching, modifying, and deleting documents. And with this, we come to the end of this chapter.

# Summary

Data management with MongoDB is relatively easy, thanks to the use of external modules such as mongoose. All possible actions on a database are easily achievable.

The mongo utility, available when installing MongoDB, makes it easy to view collections and the documents they contain.

Using the MongoDB database is essential for building client-server applications and maintaining user information.

All that’s left is to see how to interconnect a client side made with Vue.js and a server side made with Node.js. We will see this in the following chapter. We will build a 100% JavaScript application in order to show how simple and efficient it is.



> [ 10 C7 Using Express with Node.js ](/packtpub/javascript_from_frontend_to_backend/10_c7_using_express_with_node.js) <---> [ 12 C9 Integrating Vue.js with Node.js ](/packtpub/javascript_from_frontend_to_backend/12_c9_integrating_vue.js_with_node.js)
>
> Title: 11 C8 Using MongoDB with Node.js
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/11_c8_using_mongodb_with_node.js
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 13:20:55
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 11_c8_using_mongodb_with_node.js.md

