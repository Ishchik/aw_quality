// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aqi_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AQIHiveModelAdapter extends TypeAdapter<AQIHiveModel> {
  @override
  final int typeId = 0;

  @override
  AQIHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AQIHiveModel(
      location: fields[0] == null ? '' : fields[0] as String,
      index: fields[1] == null ? 0 : fields[1] as int,
      timestamp: fields[2] == null ? 0 : fields[2] as int,
      co: fields[3] == null ? 0.0 : fields[3] as double,
      no: fields[4] == null ? 0.0 : fields[4] as double,
      no2: fields[5] == null ? 0.0 : fields[5] as double,
      o3: fields[6] == null ? 0.0 : fields[6] as double,
      so2: fields[7] == null ? 0.0 : fields[7] as double,
      pm2_5: fields[8] == null ? 0.0 : fields[8] as double,
      pm10: fields[9] == null ? 0.0 : fields[9] as double,
      nh3: fields[10] == null ? 0.0 : fields[10] as double,
    );
  }

  @override
  void write(BinaryWriter writer, AQIHiveModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.location)
      ..writeByte(1)
      ..write(obj.index)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.co)
      ..writeByte(4)
      ..write(obj.no)
      ..writeByte(5)
      ..write(obj.no2)
      ..writeByte(6)
      ..write(obj.o3)
      ..writeByte(7)
      ..write(obj.so2)
      ..writeByte(8)
      ..write(obj.pm2_5)
      ..writeByte(9)
      ..write(obj.pm10)
      ..writeByte(10)
      ..write(obj.nh3);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AQIHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
