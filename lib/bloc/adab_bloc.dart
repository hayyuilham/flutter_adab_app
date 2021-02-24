import 'dart:async';

import 'package:adab_app/models/adab_model.dart';
import 'package:adab_app/repository/adab_repository.dart';
import 'package:adab_app/utils/api_response.dart';

class AdabBloc {
  AdabRepository _adabRepository;

  StreamController _newsFeedListController;

  StreamSink<ApiResponse<List<NewsFeedResponseDatum>>> get newsFeedListSink =>
      _newsFeedListController.sink;

  Stream<ApiResponse<List<NewsFeedResponseDatum>>> get newsFeedListStream =>
      _newsFeedListController.stream;

  AdabBloc() {
    _newsFeedListController =
        StreamController<ApiResponse<List<NewsFeedResponseDatum>>>();
    _adabRepository = AdabRepository();
    fetchNewsFeedList();
  }

  fetchNewsFeedList() async {
    newsFeedListSink.add(ApiResponse.loading('Fetching NewsFeed'));
    try {
      List<NewsFeedResponseDatum> newsFeeds =
          await _adabRepository.fetchNewsFeedList();
      newsFeedListSink.add(ApiResponse.completed(newsFeeds));
    } catch (e) {
      newsFeedListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _newsFeedListController?.close();
  }
}
