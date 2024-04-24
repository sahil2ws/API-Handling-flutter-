import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'SingleUserPostModel.dart';

class SingleUserPost extends StatefulWidget {
  const SingleUserPost({super.key});

  @override
  State<SingleUserPost> createState() {
    return _SingleUserPostState();
  }
}

class _SingleUserPostState extends State<SingleUserPost> {

  Future<SingleUserPostModel> addUserData(String name, String userName) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'name': name, 'username': userName}),
    );
    if (response.statusCode == 201) {
      print(response.body);
      SingleUserPostModel userModel =
          SingleUserPostModel.fromJson(jsonDecode(response.body));
      return userModel;
    } else {
      throw Exception('Failed to add data.');
    }
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  Future<SingleUserPostModel>? _futureUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: (_futureUser == null) ? buildColumn() : buildFutureBuilder(),
        ),
      );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(hintText: 'Enter name'),
        ),
        TextField(
          controller: _userNameController,
          decoration: const InputDecoration(hintText: 'Enter userName'),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureUser =
                  addUserData(_nameController.text, _userNameController.text);
            });
          },
          child: const Text('Add Data'),
        ),
      ],
    );
  }

  FutureBuilder<SingleUserPostModel> buildFutureBuilder() {
    return FutureBuilder<SingleUserPostModel>(
      future: _futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Column(
                children: [
                  Text('name is : ${snapshot.data!.name}'),
                  SizedBox(
                    height: 20,
                  ),
                  Text('userName is : ${snapshot.data!.username}'),
                  Text('adress is : ${snapshot.data!.address}'),
                  SizedBox(
                    height: 20,
                  ),
                  Text('company is : ${snapshot.data!.company}'),
                  Text('phone is : ${snapshot.data!.phone}'),
                  SizedBox(
                    height: 20,
                  ),
                  Text('id is : ${snapshot.data!.id}'),
                ],
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
