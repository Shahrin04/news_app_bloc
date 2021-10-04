import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Data/models/article_model.dart';
import 'package:news_app/Data/models/article_response.dart';
import 'package:news_app/Data/models/source_model.dart';
import 'package:news_app/Logic/source_detail_bloc/source_details_bloc.dart';
import 'package:news_app/Presentation/screens/detail_news.dart';
import 'package:news_app/Utils/universal_variables.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class SourceDetails extends StatefulWidget {
  final SourceModel source;

  const SourceDetails({Key key, @required this.source}) : super(key: key);

  @override
  _SourceDetailsState createState() => _SourceDetailsState();
}

class _SourceDetailsState extends State<SourceDetails> {
  SourceDetailsBloc sourceDetailsBloc;

  @override
  void initState() {
    super.initState();
    sourceDetailsBloc = BlocProvider.of<SourceDetailsBloc>(context);
    sourceDetailsBloc.add(FetchSourceDetails(widget.source.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            title: Text(''),
            centerTitle: false,
            backgroundColor: UniversalVariables.mainColor,
            elevation: 0.0,
          )),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            width: MediaQuery.of(context).size.width,
            color: UniversalVariables.mainColor,
            child: Column(
              children: [
                Hero(
                    tag: widget.source.id,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2, color: Colors.white),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/logo/${widget.source.id}.png'))),
                    )),
                SizedBox(height: 5),
                Text(
                  widget.source.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  widget.source.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          Expanded(child: BlocBuilder<SourceDetailsBloc, SourceDetailsState>(
              builder: (context, state) {
            if (state is SourceDetailsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SourceDetailsLoadComplete) {
              return _buildSourceDetailsList(state.getSourceDetail);
            } else {
              return Center(
                child: Text('Error'),
              );
            }
          })),
        ],
      ),
    );
  }

  Widget _buildSourceDetailsList(ArticleResponse data) {
    final List<ArticleModel> sourceDetails = data.articles;

    if (sourceDetails.length == 0) {
      return Center(
        child: Container(
          height: 115,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              'No more News',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ),
      );
    } else {
      return ListView.builder(
          itemCount: sourceDetails.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                sourceDetails[index] == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailNews(article: sourceDetails[index])));
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey[100])),
                    color: Colors.white),
                height: 150,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sourceDetails[index].title,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              timeUntil(
                                  DateTime.parse(sourceDetails[index].date)),
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 130,
                      child: FadeInImage.assetNetwork(
                          // width: double.maxFinite,
                          // height: MediaQuery.of(context).size.height * 0.33,
                          fit: BoxFit.cover,
                          placeholder: 'assets/img/placeholder.jpg',
                          image: sourceDetails[index].image == null
                              ? 'https://dummyimage.com/600x400/949494/ffffff.jpg&text=No+Image'
                              : sourceDetails[index].image),
                    )
                  ],
                ),
              ),
            );
          });
    }
  }

  String timeUntil(DateTime time) {
    return timeAgo.format(time, allowFromNow: true, locale: 'en');
  }
}
