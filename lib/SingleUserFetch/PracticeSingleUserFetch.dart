import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'SingleUserFetchModel.dart';

class PractiseSingleUserFetch extends StatefulWidget {
  const PractiseSingleUserFetch({super.key});

  @override
  State<PractiseSingleUserFetch> createState() => _PractiseSingleUserFetchState();
}

class _PractiseSingleUserFetchState extends State<PractiseSingleUserFetch> {
  Future<SingleUserModel> fetchData() async {
    final myResponse = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));
    if (myResponse.statusCode == 200) {
      final data = jsonDecode(myResponse.body);
      return SingleUserModel.fromJson(data);
    } else {
      throw Exception('Error in Parsing');
    }
  }

  late Future<SingleUserModel> fetch;

  @override
  void initState() {
    super.initState();
    fetch = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
    child: FutureBuilder<SingleUserModel>(
      future: fetch,
      builder:
      (BuildContext context, AsyncSnapshot<SingleUserModel> snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Text ('snapshot has error');
        }else{
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${snapshot.data!.id}'),
                Text('${snapshot.data!.name}'),
                Text('${snapshot.data!.username}'),
                Text('${snapshot.data!.email}'),
              ],
            ),
          );
        }
      },
    ),
    ),
    );
  }
}
