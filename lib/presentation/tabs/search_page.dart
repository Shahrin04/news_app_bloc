import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Data/models/article_model.dart';
import 'package:news_app/Data/models/article_response.dart';
import 'package:news_app/Logic/hot_news_bloc/hot_news_bloc.dart';
import 'package:news_app/Presentation/screens/detail_news.dart';
import 'package:news_app/Utils/universal_variables.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _searchController = TextEditingController();
  HotNewsBloc searchBloc;

  @override
  void initState() {
    super.initState();
    searchBloc = BlocProvider.of<HotNewsBloc>(context);
    searchBloc.add(FetchHotNews());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: _searchController,
        autocorrect: false,
        autovalidateMode: AutovalidateMode.always,
        style: TextStyle(color: Colors.black, fontSize: 14),
        onChanged: (changed) {
          setState(() {
            searchBloc.add(FetchSearchNews(search: _searchController.text));
          });
        },
        decoration: InputDecoration(
          fillColor: Colors.grey[100],
          filled: true,
          hintText: 'Search',
          hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500),
          suffixIcon: _searchController.text.length > 0
              ? IconButton(
                  icon: Icon(
                    Icons.backspace_outlined,
                    color: Colors.grey[500],
                    size: 16,
                  ),
                  onPressed: () {
                    setState(() {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _searchController.clear();
                      searchBloc.add(FetchHotNews());
                    });
                  })
              : Icon(
                  Icons.search_outlined,
                  color: Colors.grey[500],
                  size: 16,
                ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide:
                  BorderSide(color: Colors.grey[100].withOpacity(0.3))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                  color: UniversalVariables.mainColor.withOpacity(0.3))),
        ),
      ),
    ),
    Expanded(
        child: BlocBuilder<HotNewsBloc, HotNewsState>(
            builder: (context, state){
              if(state is HotNewsLoading){
                return Center(child: CircularProgressIndicator());
              }else if(state is HotNewsLoadComplete){
                return _buildSearchWidget(state.getHotNews);
              }else{
                return Center(child: Text('Error'));
              }

            }
        )
    )
    ],
    );
  }

  Widget _buildSearchWidget(ArticleResponse data) {
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
