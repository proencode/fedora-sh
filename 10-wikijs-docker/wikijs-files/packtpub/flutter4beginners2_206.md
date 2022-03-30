-- 원본 제목: Chapter 6: Handling User Input and Gestures
-- 원본 링크: https://www.packtpub.com/product/flutter-for-beginners-second-edition/9781800565999
-- Path:
packtpub/flutter4beginners2/206
-- Title:
206 Handling User Input and Gestures
-- Short Description:
Flutter for Beginners Second Edition 사용자 입력 및 제스처 처리

![Figure 6.1 - Example of a custom input widget ](/flutter4beginners2_img/figure_6.1_-_example_of_a_custom_input_widget.jpg)
- cut line


# Chapter 6: Handling User Input and Gestures
Flutter for Beginners Second Edition

With the use of widgets, it is possible to create an interface that is rich in visual resources while also allowing user interaction through gestures and data entry. In this chapter, you will learn about the widgets used to handle user gestures and receive and validate user input, along with how to create your own custom inputs.

The following topics will be covered in this chapter:

- Handling user gestures
- A deeper look at the stateful widget life cycle
- Input widgets and forms
- Creating custom inputs

# Technical requirements

You will need your development environment again for this chapter. Look back at Chapter 1, An Introduction to Flutter, if you need to set up your IDE or refresh your knowledge of the development environment requirements.

You can find the source code for this chapter on GitHub at https://github.com/PacktPublishing/Flutter-for-Beginners-Second-Edition/tree/main/hello_world/lib/chapter_06.

# Handling user gestures

A mobile application would be very limited without some kind of interactivity. The Flutter framework allows the handling of user gestures in every possible way, from simple taps to drag and pan gestures. The screen events in Flutter's gesture system are separated into two layers, as follows:

- Pointers layer: This layer holds the raw information about how a pointer (for example, a touch, mouse, or stylus) is interacting with the screen. This raw data will include the location and movement of the pointer.
- Gestures layer: This layer takes multiple pointer actions and tries to assign them some meaning as a user action. These semantic actions (for example, a tap, drag, or scale) are often more useful to the application, and they are the most typical way of implementing user input handling.

## Pointers

Flutter starts screen input handling in the low-level pointer layer. Generally, there is no need to use events from this layer in your application, but if you need to do some bespoke input handling, then you can use this layer to receive events on every pointer update and decide how to control it. For example, if you are coding a game, then you may need precise details on every pointer update rather than relying on the higher-level gesture events.

The Flutter framework implements pointer event dispatching on the widget tree by following a sequence of events:

- PointerDownEvent is where the interaction begins, with a pointer coming into contact with a certain location of the device screen. Here, the framework searches the widget tree for the widget that exists in the location of the pointer on the screen. This action is called a hit test.
- Every following event is dispatched to the innermost widget that matches the location and then raises the widget tree from the parent widgets to the root. This propagation of event actions cannot be interrupted. The event could be PointerMoveEvent, where the location of the pointer is changed, PointerUpEvent, indicating that the pointer is no longer in contact with the screen, or PointerCancelEvent, where the pointer is still active on the device but is no longer interacting with your app.
- The interaction will finish with one of the PointerUpEvent or PointerCancelEvent events.

Flutter provides the Listener class, which can be used to detect the pointer interaction events listed previously. You can wrap a widget tree with this widget to handle pointer events on its widget subtree.

## Gestures

Although possible, it is not always practical to handle pointer events by ourselves using the Listener widget. Instead, the events can be handled on the second layer of the gesture system. The gestures are recognized from multiple pointer events, and even multiple individual pointers (multitouch). There are multiple kinds of gestures that can be handled:

- Tap: A single tap/touch on the device screen.
- Double-tap: A quick double-tap on the same location on the device screen.
- Press and long-press: A press on the device screen, similar to tap, but having contact with the screen for a longer period of time before release.
- Drag: A press that starts with a pointer having contact with the screen in some location, which is then moved, and stops having contact at another location on the device screen.
- Pan: Similar to drag events. In Flutter, they are different in direction; pan gestures cover both horizontal and vertical drag.
- Scale: Two-pointers are used for a drag move to employ a scale gesture. This is also similar to a zoom gesture.

