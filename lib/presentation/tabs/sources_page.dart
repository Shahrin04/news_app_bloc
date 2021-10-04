import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Data/models/source_model.dart';
import 'package:news_app/Data/models/source_response.dart';
import 'package:news_app/Logic/top_channels_bloc/top_channels_bloc.dart';
import 'package:news_app/Presentation/screens/source_details.dart';

class SourcesPage extends StatefulWidget {
  const SourcesPage({Key key}) : super(key: key);

  @override
  _SourcesPageState createState() => _SourcesPageState();
}

class _SourcesPageState extends State<SourcesPage> {
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
          child: CircularProgressIndicator(),
        );
      } else if (state is TopChannelsLoadComplete) {
        return _buildChannelSourceGrid(state.getTopChannels);
      } else {
        return Center(child: Text('Error'));
      }
    });
  }

  Widget _buildChannelSourceGrid(SourceResponse data) {
    List<SourceModel> sources = data.sources;

    if (sources.length == 0) {
      return Center(
        child: Container(
          height: 115,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              'No more Sources',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ),
      );
    } else {
      return GridView.builder(
          itemCount: sources.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 0.86),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SourceDetails(source: sources[index])));
                },
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[100],
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(1, 1))
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: sources[index].id,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/logo/${sources[index].id}.png'))),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Text(
                          sources[index].name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}
