import 'package:flutter/material.dart';
import '../models/insult.dart';

// Calls the API and displays the results as a Material App.
class InsultScreen extends StatefulWidget {
  const InsultScreen({Key? key, required this.queryString}) : super(key: key);

  // the API endpoint and parameter values used
  // to query the API.
  final String queryString;

  @override
  _InsultScreenState createState() => _InsultScreenState();
}

class _InsultScreenState extends State<InsultScreen> {
  // the result of our API query.
  // https://foaas.com/{queryString}
  late Future<Insult> insult;

  // 20pt font for operation titles
  final _biggerFont = const TextStyle(fontSize: 20.0);

  // when the widget is loaded, query the API
  @override
  void initState() {
    super.initState();
    insult = fetchInsult(widget.queryString);
  }

  // return a material app with the data returned
  // from the API.  If the API call hasn't returned,
  // show a progress indicator.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter Off!')),
        body: Center(
            child: FutureBuilder<Insult>(
                future: insult,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(children: [
                      Container(
                          margin: const EdgeInsets.all(16.0),
                          child: Text(
                              snapshot.data!.message +
                                  "\r\n" +
                                  snapshot.data!.subtitle,
                              style: _biggerFont))
                    ]);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // return a progress indicator if still waiting for data.
                  return const CircularProgressIndicator();
                })));
  }
}
