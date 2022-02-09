import 'dart:async';

import '../models/common/aqi_data.dart';
import '../repositories/aqi_repository.dart';
import 'status.dart';

class ForecastViewModel {
  ForecastViewModel(this._apiRepository);

  final List<AQIList> _list = [];

  final AQIRepository _apiRepository;

  final StreamController<Status> _controller = StreamController();

  Stream<Status> get stream => _controller.stream.asBroadcastStream();

  List<AQIList> get dataList => _list;

  Future<void> init() async {
    _emitStatus(Status.loading);
    try {
      final result = await _apiRepository.fetchForecastAQI();
      _list
        ..clear()
        ..addAll(result);
      _emitStatus(Status.success);
    } catch (_) {
      _emitStatus(Status.error);
    }
  }

  void _emitStatus(Status status) => _controller.add(status);

  void dispose() {
    _controller.close();
  }
}
