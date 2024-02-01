import 'export_funcs.dart';

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

// Шаг 3 - теперь переводим прямоугольные координаты в сферические
  // var oblecl = 23.4393 - 3.563E-7 * d;
  // var xequat = xgeoc;
  // var yequat = ygeoc * cos(radians(oblecl)) - zgeoc * sin(radians(oblecl));
  // var zequat = ygeoc * sin(radians(oblecl)) + zgeoc * cos(radians(oblecl));

  // var RA = deg_360(degrees(atan2(yequat, xequat)));
  // var Decl = degrees(atan2(zequat, sqrt(xequat * xequat + yequat * yequat)));
  // var R = sqrt(xequat * xequat + yequat * yequat + zequat * zequat);

  var _lonTopos = atan2(ygeoc, xgeoc);
  var lonTopos = deg_360(degrees(_lonTopos));

  return [lonTopos, lonEcl];
}


/* Примечание 
все что закомментировал - только потому что мне |пока не требуется| выводить данные
LAT RA R DECL
*/