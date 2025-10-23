Check_code: /items[id2]/value/defining_code matches {[ac3]}

$extended_validity:Boolean ::= /data[id2]/events[id3]/data[id4]/items[id5]/value/magnitude matches {|0.0..30.0|}
$extended_validity_2:Boolean ::= /data[id2]/events[id3]/data[id4]/items[id5]/value/magnitude - 3 matches {|0.0..30.0|}
$variable:Real ::= /data[id2]/events[id3]/data[id4]/items[id5]/value/magnitude
$variable_matches: Boolean ::= $variable matches {|0.0..30.0|}
