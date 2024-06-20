//  without model

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  var data;
  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Example Four'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading');
                } else {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.blueAccent,
                          child: Column(
                            children: [
                              ReusbaleRow(
                                  title: 'Name',
                                  value: data[index]['name'].toString()),
                              ReusbaleRow(
                                  title: 'UserName',
                                  value: data[index]['username'].toString()),
                              ReusbaleRow(
                                  title: 'Email',
                                  value: data[index]['email'].toString()),
                              ReusbaleRow(
                                  title: 'Address',
                                  value: data[index]['address']['city'].toString()),
                              ReusbaleRow(
                                  title: 'lat',
                                  value: data[index]['address']['geo']['lat'].toString()),
                              ReusbaleRow(
                                  title: 'lng',
                                  value: data[index]['address']['geo']['lng'].toString()),
                            ],
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

class ReusbaleRow extends StatelessWidget {
  String title, value;
  ReusbaleRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
