// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:math';
import 'func.dart';

List<double> domes(double LAT, double lst, double d) {
  var ecl = 23.4393 - 3.563E-7 * d;

  var RA = lst; // прямое восхождение

  var pv = radians(RA);
  var lat = radians(LAT);
  var e = radians(ecl); // склонение эклиптики в радианах

  // формула для МС
  var mc = degrees(atan(tan(pv) / cos(e)));

  double ic = 0, v = 0, vi = 0, ds = 0, viii = 0, ix = 0;
  // формула для AS
  var asc =
      deg_360(degrees(atan(cos(pv) / -(tan(lat) * sin(e) + sin(pv) * cos(e)))));

  // вспомогательный угол для куспидов
  var c = acos(-tan(e) * sin(pv) * tan(lat));

  var ii = degrees(
      atan(cos(pv + c / 3) / -(tan(lat) * sin(e) + sin(pv + c / 3) * cos(e))));
  var iii = degrees(atan(cos(pv + 2 * c / 3) /
      -(tan(lat) * sin(e) + sin(pv + 2 * c / 3) * cos(e))));
  double xi = degrees(atan(cos(pv - 2 * c / 3) /
      -(tan(lat) * sin(e) + sin(pv - 2 * c / 3) * cos(e))));
  var xii = degrees(
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
    ii > 360 ? ii = ii - 360 : ii;
    ii > 180 ? viii = ii - 180 : viii = ii + 180;
  }

  while (iii < asc) {
    iii += 180;
    iii > 360 ? iii = iii - 360 : iii;
    iii > 180 ? ix = iii - 180 : ix = iii + 180;
  }

  while (xi < mc) {
    xi += 180;
    xi > 360 ? xi = xi - 360 : xi;
    xi > 180 ? v = xi - 180 : v = xi + 180;
  }

  while (xii < mc) {
    xii += 180;
    xii > 360 ? xii = xii - 360 : xii;
    xii > 180 ? vi = xii - 180 : vi = xii + 180;
  }
  // print('$xi $iii');
  return [asc, ii, iii, ic, v, vi, ds, viii, ix, mc, xi, xii];
}


  // var w_sun = 282.9404 + 4.70935E-5 * d;
  // var M_sun = deg_360(356.0470 + 0.9856002585 * d);
  // var L_sun = deg_360(w_sun + M_sun); // Звездное время