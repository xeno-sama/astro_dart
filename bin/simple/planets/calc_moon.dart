import 'export_funcs.dart';

List<double> dataMoon(double N, double i, double a, double w, double _e,
    double M, double mSun, double lSun, double lst, double d) {
  var latitude = 60.0;
// Шаг 1 - вычислить E экцентрическую аномалию
  var __e = M + degrees(_e) * sin(radians(M)) * (1.0 + _e * cos(radians(M)));
  var e = __e -
      (__e - degrees(_e) * sin(radians(__e)) - M) /
          (1 - _e * cos(radians(__e)));

// Шаг 2 - вычислить прямоугольные координаты в плоскости лунной орбиты
  var x = a * (cos(radians(e)) - _e);
  var y = a * sqrt(1 - _e * _e) * sin(radians(e));

// Шаг 3 - конвертировать в расстояние и истинную аномалию
  var rast = sqrt(x * x + y * y); //расстояние
  var _v = atan2(y, x);
  var v = deg_360(degrees(_v)); // -> истинная аномалия в градусах

// Шаг 4 - Теперь можно расчитать эклиптические координаты
  var xEclip = rast *
      (cos(radians(N)) * cos(radians(v + w)) -
          sin(radians(N)) * sin(radians(v + w)) * cos(radians(i)));
  var yEclip = rast *
      (sin(radians(N)) * cos(radians(v + w)) +
          cos(radians(N)) * sin(radians(v + w)) * cos(radians(i)));
  var zEclip = rast * sin(radians(v + w)) * sin(radians(i));

// Шаг 5 - конвертировать в эклиптические долготу/широту и расстояние (пока неточные)
  var _long0 = atan2(yEclip, xEclip);
  var _lat0 = atan2(zEclip, sqrt(xEclip * xEclip + yEclip * yEclip));
  var _lon = deg_360(degrees(_long0));
  var _lat = degrees(_lat0);
  var _r = sqrt(xEclip * xEclip + yEclip * yEclip + zEclip * zEclip);

  // # делаем уточняющий расчет координат луны c пертурбациями
  // # Ls : Sun's  mean longitude: import
  // # Ms : Sun's  mean anomaly: import
  var mM = M; // Moon mean anomaly
  var lM = deg_360(N + w + M); // Moon's mean longitude:
  var elon = deg_360(lM - lSun); // Moon's mean elongation
  var al = deg_360(lM - N); // Moon's argument of latitude

  // # Perturbations in longitude (degrees):
  var pblon_1 = -1.274 * sin(radians(mM - 2 * elon));
  var pblon_2 = 0.658 * sin(radians(2 * elon));
  var pblon_3 = -0.186 * sin(radians(mSun));
  var pblon_4 = -0.059 * sin(radians(2 * mM - 2 * elon));
  var pblon_5 = -0.057 * sin(radians(mM - 2 * elon + mSun));
  var pblon_6 = 0.053 * sin(radians(mM + 2 * elon));
  var pblon_7 = 0.046 * sin(radians(2 * elon - mSun));
  var pblon_8 = 0.041 * sin(radians(mM - mSun));
  var pblon_9 = -0.035 * sin(radians(elon));
  var pblon_10 = -0.031 * sin(radians(mM + mSun));
  var pblon_11 = -0.015 * sin(radians(2 * al - 2 * elon));
  var pblon_12 = 0.011 * sin(radians(mM - 4 * elon));
  var pblon = pblon_1 +
      pblon_2 +
      pblon_3 +
      pblon_4 +
      pblon_5 +
      pblon_6 +
      pblon_7 +
      pblon_8 +
      pblon_9 +
      pblon_10 +
      pblon_11 +
      pblon_12;

  // Perturbations in latitude (degrees):
  var pblat_1 = -0.173 * sin(radians(al - 2 * elon));
  var pblat_2 = -0.055 * sin(radians(mM - al - 2 * elon));
  var pblat_3 = -0.046 * sin(radians(mM + al - 2 * elon));
  var pblat_4 = 0.033 * sin(radians(al + 2 * elon));
  var pblat_5 = 0.017 * sin(radians(2 * mM + al));
  var pblat = pblat_1 + pblat_2 + pblat_3 + pblat_4 + pblat_5;

  // Perturbations in lunar distance (Earth radii):
  var pbR_1 = -0.58 * cos(radians(mM - 2 * elon));
  var pbR_2 = -0.46 * cos(radians(2 * elon));
  var pbR = pbR_1 + pbR_2;

  // Окончательные точные координаты Луны
  var lon = _lon + pblon;
  var lat = _lat + pblat;
  var r = _r + pbR; //######

  // Расчет RA и Decl для луны
  var oblecl = 23.4393 - 3.563E-7 * d;

  // To simplify we can set r = 1.0 - the result the same
  var xeclip = cos(radians(lon)) * cos(radians(lat)); // *r;
  var yeclip = sin(radians(lon)) * cos(radians(lat)); // *r;
  var zeclip = sin(radians(lat)); // *r;

  var xequat = xeclip;
  var yequat = yeclip * cos(radians(oblecl)) - zeclip * sin(radians(oblecl));
  var zequat = yeclip * sin(radians(oblecl)) + zeclip * cos(radians(oblecl));

  var ra = deg_360(degrees(atan2(yequat, xequat)));
  var decl = degrees(atan2(zequat, sqrt(xequat * xequat + yequat * yequat)));

  //
  // ТОПОЦЕНТРИЧЕСКИЕ координаты Луны.
  // мы уже взяли как пример LON = 15; LAT = 60
  // начнем с расчета лунного параллакса
  var mpar = degrees(asin(1 / r));

  var gclat = latitude -
      0.1924 * sin(radians(2 * latitude)); // геоцентрическая широта gclat
  var rho = 0.99833 +
      0.00167 * cos(radians(2 * latitude)); // дистанция от центра земли

  var ha = deg_360(lst - ra);

  // нам нужен вспомогательный угол
  // var g = degrees(atan(tan(radians(gclat)) / cos(radians(ha))));

  // Теперь все готово к подсчету
  var topRA = deg_360(ra -
      mpar * rho * cos(radians(gclat)) * sin(radians(ha)) / cos(radians(decl)));
  // var topDecl = decl -
  //     mpar *
  //         rho *
  //         sin(radians(gclat)) *
  //         sin(radians(g - decl)) /
  //         sin(radians(g));

  return [topRA, lon];
}

/* Примечание 
все что закомментировал - только потому что мне |пока не требуется| выводить данные
LAT RA R DECL
*/