open Printf

module RD = Crlibm.RoundDown
module RU = Crlibm.RoundUp

let pi = acos(-1.)

let () =
  printf "cos(%.17f) ≈ %g (rounded to the nearest)\n" pi (cos pi);
  let cos_dw = RD.cos pi and cos_up = RU.cos pi in
  printf "cos(%.17f) ∈ [%.17f, %.17f]\n" pi cos_dw cos_up;
  printf "                           (width: %g)\n" (cos_up -. cos_dw);
  printf "cos(π) =: cospi(1.) ∈ [%g, %g]\n" (RD.cospi 1.) (RU.cospi 1.);
  printf "acos(-1)/π =: acospi(-1.) = %g\n" (Crlibm.acospi (-1.))

let () =
  let exp_dw = RD.exp (-1.) and exp_up = RU.exp (-1.) in
  printf "exp(-1.) ∈ [%.17f, %.17f]\n" exp_dw exp_up;
  printf "           (width: %g)\n" (exp_up -. exp_dw);
