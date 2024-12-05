import 'dart:collection';

class TanGo {
  String word = "";
  String meaning = "";
  String pronunciation = "";
  int level = 0;

  TanGo.fromJson(Map<String, dynamic> json)
      : word = json["word"],
        meaning = json["meaning"],
        pronunciation = json["furigana"],
        level = json["level"];
}

class TanGoList extends ModelList<TanGo> {
  TanGoList();
}

class ModelList<E> with ListMixin<E> {
  List<E> _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int newLength) => _list.length = newLength;

  @override
  E operator [](int index) => _list[index];

  @override
  void operator []=(int index, E value) {
    _list[index] = value;
  }

  @override
  void insert(int index, E element) => _list.insert(index, element);

  @override
  void add(E element) => _list.add(element);

  @override
  void addAll(Iterable<E> iterable) => _list.addAll(iterable);

  @override
  bool remove(Object? element) => _list.remove(element);

  @override
  void clear() => _list.clear();
}
