import 'package:adab_app/models/adab_model.dart';
import 'package:adab_app/utils/api_base_helper.dart';

class AdabRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<NewsFeedResponseDatum>> fetchNewsFeedList() async {
    final response =
        await _helper.get("https://dev-api.adab.page/newsfeed?page=0");
    return NewsFeedResponse.fromJson(response).results;
  }
}
