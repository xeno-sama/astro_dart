import 'func.dart';

Map<String, double> initVals(double d) {
  var dictSun = {
    'N_sun': 0.0, //N = Долгота восходящего узла/ascending node
    'i_sun': 0.0, //i = наклон плоскости экватора к эклиптике
    'a_sun': 1.000000, // (AU) a = средняя дистанция до солнца
    'w_sun': 282.9404 + 4.70935E-5 * d, //w = аргумент перигелия
    'e_sun': 0.016709 -
        1.151E-9 * d, //e = экцентриситет (0=круг, 0-1=эллипс, 1=парабола)
    'M_sun': deg_360(356.0470 +
        0.9856002585 * d), //M = среднее угловое расстояние (0 в перигелии)
    'L_sun': deg_360(
        (282.9404 + 4.70935E-5 * d) + deg_360(356.0470 + 0.9856002585 * d))
  };

  // Луна
  var dictMoon = {
    'N_moon': 125.1228 - 0.0529538083 * d,
    'i_moon': 5.1454,
    'w_moon': 318.0634 + 0.1643573223 * d,
    'a_moon': 60.2666,
    'e_moon': 0.054900,
    'M_moon': deg_360(115.3654 + 13.0649929509 * d)
  };

  // Меркурий
  var dictMercury = {
    'N_mercury': 48.3313 + 3.24587E-5 * d,
    'i_mercury': 7.0047 + 5.00E-8 * d,
    'w_mercury': 29.1241 + 1.01444E-5 * d,
    'a_mercury': 0.387098,
    'e_mercury': 0.205635 + 5.59E-10 * d,
    'M_mercury': deg_360(168.6562 + 4.0923344368 * d)
  };

  // Меркурий
  var dictVenus = {
    'N_venus': 76.6799 + 2.46590E-5 * d,
    'i_venus': 3.3946 + 2.75E-8 * d,
    'w_venus': 54.8910 + 1.38374E-5 * d,
    'a_venus': 0.723330,
    'e_venus': 0.006773 - 1.302E-9 * d,
    'M_venus': deg_360(48.0052 + 1.6021302244 * d)
  };

  // Марс
  var dictMars = {
    'N_mars': 49.5574 + 2.11081E-5 * d,
    'i_mars': 1.8497 - 1.78E-8 * d,
    'w_mars': 286.5016 + 2.92961E-5 * d,
    'a_mars': 1.523688,
    'e_mars': 0.093405 + 2.516E-9 * d,
    'M_mars': deg_360(18.6021 + 0.5240207766 * d)
  };

  // Юпитер
  var dictJupiter = {
    'N_jupiter': 100.4542 + 2.76854E-5 * d,
    'i_jupiter': 1.3030 - 1.557E-7 * d,
    'w_jupiter': 273.8777 + 1.64505E-5 * d,
    'a_jupiter': 5.20256,
    'e_jupiter': 0.048498 + 4.469E-9 * d,
    'M_jupiter': deg_360(19.8950 + 0.0830853001 * d)
  };

  // Сатурн
  var dictSaturn = {
    'N_saturn': 113.6634 + 2.38980E-5 * d,
    'i_saturn': 2.4886 - 1.081E-7 * d,
    'w_saturn': 339.3939 + 2.97661E-5 * d,
    'a_saturn': 9.55475,
    'e_saturn': 0.055546 - 9.499E-9 * d,
    'M_saturn': deg_360(316.9670 + 0.0334442282 * d)
  };

  // Уран
  var dictUranus = {
    'N_uranus': 74.0005 + 1.3978E-5 * d,
    'i_uranus': 0.7733 + 1.9E-8 * d,
    'w_uranus': 96.6612 + 3.0565E-5 * d,
    'a_uranus': 19.18171 - 1.55E-8 * d,
    'e_uranus': 0.047318 + 7.45E-9 * d,
    'M_uranus': deg_360(142.5905 + 0.011725806 * d)
  };

  // Нептун
  var dictNeptune = {
    'N_neptune': 131.7806 + 3.0173E-5 * d,
    'i_neptune': 1.7700 - 2.55E-7 * d,
    'w_neptune': 272.8461 - 6.027E-6 * d,
    'a_neptune': 30.05826 + 3.313E-8 * d,
    'e_neptune': 0.008606 + 2.15E-9 * d,
    'M_neptune': deg_360(260.2471 + 0.005995147 * d)
  };

  // Плутон
  // так как не существует теории - есть приближение валидное для 1800-2000гг
  var dictPluto = {'S': 50.03 + 0.033459652 * d, 'P': 238.95 + 0.003968789 * d};

  Map<String, double> dictAll = {};
  var mapAll = [
    dictSun,
    dictMoon,
    dictMercury,
    dictVenus,
    dictMars,
    dictJupiter,
    dictSaturn,
    dictUranus,
    dictNeptune,
    dictPluto
  ];

  for (final item in mapAll) {
    dictAll.addAll(item);
  }

  return dictAll;
}
