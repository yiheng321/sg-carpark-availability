import 'dart:async' show Timer;
import 'dart:convert';
import 'package:sg_carpark_availability/Controller/CarparkDatabase.dart';
import 'package:http/http.dart' as http;

class ApiService {
  void loadCarparkList() async {
    var carparkDB = CarparkDataBase();
    List<String> carparkNoList = [];
    List<int> currentsLotsList = [];
    var response = await http.get(
        Uri.encodeFull(
            "https://api.data.gov.sg/v1/transport/carpark-availability") as Uri,
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonBody = await jsonDecode(response.body) as Map;
      for (var obj in jsonBody["items"][0]["carpark_data"]) {
        carparkNoList.add(obj["carpark_number"]);
        currentsLotsList.add(int.parse(obj["carpark_info"][0]["lots_available"]));
      }
      Map<String, int> carparkInfoMap = Map.fromIterables(carparkNoList, currentsLotsList);
      carparkDB.updateCarParkSlotbyID(carparkInfoMap);
    }
  }


  void updateCurrentSlot() async {
    const period = Duration(seconds: 10);
    Timer.periodic(period, (Timer t) async {
      loadCarparkList();
    });
  }
}
