import 'package:flutter/material.dart';
import 'form_screen.dart';
import '../models/insult_operation.dart';

class FOAASOperationsList extends StatefulWidget {
  const FOAASOperationsList({Key? key}) : super(key: key);

  @override
  _FOAASOperationsListState createState() => _FOAASOperationsListState();
}

class _FOAASOperationsListState extends State<FOAASOperationsList> {
  // A list of all available API endpoints
  // Populated by GET https://foaas.com/operations
  late Future<List<InsultOperation>> operations;

  // 18pt font for operation titles
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    // call fetchOperations (see insult_operation model)
    // and populate the list of available API endpoints
    operations = fetchOperations();
  }

  // return a material app, the body of which is a list
  // of API operations/endpoints available to us at
  // foaas.com
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Off!',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Flutter Off!'),
            ),
            body: _buildOperations()));
  }

  // Function to build the list and return a widget.
  // If we haven't received the data back from
  // call we made during initState, then display
  // a progress indicator.
  Widget _buildOperations() {
    return Center(
        child: FutureBuilder<List<InsultOperation>>(
      future: operations,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, i) {
                // return const Divider();
                // repeating carousel
                int index = i % snapshot.data!.length;
                return _buildRow(snapshot.data![index]);
              });
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // return a progress indicator if we're still waiting
        // on the API to return data.
        return const CircularProgressIndicator();
      },
    ));
  }

  // return a ListTile with the name and path of each
  // API operation.  when tapped, route to the form screen.
  Widget _buildRow(InsultOperation op) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Theme.of(context).dividerColor, width: 1))),
        child: ListTile(
            title: Text(op.name, style: _biggerFont),
            subtitle: Text(op.url),
            onTap: () => _pushOperation(op)));
  }

  // show the form screen and pass it the operation details.
  void _pushOperation(InsultOperation op) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FlutterOffForm(operation: op)));
  }
}
