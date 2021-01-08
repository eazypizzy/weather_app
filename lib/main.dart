import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/model/weather_info.dart';
import 'package:weather_app/util.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<WeatherInformation> weatherInfo;
  @override
  void initState() {
    super.initState();
    weatherInfo = fetchWeatherInfo();
  }

  @override
  Widget build(BuildContext context) {
    var style1 = Theme.of(context).textTheme.headline5.copyWith(
        fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white);

    var style2 = Theme.of(context).textTheme.headline1.copyWith(
        fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white);

    var style3 = Theme.of(context).textTheme.headline1.copyWith(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Colors.white.withOpacity(.6));

    var style4 = Theme.of(context).textTheme.headline1.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Colors.white.withOpacity(.9));
    var style5 = Theme.of(context).textTheme.headline1.copyWith(
        fontSize: 50, fontWeight: FontWeight.w600, color: Colors.white);

    var style6 = Theme.of(context).textTheme.headline1.copyWith(
        fontSize: 25, fontWeight: FontWeight.w400, color: Colors.white);

    var style7 = Theme.of(context).textTheme.headline1.copyWith(
        fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white);

    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<WeatherInformation>(
              future: weatherInfo,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/weather.jpg'))),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 35.0,
                                        left: 25,
                                        right: 25,
                                        bottom: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.my_location,
                                            size: 17, color: Colors.white),
                                        Text(snapshot.data.timezone,
                                            style: style1),
                                        (SizedBox(width: 100)),
                                        SvgPicture.asset(
                                            'assets/icons/menu.svg')
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: Center(
                                      child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: 'Today\n', style: style2),
                                            TextSpan(
                                                text:
                                                    '${timestampToDate(snapshot.data.current.dt)}',
                                                style: style3)
                                          ])),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${kelvinToCelsius(snapshot.data.current.temp)}',
                                          style: style5),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text('\u2103', style: style6),
                                      )
                                    ],
                                  ),
                                  Center(
                                    child: Text(
                                        'Feels like ${kelvinToCelsius(snapshot.data.current.feelsLike)} \u00B0',
                                        style: style3),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 18, left: 25),
                                    child:
                                        Text('7 days ForeCast', style: style1),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data.daily.length,
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {
                                          return Container(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 15),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10.0),
                                                  child: Text(
                                                      '${timestampToDate(snapshot.data.daily[index].dt)}',
                                                      style: style4),
                                                ),
                                                Container(
                                                  width: 60,
                                                  height: 110,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: .7),
                                                      color: Colors.grey
                                                          .withOpacity(0.4),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      10),
                                                          child: Image.network(
                                                              'http://openweathermap.org/img/wn/${snapshot.data.daily[index].weather[0].icon}@2x.png')),
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 5),
                                                          child: Text(
                                                              '${kelvinToCelsius(snapshot.data.daily[index].temp.morn)} \u00B0',
                                                              style: style7))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 23),
                                  child: Column(
                                    children: [
                                      WidgetDetails(
                                        text:
                                            '${timeStamptoToTime(snapshot.data.current.sunrise).toLowerCase()}',
                                        title: 'SUNSHINE',
                                        text2:
                                            '${timeStamptoToTime(snapshot.data.current.sunset).toLowerCase()}',
                                        title1: 'SUNSET',
                                      ),
                                      Divider(),
                                      WidgetDetails(
                                        text:
                                            '${snapshot.data.current.clouds}%',
                                        title: 'PRECIPITATION',
                                        text2:
                                            '${snapshot.data.current.humidity}%',
                                        title1: 'HUMIDITY',
                                      ),
                                      Divider(),
                                      WidgetDetails(
                                        text:
                                            '${snapshot.data.current.windSpeed} m/s',
                                        title: 'WIND',
                                        text2:
                                            '${snapshot.data.current.pressure} hPa',
                                        title1: 'PRESSURE',
                                      )
                                    ],
                                  )),
                            )),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(child: CircularProgressIndicator());
              })),
    );
  }
}

class WidgetDetails extends StatelessWidget {
  final String title;
  final String title1;
  final String text;
  final String text2;
  const WidgetDetails({Key key, this.text, this.title, this.title1, this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline1.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.grey.withOpacity(.7)),
          ),
          Text(text,
              style: Theme.of(context).textTheme.headline1.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(.5)))
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title1,
            style: Theme.of(context).textTheme.headline1.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.grey.withOpacity(.7)),
          ),
          Text(text2,
              style: Theme.of(context).textTheme.headline1.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(.5)))
        ],
      )
    ]);
  }
}
