Result := cyclophosphamide_dose_per_m2 * {BSA}.bsa_m2
    * case platelets.range in
        ===================
        #normal:      1,
        #low:         0.75
        ===================
    * case gfr.range in
        ===================
        #normal:      1,
        #low:         0.75,
        #very_low:    0.5
        ===================
    ;