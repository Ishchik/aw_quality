import 'package:async/async.dart';
import 'package:flutter/foundation.dart';

abstract class ViewModelBase {
  Future<void> init();
  void dispose();
}