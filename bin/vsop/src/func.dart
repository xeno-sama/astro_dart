// ------
// Ready
// ------
import 'dart:math';
import 'classes.dart';
import 'constants.dart';

double radians(double rad) => rad * pi / 180;
double degrees(double grad) => grad / pi * 180;
double fmod(double x, double y) => x - (x / y).truncate() * y;

//Приведение к 360 градусов
double deg360(double x) {
  var rv = x - (x / 360.0).truncate() * 360.0;
  if (rv < 0.0) {
    rv += 360.0;
  }
  return rv;
}

double time24(double t0) {
  var t = t0 - (t0 / 24.0).truncate() * 24.0;
  if (t < 0.0) {
    t += 24.0;
  }
  return t;
}

//конвертируем RA -> время, 15град=1час
List<int> timeRA(double ra) {
  var hRA = (ra ~/ 15).toInt();
  var mRA = ((ra / 15 - hRA) * 60 ~/ 1).toInt();
  var sRA = ((ra / 15 - hRA) * 60 % 1 * 60).toInt();
  return [hRA, mRA, sRA];
}

double numDate(dat) {
  int y = dat.year;
  int m = dat.month;
  int D = dat.day;
  int hour = dat.hour;
  int minute = dat.minute;
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
  double gmst0 = time24(L / 15 + 12); // L солнечная долгота
  double sidTime = gmst0 + ut + lon / 15;
  double sidTimeDeg = sidTime * 15; //Звездное время в градусах
  return sidTimeDeg;
}

double era(time) // Earth Rotation Angle
{
  var thet1 = 0.7790572732640 + 0.00273781191135448 * time;
  var thet3 = fmod(time, 1.0);
  var theta = 360.0 * fmod((thet1 + thet3), 1.0);
  if (theta < 0.0) {
    theta += 360.0;
  }
  return theta;
}

double siderealTime(time) {
  var t = time / 36525.0;
  var theta = era(time);
  var st = (0.014506 +
      ((((-0.0000000368 * t - 0.000029956) * t - 0.00000044) * t + 1.3915817) *
                  t +
              4612.156534) *
          t);
  var gst = fmod((st / 3600.0 + theta), 360.0) / 15.0;
  if (gst < 0.0) {
    gst += 24.0;
  }
  return gst;
}

List terra(observer, st) {
  return terraPosvel(observer, st);
}

List terraPosvel(observer, st) {
  var df2 = earthFlattening * earthFlattening;
  var phi = radians(observer.latitude);
  var sinphi = sin(phi);
  var cosphi = cos(phi);
  var c = 1.0 / sqrt(cosphi * cosphi + df2 * sinphi * sinphi);
  var s = df2 * c;
  var ach = earthEquatorialRadiusKM * c;
  var ash = earthEquatorialRadiusKM * s;
  var stlocl = radians(15.0 * st + observer.longitude);
  var sinst = sin(stlocl);
  var cosst = cos(stlocl);
  return [
    ach * cosphi * cosst / kmPerAU,
    ach * cosphi * sinst / kmPerAU,
    ash * sinphi / kmPerAU
  ];
}

Vector vector2radec(pos, time) {
  Vector vec = Vector(pos[0], pos[1], pos[2], time);
  return vec;
}

List precession(pos, time, direction) {
  var r = precessionRot(time, direction);

  // print("${r?.rot}");
  return rotate(r, pos);
}

