import 'package:flutter/material.dart';
import './models.dart';
import './featch_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _cityController = TextEditingController();
  final _featchedData = FetchData();
  WeatherResponse _responsee;
  var isLoading = false;

  //int tempreture = 0;
  //String location = 'Egypt';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('image/cloudy.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (_responsee != null)
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Center(
                          child: Image.network(_responsee.iconUrl),
                        ),
                        Center(
                          child: Text(
                            '${_responsee.tempInfo.temperature} °C',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 60),
                          ),
                        ),
                        Center(
                          child: Text(
                            _responsee.weatherInfo.description,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 40),
                          ),
                        ),
                        Center(
                          child: Text(
                            _responsee.cityName,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
            Column(
              children: [
                Container(
                  width: 400,
                  child: TextField(
                    controller: _cityController,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    decoration: InputDecoration(
                        hintText: 'search for location',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: _search,
                  child: Text('search'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white70,
                    onPrimary: Colors.blueGrey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _search() async {
    setState(() {
      isLoading = true;
    });
    final response = await _featchedData.getWeather(_cityController.text);
    setState(() {
      isLoading = false;
      _responsee = response;
    });
  }
}
