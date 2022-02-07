bool shouldUpdateCurrent(DateTime lastUpdate){
  final now = DateTime.now();
  final lastValidUpdate = DateTime(now.year, now.month, now.day, now.hour);
  return lastUpdate.isBefore(lastValidUpdate);
}

bool shouldUpdateGlobal(DateTime lastUpdate){
  final now = DateTime.now();
  final lastValidUpdate = DateTime(now.year, now.month, now.day);
  return lastUpdate.isBefore(lastValidUpdate);
}