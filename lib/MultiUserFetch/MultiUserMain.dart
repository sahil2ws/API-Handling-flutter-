import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'MultiUserListModel.dart';


class MultiUserFetchData extends StatefulWidget {
  const MultiUserFetchData({super.key});

  @override
  State<MultiUserFetchData> createState() => _MultiUserFetchDataState();
}

class _MultiUserFetchDataState extends State<MultiUserFetchData> {
  Future<List<MultiUserListModel>> fetchMultiUserData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((user) => MultiUserListModel.fromJson(user)).toList();
    } else {
      throw Exception('Error in JSON fetching');
    }
  }

  late Future<List<MultiUserListModel>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchMultiUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<MultiUserListModel>>(
            future: futureData,
            builder: (BuildContext context,
                AsyncSnapshot<List<MultiUserListModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (!snapshot.hasData) {
                return Text('No data available');
              } else {
                final userlist = snapshot.data;
                return ListView.builder(
                  itemCount: userlist?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      ListTile(
                        title: Text(
                          'Name of the user: ${userlist![index].name}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26),
                        ),
                        subtitle: Column(
                          //  mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'userName of the user: ${userlist![index].username}',
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Email of the user: ${userlist![index].email}',
                            ),
                            Text(
                              'City of the user is: ${userlist![index].address?.city}',
                            ),
                            Text(
                              'Street of the user is: ${userlist![index].address?.street}',
                            ),
                            Text(
                              'Latitude of the user is: ${userlist![index].address!.geo!.lat}',
                            ),
                            Text(
                              'Longitude of the user is: ${userlist![index].address!.geo!.lng}',
                            ),
                          ],
                        ),
                      )
                    ]);
                  },
                );
              }
            }),
      ),
    );
  }
}
