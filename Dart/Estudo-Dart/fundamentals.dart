import 'dart:io';

void main() {
  var x = int.parse(stdin.readLineSync()!);
  var y = int.parse(stdin.readLineSync()!);
  print(sum(x, y));

  var firstName = stdin.readLineSync();
  var lastName = stdin.readLineSync();
  print('My name is $firstName $lastName.');

  dynamic number = 10;
  print(number);
  number = "Ten";
  print(number);

  List words = ['\naa', 'ball', 'cat', 'moon'];

  for (var i = 0; i < words.length; i++) {
    print(words[i]);
  }

  for (var word in words) {
    print(word);
  }

  words.forEach((word) => print(word));

  List objects = [1, 'a', 2.5, "banana"];

  for (var item in objects) {
    print(item);
  }

  objects = words;

  for (var item in objects) {
    print(item);
  }

  objects = [...words];
  words[1] = 9999999;

  for (var item in objects) {
    print(item);
  }

  Set uniqueItems = {'Angelo', 'Savioti'};
  uniqueItems.add('Bernini');
  uniqueItems.forEach((element) => print(element));
  print('\n');
  uniqueItems.add('Angelo');
  uniqueItems.add('Angelo');
  uniqueItems.add('Angelo');
  uniqueItems.forEach((element) => print(element));

  Map hashTable = {119388: 'angelo', 551234: 'matheus', 897813: 'lucas'};
  print(hashTable[551234]);
  hashTable[0] = 'empty';
  print(hashTable[0]);

  print(square(5));
  print(square(2.5));
  print(cube(3));
  print(multiply(10));
  print(multiply(10, b: 2));
  print(divide(10));
}

int sum(x, y) {
  return x + y;
}

dynamic square(var num) {
  return num * num;
}

dynamic cube(num) => num * num * num;

dynamic multiply(var a, {var b}) => a * (b ?? 1);
dynamic divide(var a, {var b = 1}) => a * b;
dynamic subtraction(var a, [var b = 0]) => a - b;
