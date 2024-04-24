import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'SingleUserUpdateModel.dart';

class SingleUserUpdate extends StatefulWidget {
  const SingleUserUpdate({super.key});

  @override
  State<SingleUserUpdate> createState() {
    return _SingleUserUpdateState();
  }
}

class _SingleUserUpdateState extends State<SingleUserUpdate> {
  Future<SingleUserUpdateModel> fetchData() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));
    if (response.statusCode == 200) {
      print(response.body);

      return SingleUserUpdateModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to fetch Data');
    }
  }

  Future<SingleUserUpdateModel> updateData(String name, String userName) async {
    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'username': userName,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return SingleUserUpdateModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to fetch Data');
    }
  }

  late Future<SingleUserUpdateModel> fetchuserData;
  late TextEditingController nameController;
  late TextEditingController userNameCnt;

  @override
  void initState() {
    super.initState();
    fetchuserData = fetchData();
    nameController = TextEditingController();
    userNameCnt = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: fetchuserData,
      builder: (BuildContext context, AsyncSnapshot<SingleUserUpdateModel> snapshot) {
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
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: 'Enter name to update',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: userNameCnt,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: 'Enter userName to update',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        fetchuserData =
                            updateData(nameController.text, userNameCnt.text);
                        nameController.text = "";
                        userNameCnt.text = "";
                      });
                    },
                    child: Text('Update data'))
              ],
            ),
          );
        }
      },
    ));
  }
}
