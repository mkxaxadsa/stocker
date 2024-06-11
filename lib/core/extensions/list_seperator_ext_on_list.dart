extension ListSeparatorExtension<T> on List<T> {
  List<T> separatedBy(T separator) {
    if (isEmpty) {
      return [];
    }

    final List<T> result = [];
    for (int i = 0; i < length; i++) {
      result.add(this[i]);
      if (i != length - 1) {
        result.add(separator);
      }
    }
    return result;
  }
}