    |
    | International Prognostic Index
    | ref: https:|en.wikipedia.org/wiki/International_Prognostic_Index
    |
    | One point is assigned for each of the following risk factors:
    |     Age greater than 60 years
    |     Stage III or IV disease
    |     Elevated serum LDH
    |     ECOG/Zubrod performance status of 2, 3, or 4
    |     More than 1 extranodal site
    |
    | The sum of the points allotted correlates with the following risk groups:
    |     Low risk (0-1 points) - 5-year survival of 73%
    |     Low-intermediate risk (2 points) - 5-year survival of 51%
    |     High-intermediate risk (3 points) - 5-year survival of 43%
    |     High risk (4-5 points) - 5-year survival of 26%
    |
    Result := case ipi_raw_score in
        =======================================
        |0..1|  : #ipi_low_risk,
        |2|     : #ipi_intermediate_low_risk,
        |3|     : #ipi_intermediate_high_risk,
        |4..5|  : #ipi_high_risk
        =======================================
    ;