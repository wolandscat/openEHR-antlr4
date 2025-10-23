score := Result.add (
        ---------------------------------------------
        basic.gender = #male                 ? 1 : 0,
        age_score                                   ,
        has_congestive_heart_failure         ? 1 : 0,
        has_hypertension                     ? 1 : 0,
        has_stroke_TIA_thromboembolism       ? 2 : 0,
        has_vascular_disease                 ? 1 : 0,
        has_diabetes                         ? 1 : 0
        ---------------------------------------------
    )
    ;