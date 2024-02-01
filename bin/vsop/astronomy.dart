import 'calc_moon.dart';
import 'calc_pluto_simple.dart';
import 'src/classes.dart';
import 'src/constants.dart';
import 'src/espenac.dart';
import 'src/func.dart';
import 'src/rotate_vector.dart';
import 'src/vsop.dart';
// # -------------------------
// # 1. Парсинг входной даты
// # -------------------------

List parseArgs(data, lat, lon) {
  double time = make(data);
  Observer observer = Observer(lat, lon);
  return [observer, dt(time)];
}

// # --------------------------------------
// # 2. Получение обьекта времени Time(ut)
// # --------------------------------------

double dt(time) {
  var deltaT = Timex().deltaTEspenakMeeus(time);
  return time + deltaT / 86400.0;
}

double make(data) {
  DateTime d1 = DateTime.utc(2000, 1, 1, 12, 0);
  Duration diff = data.difference(d1);
  return diff.inSeconds / 86400;
}

// # ------------------------
// # 3. секция ГЕЛИОЦЕНТРИКИ
// # ------------------------
double helioEclipLon(body, time) {
  if (body == Body.pluto) {
    var p = pluto(time);
    return p[0]; // эклиптика'
  } else {
    Vector hv = helioVector(body, time);
    var helio = ecliptic(hv, time);
    return helio.elon;
  }
}
//Расчет гелиоцентрических эклиптических координат планет в J2000 equatorial system.

Vector helioVector(body, time) {
  if (body == Body.sun) {
    return Vector(0.0, 0.0, 0.0, time);
  } else if (body.index >= 0 && body.index < vsop.length) {
    return calcVsop(vsop[body.index], time);
  } else {
    return Vector(0.0, 0.0, 0.0, time);
  }
}

// # ----------------------
// # 4. секция ГЕОЦЕНТРИКИ
// # ----------------------
// """Расчет геоцентрической долготы планет. """
double geoLon(body, time, observer) {
  List gcObserver = geoPos(time, observer);
  Vector gc = geoVector(body, time);
  var j2000 = [
    gc.x - gcObserver[0],
    gc.y - gcObserver[1],
    gc.z - gcObserver[2]
  ];

  List _tmp = precession(j2000, time, PrecessDir.from2000);

  List datevect = nutation(_tmp, time, PrecessDir.from2000);

  Vector geoVect = Vector(datevect[0], datevect[1], datevect[2], time);
  var _geo = ecliptic(geoVect, time);

  if (body == Body.earth) {
    return 0;
  } else if (body == Body.pluto) {
    return pluto(time)[1];
  } else if (body == Body.moon) {
    return geoMoon(time)[1];
  } else {
    return _geo.elon;
  }
}

double cartLon(body, time) {
  // """Расчет прямоугольной геоцентрической долготы планет. """
  if (body == Body.pluto) {
    return pluto(time)[1]; // гео
  } else {
    Vector geoV = geoVector(body, time);
    var geoPos = ecliptic(geoV, time);
    return geoPos.elon;
  }
}

Vector calcEarth(body, time) {
  return calcVsop(vsop[Body.earth.index], time);
}

Vector geoVector(body, time) {
  Vector earth = calcEarth(body, time);
  Vector helio = helioVector(body, time);
  Vector geo =
      Vector(helio.x - earth.x, helio.y - earth.y, helio.z - earth.z, time);

  if (body == Body.earth) {
    return Vector(0.0, 0.0, 0.0, time);
  } else {
    return geo;
  }
}
