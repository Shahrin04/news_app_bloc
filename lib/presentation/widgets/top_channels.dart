import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Data/models/source_model.dart';
import 'package:news_app/Data/models/source_response.dart';
import 'package:news_app/Logic/top_channels_bloc/top_channels_bloc.dart';
import 'package:news_app/Presentation/screens/detail_news.dart';
import 'package:news_app/Presentation/screens/source_details.dart';
import 'package:news_app/Utils/universal_variables.dart';

class TopChannels extends StatefulWidget {
  const TopChannels({Key key}) : super(key: key);

  @override
  _TopChannelsState createState() => _TopChannelsState();
}

class _TopChannelsState extends State<TopChannels> {
  TopChannelsBloc topChannelsBloc;

  @override
  void initState() {
    super.initState();
    topChannelsBloc = BlocProvider.of<TopChannelsBloc>(context);
    topChannelsBloc.add(FetchTopChannels());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopChannelsBloc, TopChannelsState>(
        builder: (context, state) {
      if (state is TopChannelsLoading) {
        return Center(
          child: SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is TopChannelsLoadComplete) {
        return _buildTopChannelsList(state.getTopChannels);
      } else {
        return Center(child: Text('Error'));
      }
    });
  }

  Widget _buildTopChannelsList(SourceResponse data) {
    List<SourceModel> sources = data.sources;

    if (sources.length == 0) {
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
        height: 115,
        padding: EdgeInsets.only(top: 5),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sources.length,
            itemBuilder: (context, index) {
              return Container(
                //padding: EdgeInsets.only(top: 10),
                width: 80,
                child: GestureDetector(
                  onTap: () {
                    sources[index] == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SourceDetails(source: sources[index])));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: sources[index].id,
                        child: Container(
                          height: 52,
                          width: 52,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                    offset: Offset(1, 1))
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      'assets/logo/${sources[index].id}.png'))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        sources[index].name,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                            fontSize: 10),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        sources[index].category,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: UniversalVariables.titleColor,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                            fontSize: 9),
                      ),
                    ],
                  ),
                ),
              );
            }),
      );
    }
  }
}
