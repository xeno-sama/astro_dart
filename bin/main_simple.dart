import 'simple/export_planets.dart';

void main() {
  final sw = Stopwatch()..start();
  for (int i = 1; i <= 1; i++) {
    var d = numDate(1977, 5, 27, 16, 52);
    var data = initVals(d);
    var lst = localSidTime(16, 52, data['L_sun'], 74.6);

    var sun = dataSun(data['w_sun']!, data['e_sun']!, data['M_sun']!, d);
    var xsun = sun[2];
    var ysun = sun[3];

    var moon = dataMoon(
        data['N_moon']!,
        data['i_moon']!,
        data['a_moon']!,
        data['w_moon']!,
        data['e_moon']!,
        data['M_moon']!,
        data['M_sun']!,
        data['L_sun']!,
        lst,
        d);

    var mercury = dataMercury(
        data['N_mercury']!,
        data['i_mercury']!,
        data['a_mercury']!,
        data['w_mercury']!,
        data['e_mercury']!,
        data['M_mercury']!,
        xsun,
        ysun,
        d);

    var venus = dataVenus(data['N_venus']!, data['i_venus']!, data['a_venus']!,
        data['w_venus']!, data['e_venus']!, data['M_venus']!, xsun, ysun, d);

    var mars = dataMars(data['N_mars']!, data['i_mars']!, data['a_mars']!,
        data['w_mars']!, data['e_mars']!, data['M_mars']!, xsun, ysun, d);

    var jupiter = dataJupiter(
        data['N_jupiter']!,
        data['i_jupiter']!,
        data['a_jupiter']!,
        data['w_jupiter']!,
        data['e_jupiter']!,
        data['M_jupiter']!,
        xsun,
        ysun,
        d);

    var saturn = dataSaturn(
        data['N_saturn']!,
        data['i_saturn']!,
        data['a_saturn']!,
        data['w_saturn']!,
        data['e_saturn']!,
        data['M_saturn']!,
        xsun,
        ysun,
        d);

    var uranus = dataUranus(
        data['N_uranus']!,
        data['i_uranus']!,
        data['a_uranus']!,
        data['w_uranus']!,
        data['e_uranus']!,
        data['M_uranus']!,
        xsun,
        ysun,
        d);

    var neptune = dataNeptune(
        data['N_neptune']!,
        data['i_neptune']!,
        data['a_neptune']!,
        data['w_neptune']!,
        data['e_neptune']!,
        data['M_neptune']!,
        xsun,
        ysun,
        d);

    var pluto = dataPluto(xsun, ysun, d);

    var _planets = [
      sun,
      moon,
      mercury,
      venus,
      mars,
      jupiter,
      saturn,
      uranus,
      neptune,
      pluto
    ];

    var _domes = domes(42.9, lst, d);
    int index = 0;
    for (var item in _domes) {
      index++;
      print('$index-дом __ ${item.toStringAsFixed(2)}');
    }

    for (var item in _planets) {
      print(item[0]);
    }
    // print(d);
  }
  print('прошло ${sw.elapsed.inMilliseconds / 1000} sec');
}
