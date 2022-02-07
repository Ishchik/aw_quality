import 'dart:async';

import '../models/common/aqi_data.dart';
import '../repositories/aqi_repository.dart';
import 'status.dart';

class CurrentAQIViewModel {
  CurrentAQIViewModel(this._apiRepository);

  late AQIList _aqiList;

  final AQIRepository _apiRepository;

  final StreamController<Status> _controller = StreamController();

  Stream<Status> get stream => _controller.stream.asBroadcastStream();

  List<AQIData> get dataList => _aqiList.data;

  Future<void> init() async {
    _emitStatus(Status.loading);
    try {
      _aqiList = await _apiRepository.fetchCurrentAQI();
      _emitStatus(Status.success);
    }catch(_){
      _emitStatus(Status.error);
    }
  }

  void _emitStatus(Status status) => _controller.add(status);

  void dispose() {
    _controller.close();
  }
}
