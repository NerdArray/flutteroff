import 'package:flutter/material.dart';
import '../models/insult_operation.dart';
import 'insult_screen.dart';

// Displays a form field for each field of the InsultOperation.
class FlutterOffForm extends StatefulWidget {
  const FlutterOffForm({Key? key, required this.operation}) : super(key: key);

  // the API operation selected by the user
  final InsultOperation operation;

  @override
  _FlutterOffFormState createState() => _FlutterOffFormState();
}

class _FlutterOffFormState extends State<FlutterOffForm> {
  // Build a material app, call _buildForm to generate
  // the form fields.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.operation.url)),
        body: _buildForm(context, widget.operation));
  }

  // Returns a form with a text field for each
  // parameter/field of the chosen API operation.
  // If validation passes when the button is clicked,
  // Then navigate to the insult screen.
  Widget _buildForm(BuildContext context, InsultOperation op) {
    // form key for validation.
    final _formKey = GlobalKey<FormState>();

    // a list of all widgets that make up the form (including the button)
    List<Widget> formFields = [];

    // the actual form after it's been generated.
    Form form;

    // a list of controllers to get the text box values later.
    List<TextEditingController> textValues = [];

    // fields should never be empty since all operations
    // take at least a 'from' parameter.
    if (op.fields!.isNotEmpty) {
      // loop through each field and add a text box with
      // a controller and validation to check that a value exists.
      for (final field in op.fields!) {
        textValues.add(TextEditingController());
        formFields.add(Container(
            margin: const EdgeInsets.all(8.0),
            child: (TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter some text!';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: const OutlineInputBorder(), labelText: field.name),
              controller:
                  textValues.last, // assign the last controller from the list
            ))));
      }

      // add a button to the list of form parts.
      // when it's clicked, validate the form and calculate
      // the query string for our call to the API based on
      // the user's answers.
      formFields.add(Container(
          margin: const EdgeInsets.only(left: 8.0),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String query =
                          op.url.substring(1); // get rid of the first '/'
                      var queryParts = query.split("/"); // split into parts

                      query =
                          "/" + queryParts[0]; // the first part is the endpoint

                      // loop through each form answer and add them
                      // to the query string.
                      for (var i = 0; i < textValues.length; i++) {
                        query += "/" + textValues[i].text;
                      }

                      // display the insult page.
                      _pushOperation(context, query);
                    }
                  },
                  child: const Text('Flutter Off')))));

      // create an actual form from our form parts.
      form = Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: formFields,
          ));
    } else {
      // all API operations require at least a 'from' parameter.
      return const Text('You\'ve got errors...');
    }

    // return the form.
    return form;
  }

  // pushes the insult screen onto the navigator
  void _pushOperation(BuildContext context, String queryString) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InsultScreen(queryString: queryString)));
  }
}
