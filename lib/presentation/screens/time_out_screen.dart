import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/utils/universal_variables.dart';

class TimeOutScreen extends StatelessWidget {
  const TimeOutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backwardsCompatibility: false,
          centerTitle: true,
          backgroundColor: UniversalVariables.mainColor,
          title: Text(
            'News App',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          child: Center(
            child: AlertDialog(
              title: Text('Maximum Limit Reached'),
              content: Text('Sorry !!! This app is using free version of News API and reached 50 request quota for 12 hours.'),
              actions: [
                FlatButton(
                    onPressed: () => SystemNavigator.pop(),
                    child: Text('Exit')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
