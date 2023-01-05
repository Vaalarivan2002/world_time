import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location = "", time = "", flag = "", url = "";
  bool isDayTime = true;
  WorldTime({required this.location, required this.flag, required this.url});
  Future<void> getTime() async {
    try {
      var urL = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(urL);
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].toString().substring(0, 3);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      time = DateFormat.jm().format(now);
      isDayTime = now.hour > 6 && now.hour < 20;

    } catch (e) {
      print("Error $e");
      time = "Could not load time";
    }

  }
}

