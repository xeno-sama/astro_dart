// # -------------------------
// # Преобразование координат
// # -------------------------
import 'dart:math';
import 'classes.dart';
import 'func.dart';

EclipticCoordinates ecliptic(equ, time) {
  //Преобразование прямоугольных в эклиптические координаты.
  //Based on NOVAS functions equ2ecl() and equ2ecl_vec().
  double ob2000 =
      0.40909260059599012; // mean obliquity of the J2000 ecliptic in radians
  return rotateEquatorialToEcliptic([equ.x, equ.y, equ.z], ob2000, equ.t);
}

EclipticCoordinates rotateEquatorialToEcliptic(pos, obliqRadians, time) {
  double cosOb = cos(obliqRadians);
  double sinOb = sin(obliqRadians);
  var ex = pos[0];
  var ey = pos[1] * cosOb + pos[2] * sinOb;
  var ez = pos[1] * sinOb + pos[2] * cosOb;
  double elon;
  double xyproj = sqrt(ex * ex + ey * ey);
  if (xyproj > 0.0) {
    elon = degrees(atan2(ey, ex));
    if (elon < 0.0) {
      elon += 360.0;
    }
  } else {
    elon = 0.0;
  }

  double elat = degrees(atan2(ez, xyproj));
  var vec = Vector(ex, ey, ez, time);

  return EclipticCoordinates(vec, elat, elon);
}

TerseVector vsopRotate(eclip) {
  // Convert ecliptic cartesian coordinates to equatorial cartesian coordinates.
  double x = eclip.x + 0.000000440360 * eclip.y - 0.000000190919 * eclip.z;
  double y = -0.000000479966 * eclip.x +
      0.917482137087 * eclip.y -
      0.397776982902 * eclip.z;
  double z = 0.397776982902 * eclip.y + 0.917482137087 * eclip.z;
  return TerseVector(x, y, z);
}

TerseVector vsopSphereToRect(lon, lat, rad) {
  // Convert spherical coordinates to cartesian coordinates.
  double rCosLat = rad * cos(lat);
  return TerseVector(rCosLat * cos(lon), rCosLat * sin(lon), rad * sin(lat));
}
