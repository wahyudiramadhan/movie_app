import 'package:get/get.dart';
import 'package:movie_app/data/const.dart';
import 'package:movie_app/services/get_service.dart';

class DetailController extends GetxController {
  var endpoint = Get.arguments;
  RxMap detailMovie = {}.obs;
  RxBool isLoading = true.obs;

  Future<void> fetchMovie() async {
    try {
      final data = await fetchDataFromAPI('/$endpoint', token);
      detailMovie.assignAll(data);
      print('Data from API ($endpoint): $data');
    } catch (e) {
      print('Error fetching data from $endpoint: $e');
    }
    isLoading(false);
  }

  @override
  void onInit() {
    fetchMovie();
    super.onInit();
  }
}