Like the Listener widget for pointer events, Flutter provides the GestureDetector widget, which contains callbacks for all of the preceding events. You would use them according to the interaction you want to allow. Let's take a look at some examples of GestureDetector.

## GestureDetector

We can create a stateless widget called TapExample to have a look at GestureDetector detecting a gesture event:

```
class TapExample extends StatefulWidget {
  TapExample({Key key}) : super(key: key);
  @override
  _TapExampleState createState() => _TapExampleState();
}
class _TapExampleState extends State<TapExample> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _counter++;
        });
      },
      child: Container(
        color: Colors.grey,
        child: Text(
          "Tap count: $_counter",
        ),
      ),
    );
  }
}
```

In this example, we have a stateful widget named TapExample and its companion state class, _TapExampleState. This follows the stateful widget structure we saw in the previous chapter. We need to have a state because we want the widget to react to user input, and this will involve changing the value of a variable and then redrawing the widget.

In the state object, we have a single _counter variable to show how many taps have been performed on the screen. The state object also has the obligatory build method, which holds the details of how the widget should be drawn to the screen. As previously, this is done by returning a child widget tree.

The top widget that is returned is GestureDetector, which in turn has a child constructor parameter into which we have passed a Container widget holding a Text widget. GestureDetector wraps the child widgets and reports on gestures that happen within the child widget tree. Let's look at how we listen to the different gestures.

### Tap

A tap gesture involves a pointer contacting the screen at a location and then ending contact at a similar location, without moving away from the location.

In the preceding example, we have specifically used GestureDetector's onTap constructor parameter. Let's look closer at the key section of code:

```
GestureDetector(
  onTap: () {
    setState(() {
      _counter++;
    });
  },
  ...
```

The onTap parameter takes a function as the argument, and we have placed an inline function that increments the _counter variable within the setState method.

If you wish to listen to more fine-grained gestures around taps, there are also other constructor parameters on GestureDetector that can be used:

- onTapDown: A pointer that may be about to tap has come into contact with the screen.
- onTapUp: A pointer that has tapped the screen has finished touching the screen.
- onTapCancel: A pointer that triggered onTapDown (so the gesture layer thought there was a chance the full gesture was going to be a tap) did not actually do a tap.

Using GestureDetector to receive gestures is really that simple, so let's look at the other gestures available to us.

### Double-tap

A double-tap has very similar constraints to tap but adds the stipulation that there must be two taps in quick succession.

The code will look very similar to the tap example:

```
GestureDetector(
  onDoubleTap: () {
    setState(() {
      _counter++;
    });
    },
  …
```

The only difference from the previous example is that the onDoubleTap constructor parameter is used. We have passed in the same inline function as the argument and the function will be called every time double-taps are performed at the same location on the screen.

If you wish to listen to more fine-grained gestures around double-taps, there are also other constructor parameters on GestureDetector that can be used:

- onDoubleTapDown: A pointer that may be about to double-tap has come into contact with the screen.
- onDoubleTapUp: A pointer that has double-tapped the screen has finished touching the screen.
- onDoubleTapCancel: A pointer that triggered onDoubleTapDown (so the gesture layer thought there was a chance the full gesture was going to be a double-tap) did not actually do a double-tap.

Note that some of the more fine-grained, or partial, gestures may be triggered before the full gesture has been resolved, and therefore not align with the correct gesture. For example, onTapDown would be triggered on the first tap of a double-tap, but ultimately the tap gesture would not complete because the user did a double-tap rather than a single tap. So, be careful when you use these partial gestures.

### Press and hold

A press on the device screen is similar to a tap but having contact with the screen for a longer period of time before release and with no movement away from the location.

The code will look very similar to the previous examples:

```
GestureDetector(
  onLongPress: () {
    setState(() {
      _counter++;
    });
  },
  …
```

The only difference from the previous item is the property assigned, onLongPress, which will be called every time a tap is performed and held for some time before being released from the screen.

If you wish to listen to more fine-grained gestures around long-press, there are also other constructor parameters on GestureDetector that can be used:

- onLongPressStart: A pointer in contact with the screen has been recognized as enacting a long-press.
- onLongPressEnd/nLongPressUp: A pointer that has long-pressed the screen has finished touching the screen.
- onLongPressMoveUpdate: A pointer that triggered onLongPressStart has now been drag-moved.

