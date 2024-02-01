// ------
// Ready
// ------
// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:math';
import 'src/func.dart';

List<double> domes(DateTime dat, double LAT, double LON, double d) {
  var h = dat.hour;
  var m = dat.minute;

  double ecl = 23.4393 - 3.563E-7 * d;

  double w_sun = 282.9404 + 4.70935E-5 * d;
  double M_sun = deg360(356.0470 + 0.9856002585 * d);
  double L_sun = deg360(w_sun + M_sun); // Звездное время

  double RA = localSidTime(h, m, L_sun, LON); // прямое восхождение

  double pv = radians(RA);
  double lat = radians(LAT);
  double e = radians(ecl); // склонение эклиптики в радианах

  // формула для МС
  double mc = degrees(atan(tan(pv) / cos(e)));
  late double ic, v, vi, ds, viii, ix;
  double asc =
      deg360(degrees(atan(cos(pv) / -(tan(lat) * sin(e) + sin(pv) * cos(e)))));

  // вспомогательный угол для куспидов
  double c = acos(-tan(e) * sin(pv) * tan(lat));

  double ii = degrees(
      atan(cos(pv + c / 3) / -(tan(lat) * sin(e) + sin(pv + c / 3) * cos(e))));
  double iii = degrees(atan(cos(pv + 2 * c / 3) /
      -(tan(lat) * sin(e) + sin(pv + 2 * c / 3) * cos(e))));
  double xi = degrees(atan(cos(pv - 2 * c / 3) /
      -(tan(lat) * sin(e) + sin(pv - 2 * c / 3) * cos(e))));
  double xii = degrees(
      atan(cos(pv - c / 3) / -(tan(lat) * sin(e) + sin(pv - c / 3) * cos(e))));

  mc < 0 ? mc += 180 : mc;
  // МС должен быть в пределах 10гр от Pv и положительным
  if ((mc - pv).abs() > 10) {
    mc += 180;
  }

  mc < 180 ? ic = mc + 180 : mc; // IC отстоит на 180гр
  mc >= 180 ? ic = mc - 180 : mc;

  asc < 0 ? asc += 180 : asc;
  asc > 360 ? asc -= 360 : asc;

  0 < asc && asc < mc ? asc += 180 : asc;

  asc < 180 ? ds = asc + 180 : asc;
  asc >= 180 ? ds = asc - 180 : asc;

  while (ii < asc) {
    ii += 180;
  }
  ii > 360 ? ii = ii - 360 : ii;
  ii > 180 ? viii = ii - 180 : viii = ii + 180;

  while (iii < ii) {
    iii += 180;
  }
  iii > 360 ? iii = iii - 360 : iii;
  iii > 180 ? ix = iii - 180 : ix = iii + 180;

  while (xi < mc) {
    xi += 180;
  }
  xi > 360 ? xi = xi - 360 : xi;
  xi > 180 ? v = xi - 180 : v = xi + 180;

  while (xii < mc) {
    xii += 180;
  }
  xii > 360 ? xii = xii - 360 : xii;
  xii > 180 ? vi = xii - 180 : vi = xii + 180;

  return [asc, ii, iii, ic, v, vi, ds, viii, ix, mc, xi, xii];
}
