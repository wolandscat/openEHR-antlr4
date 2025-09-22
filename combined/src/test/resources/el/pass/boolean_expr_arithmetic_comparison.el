$is_smoker := $was_previous_smoker AND $tobacco_consumption > 0 ;

$at_risk_ht2 :=  $is_male AND (current_date() - $date_of_birth) > P50Y ;

$at_risk_ht := (current_date() - $date_of_birth) > P50Y AND $is_male ;

Result := (tnm_t = "1b" and tnm_n = 0) ;

boolean_false_test := 3 > 5 + 6 * 7 + 3 * 23 + 8 / (1 + 2) ;

v := (3 < 5 OR 2 > 1) AND 1 = 1 ;

