import 'package:hive/hive.dart';
import 'package:my_books/domain/datasources/i_hive_data_source.dart';

class HiveDataSource<T> implements IHiveDataSource<T> {
  HiveDataSource({required Box box}) : _box = box;

  final Box _box;

  @override
  Future<T?> get(dynamic id) async {
    return _box.get(id);
  }

  @override
  Future<List<T>> getList(dynamic id) async {
    List<T> list = _box.values.toList() as List<T>;
    return list;
  }

  @override
  Future<void> add(T? object) async {
    await _box.add(object);
  }

  @override
  Future<void> save(T? object, dynamic id) async {
    await _box.put(id, object);
  }

  @override
  Future<void> update(T? object, dynamic id) async {
    await _box.putAt(id, object);
  }

  @override
  Future<void> delete(dynamic id) async {
    await _box.delete(id);
  }

  @override
  Future<void> deleteAt(int index) async {
    await _box.deleteAt(index);
  }

  //bool get boxIsClosed => !(_box.isOpen ?? false);
}
