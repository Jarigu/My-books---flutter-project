abstract class IHiveDataSource<T> {
  Future<T?> get(dynamic id);
  Future<List<T>> getList(dynamic id);
  Future<void> add(T object);
  Future<void> save(T? object, dynamic id);
  Future<void> update(T? object, dynamic id);
  Future<void> delete(dynamic id);
  Future<void> deleteAt(int index);
}
