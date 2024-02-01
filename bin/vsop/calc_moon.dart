// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';
import 'src/classes.dart';
import 'src/constants.dart';
import 'src/func.dart';
import 'src/complex.dart';
import 'src/complex_var.dart';
// import 'package:complex/complex.dart';

class MoonPos {
  double lon, lat, dist;
  MoonPos(this.lon, this.lat, this.dist);
}

double _pi2 = 2.0 * pi; //PI2
double _arc = 3600.0 * 180.0 / pi; //ARC

List geoMoon(time) {
  //Вычисление геоцентрической позиции Луны
  MoonPos m0 = calcMoon(time);
  // print(m0.lon);

  // Преобразование геоцентрических эклиптических сферических координат в прямоугольные/Cartesian
  double distCosLat = m0.dist * cos(m0.lat);
  List gepos = [
    distCosLat * cos(m0.lon),
    distCosLat * sin(m0.lon),
    m0.dist * sin(m0.lat)
  ];
  // print("$gepos");
  // Преобразование эклиптических координат в экваториальные'.
  var mpos1 = ecl2equVec(time, gepos);

  // Convert from mean equinox of date to J2000.
  var mpos2 = precession(mpos1, time, PrecessDir.into2000);

  return [Vector(mpos2[0], mpos2[1], mpos2[2], time), degrees(m0.lon)];
}

Map _array1(int xmin, int xmax) {
  Map arr1 = {for (var i = xmin; i < xmax + 1; i++) i: '0j'};
  return arr1;
}

Map _array2(int xmin, int xmax, int ymin, int ymax) {
  Map arr2 = {for (var i = xmin; i < xmax + 1; i++) i: _array1(ymin, ymax)};
  return arr2;
}

// # непосредственный расчет положения Луны
dynamic calcMoon(time) {
  double t = time / 36525;

  Map ex = _array2(-6, 6, 1, 4); // правильно

  double sine(double phi) => sin(_pi2 * phi);
  double frac(double x) => x - x.floor();

  double t2 = t * t;
  double dlam = 0;
  double ds = 0;
  double gam1c = 0;
  double sinpi = 3422.7000;

  double s1 = sine(0.19833 + 0.05611 * t);
  double s2 = sine(0.27869 + 0.04508 * t);
  double s3 = sine(0.16827 - 0.36903 * t);
  double s4 = sine(0.34734 - 5.37261 * t);
  double s5 = sine(0.10498 - 5.37899 * t);
  double s6 = sine(0.42681 - 0.41855 * t);
  double s7 = sine(0.14943 - 5.37511 * t);
  double dl0 =
      0.84 * s1 + 0.31 * s2 + 14.27 * s3 + 7.26 * s4 + 0.28 * s5 + 0.24 * s6;
  double dl =
      2.94 * s1 + 0.31 * s2 + 14.27 * s3 + 9.34 * s4 + 1.12 * s5 + 0.83 * s6;
  double dls = -6.40 * s1 - 1.89 * s6;
  double df = 0.21 * s1 +
      0.31 * s2 +
      14.27 * s3 -
      88.70 * s4 -
      15.30 * s5 +
      0.24 * s6 -
      1.86 * s7;
  double dd = dl0 - dls;
  double dgam = (-3332E-9 * sine(0.59734 - 5.37261 * t) -
      539E-9 * sine(0.35498 - 5.37899 * t) -
      64E-9 * sine(0.39943 - 5.37511 * t));

  double l0 = _pi2 * frac(0.60643382 + 1336.85522467 * t - 0.00000313 * t2) +
      dl0 / _arc;
  double L =
      _pi2 * frac(0.37489701 + 1325.55240982 * t + 0.00002565 * t2) + dl / _arc;
  double ls =
      _pi2 * frac(0.99312619 + 99.99735956 * t - 0.00000044 * t2) + dls / _arc;
  double F =
      _pi2 * frac(0.25909118 + 1342.22782980 * t - 0.00000892 * t2) + df / _arc;
  double D =
      _pi2 * frac(0.82736186 + 1236.85308708 * t - 0.00000397 * t2) + dd / _arc;

  int I = 1;
  int max, J;
  double arg, fac;

  while (I <= 4) {
    if (I == 1) {
      arg = L;
      max = 4;
      fac = 1.000002208;
    } else if (I == 2) {
      arg = ls;
      max = 3;
      fac = 0.997504612 - 0.002495388 * t;
    } else if (I == 3) {
      arg = F;
      max = 4;
      fac = 1.000002708 + 139.978 * dgam;
    } else {
      arg = D;
      max = 6;
      fac = 1.0;
    }

    ex.update(0, (value) {
      return value..[I] = Complex(1, 0);
    });
    ex.update(1, (value) {
      return value..[I] = Complex(fac * cos(arg), fac * sin(arg));
    });

    J = 2;
    while (J <= max) {
      ex[J][I] = ex[J - 1][I] * ex[1][I];
      J += 1;
    }
    // print("${ex[1][I]}");
    J = 1;
    while (J <= max) {
      Complex r =
          Complex.conjugate(ex[J][I], ex[J][I]); // меняет знак в мат.выражении
      ex[-J][I] = r;
      J += 1;
    }
    I++;
  }

  var _vars = vars(ex, dlam, ds, gam1c, sinpi);
  dlam = _vars[0];
  ds = _vars[1];
  gam1c = _vars[2];
  sinpi = _vars[3];
  // print("$dlam $ds $gam1c $sinpi");

  dlam += (0.82 * sine(0.7736 - 62.5512 * t) +
      0.31 * sine(0.0466 - 125.1025 * t) +
      0.35 * sine(0.5785 - 25.1042 * t) +
      0.66 * sine(0.4591 + 1335.8075 * t) +
      0.64 * sine(0.3130 - 91.5680 * t) +
      1.14 * sine(0.1480 + 1331.2898 * t) +
      0.21 * sine(0.5918 + 1056.5859 * t) +
      0.44 * sine(0.5784 + 1322.8595 * t) +
      0.24 * sine(0.2275 - 5.7374 * t) +
      0.28 * sine(0.2965 + 2.6929 * t) +
      0.33 * sine(0.3132 + 6.3368 * t));

  double S = F + ds / arc;
  double N = 0; // почти не влияет
  double latSeconds =
      (1.000002708 + 139.978 * dgam) * (18518.511 + 1.189 + gam1c) * sin(S) -
          6.24 * sin(3 * S) +
          N;

  return MoonPos(
      pi2 * frac((l0 + dlam / arc) / pi2),
      pi / (180 * 3600) * latSeconds,
      (arc * earthEquatorialRadiusAU) / (0.999953253 * sinpi));
}
