// # ----------------------
// # 5. секция БариЦентр
// # ----------------------
// from math import sqrt
// from vsop.src.classes import Body, TerseVector, Vector, body_state_t
// from vsop.src.constants import JUPITER_GM, NEPTUNE_GM, SATURN_GM, SUN_GM, URANUS_GM, vsop87, vsop
// from vsop.src.vsop import CalcVsop, CalcVsopPosVel

// import 'classes.dart';

// class major_bodies_t {
//   //Accumulate the Solar System Barycenter position.
//   // var ssb = body_state_t(tt, TerseVector(0, 0, 0), TerseVector(0, 0, 0));
//   // // Calculate the position and velocity vectors of the 4 major planets.
//   // var Jupiter = AdjustBarycenterPosVel(
//   //     ssb, tt, Body.Jupiter, JUPITER_GM);
//   // var Saturn = AdjustBarycenterPosVel(
//   //     ssb, tt, Body.Saturn,  SATURN_GM);
//   // var Uranus = AdjustBarycenterPosVel(
//   //     ssb, tt, Body.Uranus,  URANUS_GM);
//   // var Neptune = AdjustBarycenterPosVel(
//   //     ssb, tt, Body.Neptune, NEPTUNE_GM);
//   // // Convert the planets' vectors from heliocentric to barycentric.
//   // Jupiter.r -= ssb.r;
//   // Jupiter.v -= ssb.v;
//   // Saturn.r -= ssb.r;
//   // Saturn.v -= ssb.v;
//   // Uranus.r -= ssb.r;
//   // Uranus.v -= ssb.v;
//   // Neptune.r -= ssb.r;
//   // Neptune.v -= ssb.v;
//   // // Convert heliocentric SSB to barycentric Sun.
//   // var Sun = body_state_t(tt, -1*ssb.r, -1*ssb.v);
// }

//     def Acceleration(self, pos):
//         '''Use barycentric coordinates of the Sun and major planets to calculate
//         the gravitational acceleration vector experienced at location 'pos'.'''
//         def AccelerationIncrement(small_pos, gm, major_pos):
//             delta = major_pos - small_pos
//             r2 = delta.quadrature()
//             return (gm / (r2 * sqrt(r2))) * delta

//         acc = AccelerationIncrement(pos, SUN_GM,     self.Sun.r)
//         acc += AccelerationIncrement(pos, JUPITER_GM, self.Jupiter.r)
//         acc += AccelerationIncrement(pos, SATURN_GM,  self.Saturn.r)
//         acc += AccelerationIncrement(pos, URANUS_GM,  self.Uranus.r)
//         acc += AccelerationIncrement(pos, NEPTUNE_GM, self.Neptune.r)
//         return acc


// def AdjustBarycenterPosVel(ssb, tt, body, planet_gm):
//     shift = planet_gm / (planet_gm + SUN_GM)
//     planet = CalcVsopPosVel(vsop[body.value], tt)
//     ssb.r += shift * planet.r
//     ssb.v += shift * planet.v
//     return planet

// def AdjustBarycenter(ssb, time, body, pmass):
//     shift = pmass / (pmass + SUN_GM)
//     planet = CalcVsop(vsop87[body.value], time)
//     ssb.x += shift * planet.x
//     ssb.y += shift * planet.y
//     ssb.z += shift * planet.z

// def CalcSolarSystemBarycenter(time):
//     ssb = Vector(0.0, 0.0, 0.0, time)
//     AdjustBarycenter(ssb, time, Body.Jupiter, JUPITER_GM)
//     AdjustBarycenter(ssb, time, Body.Saturn,  SATURN_GM)
//     AdjustBarycenter(ssb, time, Body.Uranus,  URANUS_GM)
//     AdjustBarycenter(ssb, time, Body.Neptune, NEPTUNE_GM)
//     return ssb