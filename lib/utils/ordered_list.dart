class OrderedList<T> {
  final List<T> _list = [];
  final bool Function(T v1, T v2) compare;
  int get length => _list.length;

  OrderedList({required this.compare});

  void add(T item) {
    for (int i = 0; i < length; ++i) {
      if (compare.call(_list[i], item)) {
        _list.insert(i, item);
        return;
      }
    }
    _list.add(item);
  }

  void remove(T item) {
    _list.remove(item);
  }

  T operator [](int i) {
    return _list[i];
  }

  List<T> toList() {
    return _list;
  }
}
