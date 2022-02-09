import 'package:aw_quality/main.dart';
import 'package:aw_quality/src/core/repositories/aqi_repository.dart';
import 'package:aw_quality/src/ui/screens/home/components/aqi_diagram_list.dart';
import 'package:flutter/material.dart';

import '../../../../core/view_models/forecast_view_model.dart';
import '../../../../core/view_models/status.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  final ForecastViewModel _viewModel = ForecastViewModel(
    getIt.get<AQIRepository>(),
  );

  @override
  void initState() {
    super.initState();

    _viewModel.init();
  }

  @override
  void dispose() {
    _viewModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        initialData: Status.idle,
        stream: _viewModel.stream,
        builder: (_, AsyncSnapshot<Status> snapshot) {
          final status = snapshot.data;
          switch (status) {
            case Status.idle:
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.success:
              if (_viewModel.dataList.isNotEmpty) {
                return AQIDiagramList(list: _viewModel.dataList);
              } else {
                return const Center(
                  child: Text('No data'),
                );
              }
            case Status.error:
            default:
              return const Center(
                child: Text('Error'),
              );
          }
        },
      ),
    );
  }
}