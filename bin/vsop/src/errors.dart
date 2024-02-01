// ------
// Ready?
// ------

/// классы ошибки
class Error {
  late Exception E;
  Error(this.E);
}
// class Error(Exception):
//     """Indicates an error in an astronomical calculation."""

//     def __init__(self, message):
//         Exception.__init__(self, message)

// class DateTimeFormatError(Error):
//     """The syntax of a UTC date/time string was not valid, or it contains invalid values."""

//     def __init__(self, text):
//         Error.__init__(
//             self, 'The date/time string is not valid: "{}"'.format(text))

// class EarthNotAllowedError(Error):
//     """The Earth is not allowed as the celestial body in this calculation."""

//     def __init__(self):
//         Error.__init__(self, 'The Earth is not allowed as the body.')

// class InvalidBodyError(Error):
//     """The celestial body is not allowed for this calculation."""

//     def __init__(self):
//         Error.__init__(self, 'Invalid astronomical body.')

// class BadVectorError(Error):
//     """A vector magnitude is too small to have a direction in space."""

//     def __init__(self):
//         Error.__init__(self, 'Vector is too small to have a direction.')

// class InternalError(Error):
//     """An internal error occured that should be reported as a bug."""

//     def __init__(self):
//         Error.__init__(
//             self, 'Internal error - please report issue at https://github.com/cosinekitty/astronomy/issues')

// class NoConvergeError(Error):
//     """A numeric solver did not converge.  """

//     def __init__(self):
//         Error.__init__(self, 'Numeric solver did not converge ')