It is possible to use many of the different gestures in the same GestureDetector. GestureDetector will decide which gesture, if any, is applicable to the touch and call the function supplied for that gesture.

### Drag, pan, and scale

Drag, pan, and scale gestures are similar to each other, and we have to decide which one to use in each situation, as they cannot all be used together in the same GestureDetector widget.

Drag gestures are separated into vertical and horizontal gestures. Even the callbacks are separated.

### Horizontal drag

A horizontal drag, as the name suggests, is where the pointer has been placed on the screen, dragged in a mainly horizontal direction, and then released.

Let's see how the detection of a horizontal drag looks in code:

```
GestureDetector(
  onHorizontalDragStart: (DragStartDetails details) {
    setState(() {
      _move = Offset.zero;
      _dragging = true;
    });
  },
  onHorizontalDragUpdate: (DragUpdateDetails details) {
    setState(() {
      _move += details.delta;
    });
  },
  onHorizontalDragEnd: (DragEndDetails details) {
    setState(() {
      _dragging = false;
      _dragCount++;
    });
  },
  ...
```

This time, we need a bit more work than for tap events. In the example, we have three properties present in the state:

- _dragging: Used to update the text viewed by the user while dragging.
- _dragCount: This accumulates the total number of drag events made from start to end.
- _move: This accumulates the offset of the dragging that is applied to the text using the translate constructor of the Transform widget.

As you can see, the drag callbacks receive parameters related to each event: DragStartDetails, DragUpdateDetails, and DragEndDetails. These contain values that may help at each stage of the dragging.

### Vertical drag

A vertical drag, as the name suggests, is where the pointer has been placed on the screen, dragged in a mainly vertical direction, and then released.

The vertical version of drag is almost the same as the horizontal version. The significant differences are in the callback properties, which are onVerticalDragStart, onVerticalDragUpdate, and onVerticalDragEnd.

What changes for vertical and horizontal callbacks in terms of code is the delta property value of the DragUpdateDetails class. For horizontal, it will only have the horizontal part of the offset changed, and for vertical, the opposite is the case.

### Pan

A pan is similar to a horizontal or vertical drag but the movement of the pointer when in contact with the screen is not predominantly only horizontal or vertical but is instead a mix of both.

The significant differences to the previous examples are that, in addition to the callback properties, which are now onPanStart, onPanUpdate, and onPanEnd. For pan drags, both axes' offsets are evaluated; that is, both delta values in DragUpdateDetails are present, so the dragging has no limitation on the direction.

### Scale

The scale version is nothing more than panning on more than one pointer.

Let's see what the scale version of panning looks like:

```
GestureDetector(
  onScaleStart: (ScaleStartDetails details) {
    setState(() {
      _scale = 1.0;
      _resizing = true;
    });
  },
  onScaleUpdate: (ScaleUpdateDetails details) {
    setState(() {
      _scale = details.scale;
    });
  },
  onScaleEnd: (ScaleEndDetails details) {
    setState(() {
      _resizing = false;
      _scaleCount++;
    });
  },
  ...
```

We have three properties in the state:

- _resizing: This is used to update the text viewed by the user while resizing using the scale gesture.
- _scaleCount: This accumulates the total number of scale events made from start to end.
- _scale: This stores the scale value from the ScaleUpdateDetails parameter, and that later is applied to the Text widget using the scale constructor of the Transform widget.

As you can see, scale callbacks look very similar to drag callbacks in that they also receive parameters related to each event: ScaleStartDetails, ScaleUpdateDetails, and ScaleEndDetails. These contain values that may help at each stage of the scale event.

## Gestures in material widgets

While GestureDetector is a very useful widget, most of the time you will not need to use it because built-in widgets will already have gesture management built into them.

Material Design and iOS Cupertino widgets have many gestures abstracted to a constructor parameter by using the GestureDetector widget internally in their code.

For example, material widgets such as ElevatedButton embed a special widget named InkWell that, in addition to giving access to the tap gesture event, will also create a splash effect on the target widget. The onPressed property of ElevatedButton exposes the tap functionality that can be used to implement the action of the button.

### Consider the following example:

```
ElevatedButton(
  onPressed: () {
    print("Running validation");
    ...
  },
  child: Text("validate"),
)
```

