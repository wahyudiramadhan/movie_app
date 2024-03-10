// ignore_for_file: unnecessary_null_comparison
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../data/const.dart';
import '../database/json_database.dart';
import '../services/get_service.dart';

class HomeController extends GetxController {
//connection
  var connectionStatus = 'Unknown'.obs;
  final Connectivity _connectivity = Connectivity();

  RxBool isLoading = true.obs;
  RxBool isInitialLoaded = false.obs;

  //data variable
  RxMap nowPlayingData = {}.obs;
  RxMap popularData = {}.obs;
  RxMap topRateData = {}.obs;
  RxMap upcommingData = {}.obs;

  Future<void> fetchMovie(
      String endpoint, RxMap<dynamic, dynamic> dataContainer) async {
    try {
      final data = await fetchDataFromAPI(endpoint, token);
      dataContainer.assignAll(data);
      // print('Data from API ($endpoint): $data');
    } catch (e) {
      // print('Error fetching data from $endpoint: $e');
    }
  }

  Future<void> initialLoad() async {
    if (!isInitialLoaded.value) {
      await fetchMovie('/now_playing?language=en-US&page=1', nowPlayingData);
      await fetchMovie('/popular?language=en-US&page=1', popularData);
      await fetchMovie('/top_rated?language=en-US&page=1', topRateData);
      await fetchMovie('/upcoming?language=en-US&page=1', upcommingData);
      isInitialLoaded(true);
    }
  }

  @override
  void onInit() {
    initConnectivity();
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      updateConnectionStatus(result);
    });

    super.onInit();
  }

  void initConnectivity() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    updateConnectionStatus(result);
  }

  void updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        connectionStatus.value = 'Connected';
        await initialLoad();

        await simpanDataKeJSON(
          fileName: 'nowPlayingData',
          data: nowPlayingData,
        );
        await simpanDataKeJSON(
          fileName: 'popularData',
          data: popularData,
        );
        await simpanDataKeJSON(
          fileName: 'topRateData',
          data: topRateData,
        );
        await simpanDataKeJSON(
          fileName: 'upcommingData',
          data: upcommingData,
        );

        isLoading(false);

        break;
      case ConnectivityResult.none:
        connectionStatus.value = 'Disconnected';
        Map<String, dynamic> nowPlayingDataJson = await panggilDataDariJSON(
          fileName: 'nowPlayingData',
        );
        Map<String, dynamic> popularDataJson = await panggilDataDariJSON(
          fileName: 'nowPlayingData',
        );
        Map<String, dynamic> topRateDataJson = await panggilDataDariJSON(
          fileName: 'nowPlayingData',
        );
        Map<String, dynamic> upcommingDataJson = await panggilDataDariJSON(
          fileName: 'nowPlayingData',
        );
        nowPlayingData.assignAll(nowPlayingDataJson);
        upcommingData.assignAll(upcommingDataJson);
        popularData.assignAll(popularDataJson);
        topRateData.assignAll(topRateDataJson);
        isLoading(false);
        break;
      default:
        connectionStatus.value = 'Unknown';
        break;
    }
  }
}
