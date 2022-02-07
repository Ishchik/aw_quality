// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aqi_data_list_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AQIDataListHiveModelAdapter extends TypeAdapter<AQIDataListHiveModel> {
  @override
  final int typeId = 1;

  @override
  AQIDataListHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AQIDataListHiveModel(
      data: fields[0] == null ? [] : (fields[0] as List).cast<AQIHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, AQIDataListHiveModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AQIDataListHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
