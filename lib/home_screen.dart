import 'dart:convert';
import 'package:api_flutter_1/model/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postList = [];
  Future<List<PostsModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      postList.cast();
      // for (Map i in data) {
      //   postList.add(PostsModel.fromJson(i));
      // }
      for (Map<String, dynamic> i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text('Api Course'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text('Loading');
                } else {
                  return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Title', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                Text(
                                  postList[index].title.toString()),
                                  SizedBox(height: 5,),
                                Text('Description', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                Text(
                                    'Description\n' + postList[index].body.toString()),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
       
      ),
    );
  }
}
