import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Data/models/article_model.dart';
import 'package:news_app/Data/models/article_response.dart';
import 'package:news_app/Logic/top_headlines_bloc.dart';
import 'package:news_app/Presentation/screens/detail_news.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class TopHeadLineSliderWidget extends StatefulWidget {
  @override
  _TopHeadLineSliderWidgetState createState() =>
      _TopHeadLineSliderWidgetState();
}

class _TopHeadLineSliderWidgetState extends State<TopHeadLineSliderWidget> {
  TopHeadlinesBloc topHeadlinesBloc;

  @override
  void initState() {
    super.initState();
    topHeadlinesBloc = BlocProvider.of<TopHeadlinesBloc>(context);
    topHeadlinesBloc.add(FetchTopHeadLines());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopHeadlinesBloc, TopHeadlinesState>(
        builder: (context, state) {
      if (state is TopHeadlinesLoading) {
        return Center(
            child: SizedBox(
                height: 25, width: 25, child: CircularProgressIndicator()));
      } else if (state is TopHeadlinesLoadComplete) {
        return _buildHeadLineSlider(state.getTopHeadLines);
      } else {
        return Center(child: Text('Error'));
      }
    });
  }

  Widget _buildHeadLineSlider(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;

    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        viewportFraction: 0.9,
      ),
      items: getExpenseSliders(articles),
    );
  }

  getExpenseSliders(List<ArticleModel> articles) {
    return articles
        .map((article) => GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailNews(article: article)));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: article.image == null
                                  ? AssetImage('assets/img/placeholder.jpg')
                                  : NetworkImage(article.image))),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.9),
                                Colors.white.withOpacity(0),
                              ],
                              stops: [
                                0.2,
                                1
                              ])),
                    ),
                    Positioned(
                      bottom: 30,
                      child: Container(
                        width: 250,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            article.title == null
                                ? Container()
                                : Text(
                                    article.title,
                                    style: TextStyle(
                                        height: 1,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 10,
                        left: 10,
                        child: article.author == null
                            ? Container()
                            : Text(
                                article.author,
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 9),
                              )),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: article.date == null
                            ? Container()
                            : Text(
                                timeNow(DateTime.parse(article.date)),
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 9),
                              ))
                  ],
                ),
              ),
            ))
        .toList();
  }

  String timeNow(DateTime date) {
    return timeAgo.format(date, allowFromNow: true, locale: 'en');
  }
}
