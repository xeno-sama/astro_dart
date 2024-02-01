// ignore_for_file: unused_local_variable

import 'vsop/src/func.dart';
import 'vsop/domes.dart';
import 'vsop/astronomy.dart';
import 'vsop/calc_moon.dart';
import 'vsop/src/classes.dart';
// import 'vsop/src/complex.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  DateTime data = DateTime.utc(2000);
  // DateTime data = DateTime.utc(1977, 5, 27, 16, 52);
  double lat = 42.9; //42.9
  double lon = 74.6; //74.6
  List bodyList = Body.values;
  List geo = [];
  List helio = [];
  double time = parseArgs(data, lat, lon)[1];
  Observer observer = parseArgs(data, lat, lon)[0];

  for (var body in bodyList) {
    if (body == Body.moon) {
      geoMoon(time)[1];
      var moon = geoMoon(time)[1]; // более точный расчет
      // print('$body - $moon');
    } else {
      geo.add(helioEclipLon(body, time));
      helio.add(geoLon(body, time, observer));

      // print('$body - ${helioEclipLon(body, time)}');
      // print('$body - ${geoLon(body, time, observer)}');
    }
  }
  // }
  // print(''); // print('Гелио - ${helioEclipLon(body, time)}');
  var dt = numDate(data);
  var _domes = domes(data, lat, lon, dt);
  // for (var item in _domes) {
  //   print(item.toStringAsFixed(2));
  // }
  // print('1дом ${_domes[0]}');
  // print(geo);
  // print(helio);

  print("$time $dt");

  print('Execution time ${stopwatch.elapsedMilliseconds / 1000} секунд');
}
