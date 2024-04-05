typedef SplitWhere<T> = ({Iterable<T> left, Iterable<T> right});

extension IterableExtensions<T> on Iterable<T> {
  Iterable<R> mapIndexed<R>(R Function(int index, T element) convert) sync* {
    var index = 0;
    for (var element in this) {
      yield convert(index++, element);
    }
  }

  SplitWhere<T> splitWhere(bool Function(T) condition) {
    final List<T> leftList = [];
    final List<T> rightList = [];

    for (final item in this) {
      if (condition(item)) {
        leftList.add(item);
      } else {
        rightList.add(item);
      }
    }

    return (left: leftList, right: rightList);
  }
}
