import 'package:jiffy/jiffy.dart';

String convertDate(DateTime date) {
  var month = Jiffy.parseFromDateTime(date).format(pattern: 'MMMM');
  var result = '${date.day} ${month.substring(0, 3)} ${date.year}';
  return result.toString();
}