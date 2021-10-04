import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:news_app/Data/models/article_model.dart';
import 'package:news_app/Utils/universal_variables.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class DetailNews extends StatelessWidget {
  final ArticleModel article;

  const DetailNews({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          launch(article.url);
        },
        child: Container(
          height: 48,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: UniversalVariables.primaryGradient),
          child: Text(
            'Read More',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: UniversalVariables.mainColor,
        title: Text(
          article.title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize:
                  Theme.of(context).platform == TargetPlatform.iOS ? 17 : 17),
        ),
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/img/placeholder.jpg',
              image: article.image == null
                  ? 'https://dummyimage.com/600x400/949494/ffffff.jpg&text=No+Image'
                  : article.image,
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 1 / 3,
              width: double.maxFinite,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    article.author == null ? Text(
                      'Nothing',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ) : Text(
                      article.author,
                      style: TextStyle(
                          color: UniversalVariables.mainColor,
                          fontWeight: FontWeight.bold),
                    ),
                    article.date == null ? Text(
                      'Nothing',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ) : Text(
                      article.date.substring(0, 10),
                      style: TextStyle(
                          color: UniversalVariables.mainColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () => launch(article.url),
                  child: Text(
                    article.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  timeUntil(DateTime.parse(article.date)),
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                SizedBox(
                  height: 10,
                ),
                article.content == null
                    ? Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text('Press Read More for details'),
                        ))
                    : Html(
                        data: article.content,
                        defaultTextStyle:
                            TextStyle(fontSize: 14, color: Colors.black87),
                        //renderNewlines: true,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String timeUntil(DateTime date) {
    return timeAgo.format(date, allowFromNow: true, locale: 'en');
  }
}
