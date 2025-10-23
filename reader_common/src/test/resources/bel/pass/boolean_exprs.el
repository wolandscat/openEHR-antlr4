$is_smoker := $was_previous_smoker AND $tobacco_consumption > 0

$at_risk_ht := ($current_date - $date_of_birth) > P50Y AND $is_male

$at_risk_ht2 :=  $is_male AND ($current_date - $date_of_birth) > P50Y
