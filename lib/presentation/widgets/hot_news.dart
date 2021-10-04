import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Data/models/article_model.dart';
import 'package:news_app/Data/models/article_response.dart';
import 'package:news_app/Logic/hot_news_bloc/hot_news_bloc.dart';
import 'package:news_app/Presentation/screens/detail_news.dart';
import 'package:news_app/Utils/universal_variables.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class HotNews extends StatefulWidget {
  const HotNews({Key key}) : super(key: key);

  @override
  _HotNewsState createState() => _HotNewsState();
}

class _HotNewsState extends State<HotNews> {
  HotNewsBloc hotNewsBloc;

  @override
  void initState() {
    super.initState();
    hotNewsBloc = BlocProvider.of<HotNewsBloc>(context);
    hotNewsBloc.add(FetchHotNews());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotNewsBloc, HotNewsState>(builder: (context, state) {
      if (state is HotNewsLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is HotNewsLoadComplete) {
        return _buldHotNewsWidget(state.getHotNews);
      } else {
        return Container(
          child: Center(
            child: Text('Error'),
          ),
        );
      }
    });
  }

  Widget _buldHotNewsWidget(ArticleResponse data) {
    List<ArticleModel> hotNews = data.articles;
    if (hotNews.length == 0) {
      return Container(
        height: 115,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            'No more Sources',
            style: TextStyle(color: Colors.black54),
          ),
        ),
      );
    } else {
      return Container(
        height: hotNews.length / 2 * 225,
        padding: EdgeInsets.all(5),
        child: GridView.builder(
            itemCount: hotNews.length,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.86),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailNews(article: hotNews[index])));
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 1,
                            color: Colors.grey[100],
                            offset: Offset(1, 1))
                      ]),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  topLeft: Radius.circular(5)),
                              image: hotNews[index].image == null
                                  ? DecorationImage(
                                fit: BoxFit.cover,
                                  image: AssetImage('assets/img/placeholder.jpg')
                              )
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(hotNews[index].image))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Text(
                          hotNews[index].title,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(height: 1.3, fontSize: 15),
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 1,
                            width: 180,
                            color: Colors.black12,
                          ),
                          Container(
                            height: 3,
                            width: 30,
                            color: UniversalVariables.mainColor,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            hotNews[index].source.name == null
                                ? Text(
                                    'Nothing',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 9),
                                  )
                                : Text(
                                    hotNews[index].source.name,
                                    style: TextStyle(
                                        color: UniversalVariables.mainColor,
                                        fontSize: 9),
                                  ),
                            Text(
                              hotNews[index].date == null
                                  ? Text(
                                      'Nothing',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 9),
                                    )
                                  : timeUntil(
                                      DateTime.parse(hotNews[index].date)),
                              style:
                                  TextStyle(color: Colors.black54, fontSize: 9),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      );
    }
  }

  String timeUntil(DateTime time) {
    return timeAgo.format(time, allowFromNow: true, locale: 'en');
  }
}
