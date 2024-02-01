import 'src/func.dart';
import 'dart:math';

List<double> dataPluto(double xsun, double ysun, double d) {
// так как не существует теории - есть приближение валидное для 1800-2000гг
// вспомогательные величины S P
  var S = 50.03 + 0.033459652 * d;
  var P = 238.95 + 0.003968789 * d;

// Шаг 1 - расчитать эклиптические координаты / lonecl - Гелиоцентрическая ккордината
  var lonEcl = 238.9508 +
      0.00400703 * d -
      19.799 * sin(radians(P)) +
      19.848 * cos(radians(P)) +
      0.897 * sin(radians(2 * P)) -
      4.956 * cos(radians(2 * P)) +
      0.610 * sin(radians(3 * P)) +
      1.211 * cos(radians(3 * P)) -
      0.341 * sin(radians(4 * P)) -
      0.190 * cos(radians(4 * P)) +
      0.128 * sin(radians(5 * P)) -
      0.034 * cos(radians(5 * P)) -
      0.038 * sin(radians(6 * P)) +
      0.031 * cos(radians(6 * P)) +
      0.020 * sin(radians(S - P)) -
      0.010 * cos(radians(S - P));
  var lat = -3.9082 -
      5.453 * sin(radians(P)) -
      14.975 * cos(radians(P)) +
      3.527 * sin(radians(2 * P)) +
      1.673 * cos(radians(2 * P)) -
      1.051 * sin(radians(3 * P)) +
      0.328 * cos(radians(3 * P)) +
      0.179 * sin(radians(4 * P)) -
      0.292 * cos(radians(4 * P)) +
      0.019 * sin(radians(5 * P)) +
      0.100 * cos(radians(5 * P)) -
      0.031 * sin(radians(6 * P)) -
      0.026 * cos(radians(6 * P)) +
      0.011 * cos(radians(S - P));

  var r = 40.72 +
      6.68 * sin(radians(P)) +
      6.90 * cos(radians(P)) -
      1.18 * sin(radians(2 * P)) -
      0.03 * cos(radians(2 * P)) +
      0.15 * sin(radians(3 * P)) -
      0.14 * cos(radians(3 * P)); //расстояние

// Шаг 2 Переводим в ГЕОЦЕНТРИЧЕСКИЕ координаты
  var xh = r * cos(radians(lonEcl)) * cos(radians(lat));
  var yh = r * sin(radians(lonEcl)) * cos(radians(lat));
  // var zh = r * sin(radians(lat));

  var xgeoc = xh + xsun;
  var ygeoc = yh + ysun;
  // var zgeoc = zh;

  // var oblecl = 23.4393 - 3.563E-7 * d;
  // var xequat = xgeoc;
  // var yequat = ygeoc * cos(radians(oblecl)) - zgeoc * sin(radians(oblecl));
  // var zequat = ygeoc * sin(radians(oblecl)) + zgeoc * cos(radians(oblecl));

  var _lonTopos = atan2(ygeoc, xgeoc);
  var lonTopos = deg360(degrees(_lonTopos));

  return [lonEcl, lonTopos];
  // return [xh, yh, zh, xgeoc, ygeoc, zgeoc, xequat, yequat, zequat];
}

List<double> dataSun(
    double N, double i, double a, double w, double e, double M, double d) {
  var _e = M + degrees(e) * sin(radians(M)) * (1.0 + e * cos(radians(M)));
  var E = radians(_e);

  var x = cos(E) - e;
  var y = sin(E) * sqrt(1 - e * e);

  var r = sqrt(x * x + y * y); //расстояние
  var _v = atan2(y, x);
  var v = deg360(degrees(_v)); // -> истинная аномалия в градусах

  var _lon = v + w;
  var _lonEcl = deg360(_lon);
  var lonEcl = deg360(_lon + 180);
  var lonTopos = deg360(_lon); // по факту = топоцентрике

  var xEclip = r * cos(radians(_lonEcl));
  var yEclip = r * sin(radians(_lonEcl));

  return [lonTopos, lonEcl, xEclip, yEclip];
}

Map<String, double> sunVals(double d) {
  var dictSun = {
    'N_sun': 0.0, //N = Долгота восходящего узла/ascending node
    'i_sun': 0.0, //i = наклон плоскости экватора к эклиптике
    'a_sun': 1.000000, // (AU) a = средняя дистанция до солнца
    'w_sun': 282.9404 + 4.70935E-5 * d, //w = аргумент перигелия
    'e_sun': 0.016709 -
        1.151E-9 * d, //e = экцентриситет (0=круг, 0-1=эллипс, 1=парабола)
    'M_sun': deg360(356.0470 +
        0.9856002585 * d), //M = среднее угловое расстояние (0 в перигелии)
    'L_sun': deg360(
        (282.9404 + 4.70935E-5 * d) + deg360(356.0470 + 0.9856002585 * d))
  };
  return dictSun;
}

List pluto(d) {
  var data = sunVals(d);

  var sun = dataSun(data['N_sun']!, data['i_sun']!, data['a_sun']!,
      data['w_sun']!, data['e_sun']!, data['M_sun']!, d);

  var xsun = sun[2];
  var ysun = sun[3];
  var pluto = dataPluto(xsun, ysun, d);
  return pluto;
}
