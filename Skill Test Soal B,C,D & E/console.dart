import 'dart:io';

void taskB() {
  String? numberStr = "1.225.441"; //stdin.readLineSync();
  var nominal = numberStr.replaceAll('.', '');

  for (var i = 0; i < nominal.length; i++) {
    String result = nominal[i];
    var index = nominal.length - i - 1;
    for (var i = 0; i < index; i++) {
      if (result != '0') {
        result += '0';
      }
    }
    if (result != '0') {
      print(result);
    }
  }
}

void taskC() {
  String input = "hello world";
  Map<String, int> characterCount = {};

  var rep = input.replaceAll(' ', '');
  for (var i = 0; i < rep.length; i++) {
    String char = rep[i];
    if (characterCount.containsKey(char)) {
      int a = characterCount[char]!;
      a += 1;
      characterCount[char] = a;
    } else {
      characterCount[char] = 1;
    }
  }

  characterCount.forEach((char, count) {
    print('$char-$count');
  });
}

void taskD() {
  print("Masukan Angka");
  String? n = stdin.readLineSync();
  int multipleOfFifth = 5;
  int multipleOfSixth = 6;
  int count = int.tryParse(n ?? '0') ?? 0;
  print("============================");
  for (int i = 1; i <= count; i++) {
    if (i % multipleOfFifth == 0 && i != multipleOfFifth) {
      print('IDIC');
    } else if (i % multipleOfSixth == 0 && i != multipleOfSixth) {
      print('LPS');
    } else {
      print(i);
    }
  }
}

void taskE() {
  print('Masukan tesk');
  String? input = 'SeLamAT PAGi semua halOo'; //stdin.readLineSync();
  print("============================");
  String? title = input.capitalize(input);
  String? normalTitle = input.capitalizeFirst(input);
  print('Format Judul : $title');
  print('Format Biasa : $normalTitle');
}

extension StringExt on String {
  String capitalize(String value) {
    return value.split(' ').map(capitalizeFirst).join(' ');
  }

  String capitalizeFirst(String s) {
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }
}
