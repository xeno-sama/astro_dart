import 'export_funcs.dart';

List<double> dataSun(double w, double _e, double M, double d) {
// Шаг 1 - вычислить E экцентрическую аномалию
// sin/cos выдают в радианах - поэтому сразу конвертировать *pi/180
  var __e = M + degrees(_e) * sin(radians(M)) * (1.0 + _e * cos(radians(M)));
  var e = radians(__e);

// Шаг 2 - вычислить прямоугольные координаты солнца в плоскости эклиптики
// где x - угол направленный к перигелию
  var x = cos(e) - _e;
  var y = sin(e) * sqrt(1 - _e * _e);

// Шаг 3 - конвертировать в расстояние и истинную аномалию
  var r = sqrt(x * x + y * y); //расстояние
  var _v = atan2(y, x);
  var v = deg_360(degrees(_v)); // -> истинная аномалия в градусах

// Шаг 4 (главный) - Теперь подсчитать ГЕОЦЕНТРИКУ !!!
// lat = 0 # т.к это само солнце в своей плоскости
// R = 0   # т.к это само солнце и расст до солнца = 0
  var _lon = v + w;
  var _lonEcl = deg_360(_lon);
  var lonEcl = deg_360(_lon + 180);
  var lonTopos = deg_360(_lon); // по факту = топоцентрике

  var xEclip = r * cos(radians(_lonEcl));
  var yEclip = r * sin(radians(_lonEcl));

  return [lonTopos, lonEcl, xEclip, yEclip];
}


/* Примечание 
все что закомментировал - только потому что мне |пока не требуется| выводить данные
LAT RA R DECL
*/