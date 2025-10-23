check_code: assert $abc matches {#ac3};

$extended_validity: Boolean := $baseline AND $abc ∈ {|0.0..30.0|} OR $other <= $otherLimit ;
$extended_validity_2: Boolean := ($abc - 3) matches {|0.0..30.0|} ;
$variable: Real := $abc ;
$variable_matches: Boolean := $variable ∈ {|0.0..30.0|} ;
