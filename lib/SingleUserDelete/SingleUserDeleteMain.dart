import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'SingleUserDeleteModel.dart';

class SingleUserDelete extends StatefulWidget {
  const SingleUserDelete({super.key});

  @override
  State<SingleUserDelete> createState() {
    return _SingleUserDeleteState();
  }
}

class _SingleUserDeleteState extends State<SingleUserDelete> {
  Future<SingleUserDeleteModel> fetchData() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));
    if (response.statusCode == 200) {
      print(response.body);

      return SingleUserDeleteModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to fetch Data');
    }
  }

  Future<SingleUserDeleteModel> deleteData(String id) async {
    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/users/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return SingleUserDeleteModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to fetch Data');
    }
  }

  late Future<SingleUserDeleteModel> fetchuserData;

  @override
  void initState() {
    super.initState();
    fetchuserData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: fetchuserData,
      builder: (BuildContext context,
          AsyncSnapshot<SingleUserDeleteModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('name is :${snapshot.data!.name}'),
                SizedBox(
                  height: 15,
                ),
                Text('user name is :${snapshot.data!.username}'),
                SizedBox(
                  height: 15,
                ),
                // Text('email name is :${snapshot.data!.email}'),

                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        fetchuserData =
                            deleteData(snapshot.data!.id.toString());
                      });
                    },
                    child: Text('Detete data'))
              ],
            ),
          );
        }
      },
    ));
  }
}
