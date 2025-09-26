    Result := case ipi_raw_score in
        =======================================
        |0..1|  : #ipi_low_risk,
        |2|     : #ipi_intermediate_low_risk,
        |3|     : #ipi_intermediate_high_risk,
        |4..5|  : #ipi_high_risk
        =======================================
    ;