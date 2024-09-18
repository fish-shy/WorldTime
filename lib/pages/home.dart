import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = (data.isEmpty ?? true) ? ModalRoute.of(context)!.settings.arguments as Map : data;
    //set nigh day
    String bgImage = data['isDayTime'] ? 'imageDay.png' : 'imageNight.png';
    Color bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo;

    return Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/$bgImage'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                //change location buttom
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                        setState(() {
                          data ={
                            'time':result['time'],
                            'location':result['location'],
                            'isDayTime':result['isDayTime']
                          };
                        });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'edit location',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${data['location']}',
                      style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 28,
                          color: Colors.grey[300]),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  data['time'],
                  style: TextStyle(
                      letterSpacing: 2, fontSize: 66, color: Colors.grey[300]),
                )
              ],
            ),
          ),
        )));
  }
}
