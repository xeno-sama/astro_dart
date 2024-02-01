import 'complex.dart';

List vars(ex, dlam, ds, gam1c, sinpi) {
  Complex z;
  z = ex[4][4];
  dlam += 13.902 * z.imaginary;
  ds += 14.06 * z.imaginary;
  gam1c += -0.001 * z.real;
  sinpi += 0.2607 * z.real;

  z = ex[3][4];
  dlam += 0.403 * z.imaginary;
  ds += -4.01 * z.imaginary;
  gam1c += 0.394 * z.real;
  sinpi += 0.0023 * z.real;

  z = ex[2][4];
  dlam += 2369.912 * z.imaginary;
  ds += 2373.36 * z.imaginary;
  gam1c += 0.601 * z.real;
  sinpi += 28.2333 * z.real;

  z = ex[1][4];
  dlam += -125.154 * z.imaginary;
  ds += -112.79 * z.imaginary;
  gam1c += -0.725 * z.real;
  sinpi += -0.9781 * z.real;

  z = ex[1][1] * ex[4][4];
  dlam += 1.979 * z.imaginary;
  ds += 6.98 * z.imaginary;
  gam1c += -0.445 * z.real;
  sinpi += 0.0433 * z.real;

  z = ex[1][1] * ex[2][4];
  dlam += 191.953 * z.imaginary;
  ds += 192.72 * z.imaginary;
  gam1c += 0.029 * z.real;
  sinpi += 3.0861 * z.real;

  z = ex[1][1] * ex[1][4];
  dlam += -8.466 * z.imaginary;
  ds += -13.51 * z.imaginary;
  gam1c += 0.455 * z.real;
  sinpi += -0.1093 * z.real;

  z = ex[1][1];
  dlam += 22639.500 * z.imaginary;
  ds += 22609.07 * z.imaginary;
  gam1c += 0.079 * z.real;
  sinpi += 186.5398 * z.real;

  z = ex[1][1] * ex[-1][4];
  dlam += 18.609 * z.imaginary;
  ds += 3.59 * z.imaginary;
  gam1c += -0.094 * z.real;
  sinpi += 0.0118 * z.real;

  z = ex[1][1] * ex[-2][4];
  dlam += -4586.465 * z.imaginary;
  ds += -4578.13 * z.imaginary;
  gam1c += -0.077 * z.real;
  sinpi += 34.3117 * z.real;

  z = ex[1][1] * ex[-3][4];
  dlam += 3.215 * z.imaginary;
  ds += 5.44 * z.imaginary;
  gam1c += 0.192 * z.real;
  sinpi += -0.0386 * z.real;

  z = ex[1][1] * ex[-4][4];
  dlam += -38.428 * z.imaginary;
  ds += -38.64 * z.imaginary;
  gam1c += 0.001 * z.real;
  sinpi += 0.6008 * z.real;

  z = ex[1][1] * ex[-6][4];
  dlam += -0.393 * z.imaginary;
  ds += -1.43 * z.imaginary;
  gam1c += -0.092 * z.real;
  sinpi += 0.0086 * z.real;

  z = ex[1][2] * ex[4][4];
  dlam += -0.289 * z.imaginary;
  ds += -1.59 * z.imaginary;
  gam1c += 0.123 * z.real;
  sinpi += -0.0053 * z.real;

  z = ex[1][2] * ex[2][4];
  dlam += -24.420 * z.imaginary;
  ds += -25.10 * z.imaginary;
  gam1c += 0.040 * z.real;
  sinpi += -0.3000 * z.real;

  z = ex[1][2] * ex[1][4];
  dlam += 18.023 * z.imaginary;
  ds += 17.93 * z.imaginary;
  gam1c += 0.007 * z.real;
  sinpi += 0.1494 * z.real;

  z = ex[1][2];
  dlam += -668.146 * z.imaginary;
  ds += -126.98 * z.imaginary;
  gam1c += -1.302 * z.real;
  sinpi += -0.3997 * z.real;

  z = ex[1][2] * ex[-1][4];
  dlam += 0.560 * z.imaginary;
  ds += 0.32 * z.imaginary;
  gam1c += -0.001 * z.real;
  sinpi += -0.0037 * z.real;

  z = ex[1][2] * ex[-2][4];
  dlam += -165.145 * z.imaginary;
  ds += -165.06 * z.imaginary;
  gam1c += 0.054 * z.real;
  sinpi += 1.9178 * z.real;

  z = ex[1][2] * ex[-4][4];
  dlam += -1.877 * z.imaginary;
  ds += -6.46 * z.imaginary;
  gam1c += -0.416 * z.real;
  sinpi += 0.0339 * z.real;

  z = ex[2][1] * ex[4][4];
  dlam += 0.213 * z.imaginary;
  ds += 1.02 * z.imaginary;
  gam1c += -0.074 * z.real;
  sinpi += 0.0054 * z.real;

  z = ex[2][1] * ex[2][4];
  dlam += 14.387 * z.imaginary;
  ds += 14.78 * z.imaginary;
  gam1c += -0.017 * z.real;
  sinpi += 0.2833 * z.real;

  z = ex[2][1] * ex[1][4];
  dlam += -0.586 * z.imaginary;
  ds += -1.20 * z.imaginary;
  gam1c += 0.054 * z.real;
  sinpi += -0.0100 * z.real;

  z = ex[2][1];
  dlam += 769.016 * z.imaginary;
  ds += 767.96 * z.imaginary;
  gam1c += 0.107 * z.real;
  sinpi += 10.1657 * z.real;

  z = ex[2][1] * ex[-1][4];
  dlam += 1.750 * z.imaginary;
  ds += 2.01 * z.imaginary;
  gam1c += -0.018 * z.real;
  sinpi += 0.0155 * z.real;

  z = ex[2][1] * ex[-2][4];
  dlam += -211.656 * z.imaginary;
  ds += -152.53 * z.imaginary;
  gam1c += 5.679 * z.real;
  sinpi += -0.3039 * z.real;

  z = ex[2][1] * ex[-3][4];
  dlam += 1.225 * z.imaginary;
  ds += 0.91 * z.imaginary;
  gam1c += -0.030 * z.real;
  sinpi += -0.0088 * z.real;

  z = ex[2][1] * ex[-4][4];
  dlam += -30.773 * z.imaginary;
  ds += -34.07 * z.imaginary;
  gam1c += -0.308 * z.real;
  sinpi += 0.3722 * z.real;

  z = ex[2][1] * ex[-6][4];
  dlam += -0.570 * z.imaginary;
  ds += -1.40 * z.imaginary;
  gam1c += -0.074 * z.real;
  sinpi += 0.0109 * z.real;

  z = ex[1][1] * ex[1][2] * ex[2][4];
  dlam += -2.921 * z.imaginary;
  ds += -11.75 * z.imaginary;
  gam1c += 0.787 * z.real;
  sinpi += -0.0484 * z.real;

  z = ex[1][1] * ex[1][2] * ex[1][4];
  dlam += 1.267 * z.imaginary;
  ds += 1.52 * z.imaginary;
  gam1c += -0.022 * z.real;
  sinpi += 0.0164 * z.real;

  z = ex[1][1] * ex[1][2];
  dlam += -109.673 * z.imaginary;
  ds += -115.18 * z.imaginary;
  gam1c += 0.461 * z.real;
  sinpi += -0.9490 * z.real;

  z = ex[1][1] * ex[1][2] * ex[-2][4];
  dlam += -205.962 * z.imaginary;
  ds += -182.36 * z.imaginary;
  gam1c += 2.056 * z.real;
  sinpi += 1.4437 * z.real;

  z = ex[1][1] * ex[1][2] * ex[-3][4];
  dlam += 0.233 * z.imaginary;
  ds += 0.36 * z.imaginary;
  gam1c += 0.012 * z.real;
  sinpi += -0.0025 * z.real;

  z = ex[1][1] * ex[1][2] * ex[-4][4];
  dlam += -4.391 * z.imaginary;
  ds += -9.66 * z.imaginary;
  gam1c += -0.471 * z.real;
  sinpi += 0.0673 * z.real;

  z = ex[1][1] * ex[-1][2] * ex[4][4];
  dlam += 0.283 * z.imaginary;
  ds += 1.53 * z.imaginary;
  gam1c += -0.111 * z.real;
  sinpi += 0.0060 * z.real;

  z = ex[1][1] * ex[-1][2] * ex[2][4];
  dlam += 14.577 * z.imaginary;
  ds += 31.70 * z.imaginary;
  gam1c += -1.540 * z.real;
  sinpi += 0.2302 * z.real;

  z = ex[1][1] * ex[-1][2];
  dlam += 147.687 * z.imaginary;
  ds += 138.76 * z.imaginary;
  gam1c += 0.679 * z.real;
  sinpi += 1.1528 * z.real;

  z = ex[1][1] * ex[-1][2] * ex[-1][4];
  dlam += -1.089 * z.imaginary;
  ds += 0.55 * z.imaginary;
  gam1c += 0.021 * z.real;

  z = ex[1][1] * ex[-1][2] * ex[-2][4];
  dlam += 28.475 * z.imaginary;
  ds += 23.59 * z.imaginary;
  gam1c += -0.443 * z.real;
  sinpi += -0.2257 * z.real;

  z = ex[1][1] * ex[-1][2] * ex[-3][4];
  dlam += -0.276 * z.imaginary;
  ds += -0.38 * z.imaginary;
  gam1c += -0.006 * z.real;
  sinpi += -0.0036 * z.real;

  z = ex[1][1] * ex[-1][2] * ex[-4][4];
  dlam += 0.636 * z.imaginary;
  ds += 2.27 * z.imaginary;
  gam1c += 0.146 * z.real;
  sinpi += -0.0102 * z.real;

  z = ex[2][2] * ex[2][4];
  dlam += -0.189 * z.imaginary;
  ds += -1.68 * z.imaginary;
  gam1c += 0.131 * z.real;
  sinpi += -0.0028 * z.real;

  z = ex[2][2];
  dlam += -7.486 * z.imaginary;
  ds += -0.66 * z.imaginary;
  gam1c += -0.037 * z.real;
  sinpi += -0.0086 * z.real;

  z = ex[2][2] * ex[-2][4];
  dlam += -8.096 * z.imaginary;
  ds += -16.35 * z.imaginary;
  gam1c += -0.740 * z.real;
  sinpi += 0.0918 * z.real;

  z = ex[2][3] * ex[2][4];
  dlam += -5.741 * z.imaginary;
  ds += -0.04 * z.imaginary;
  sinpi += -0.0009 * z.real;

  z = ex[2][3] * ex[1][4];
  dlam += 0.255 * z.imaginary;

  z = ex[2][3];
  dlam += -411.608 * z.imaginary;
  ds += -0.20 * z.imaginary;
  sinpi += -0.0124 * z.real;

  z = ex[2][3] * ex[-1][4];
  dlam += 0.584 * z.imaginary;
  ds += 0.84 * z.imaginary;
  sinpi += 0.0071 * z.real;

  z = ex[2][3] * ex[-2][4];
  dlam += -55.173 * z.imaginary;
  ds += -52.14 * z.imaginary;
  sinpi += -0.1052 * z.real;

  z = ex[2][3] * ex[-3][4];
  dlam += 0.254 * z.imaginary;
  ds += 0.25 * z.imaginary;
  sinpi += -0.0017 * z.real;

  z = ex[2][3] * ex[-4][4];
  dlam += 0.025 * z.imaginary;
  ds += -1.67 * z.imaginary;
  sinpi += 0.0031 * z.real;

  z = ex[3][1] * ex[2][4];
  dlam += 1.060 * z.imaginary;
  ds += 2.96 * z.imaginary;
  gam1c += -0.166 * z.real;
  sinpi += 0.0243 * z.real;

  z = ex[3][1];
  dlam += 36.124 * z.imaginary;
  ds += 50.64 * z.imaginary;
  gam1c += -1.300 * z.real;
  sinpi += 0.6215 * z.real;

  z = ex[3][1] * ex[-2][4];
  dlam += -13.193 * z.imaginary;
  ds += -16.40 * z.imaginary;
  gam1c += 0.258 * z.real;
  sinpi += -0.1187 * z.real;

  z = ex[3][1] * ex[-4][4];
  dlam += -1.187 * z.imaginary;
  ds += -0.74 * z.imaginary;
  gam1c += 0.042 * z.real;
  sinpi += 0.0074 * z.real;

  z = ex[3][1] * ex[-6][4];
  dlam += -0.293 * z.imaginary;
  ds += -0.31 * z.imaginary;
  gam1c += -0.002 * z.real;
  sinpi += 0.0046 * z.real;

  z = ex[2][1] * ex[1][2] * ex[2][4];
  dlam += -0.290 * z.imaginary;
  ds += -1.45 * z.imaginary;
  gam1c += 0.116 * z.real;
  sinpi += -0.0051 * z.real;

  z = ex[2][1] * ex[1][2];
  dlam += -7.649 * z.imaginary;
  ds += -10.56 * z.imaginary;
  gam1c += 0.259 * z.real;
  sinpi += -0.1038 * z.real;

  z = ex[2][1] * ex[1][2] * ex[-2][4];
  dlam += -8.627 * z.imaginary;
  ds += -7.59 * z.imaginary;
  gam1c += 0.078 * z.real;
  sinpi += -0.0192 * z.real;

  z = ex[2][1] * ex[1][2] * ex[-4][4];
  dlam += -2.740 * z.imaginary;
  ds += -2.54 * z.imaginary;
  gam1c += 0.022 * z.real;
  sinpi += 0.0324 * z.real;

  z = ex[2][1] * ex[-1][2] * ex[2][4];
  dlam += 1.181 * z.imaginary;
  ds += 3.32 * z.imaginary;
  gam1c += -0.212 * z.real;
  sinpi += 0.0213 * z.real;

  z = ex[2][1] * ex[-1][2];
  dlam += 9.703 * z.imaginary;
  ds += 11.67 * z.imaginary;
  gam1c += -0.151 * z.real;
  sinpi += 0.1268 * z.real;

  z = ex[2][1] * ex[-1][2] * ex[-1][4];
  dlam += -0.352 * z.imaginary;
  ds += -0.37 * z.imaginary;
  gam1c += 0.001 * z.real;
  sinpi += -0.0028 * z.real;

  z = ex[2][1] * ex[-1][2] * ex[-2][4];
  dlam += -2.494 * z.imaginary;
  ds += -1.17 * z.imaginary;
  gam1c += -0.003 * z.real;
  sinpi += -0.0017 * z.real;

  z = ex[2][1] * ex[-1][2] * ex[-4][4];
  dlam += 0.360 * z.imaginary;
  ds += 0.20 * z.imaginary;
  gam1c += -0.012 * z.real;
  sinpi += -0.0043 * z.real;

  z = ex[1][1] * ex[2][2];
  dlam += -1.167 * z.imaginary;
  ds += -1.25 * z.imaginary;
  gam1c += 0.008 * z.real;
  sinpi += -0.0106 * z.real;

  z = ex[1][1] * ex[2][2] * ex[-2][4];
  dlam += -7.412 * z.imaginary;
  ds += -6.12 * z.imaginary;
  gam1c += 0.117 * z.real;
  sinpi += 0.0484 * z.real;

  z = ex[1][1] * ex[2][2] * ex[-4][4];
  dlam += -0.311 * z.imaginary;
  ds += -0.65 * z.imaginary;
  gam1c += -0.032 * z.real;
  sinpi += 0.0044 * z.real;

  z = ex[1][1] * ex[-2][2] * ex[2][4];
  dlam += 0.757 * z.imaginary;
  ds += 1.82 * z.imaginary;
  gam1c += -0.105 * z.real;
  sinpi += 0.0112 * z.real;

  z = ex[1][1] * ex[-2][2];
  dlam += 2.580 * z.imaginary;
  ds += 2.32 * z.imaginary;
  gam1c += 0.027 * z.real;
  sinpi += 0.0196 * z.real;

  z = ex[1][1] * ex[-2][2] * ex[-2][4];
  dlam += 2.533 * z.imaginary;
  ds += 2.40 * z.imaginary;
  gam1c += -0.014 * z.real;
  sinpi += -0.0212 * z.real;

  z = ex[3][2] * ex[-2][4];
  dlam += -0.344 * z.imaginary;
  ds += -0.57 * z.imaginary;
  gam1c += -0.025 * z.real;
  sinpi += 0.0036 * z.real;

  z = ex[1][1] * ex[2][3] * ex[2][4];
  dlam += -0.992 * z.imaginary;
  ds += -0.02 * z.imaginary;

  z = ex[1][1] * ex[2][3];
  dlam += -45.099 * z.imaginary;
  ds += -0.02 * z.imaginary;
  sinpi += -0.0010 * z.real;

  z = ex[1][1] * ex[2][3] * ex[-2][4];
  dlam += -0.179 * z.imaginary;
  ds += -9.52 * z.imaginary;
  sinpi += -0.0833 * z.real;

  z = ex[1][1] * ex[2][3] * ex[-4][4];
  dlam += -0.301 * z.imaginary;
  ds += -0.33 * z.imaginary;
  sinpi += 0.0014 * z.real;

  z = ex[1][1] * ex[-2][3] * ex[2][4];
  dlam += -6.382 * z.imaginary;
  ds += -3.37 * z.imaginary;
  sinpi += -0.0481 * z.real;

  z = ex[1][1] * ex[-2][3];
  dlam += 39.528 * z.imaginary;
  ds += 85.13 * z.imaginary;
  sinpi += -0.7136 * z.real;

  z = ex[1][1] * ex[-2][3] * ex[-2][4];
  dlam += 9.366 * z.imaginary;
  ds += 0.71 * z.imaginary;
  sinpi += -0.0112 * z.real;

  z = ex[1][1] * ex[-2][3] * ex[-4][4];
  dlam += 0.202 * z.imaginary;
  ds += 0.02 * z.imaginary;

  z = ex[1][2] * ex[2][3];
  dlam += 0.415 * z.imaginary;
  ds += 0.10 * z.imaginary;
  sinpi += 0.0013 * z.real;

  z = ex[1][2] * ex[2][3] * ex[-2][4];
  dlam += -2.152 * z.imaginary;
  ds += -2.26 * z.imaginary;
  sinpi += -0.0066 * z.real;

  z = ex[1][2] * ex[-2][3] * ex[2][4];
  dlam += -1.440 * z.imaginary;
  ds += -1.30 * z.imaginary;
  sinpi += 0.0014 * z.real;

  z = ex[1][2] * ex[-2][3] * ex[-2][4];
  dlam += 0.384 * z.imaginary;
  ds += -0.04 * z.imaginary;

  z = ex[4][1];
  dlam += 1.938 * z.imaginary;
  ds += 3.60 * z.imaginary;
  gam1c += -0.145 * z.real;
  sinpi += 0.0401 * z.real;

  z = ex[4][1] * ex[-2][4];
  dlam += -0.952 * z.imaginary;
  ds += -1.58 * z.imaginary;
  gam1c += 0.052 * z.real;
  sinpi += -0.0130 * z.real;

  z = ex[3][1] * ex[1][2];
  dlam += -0.551 * z.imaginary;
  ds += -0.94 * z.imaginary;
  gam1c += 0.032 * z.real;
  sinpi += -0.0097 * z.real;

  z = ex[3][1] * ex[1][2] * ex[-2][4];
  dlam += -0.482 * z.imaginary;
  ds += -0.57 * z.imaginary;
  gam1c += 0.005 * z.real;
  sinpi += -0.0045 * z.real;

  z = ex[3][1] * ex[-1][2];
  dlam += 0.681 * z.imaginary;
  ds += 0.96 * z.imaginary;
  gam1c += -0.026 * z.real;
  sinpi += 0.0115 * z.real;

  z = ex[2][1] * ex[2][2] * ex[-2][4];
  dlam += -0.297 * z.imaginary;
  ds += -0.27 * z.imaginary;
  gam1c += 0.002 * z.real;
  sinpi += -0.0009 * z.real;

  z = ex[2][1] * ex[-2][2] * ex[-2][4];
  dlam += 0.254 * z.imaginary;
  ds += 0.21 * z.imaginary;
  gam1c += -0.003 * z.real;

  z = ex[1][1] * ex[3][2] * ex[-2][4];
  dlam += -0.250 * z.imaginary;
  ds += -0.22 * z.imaginary;
  gam1c += 0.004 * z.real;
  sinpi += 0.0014 * z.real;

  z = ex[2][1] * ex[2][3];
  dlam += -3.996 * z.imaginary;
  sinpi += 0.0004 * z.real;

  z = ex[2][1] * ex[2][3] * ex[-2][4];
  dlam += 0.557 * z.imaginary;
  ds += -0.75 * z.imaginary;
  sinpi += -0.0090 * z.real;

  z = ex[2][1] * ex[-2][3] * ex[2][4];
  dlam += -0.459 * z.imaginary;
  ds += -0.38 * z.imaginary;
  sinpi += -0.0053 * z.real;

  z = ex[2][1] * ex[-2][3];
  dlam += -1.298 * z.imaginary;
  ds += 0.74 * z.imaginary;
  sinpi += 0.0004 * z.real;

  z = ex[2][1] * ex[-2][3] * ex[-2][4];
  dlam += 0.538 * z.imaginary;
  ds += 1.14 * z.imaginary;
  sinpi += -0.0141 * z.real;

  z = ex[1][1] * ex[1][2] * ex[2][3];
  dlam += 0.263 * z.imaginary;
  ds += 0.02 * z.imaginary;

  z = ex[1][1] * ex[1][2] * ex[-2][3] * ex[-2][4];
  dlam += 0.426 * z.imaginary;
  ds += 0.07 * z.imaginary;
  sinpi += -0.0006 * z.real;

  z = ex[1][1] * ex[-1][2] * ex[2][3];
  dlam += -0.304 * z.imaginary;
  ds += 0.03 * z.imaginary;
  sinpi += 0.0003 * z.real;

  z = ex[1][1] * ex[-1][2] * ex[-2][3] * ex[2][4];
  dlam += -0.372 * z.imaginary;
  ds += -0.19 * z.imaginary;
  sinpi += -0.0027 * z.real;

  z = ex[4][3];
  dlam += 0.418 * z.imaginary;

  z = ex[3][1] * ex[2][3];
  dlam += -0.330 * z.imaginary;
  ds += -0.04 * z.imaginary;

  return [dlam, ds, gam1c, sinpi];
}
