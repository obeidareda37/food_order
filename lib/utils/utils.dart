import 'package:intl/intl.dart';

String convertToDate(var date) {
  print(date);
  String date1 = DateFormat('dd-MM-yyyy HH:mm')
      .format(DateTime.fromMillisecondsSinceEpoch(date));
  print(date1);
  return date1;
}

String convertStatus(int status) {
  return status == 0
      ? 'Placed'
      : status == 1
          ? 'Shipping'
          : status == 2
              ? 'Shipped'
              : 'Cancelled';
}
