// ------
// Ready
// ------
// ignore_for_file: unnecessary_getters_setters, hash_and_equals

import 'dart:math';

class ComplexN {
  num _real;
  num _imag;

  // 1- Here we define different ways to build a complex number:
  // constructors:
  ComplexN([this._real = 0, this._imag = 0]);
  ComplexN.im(num imaginary) : this(0, imaginary);
  ComplexN.re(num real) : this(real, 0);
  // 2- The normal utility methods to get and set the real and
  // imaginary part, to get the absolute value and the angle, to
  //  compare two complex numbers:
  num get real => _real;
  set real(num value) => _real = value;
  num get imaginary => _imag;
  set imaginary(num value) => _imag = value;
  num get abs => sqrt(real * real + imaginary * imaginary);
  num get angle => atan2(imaginary, real);

  @override
  bool operator ==(other) {
    if (other is! ComplexN) {
      return false;
    }
    return real == other.real && imaginary == other.imaginary;
  }

  // @override
  // String toString() {
  //   if (_imag >= 0) {
  //     return '$_real + ${_imag}j';
  //   }
  //   return '$_real - ${_imag.abs()}j';
  // }

  @override
  String toString() {
    if (_imag >= 0) {
      return '$_imag - ${_real}j';
    }
    return '$_imag + ${_real.abs()}j';
  }
  // static Complex conjugate(_real, _imag) {
  //  if (_imag >= 0) {
  //     return '$_real + ${_imag}j';
  //   }
  //   return '$_real - ${_imag.abs()}j';
  // }

  // 3- operator overloading:
  // The basic operations for adding, multiplying, subtraction and    //
  //  division are defined as overloading of the operators +, *, - and /
  ComplexN operator +(ComplexN x) {
    return ComplexN(_real + x.real, _imag + x.imaginary);
  }

  ComplexN operator -(var x) {
    if (x is ComplexN) {
      return ComplexN(real - x.real, imaginary - x.imaginary);
    } else if (x is num) {
      _real -= x;
      return this;
    }
    throw 'Not a number';
  }

  ComplexN operator *(var x) {
    if (x is ComplexN) {
      num realAux = (real * x.real - imaginary * x.imaginary);
      num imagAux = (imaginary * x.real + real * x.imaginary);
      return ComplexN(realAux, imagAux);
    } else if (x is num) {
      return ComplexN(real * x, imaginary * x);
    }
    throw 'Not a number';
  }

  ComplexN operator /(var x) {
    if (x is ComplexN) {
      num realAux = (real * x.real + imaginary * x.imaginary) /
          (x.real * x.real + x.imaginary * x.imaginary);
      num imagAux = (imaginary * x.real - real * x.imaginary) /
          (x.real * x.real + x.imaginary * x.imaginary);
      return ComplexN(realAux, imagAux);
    } else if (x is num) {
      return ComplexN(real / x, imaginary / x);
    }
    throw 'Not a number';
  }

  // 4- Here we define the same operations as methods:
  static ComplexN add(ComplexN c1, ComplexN c2) {
    num rr = c1.real + c2.real;
    num ii = c1.imaginary + c2.imaginary;
    return ComplexN(rr, ii);
  }

  static ComplexN subtract(ComplexN c1, ComplexN c2) {
    num rr = c1.real - c2.real;
    num ii = c1.imaginary - c2.imaginary;
    return ComplexN(rr, ii);
  }

  static ComplexN multiply(ComplexN c1, ComplexN c2) {
    num rr = c1.real * c2.real - c1.imaginary * c2.imaginary;
    num ii = c1.real * c2.imaginary + c1.imaginary * c2.real;
    return ComplexN(rr, ii);
  }

  static ComplexN divide(ComplexN c1, ComplexN c2) {
    num real = (c1.real * c2.real + c1.imaginary * c2.imaginary) /
        (c2.real * c2.real + c2.imaginary * c2.imaginary);
    num imag = (c1.imaginary * c2.real - c1.real * c2.imaginary) /
        (c2.real * c2.real + c2.imaginary * c2.imaginary);
    return ComplexN(real, imag);
  }

  // static Complex conjugate(var c1, Complex c2) {
  //   var rr = exp(c1) * cos(c2.real) + exp(c1) * sin(c2.real);
  //   num ii = c1.imaginary - c2.imaginary;
  //   return Complex(rr, ii);
  // }

  /// Compute the [exponential function](http://mathworld.wolfram.com/ExponentialFunction.html)
  /// of this complex number.
  ///
  /// Implements the formula:
  ///
  ///     exp(a + bi) = exp(a)cos(b) + exp(a)sin(b)i
  ///
  /// where the (real) functions on the right-hand side are
  /// [math.exp], [math.cos], and [math.sin].
  ///
  /// Returns [nan] if either real or imaginary part of the
  /// input argument is `NaN`.
  ///
  /// Infinite values in real or imaginary parts of the input may result in
  /// infinite or `NaN` values returned in parts of the result.
  ///
  /// Examples:
  ///
  ///     exp(1 ± INFINITY i) = NaN + NaN i
  ///     exp(INFINITY + i) = INFINITY + INFINITY i
  ///     exp(-INFINITY + i) = 0 + 0i
  ///     exp(±INFINITY ± INFINITY i) = NaN + NaN i
}