A child Text widget is displayed in ElevatedButton and a tap on the button is handled by the function passed as the argument to the onPressed constructor parameter.

So, now that you've had an introduction to gestures, we can move on to other input methods for users. In preparation for that, we first need to learn a little more about stateful widgets.

# A deeper look at the stateful widget life cycle

In the previous chapter, we looked at how stateful widgets differ from stateless widgets and how the build() method can be called multiple times, triggered by the setState() method.

However, there are some additional parts of the life cycle of a stateful widget that we will explore at this point because they are important to how we manage input data and also become increasingly important throughout the rest of the book as we look at more advanced widget interactions.

## Key life cycle states

There are several life cycle states that a stateful widget can pass through. In this section, we will look at the states that you will need in most situations. Later in the book, we will introduce additional life cycle states for specific scenarios and corner cases.

### Creation of the state

The creation of a state happens at the very start of the stateful widget life cycle, just after the constructor is called. The stateful widget creates a companion State object to hold the mutable state by calling the createState() method and passing an instance of the companion State object. This is a required step in the life cycle; otherwise, the stateful widget will not have a state.

We saw an example of the createState() method in the previous chapter:

```
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
```

### Initializing the state

The instance of State can initialize its state variables or other infrastructure requirements (such as database connections) in the initState() method. This method is only called once when the widget is added to the widget tree for the first time (that is, it becomes visible to the user) and is optional.

We will see some examples of this later in the chapter, but a basic example of the initState() method looks as follows:

```
@override
void initState() {
  super.initState();
  // Custom initialization logic here
}
```

In this example, we see that the first line of the method must be a call to initialize the state of the super class. This is followed by any custom logic that is required to initialize the widget.

### Build

As you saw in the previous chapter, the build method is called when the widget is to be drawn to the screen. It is called after initState() and then called every time setState() is triggered.

### Disposing of the state

When a widget is removed from the widget tree, the dispose() method is called. Any infrastructure clean-up needed, generally for activities that happened during initState(), such as setting up database listeners or internet connections, will be done in the dispose() method.

Again, we will see an example of this later in the chapter, but here is the skeleton structure of the method:

```
@override
void dispose() {
  // Custom clean-up code here
  super.dispose();
}
```

In this example, we see that the last line of the method must be a call to dispose of the state of the super class. However, before this, any custom logic that is required to dispose of the widget can be placed.

### Not disposing of connections

A common source of errors in an application can be the failure to close connections to databases or other internet resources within the dispose method. If you do not close your connections, then they will remain active and continue to try to interact with your widget and use up valuable resources such as device memory and processing power. You will see errors in your logs if you have a connection that is trying to call setState() on a widget that is no longer mounted on the widget tree, and this is a big hint that you are not cleaning up connections.

## Mounted

In addition to the life cycle states, there is an important field available to you, from the Stateful parent class of your widget, called mounted. This will tell you whether the widget is still mounted onto the widget tree. Specifically, when initState is called, then mounted is marked as true, and when dispose is called, mounted is marked as false.

You would use this for situations such as listening on a database or internet connection. If a change in database or internet connection state was coded to trigger an update of the widget (perhaps through setState()), then it is prudent to add a mounted check before calling setState() as the widget may have been removed from the widget tree between the time you set up the listener and the time it received an update.

Let's look at a simple example:

```
if (mounted) {
  setState(() {
    // Change state here
  });
}
```

In this example, we have wrapped a setState() call within a mounted check to ensure the widget is still on the widget tree and able to be redrawn.

So, now you know a lot more about the stateful widget life cycle, and have the knowledge of user input via gestures, let's look at another common way to receive user input, via input widgets and forms.

## Input widgets and forms

The ability of your app to manage gestures is a good starting point for interaction with the user, but for many apps, you also need a way to get other types of input from a user. Getting user data is what adds custom content and customization to many apps.

Flutter provides many input data widgets to help the developer get different kinds of information from the user. We have already seen some of them in Chapter 5, Widgets – Building Layouts in Flutter, including TextField, and different kinds of Selector and Picker widgets.

A TextField widget lets the user enter text with a keyboard. The TextField widget exposes the onChanged method, which can be used to listen for changes on its current value, as we have seen previously with the TextField widget. However, another way to listen for changes is by using a controller.

## Getting input through a controller