RotationMatrix? precessionRot(time, direction) {
  double eps0 = 84381.406;
  double t = time / 36525;

  double psia =
      (((((-0.0000000951 * t + 0.000132851) * t - 0.00114045) * t - 1.0790069) *
                  t +
              5038.481507) *
          t);

  double omegaa =
      (((((0.0000003337 * t - 0.000000467) * t - 0.00772503) * t + 0.0512623) *
                      t -
                  0.025754) *
              t +
          eps0);

  double chia =
      (((((-0.0000000560 * t + 0.000170663) * t - 0.00121197) * t - 2.3814292) *
                  t +
              10.556403) *
          t);

  eps0 *= asec2rad;
  psia *= asec2rad;
  omegaa *= asec2rad;
  chia *= asec2rad;

  double sa = sin(eps0);
  double ca = cos(eps0);
  double sb = sin(-psia);
  double cb = cos(-psia);
  double sc = sin(-omegaa);
  double cc = cos(-omegaa);
  double sd = sin(chia);
  double cd = cos(chia);

  double xx = cd * cb - sb * sd * cc;
  double yx = cd * sb * ca + sd * cc * cb * ca - sa * sd * sc;
  double zx = cd * sb * sa + sd * cc * cb * sa + ca * sd * sc;
  double xy = -sd * cb - sb * cd * cc;
  double yy = -sd * sb * ca + cd * cc * cb * ca - sa * cd * sc;
  double zy = -sd * sb * sa + cd * cc * cb * sa + ca * cd * sc;
  double xz = sb * sc;
  double yz = -sc * cb * ca - sa * cc;
  double zz = -sc * cb * sa + cc * ca;

  if (direction == PrecessDir.into2000) {
    return RotationMatrix([
      [xx, yx, zx],
      [xy, yy, zy],
      [xz, yz, zz]
    ]);
  }
  // if (direction == PrecessDir.from2000)
  //Perform rotation from J2000.0 to other epoch.
  else {
    return RotationMatrix([
      [xx, xy, xz],
      [yx, yy, yz],
      [zx, zy, zz]
    ]);
  }
}

double meanObliq(time) {
  double t = time / 36525;
  double asec =
      (((((-0.0000000434 * t - 0.000000576) * t + 0.00200340) * t - 0.0001831) *
                      t -
                  46.836769) *
              t +
          84381.406);
  return asec / 3600.0;
}

List ecl2equVec(time, ecl) {
  double obl = radians(meanObliq(time));
  double oblCos = cos(obl);
  double oblSin = sin(obl);
  return [
    ecl[0],
    ecl[1] * oblCos - ecl[2] * oblSin,
    ecl[1] * oblSin + ecl[2] * oblCos
  ];
}

List rotate(rot, vec) => [
      rot.rot[0][0] * vec[0] + rot.rot[1][0] * vec[1] + rot.rot[2][0] * vec[2],
      rot.rot[0][1] * vec[0] + rot.rot[1][1] * vec[1] + rot.rot[2][1] * vec[2],
      rot.rot[0][2] * vec[0] + rot.rot[1][2] * vec[1] + rot.rot[2][2] * vec[2]
    ];

List nutation(pos, time, direction) {
  var r = nutationRot(time, direction);
  return rotate(r, pos);
}

RotationMatrix nutationRot(time, direction) {
  Etilt tilt = iau2000b(time);

  double oblm = radians(tilt.mobl);
  double oblt = radians(tilt.tobl);
  double psi = tilt.dpsi * asec2rad;
  double cobm = cos(oblm);
  double sobm = sin(oblm);
  double cobt = cos(oblt);
  double sobt = sin(oblt);
  double cpsi = cos(psi);
  double spsi = sin(psi);

  double xx = cpsi;
  double yx = -spsi * cobm;
  double zx = -spsi * sobm;
  double xy = spsi * cobt;
  double yy = cpsi * cobm * cobt + sobm * sobt;
  double zy = cpsi * sobm * cobt - cobm * sobt;
  double xz = spsi * sobt;
  double yz = cpsi * cobm * sobt - sobm * cobt;
  double zz = cpsi * sobm * sobt + cobm * cobt;

  if (direction == PrecessDir.from2000)
  // convert J2000 to of-date
  {
    return RotationMatrix([
      [xx, xy, xz],
      [yx, yy, yz],
      [zx, zy, zz]
    ]);
  } else
  // if (direction == PrecessDir.into2000)
  // convert of-date to J2000
  {
    return RotationMatrix([
      [xx, yx, zx],
      [xy, yy, zy],
      [xz, yz, zz]
    ]);
  }
}

