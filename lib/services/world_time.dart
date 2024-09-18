import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;//loation name for the ui
  String time = "";//the time at the location
  String flag;//url for the flag
  String url; //location url for api end points
  bool? isDayTime;// true or false if day or night

  WorldTime({required this.location,required this.flag ,required this.url});
  
  Future<void> getTime () async{
    try{
    //make request
    Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    Map data = jsonDecode(response.body);
    
    //print(data);
    //get property from data
    String datetime=data['datetime'];
    String offset = data['utc_offset'].substring(1,3);

    // print(datetime);
    //print(offset);
    //creat datetime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    isDayTime =now.hour > 6 && now.hour < 20  ? true: false;
     
    //print(now);
    //set the time property
    time = DateFormat.jm().format(now);

    }catch(e){
      time = 'could not get time data : $e';
    }



}}
