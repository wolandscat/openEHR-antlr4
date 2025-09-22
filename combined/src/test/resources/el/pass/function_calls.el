$max := max (1.0, 2.0);

$min := min (10.0, 3.0);

$flat_sum := flat_sum ($abc, $def, 3.3);
$sum := sum($abc, $def, 3.3);
$mean: Real := mean($abc, $def, 3.3);

$value_when_undefined: Real := value_when_undefined (10.0, $abc);

$value_when_undefined_2: Real := value_when_undefined(10.0, $abc) + max(1.0, 2.0);

$round_up := round(3.0 / 2.0);
$round_down: Integer := round(4.0 / 3.0);
$round_non_decimal := round(3);
$round_multiple: Integer := round ($abce);

$ceil_path := ceil($abc / 2.0);
$floor_path := floor($abc / 2.0);