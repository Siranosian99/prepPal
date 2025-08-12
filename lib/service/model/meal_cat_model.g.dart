// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_cat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealsCatAdapter extends TypeAdapter<MealsCat> {
  @override
  final int typeId = 0;

  @override
  MealsCat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealsCat(
      idCategory: fields[0] as String?,
      strCategory: fields[1] as String?,
      strCategoryThumb: fields[2] as String?,
      strCategoryDescription: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MealsCat obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.idCategory)
      ..writeByte(1)
      ..write(obj.strCategory)
      ..writeByte(2)
      ..write(obj.strCategoryThumb)
      ..writeByte(3)
      ..write(obj.strCategoryDescription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealsCatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
