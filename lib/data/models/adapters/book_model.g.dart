// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../book_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookModelAdapter extends TypeAdapter<BookModel> {
  @override
  final int typeId = 0;

  @override
  BookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookModel(
      key: fields[0] as String,
      title: fields[1] as String,
      language: fields[2] as String,
      authorKey: fields[3] as String,
      authorName: fields[4] as String,
      isbn: fields[5] as String,
      firstPublishYear: fields[6] as String,
      isFavorite: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BookModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.language)
      ..writeByte(3)
      ..write(obj.authorKey)
      ..writeByte(4)
      ..write(obj.authorName)
      ..writeByte(5)
      ..write(obj.isbn)
      ..writeByte(6)
      ..write(obj.firstPublishYear)
      ..writeByte(7)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