List geoPos(time, observer) {
  var gast = siderealTime(time);
  var pos1 = terra(observer, gast);
  var pos2 = nutation(pos1, time, PrecessDir.into2000);
  var outpos = precession(pos2, time, PrecessDir.into2000);
  // print("nutation $pos2");
  return outpos;
}

Etilt iau2000b(double time) {
  double t, el, elp, f, d, om, dp, de, arg, sarg, carg, dpsi, deps;
  t = time / 36525.0;
  el = fmod((485868.249036 + t * 1717915923.2178), asec360) * asec2rad;
  elp = fmod((1287104.79305 + t * 129596581.0481), asec360) * asec2rad;
  f = fmod((335779.526232 + t * 1739527262.8478), asec360) * asec2rad;
  d = fmod((1072260.70369 + t * 1602961601.2090), asec360) * asec2rad;
  om = fmod((450160.398036 - t * 6962890.5431), asec360) * asec2rad;
  dp = 0;
  de = 0;

  arg = 2.0 * f - 2.0 * d + 2.0 * om;
  sarg = sin(om);
  carg = cos(om);

  dpsi = -0.000135 + (dp * 1.0e-7);
  deps = 0.000388 + (de * 1.0e-7);

  dp = (-172064161.0 - 174666.0 * t) * sarg + 33386.0 * carg;
  de += (92052331.0 + 9086.0 * t) * carg + 15377.0 * sarg;

  sarg = sin(arg);
  carg = cos(arg);
  dp += (-13170906.0 - 1675.0 * t) * sarg - 13696.0 * carg;
  de += (5730336.0 - 3015.0 * t) * carg - 4587.0 * sarg;

  arg = 2.0 * f + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-2276413.0 - 234.0 * t) * sarg + 2796.0 * carg;
  de += (978459.0 - 485.0 * t) * carg + 1374.0 * sarg;

  arg = 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (2074554.0 + 207.0 * t) * sarg - 698.0 * carg;
  de += (-897492.0 + 470.0 * t) * carg - 291.0 * sarg;

  sarg = sin(elp);
  carg = cos(elp);
  dp += (1475877.0 - 3633.0 * t) * sarg + 11817.0 * carg;
  de += (73871.0 - 184.0 * t) * carg - 1924.0 * sarg;

  arg = elp + 2.0 * f - 2.0 * d + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-516821.0 + 1226.0 * t) * sarg - 524.0 * carg;
  de += (224386.0 - 677.0 * t) * carg - 174.0 * sarg;

  sarg = sin(el);
  carg = cos(el);
  dp += (711159.0 + 73.0 * t) * sarg - 872.0 * carg;
  de += (-6750.0) * carg + 358.0 * sarg;

  arg = 2.0 * f + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-387298.0 - 367.0 * t) * sarg + 380.0 * carg;
  de += (200728.0 + 18.0 * t) * carg + 318.0 * sarg;

  arg = el + 2.0 * f + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-301461.0 - 36.0 * t) * sarg + 816.0 * carg;
  de += (129025.0 - 63.0 * t) * carg + 367.0 * sarg;

  arg = -elp + 2.0 * f - 2.0 * d + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (215829.0 - 494.0 * t) * sarg + 111.0 * carg;
  de += (-95929.0 + 299.0 * t) * carg + 132.0 * sarg;

  arg = 2.0 * f - 2.0 * d + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (128227.0 + 137.0 * t) * sarg + 181.0 * carg;
  de += (-68982.0 - 9.0 * t) * carg + 39.0 * sarg;

  arg = -el + 2.0 * f + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (123457.0 + 11.0 * t) * sarg + 19.0 * carg;
  de += (-53311.0 + 32.0 * t) * carg - 4.0 * sarg;

  arg = -el + 2.0 * d;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (156994.0 + 10.0 * t) * sarg - 168.0 * carg;
  de += (-1235.0) * carg + 82.0 * sarg;

  arg = el + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (63110.0 + 63.0 * t) * sarg + 27.0 * carg;
  de += (-33228.0) * carg - 9.0 * sarg;

  arg = -el + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-57976.0 - 63.0 * t) * sarg - 189.0 * carg;
  de += (31429.0) * carg - 75.0 * sarg;

  arg = -el + 2.0 * f + 2.0 * d + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-59641.0 - 11.0 * t) * sarg + 149.0 * carg;
  de += (25543.0 - 11.0 * t) * carg + 66.0 * sarg;

  arg = el + 2.0 * f + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-51613.0 - 42.0 * t) * sarg + 129.0 * carg;
  de += (26366.0) * carg + 78.0 * sarg;

  arg = -2.0 * el + 2.0 * f + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (45893.0 + 50.0 * t) * sarg + 31.0 * carg;
  de += (-24236.0 - 10.0 * t) * carg + 20.0 * sarg;

  arg = 2.0 * d;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (63384.0 + 11.0 * t) * sarg - 150.0 * carg;
  de += (-1220.0) * carg + 29.0 * sarg;

  arg = 2.0 * f + 2.0 * d + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-38571.0 - 1.0 * t) * sarg + 158.0 * carg;
  de += (16452.0 - 11.0 * t) * carg + 68.0 * sarg;

  arg = -2.0 * elp + 2.0 * f - 2.0 * d + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (32481.0) * sarg;
  de += (-13870.0) * carg;

  arg = -2.0 * el + 2.0 * d;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-47722.0) * sarg - 18.0 * carg;
  de += (477.0) * carg - 25.0 * sarg;

  arg = 2.0 * el + 2.0 * f + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-31046.0 - 1.0 * t) * sarg + 131.0 * carg;
  de += (13238.0 - 11.0 * t) * carg + 59.0 * sarg;

  arg = el + 2.0 * f - 2.0 * d + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (28593.0) * sarg - carg;
  de += (-12338.0 + 10.0 * t) * carg - 3.0 * sarg;

  arg = -el + 2.0 * f + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (20441.0 + 21.0 * t) * sarg + 10.0 * carg;
  de += (-10758.0) * carg - 3.0 * sarg;

  arg = 2.0 * el;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (29243.0) * sarg - 74.0 * carg;
  de += (-609.0) * carg + 13.0 * sarg;

  arg = 2.0 * f;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (25887.0) * sarg - 66.0 * carg;
  de += (-550.0) * carg + 11.0 * sarg;

  arg = elp + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-14053.0 - 25.0 * t) * sarg + 79.0 * carg;
  de += (8551.0 - 2.0 * t) * carg - 45.0 * sarg;

  arg = -el + 2.0 * d + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (15164.0 + 10.0 * t) * sarg + 11.0 * carg;
  de += (-8001.0) * carg - sarg;

  arg = 2.0 * elp + 2.0 * f - 2.0 * d + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-15794.0 + 72.0 * t) * sarg - 16.0 * carg;
  de += (6850.0 - 42.0 * t) * carg - 5.0 * sarg;

  arg = -2.0 * f + 2.0 * d;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (21783.0) * sarg + 13.0 * carg;
  de += (-167.0) * carg + 13.0 * sarg;

  arg = el - 2.0 * d + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-12873.0 - 10.0 * t) * sarg - 37.0 * carg;
  de += (6953.0) * carg - 14.0 * sarg;

  arg = -elp + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-12654.0 + 11.0 * t) * sarg + 63.0 * carg;
  de += (6415.0) * carg + 26.0 * sarg;

  arg = -el + 2.0 * f + 2.0 * d + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-10204.0) * sarg + 25.0 * carg;
  de += (5222.0) * carg + 15.0 * sarg;

  arg = 2.0 * elp;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (16707.0 - 85.0 * t) * sarg - 10.0 * carg;
  de += (168.0 - 1.0 * t) * carg + 10.0 * sarg;

  arg = el + 2.0 * f + 2.0 * d + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-7691.0) * sarg + 44.0 * carg;
  de += (3268.0) * carg + 19.0 * sarg;

  arg = -2.0 * el + 2.0 * f;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-11024.0) * sarg - 14.0 * carg;
  de += (104.0) * carg + 2.0 * sarg;

  arg = elp + 2.0 * f + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (7566.0 - 21.0 * t) * sarg - 11.0 * carg;
  de += (-3250.0) * carg - 5.0 * sarg;

  arg = 2.0 * f + 2.0 * d + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-6637.0 - 11.0 * t) * sarg + 25.0 * carg;
  de += (3353.0) * carg + 14.0 * sarg;

  arg = -elp + 2.0 * f + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-7141.0 + 21.0 * t) * sarg + 8.0 * carg;
  de += (3070.0) * carg + 4.0 * sarg;

  arg = 2.0 * d + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-6302.0 - 11.0 * t) * sarg + 2.0 * carg;
  de += (3272.0) * carg + 4.0 * sarg;

  arg = el + 2.0 * f - 2.0 * d + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (5800.0 + 10.0 * t) * sarg + 2.0 * carg;
  de += (-3045.0) * carg - sarg;

  arg = 2.0 * el + 2.0 * f - 2.0 * d + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (6443.0) * sarg - 7.0 * carg;
  de += (-2768.0) * carg - 4.0 * sarg;

  arg = -2.0 * el + 2.0 * d + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-5774.0 - 11.0 * t) * sarg - 15.0 * carg;
  de += (3041.0) * carg - 5.0 * sarg;

  arg = 2.0 * el + 2.0 * f + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-5350.0) * sarg + 21.0 * carg;
  de += (2695.0) * carg + 12.0 * sarg;

  arg = -elp + 2.0 * f - 2.0 * d + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-4752.0 - 11.0 * t) * sarg - 3.0 * carg;
  de += (2719.0) * carg - 3.0 * sarg;

  arg = -2.0 * d + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-4940.0 - 11.0 * t) * sarg - 21.0 * carg;
  de += (2720.0) * carg - 9.0 * sarg;

  arg = -el - elp + 2.0 * d;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (7350.0) * sarg - 8.0 * carg;
  de += (-51.0) * carg + 4.0 * sarg;

  arg = 2.0 * el - 2.0 * d + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (4065.0) * sarg + 6.0 * carg;
  de += (-2206.0) * carg + sarg;

  arg = el + 2.0 * d;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (6579.0) * sarg - 24.0 * carg;
  de += (-199.0) * carg + 2.0 * sarg;

  arg = elp + 2.0 * f - 2.0 * d + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (3579.0) * sarg + 5.0 * carg;
  de += (-1900.0) * carg + sarg;

  arg = el - elp;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (4725.0) * sarg - 6.0 * carg;
  de += (-41.0) * carg + 3.0 * sarg;

  arg = -2.0 * el + 2.0 * f + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-3075.0) * sarg - 2.0 * carg;
  de += (1313.0) * carg - sarg;

  arg = 3.0 * el + 2.0 * f + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-2904.0) * sarg + 15.0 * carg;
  de += (1233.0) * carg + 7.0 * sarg;

  arg = -elp + 2.0 * d;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (4348.0) * sarg - 10.0 * carg;
  de += (-81.0) * carg + 2.0 * sarg;

  arg = el - elp + 2.0 * f + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-2878.0) * sarg + 8.0 * carg;
  de += (1232.0) * carg + 4.0 * sarg;

  sarg = sin(d);
  carg = cos(d);
  dp += (-4230.0) * sarg + 5.0 * carg;
  de += (-20.0) * carg - 2.0 * sarg;

  arg = -el - elp + 2.0 * f + 2.0 * d + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-2819.0) * sarg + 7.0 * carg;
  de += (1207.0) * carg + 3.0 * sarg;

  arg = -el + 2.0 * f;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-4056.0) * sarg + 5.0 * carg;
  de += (40.0) * carg - 2.0 * sarg;

  arg = -elp + 2.0 * f + 2.0 * d + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-2647.0) * sarg + 11.0 * carg;
  de += (1129.0) * carg + 5.0 * sarg;

  arg = -2.0 * el + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-2294.0) * sarg - 10.0 * carg;
  de += (1266.0) * carg - 4.0 * sarg;

  arg = el + elp + 2.0 * f + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (2481.0) * sarg - 7.0 * carg;
  de += (-1062.0) * carg - 3.0 * sarg;

  arg = 2.0 * el + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (2179.0) * sarg - 2.0 * carg;
  de += (-1129.0) * carg - 2.0 * sarg;

  arg = -el + elp + d;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (3276.0) * sarg + carg;
  de += (-9.0) * carg;

  arg = el + elp;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-3389.0) * sarg + 5.0 * carg;
  de += (35.0) * carg - 2.0 * sarg;

  arg = el + 2.0 * f;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (3339.0) * sarg - 13.0 * carg;
  de += (-107.0) * carg + sarg;

  arg = -el + 2.0 * f - 2.0 * d + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-1987.0) * sarg - 6.0 * carg;
  de += (1073.0) * carg - 2.0 * sarg;

  arg = el + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-1981.0) * sarg;
  de += (854.0) * carg;

  arg = -el + d;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (4026.0) * sarg - 353.0 * carg;
  de += (-553.0) * carg - 139.0 * sarg;

  arg = 2.0 * f + d + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (1660.0) * sarg - 5.0 * carg;
  de += (-710.0) * carg - 2.0 * sarg;

  arg = -el + 2.0 * f + 4.0 * d + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-1521.0) * sarg + 9.0 * carg;
  de += (647.0) * carg + 4.0 * sarg;

  arg = -el + elp + d + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (1314.0) * sarg;
  de += (-700.0) * carg;

  arg = -2.0 * elp + 2.0 * f - 2.0 * d + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-1283.0) * sarg;
  de += (672.0) * carg;

  arg = el + 2.0 * f + 2.0 * d + om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (-1331.0) * sarg + 8.0 * carg;
  de += (663.0) * carg + 4.0 * sarg;

  arg = -2.0 * el + 2.0 * f + 2.0 * d + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (1383.0) * sarg - 2.0 * carg;
  de += (-594.0) * carg - 2.0 * sarg;

  arg = -el + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (1405.0) * sarg + 4.0 * carg;
  de += (-610.0) * carg + 2.0 * sarg;

  arg = el + elp + 2.0 * f - 2.0 * d + 2.0 * om;
  sarg = sin(arg);
  carg = cos(arg);
  dp += (1290.0) * sarg;
  de += (-556.0) * carg;

  dpsi = -0.000135 + (dp * 1.0e-7);
  deps = 0.000388 + (de * 1.0e-7);

  double mobl = meanObliq(time);
  double tobl = mobl + (deps / 3600.0);
  double tt = time;
  double ee = dpsi * cos(radians(mobl)) / 15.0;

  return Etilt(dpsi, deps, mobl, tobl, tt, ee);
}



// Vector vector2radec(pos, time) {
//   double ra, dec;
//   var xyproj = pos[0] * pos[0] + pos[1] * pos[1];
//   var dist = sqrt(xyproj + pos[2] * pos[2]);
//   if (xyproj == 0.0) {
//     ra = 0.0;
//     if (pos[2] < 0.0) {
//       dec = -90.0;
//     } else {
//       dec = 90.0;
//     }
//   } else {
//     ra = rad2hour * atan2(pos[1], pos[0]);

//     if (ra < 0) {
//       ra += 24;
//     }
//     dec = degrees(atan2(pos[2], sqrt(xyproj)));
//   }
//   Vector vec = Vector(pos[0], pos[1], pos[2], time);
//   return vec;
// }
