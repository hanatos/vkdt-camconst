# vkdt camera profiles

this repository collects user-contributed camera data. in particular,
we are interested in:

* noise profiles, created with the `noise-profile.sh` in the vkdt repository (`data/nprof/${maker}-${model}-${iso}.nprof`)
* input device transform luts, created by `vkdt-mkclut` from spectral measurements, colour checker shots, or dng profiles (`data/${maker} ${model}.lut`)
* spectral CFA response curves if available