When using a standard TextField widget, we need to use its controller property to access its value. This is done with the TextEditingController class:

```
final _controller = TextEditingController.fromValue(
  TextEditingValue(text: "Initial value"),
);
```

As you can see, by setting the text property of the controller, we can specify the initial value of the widget it is controlling.

After instantiating TextEditingController, we set the controller property of the TextField widget so that it "controls" the widget:

```
TextField(
  controller: _controller,
);
```

TextEditingController is notified whenever the TextField widget has a new value. To listen for changes, we need to add a listener to our _controller:

```
_controller.addListener(() {
  this.setState(() {
    _textValue = _controller.text;
  });
});
```

We have to specify a callback function that will be called every time the TextField widget changes. In this case, we have made a simple inline function that sets a _textValue state variable to the value of the text in TextField as retrieved via the text property on the controller. Check the full example in the attached chapter files.

A similar approach is used for other input widgets. Often, though, you will want to construct a form that holds a group of input data widgets and have validation and feedback for users that work across the whole form.

## FormField and TextField

Flutter provides two widgets to help organize the storing of input data, validation of it, and providing feedback promptly to the user. These are the Form and FormField widgets.

The FormField widget works as a base class to create our own input field within a form. Its functions are as follows:

- To help the process of setting and retrieving the current input value
- To validate the current input value
- To provide feedback form validations

FormField widgets often have a Form widget as an ancestor, but in some cases, this is not needed. For example, when we have a single FormField to take input, there is probably no need for a Form widget to manage the form updates.

Many built-in input widgets from Flutter come with a corresponding FormField widget implementation. One example of this is the TextField widget, which has the form-specific TextFormField widget. The TextFormField widget helps with access to TextField's value and also adds form-related behaviors to it, such as validation.

## Accessing the FormField widget's state

If we are using the TextFormField widget, then there is an alternative approach to accessing the input data using the FormField widget's state:

```
final _key = GlobalKey<FormFieldState<String>>();
  ...
TextFormField(
  key: _key,
);
```

We can add a key to TextFormField that later can be used to access the widget's current state through the key.currentState value, which will contain the updated value of the field.

The specialized type of key refers to the kind of data the input field works with. In the preceding example, this is String, because it is a TextField widget, so the key type depends on the particular widget used.

The FormFieldState<String> class also provides other useful methods and properties to deal with FormField:

- validate() will call the widget's validator callback, which should check its current value and return an error message, or null if it's valid.
- hasError and errorText result from previous validations using the preceding function. In material widgets, for example, this adds some small text near to the field, providing proper feedback to the user about the error.
- save() will call the widget's onSaved callback.
- reset() will put the field in its initial state, with the initial value (if any) and clear validation errors.

## Form

Having FormFieldWidget helps us access and validate its information individually. But when we have a set of input widgets in a form structure, then we can use the Form widget. The Form widget groups the FormFieldWidget instances logically, allowing us to perform operations including accessing field information and validating the whole set of fields in a more structured way.

The Form widget allows us to run the following methods on all descendant fields easily:

- save(): This will call the save method of all FormField instances, saving all the form data in the fields at once.
- validate(): This will call the validate method of all FormField instances, causing all the errors to appear at once.
- reset(): This will call the reset method of all FormField instances, resetting the whole form to its initial state.

### Accessing the Form widget's state

Your app will need to be able to access the Form widget's state, much like we accessed the FormField widget's state, so that you can run validation, data saves, and resets from other parts of the user interface, not just within the form widget tree. For example, you may have a floating action button that allows you to save the form, or an app bar button to reset the form.

Let's look at two ways to access the form state.

### Using a key

The Form widget must be used with a key of the FormState type. FormState contains helpers to manage all of the children of FormField:

```
final _key = GlobalKey<FormFieldState<String>>();
  ...
  Form(
    key: _key,
    child: Column(
    children: <Widget>[
      TextFormField(),
      TextFormField(),
    ],
  ),
);
```

In this example, we have a Form with a global key and, indirectly, two TextFormField widgets as children.

We can then use the key to retrieve the Form widget's associated state and call its validation with _key.currentState.validate().

Most of the time this is the best way to access the Form widget, but if you have a complex widget tree, then there is another option. Let's have a look at this alternative option.

### Using InheritedWidget

