import 'dart:math';

double radians(double rad) => rad * pi / 180;
double degrees(double grad) => grad / pi * 180;

double deg_360(double x) {
  var rv = x - (x / 360.0).truncate() * 360.0;
  if (rv < 0.0) {
    rv += 360.0;
  }
  return rv;
}

double time_24(double t0) {
  var t = t0 - (t0 / 24.0).truncate() * 24.0;
  if (t < 0.0) {
    t += 24.0;
  }
  return t;
}

List<int> timeRA(double ra) {
  var hRA = (ra ~/ 15).toInt();
  var mRA = ((ra / 15 - hRA) * 60 ~/ 1).toInt();
  var sRA = ((ra / 15 - hRA) * 60 % 1 * 60).toInt();
  return [hRA, mRA, sRA];
}

double numDate(int y, int m, int D, int hour, int minute) {
  int _d = (367 * y -
          7 * (y + ((m + 9) / 12)).toInt() ~/ 4 -
          3 * ((y + ((m - 9) / 7)).toInt() / 100 + 1) / 4 +
          275 * m ~/ 9 +
          D -
          730515)
      .toInt();
  double ut = hour + (minute / 60);
  double d = _d + ut / 24;
  return d;
}

double localSidTime(int hour, int minute, L, lon) {
  double ut = hour + (minute / 60);
  double gmst0 = time_24(L / 15 + 12); // L солнечная долгота
  double sidTime = gmst0 + ut + lon / 15;
  double sidTimeDeg = sidTime * 15; //Звездное время в градусах
  return sidTimeDeg;
}
