import 'package:adab_app/bloc/adab_bloc.dart';
import 'package:adab_app/models/adab_model.dart';
import 'package:adab_app/utils/api_response.dart';
import 'package:adab_app/views/news_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  AdabBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = AdabBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text('adab',
              style: TextStyle(color: Colors.blue[400], fontSize: 28)),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[100],
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchNewsFeedList(),
        child: StreamBuilder<ApiResponse<List<NewsFeedResponseDatum>>>(
          stream: _bloc.newsFeedListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return NewsList(newsFeedList: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchNewsFeedList(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