The Form widget comes with a helpful class to dispense with the need to add a key to it and still get its benefits.

Each Form widget in the tree has an associated InheritedWidget with it. Form and many other widgets expose this in a static method called of(), where we pass BuildContext, and it looks up the tree to find the corresponding state we are looking for. Knowing this, if we need to access the Form widget somewhere below it in the tree, we can use Form.of(), and we gain access to the same functions as we would have if we were using the key property:

```
Widget build(BuildContext topContext) {
  return Form(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextFormField(
          validator: (String value) {
            return value.isEmpty ? "Not empty" : null;
          },
        ),
        TextFormField(),
        Builder(
          builder: (BuildContext subContext) => TextButton(
            onPressed: () {
              final valid = Form.of(subContext).validate();
              print("valid: $valid");
            },
            child: Text("validate"),
          ),
        )
      ],
    ),
  );
}
```

Pay special attention to the Builder widget used to render TextButton. As we have seen before, the inherited widget can be used to look up the widget tree. When we use Form.of(subContext), it uses BuildContext from Builder, which is lower down the widget tree than the Form widget. Therefore, Form.of(subContext) will search the widget tree and find Form.

If the builder wasn't present and we used the context from the build method, then Form.of(topContext) would start the search on the widget tree above the Form widget and would not find the Form widget during that search.

### Validating user input

Validating user input is one of the main functions of the Form widget. To ensure the data entered by the user is valid, it is fundamental to run validation checks as the user probably does not know all the allowed values or may have made a mistake.

The Form widget, combined with FormField instances, helps you show an appropriate error message if an input value needs to be corrected, before saving the form data through its save() function.

We have already seen, in the previous Form examples, how to validate the form field values. Let's look at the actual flow:

1. Create a Form widget with FormField on it.
1. Define the validation logic on each FormField validator constructor property by passing a validation function as the argument. Here is an example of an inline function:
```
TextFormField(
  validator: (String value) {
    return value.isEmpty ? "Cannot be empty" : null;
  },
)
```
3. When a user chooses to submit the form, call validate() on FormState by using its key, or the Form.of method discussed previously.
1. Each FormField that is a child of the form will have the validate() method called:
a. Where the validation is unsuccessful, some error text is returned as a string. This error text is then displayed on FormField to the user so that they can correct the issue and submit the form again.
b. Where the validation is successful, a null value is returned.
1. If the validation is successful, the save() method can be called on FormState to persist all of the data from the input fields.
Now that you have an understanding of forms, let's take a look at how we can go deeper on the customization of our form inputs.

# Custom input and FormField widgets

We have seen how the Form and FormField widgets help with input manipulation and validation. Also, we know that Flutter comes with a series of input widgets that are FormField variants containing helper functions such as save and validate.

The extensibility and flexibility of Flutter is everywhere in the framework, so creating your own custom input fields is entirely possible.

## Creating custom inputs

Creating a custom input in Flutter is as simple as creating a normal widget and including the methods described earlier. We normally do this by extending the FormField<inputType> widget, where inputType is the value type of the input widget.

So, the typical process is as follows:

1. Create a custom widget that extends StatefulWidget (to keep track of the value) and accepts input from the user by encapsulating another input widget, or by customizing the whole process, such as by using gestures.
1. Create a widget that extends FormField that basically displays the input widget created in the previous step and also exposes its fields.

## Custom input widget example

Later, in Chapter 9, Popular Third-Party Plugins, we will see how to use a plugin to add authentication to our app. For now, we will be creating a custom widget that will be similar to the one used in that step.

In this example, we will ask the user for a phone number and then pretend they have been sent a six-digit verification code. We will then ask them to enter the verification code, which must match the server value in order to successfully log in.

For now, that's all the information we need to know for the creation of the custom input widget. This is what it's going to look like:

![Figure 6.1 - Example of a custom input widget ](/flutter4beginners2_img/figure_6.1_-_example_of_a_custom_input_widget.jpg)

The widget will start a simple six-digit input widget, which will later become a FormField widget and expose the save(), reset(), and validate() methods.

### Creating an input widget

We start by creating a normal custom widget. Here, we expose some properties. Bear in mind that in a real application, we would probably expose more than the properties exposed here, but it's enough for this example:

