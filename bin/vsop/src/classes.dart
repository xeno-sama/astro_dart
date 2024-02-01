// ------
// Ready
// ------
// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';

enum PrecessDir {
  from2000, // 0
  into2000 // 1
}

enum Body {
  mercury, //0
  venus, //1
  earth, //2
  mars, //3
  jupiter, //4
  saturn, //5
  uranus, //6
  neptune, //7
  pluto, //8
  sun, //9
  moon //10
}
enum Body2 {
  mercury, //0
}

class Vector {
  // """A Cartesian vector with 3 space coordinates and 1 time coordinate. """
  var x, y, z, t;
  Vector(this.x, this.y, this.z, this.t);

  double length(x, y, z) => sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2));
  //Returns the length of the vector in AU. (xˆ2+yˆ2+zˆ2)
}

class EclipticCoordinates {
//     """Ecliptic angular and Cartesian coordinates."""
  var vec, elat, elon;
  EclipticCoordinates(this.vec, this.elat, this.elon);
}

class Observer {
//Represents the geographic location of an observer on the surface of the Earth.
  var latitude, longitude;
  Observer(this.latitude, this.longitude);
}

class TerseVector {
// A combination of a position vector, a velocity vector, and a time.
  var x, y, z;
  TerseVector(this.x, this.y, this.z);

  Vector toAstroVector(time) => Vector(x, y, z, time);
  //  Convert _TerseVector object to Vector object

  double quadrature() => x * x + y * y + z * z;
  //  Return magnitude squared of this vector.

  TerseVector mean(other) => TerseVector(
      (x + other.x) / 2.0, (y + other.y) / 2.0, (z + other.z) / 2.0);
  //  Return the average of this vector and another vector.
}

class RotationMatrix {
//     Contains a rotation matrix that can be used to transform one
//     coordinate system into another.
//    rot : float[3][3]  A normalized 3x3 rotation matrix
  var rot;
  RotationMatrix(this.rot);
}

class Etilt {
  Etilt(this.dpsi, this.deps, this.mobl, this.tobl, this.ee, this.tt);
  double dpsi, deps, mobl, tobl, ee, tt;
}
