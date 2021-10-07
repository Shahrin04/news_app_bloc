import 'package:flutter/material.dart';
import 'package:news_app/presentation/widgets/hot_news.dart';
import 'package:news_app/presentation/widgets/top_channels.dart';
import 'package:news_app/presentation/widgets/top_headLine_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TopHeadLineSliderWidget(),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Top Channels',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        TopChannels(),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Games News',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        HotNews(),
      ],
    );
  }
}
