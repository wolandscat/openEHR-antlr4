$arithmetic_test:Integer ::= 3 * 5 + 2 * 2 - 15 + 4
$boolean_false_test:Boolean ::= 3 > 5 + 6 * 7 + 3 * 23 + 8 / (1 + 2)
$boolean_true_test:Boolean ::= 3 < 5 + 6 * 7 + 3 * 23 + 8 / (1 + 2)
$boolean_extended_test:Boolean ::= (3 < 5 OR 2 > 1) AND 1 = 1
$not_false:Boolean ::= not false
$not_not_not_true:Boolean ::= ¬~! true
$variable_reference:Integer ::= $arithmetic_test % 5
$arithmetic_parentheses:Integer ::= (3+2)*5
$exponent: Real ::= $base ^ 5 * 4 + $base2 ^ $exp1 ^ $exp2
