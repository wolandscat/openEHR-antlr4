$max:Real ::= max(1.0, 2.0)

$min:Real ::= min(10.0, 3.0)

$flat_sum:Real ::= flat_sum(/data[id2]/events[id3]/data[id4]/items[id5]/value/magnitude, /data[id2]/events[id3]/data[id4]/items[id6]/value/magnitude, 3.3)
$sum:Real ::= sum(/data[id2]/events[id3]/data[id4]/items[id5]/value/magnitude, /data[id2]/events[id3]/data[id4]/items[id6]/value/magnitude, 3.3)
$mean:Real ::= mean(/data[id2]/events[id3]/data[id4]/items[id5]/value/magnitude, /data[id2]/events[id3]/data[id4]/items[id6]/value/magnitude, 3.3)

$value_when_undefined:Real ::= value_when_undefined(10.0, /data[id2]/events[id3]/data[id4]/items[id5]/value/magnitude)

$value_when_undefined_2:Real ::=
    value_when_undefined(10.0, /data[id2]/events[id3]/data[id4]/items[id5]/value/magnitude) +
    max(1.0, 2.0)

$round_up:Integer ::= round(3.0 / 2.0)
$round_down:Integer ::= round(4.0 / 3.0)
$round_non_decimal:Integer ::= round(3)
$round_multiple:Integer ::= round(/data[id2]/events[id3]/data[id4]/items[id5]/value/magnitude)

$ceil_path:Integer ::= ceil(/data[id2]/events[id3]/data[id4]/items[id5]/value/magnitude / 2.0)
$floor_path:Integer ::= floor(/data[id2]/events[id3]/data[id4]/items[id5]/value/magnitude / 2.0)