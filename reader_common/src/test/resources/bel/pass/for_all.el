$bp_list: List<Quantity> ::= /x/y/z
check_bps: for_all $bp in $bp_list $bp > 120

check_field_vals: for_all $event in /data[id2]/events[id3]
    $event/data[id4]/items[id7]/value/magnitude =
		$event/data[id4]/items[id5]/value/magnitude - $event/data[id4]/items[id6]/value/magnitude
