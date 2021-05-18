import 'package:flutter/material.dart';
import 'data/data.dart';
import 'model/tile_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<TileModel> visiblePairs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pairs = getPairs();
    pairs.shuffle();

    visiblePairs = pairs;

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        visiblePairs = getQuestions();
        load = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("Memory Game"),
//        elevation: 0,
//        centerTitle: true,
//      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "$points/100",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Text(
                "Points",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  shrinkWrap: true,
                  children: List.generate(
                    visiblePairs.length,
                    (index) => Tile(
                      imageAssetPath: visiblePairs[index].getImageAssetPath(),
                      parent: this,
                      index: index,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Tile extends StatefulWidget {
  String imageAssetPath;
  _HomeState parent;
  int index;

  Tile({this.imageAssetPath, this.parent, this.index});

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(load==true){
          setState(() {
            pairs[widget.index].setIsSelected(true);
          });
          print ("you clicked me");
        }
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Image.asset(pairs[widget.index].getIsSelected()?pairs[widget.index].getImageAssetPath():widget.imageAssetPath),
      ),
    );
  }
}
