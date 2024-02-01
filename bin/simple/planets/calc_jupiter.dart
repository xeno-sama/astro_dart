import 'export_funcs.dart';

List<double> dataJupiter(double N, double i, double a, double w, double e,
    double M, double xsun, double ysun, double d) {
// Шаг 1 - вычислить E экцентрическую аномалию
  double _e = M + degrees(e) * sin(radians(M)) * (1.0 + e * cos(radians(M)));
  var E = _e -
      (_e - degrees(e) * sin(radians(_e)) - M) / (1 - e * cos(radians(_e)));

// Шаг 2 - вычислить прямоугольные координаты в плоскости лунной орбиты
  var x = a * (cos(radians(E)) - e);
  var y = a * sqrt(1 - e * e) * sin(radians(E));

// Шаг 3 - конвертировать в расстояние и истинную аномалию
  var r = sqrt(x * x + y * y); //расстояние
  var _v = atan2(y, x);
  var v = deg_360(degrees(_v)); // -> истинная аномалия в градусах

// Шаг 4 - Теперь можно расчитать эклиптические координаты
  var xEclip = r *
      (cos(radians(N)) * cos(radians(v + w)) -
          sin(radians(N)) * sin(radians(v + w)) * cos(radians(i)));
  var yEclip = r *
      (sin(radians(N)) * cos(radians(v + w)) +
          cos(radians(N)) * sin(radians(v + w)) * cos(radians(i)));
  // var zEclip = r * sin(radians(v + w)) * sin(radians(i));

// Шаг 5 - конвертировать в эклиптические долготу/широту и расстояние
// Это наши ГЕЛИОЦЕНТРИЧЕСКИЕ координаты
  var _lon = atan2(yEclip, xEclip);
  // var _lat0 = atan2(zEclip, sqrt(xEclip * xEclip + yEclip * yEclip));
  var lonEcl = deg_360(degrees(_lon));
  // var lat = degrees(_lat0);
  // var rs = sqrt(xEclip * xEclip + yEclip * yEclip + zEclip * zEclip);

  // Шаг 6 - Переводим в ГЕОЦЕНТРИЧЕСКИЕ координаты
  var xgeoc = xEclip + xsun; // *r;
  var ygeoc = yEclip + ysun; // *r;
  // var zgeoc = zEclip; // *r;

  // теперь переводим прямоугольные координаты в сферические
  // var oblecl = 23.4393 - 3.563E-7 * d;
  // var xequat = xgeoc;
  // var yequat = ygeoc * cos(radians(oblecl)) - zgeoc * sin(radians(oblecl));
  // var zequat = ygeoc * sin(radians(oblecl)) + zgeoc * cos(radians(oblecl));

  // var ra = deg_360(degrees(atan2(yequat, xequat)));
  // var decl = degrees(atan2(zequat, sqrt(xequat * xequat + yequat * yequat)));
  // var R = sqrt(xequat * xequat + yequat * yequat + zequat * zequat);

  var _lonTopos = atan2(ygeoc, xgeoc);
  var lonTopos = deg_360(degrees(_lonTopos));

  return [lonTopos, lonEcl];
}

/* Примечание 
все что закомментировал - только потому что мне |пока не требуется| выводить данные
LAT RA R DECL
*/