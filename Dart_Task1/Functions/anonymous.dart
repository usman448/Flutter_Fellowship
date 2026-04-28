void main() {
  const list = ['apples', 'bananas', 'oranges'];

  var uppercaseList = list.map((item) { //in this we do not use function name 
    return item.toUpperCase();
  }).toList();
  // Convert to list after mapping

  for (var item in uppercaseList) {
    print('$item: ${item.length}');
  }
}