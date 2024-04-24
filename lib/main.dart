import 'package:flutter/material.dart';
import 'MultiUserFetch/MultiUserMain.dart';
import 'SingleUserDelete/SingleUserDeleteMain.dart';
import 'SingleUserFetch/PracticeSingleUserFetch.dart';
import 'SingleUserFetch/SingleUserFetchMain.dart';
import 'SingleUserUpdate/SingleUserUpdateMain.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: SingleUserFetch(),
    //home: MultiUserFetchData(),
    //home: SingleUserUpdate(),
    //home: SingleUserDelete(),
    ////////////////////////////////////////////
    //For Practicing use these
    home: PractiseSingleUserFetch(),
  ));
}
