$event: List<Event> ::= /data[id2]/events[id3]

Check_field_vals: $event/data[id4]/items[id7]/value/magnitude =
		$event/data[id4]/items[id5]/value/magnitude - $event/data[id4]/items[id6]/value/magnitude
