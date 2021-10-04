import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Data/repo/news_repository.dart';
import 'package:news_app/Logic/hot_news_bloc/hot_news_bloc.dart';
import 'package:news_app/Logic/source_detail_bloc/source_details_bloc.dart';
import 'package:news_app/Logic/top_channels_bloc/top_channels_bloc.dart';
import 'package:news_app/Logic/top_headlines_bloc.dart';
import 'package:news_app/Presentation/screens/main_screen.dart';

void main() {
  runApp(MyApp(
    newsRepo: NewsRepository(),
  ));
}

class MyApp extends StatelessWidget {
  final NewsRepository newsRepo;

  MyApp({@required this.newsRepo});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TopHeadlinesBloc>(
            create: (context) => TopHeadlinesBloc(newsRepo: newsRepo)),
        BlocProvider<TopChannelsBloc>(
            create: (context) => TopChannelsBloc(newsRepo: newsRepo)),
        BlocProvider<SourceDetailsBloc>(
            create: (context) => SourceDetailsBloc(newsRepo: newsRepo)),
        BlocProvider<HotNewsBloc>(
            create: (context) => HotNewsBloc(newsRepo: newsRepo))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
      ),
    );
  }
}
