import 'dart:io';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Random word generator',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  void nextstate(){
    current  = WordPair.random();
    notifyListeners();//call the system to update the word
    print("Word is updated");
}
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(leading: BackButton(onPressed: (){
        exit(0);
        print("back button is pressed");}),
     title: Text("Random Word Generator"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(10)),
            Center(child:Text("""Below is the random word ,It may now have a meaning""",style:TextStyle(fontSize:15),),),
            Padding(padding: EdgeInsets.all(10)),
            BigCard(pair: appState.current),
            Padding(padding: EdgeInsets.all(10)),
            BigButton(pair: appState)
          ],
        ),
      ),
    );
  }
}

class BigButton extends StatelessWidget{
  final dynamic pair;
  const BigButton({Key? key,required this.pair,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(onPressed: (){pair.nextstate();},
        child: Text("New Word"));
  }
}



class BigCard extends StatelessWidget{
  const BigCard({Key? key,required this.pair,}) : super(key: key);
  final WordPair pair;

  @override
  Widget build(BuildContext context){
    return Card(
      color: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Text(pair.asLowerCase,style: TextStyle(fontSize: 35)),
      ),
    );
  }
}



