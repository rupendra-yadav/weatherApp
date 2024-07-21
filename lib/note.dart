import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/hourly_info.dart';
import 'package:http/http.dart' as http;
// import 'package:weather_app/secrets.dart';

var api1 = '';
var api2 = '';


class MainPanel extends StatefulWidget {
  const MainPanel({super.key});

  @override
  State<MainPanel> createState() => _MainPanelState();
}

class _MainPanelState extends State<MainPanel> {
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    String city = 'London';
    try {
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$city,uk&APPID=$api2'),
      );

      final value = jsonDecode(res.body);
      if (value['cod'] != 200) {
        throw 'AN unexpectedd error occured';
      }

      return value;
    } catch (e) {
      throw e.toString();
    }
  }

  // Future<Map<String, dynamic>> getCurrentWeather() async {
  //   String city = 'London';
  //   final res = data;
  //   try {
  //     if (res['cod'] != 200) {
  //       throw 'error';
  //     }
  //     return res;
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  var city = 'Bhilai';
  var temperature = 'tre';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Text(city),
        elevation: 2,
        centerTitle: true,
        backgroundColor: Colors.black12,
        leading: const Icon(Icons.menu),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.refresh),
            color: Colors.black,
          ),
        ],
      ),
      body: FutureBuilder(
          future: getCurrentWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            final data = snapshot.data!;
            // print(data);
            final currenttemp = data['list'][0]['main']['temp'];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // MAIN CARD
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(currenttemp,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                )),
                            const Icon(
                              Icons.cloud,
                              size: 80,
                            ),
                            Text(
                              'inword',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  //GAP
                  const SizedBox(
                    height: 15,
                    width: double.infinity,
                  ),

                  //TEXT INFO
                  const Text(
                    " WEATHER REPORT ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //SMALLER CARDS
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HourlyInformation(
                          label: 'tile',
                        ),
                        HourlyInformation(
                          label: 'tile',
                        ),
                        HourlyInformation(
                          label: 'tile',
                        ),
                        HourlyInformation(
                          label: 'tile',
                        ),
                        HourlyInformation(
                          label: 'tile',
                        ),
                      ],
                    ),
                  ),

                  //GAP
                  const SizedBox(
                    height: 15,
                    width: double.infinity,
                  ),

                  //TEXT INFO
                  const Text(
                    " ADDITIONAL INFORMATION ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Addinfo(value: " otherinfo"),
                  const Addinfo(value: " otherinfo"),
                  const Addinfo(value: " otherinfo"),
                  const SizedBox(
                    height: 100,
                    width: double.infinity,
                  ),
                  const Center(
                    child: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.arrow_downward_sharp)),
                  )
                ],
              ),
            );
          }),
    );
  }
}

class Addinfo extends StatelessWidget {
  const Addinfo({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          width: double.infinity,
          child: Card(
            child: Text(value),
          ),
        ),
      ],
    );
  }
}
