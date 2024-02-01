import 'dart:math';
import 'constants.dart';
import 'classes.dart';
import 'func.dart';
import 'rotate_vector.dart';

double vsopFormula(formula, t, clampAngle) {
  double tpower = 1.0;
  double coord = 0.0;

  for (var lst in formula) {
    double incr = 0.0;
    for (var val in lst) {
      incr += val[0] * cos(val[1] + val[2] * t);
    }
    incr *= tpower;
    tpower *= t;

    if (clampAngle == true) {
      incr = fmod(incr, pi2);
    }
    coord += incr;
  }
  return coord;
}

Vector calcVsop(model, time) {
  double t = time / daysPerMillenium;
  double lon = vsopFormula(model[0], t, true); //true
  double lat = vsopFormula(model[1], t, false);
  double rad = vsopFormula(model[2], t, false);
  TerseVector eclip = vsopSphereToRect(lon, lat, rad);
  return vsopRotate(eclip).toAstroVector(time);
}

// def CalcVsopPosVel(model, tt):
//     t = tt / DAYS_PER_MILLENNIUM

//     lon = VsopFormula(model[0], t, True)
//     lat = VsopFormula(model[1], t, False)
//     rad = VsopFormula(model[2], t, False)

//     (dlon_dt, dlat_dt, drad_dt) = [VsopDeriv(formula, t) for formula in model]

//     coslon = cos(lon)
//     sinlon = sin(lon)
//     coslat = cos(lat)
//     sinlat = sin(lat)

//     vx = (
//         + (drad_dt * coslat * coslon)
//         - (rad * sinlat * coslon * dlat_dt)
//         - (rad * coslat * sinlon * dlon_dt)
//     )

//     vy = (
//         + (drad_dt * coslat * sinlon)
//         - (rad * sinlat * sinlon * dlat_dt)
//         + (rad * coslat * coslon * dlon_dt)
//     )

//     vz = (
//         + (drad_dt * sinlat)
//         + (rad * coslat * dlat_dt)
//     )

//     eclip_pos = VsopSphereToRect(lon, lat, rad)

//     # Convert speed units from [AU/millennium] to [AU/day].
//     eclip_vel = TerseVector(vx, vy, vz) / DAYS_PER_MILLENNIUM

//     # Rotate the vectors from ecliptic to equatorial coordinates.
//     equ_pos = VsopRotate(eclip_pos)
//     equ_vel = VsopRotate(eclip_vel)
//     return body_state_t(tt, equ_pos, equ_vel)

// def VsopDeriv(formula, t):
//     tpower = 1      # t**s
//     dpower = 0      # t**(s-1)
//     deriv = 0
//     s = 0
//     for series in formula:
//         sin_sum = 0
//         cos_sum = 0
//         for (ampl, phas, freq) in series:
//             angle = phas + (t * freq)
//             sin_sum += ampl * freq * sin(angle)
//             if s > 0:
//                 cos_sum += ampl * cos(angle)
//         deriv += (s * dpower * cos_sum) - (tpower * sin_sum)
//         dpower = tpower
//         tpower *= t
//         s += 1
//     return deriv

// def VsopHelioDistance(model, time):
//     # The caller only wants to know the distance between the planet and the Sun.
//     # So we only need to calculate the radial component of the spherical coordinates.
//     # There is no need to translate coordinates.
//     return VsopFormula(model[2], time.tt / DAYS_PER_MILLENNIUM, False)

//vsop78
// [[], [[0.00227777722, 3.4137662053, 6283.0758499914], [3.805678e-05, 3.37063423795, 12566.1516999828]]]

// [[[0.01346277648, 2.61877810547, 74.7815985673], [0.000623414, 5.08111189648, 149.5631971346], [0.00061601196, 3.14159265359, 0.0], [9.963722e-05, 1.61603805646, 76.2660712756], [9.92616e-05, 0.57630380333, 73.297125859]], [[0.00034101978, 0.01321929936, 74.7815985673]]]





// for (var val in series) {
    //   print(val[0]);
    //   // print('${val[i][0]}, ${val[i][1]}, ${val[i][2]}');
    //   incr += tpower * (val[0] * cos(val[1] + val[2] * t));
    //   i++;
    // }
    // print('0_incr = $incr');