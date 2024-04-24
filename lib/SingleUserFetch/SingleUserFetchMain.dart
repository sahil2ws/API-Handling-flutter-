import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'SingleUserFetchModel.dart';

class SingleUserFetch extends StatefulWidget {
  const SingleUserFetch({super.key});

  @override
  State<SingleUserFetch> createState() => _SingleUserFetchState();
}

class _SingleUserFetchState extends State<SingleUserFetch> {
  Future<SingleUserModel> fetchSingleUser() async {
    final responseInJson = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'));
    if (responseInJson.statusCode == 200) {
      return SingleUserModel.fromJson(jsonDecode(responseInJson.body));
    } else {
      throw Exception(
          'Error in getting JSON Response: Error Code is:- ${responseInJson.statusCode}');
    }
  }

  late Future<SingleUserModel> fetchData;

  @override
  void initState() {
    super.initState();
    fetchData = fetchSingleUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: fetchData,
            builder: (BuildContext context,
                AsyncSnapshot<SingleUserModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Sanpshot has Error:-${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('Snapshot has no Data');
              } else {
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Name is ${snapshot.data!.name}'),
                        Text('User Name is ${snapshot.data!.username}'),
                        Text('Email is ${snapshot.data!.email}'),
                        Text('ID is ${snapshot.data!.id}'),
                        Text('Company is ${snapshot.data!.company!.name}'),
                        Text(
                            'Company CatchPharase is ${snapshot.data!.company!.catchPhrase}'),
                        Text('Company BS is ${snapshot.data!.company!.bs}'),
                        Text('Phone Number is ${snapshot.data!.phone}'),
                        Text('City Name is ${snapshot.data!.address!.city}'),
                        Text(
                            'Street Name is ${snapshot.data!.address!.street}'),
                        Text('Zip Code is ${snapshot.data!.address!.zipcode}'),
                        Text('Suite is ${snapshot.data!.address!.suite}'),
                        Text('Latitude is ${snapshot.data!.address!.geo!.lat}'),
                        Text(
                            'Longitude is ${snapshot.data!.address!.geo!.lng}'),
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
