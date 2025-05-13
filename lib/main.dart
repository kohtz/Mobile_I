import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/PostModel.dart';
import 'package:flutter_application_2/utilidades/ApiService.dart';

void main() {
  runApp(MaterialApp(home: MainScreen()));
}

class MainScreen extends StatefulWidget {
  final String messageTitle = "Stateful Widget";
  final String messageDescription = "Este é um WidgetStateful";
  final String messageErrorTitle = "ERRO";
  final String messageErrorDescription = "Essa página não foi encontrada";
  final String messageLoadingTitle = "Loading";
  final String messageLoadingDescription = "Carregando...";

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int mainScreenState = 2;
  int countSuccess = 0;
  List<PostModel> posts = []; 

  void changeState() {
    setState(() {
      mainScreenState++;
      mainScreenState %= 3;
    });
  }

  void tryAgain() {
    setState(() {
      mainScreenState = 2;
    });
  }

  void incrementarEstado() {
    setState(() {
      mainScreenState = (mainScreenState + 1) % 3;
    });
  }

  Future<void> carregaDados() async {
    await Future.delayed(Duration(seconds: 3));

    var url = "https://jsonplaceholder.typicode.com/posts";

    var response = await ApiService.request<List<PostModel>>(
      url: url,
      verb: HttpVerb.get,
      fromJson: (json) => (json as List)
          .map((item) => PostModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      setState(() {
        posts = response.data!;
        mainScreenState = 0;
      });
    } else {
      setState(() {
        mainScreenState = 1;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    carregaDados();
  }

  @override
  Widget build(BuildContext context) {
    switch (mainScreenState) {
      case 0:
        return successScreen();
      case 1:
        return failureScreen();
      default:
        return loadingScreen();
    }
  }

  Widget successScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts Carregados"),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            child: ListTile(
              title: Text(
                post.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(post.body),
              onTap: () {
                
              },
            ),
          );
        },
      ),
    );
  }

  Widget failureScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.messageErrorTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: incrementarEstado,
            child: Center(
              child: Text(widget.messageErrorDescription),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                mainScreenState = 2;
              });
              carregaDados();
            },
            child: Text("Tentar Novamente"),
          ),
        ],
      ),
    );
  }

  Widget loadingScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.messageLoadingTitle),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