```
class VerificationCodeInput extends StatefulWidget {
  final BorderSide borderSide;
  final onChanged;
  final controller;
  ...
}
```

The only important property exposed here is controller. We will see the reason in a few moments. Let's check the associated State class:

```
class _VerificationCodeInputState extends State<VerificationCodeInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        LengthLimitingTextInputFormatter(6),
      ],
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: widget.borderSide,
        ),
      ),
      keyboardType: TextInputType.number,
      onChanged: widget.onChanged,
    );
  }
}
```

As you can see, the widget simply returns a TextField in the build method with some predefined customization:

- FilteringTextInputFormatter allows you to specify a regex with either the allowed or denied characters for the input. The .allow or .deny constructors can be used to create the relevant filter check. In this example, we have used the .allow constructor to specify a regex allowing numbers.
- By setting the keyboardType property with TextInputType, you can make sure the best keyboard is popped up to the user. We only want numbers, so popping up a full keyboard would be unhelpful to the user. In this example, we have ensured that just a number pad is popped up by using TextInputType.number.
- LengthLimitingTextInputFormatter specifies a maximum character limit for the input.
- Also, to make it look a bit fancy, a border has been added through the OutlineInputBorder class.

Take note of the important part of this code: controller: widget.controller. Here, we are setting the controller of the TextField widget to be a controller passed to our custom input from a parent widget so that the parent widget can take control of our custom input's value.

### Turning the widget into a FormField widget

To turn the widget into a FormField widget, we start by creating a widget that extends the FormField class, which is StatefulWidget with some Form facilities.

This time, let's start by checking out the new widget's associated State object. Let's do this by breaking it into parts:

```
class _VerificationCodeFormFieldState extends State<VerificationCodeFormFieldInput> {
  final TextEditingController _controller =   TextEditingController(text: "");
  @override
  void initState() {
    super.initState();
    _controller.addListener(_controllerChanged);
  }
  …
```

From the preceding code, you can see the state has a _controller field, which will represent the controller used by the FormField widget. It is initialized in the initState() function where we add a listener to it, so we can know when the value is changed in the _controllerChanged listener.

The remainder of the widget is as follows:

```
void _controllerChanged() {
  didChange(_controller.text);
}
@override
void reset() {
  super.reset();
  _controller.text = "";
}
@override
void dispose() {
  _controller?.removeListener(_controllerChanged);
  super.dispose();
}
```

There are also other important methods that we must override to make it work properly:

With initState(), we now use its opposite in the dispose() method. Here, we stop listening to changes in the controller.
The reset() method is overridden, so we can set _controller.text to empty, making the input field clear again.
The _controllerChanged() listener notifies the super FormFieldState state via its didChange() method so it can update its state via setState() and notify any Form widget that contains it about the change.
Now, let's examine the FormField widget code to see how it works:

```
class VerificationCodeFormField extends FormField<String> {
  final TextEditingController controller;
  VerificationCodeFormField({
    Key key,
    FormFieldSetter<String> onSaved,
    this.controller,
    FormFieldValidator<String> validator,
  }) : super(
    key: key,
    validator: validator,
    builder: (FormFieldState<String> field) {
      _VerificationCodeFormFieldState state = field;
      return VerificationCodeInput(
        controller: state.controller,
      );
    },
  );
  @override
  FormFieldState<String> createState() =>
    _VerificationCodeFormFieldState();
  }
  ...
```

The new part here is in the constructor. The FormField widget contains the builder callback, which should build its associated input widget. It passes the current state of the object so we can build the widget and retain the current info. As you can see, we use this to pass the controller constructed in the state, so it persists even when the field is rebuilt. That's how we keep the widget and state synchronized, and also integrate with the Form class.

# Summary

In this chapter, we have seen how gesture handling works in the Flutter framework, along with the methods for handling gestures, such as tap, double-tap, pan, and zoom, for example. We have seen some widgets that use GestureDetector by themselves to handle gestures.

We then looked deeper at the life cycles of stateful widgets so that we could use this new knowledge to explore input widgets and access their data.

Finally, we extended this knowledge of input widgets by exploring the use of the Form and FormField widgets to properly validate and handle user data.

In the next chapter, you will put together the widget knowledge you have gained from the previous two chapters to create full app pages and navigate between them using the Route concept.

