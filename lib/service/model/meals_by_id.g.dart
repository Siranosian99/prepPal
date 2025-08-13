// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meals_by_id.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealsByIdAdapter extends TypeAdapter<MealsById> {
  @override
  final int typeId = 2;

  @override
  MealsById read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealsById(
      idMeal: fields[0] as String?,
      strMeal: fields[1] as String?,
      strMealAlternate: fields[2] as String?,
      strCategory: fields[3] as String?,
      strArea: fields[4] as String?,
      strInstructions: fields[5] as String?,
      strMealThumb: fields[6] as String?,
      strTags: fields[7] as String?,
      strYoutube: fields[8] as String?,
      strIngredient: (fields[9] as List?)?.cast<String>(),
      strMeasure: (fields[10] as List?)?.cast<String>(),
      strSource: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MealsById obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.idMeal)
      ..writeByte(1)
      ..write(obj.strMeal)
      ..writeByte(2)
      ..write(obj.strMealAlternate)
      ..writeByte(3)
      ..write(obj.strCategory)
      ..writeByte(4)
      ..write(obj.strArea)
      ..writeByte(5)
      ..write(obj.strInstructions)
      ..writeByte(6)
      ..write(obj.strMealThumb)
      ..writeByte(7)
      ..write(obj.strTags)
      ..writeByte(8)
      ..write(obj.strYoutube)
      ..writeByte(9)
      ..write(obj.strIngredient)
      ..writeByte(10)
      ..write(obj.strMeasure)
      ..writeByte(11)
      ..write(obj.strSource);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealsByIdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
