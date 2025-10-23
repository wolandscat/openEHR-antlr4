path_systolic: exists /data[id2]/events[id3]/data[id4]/items[id5]/value/magnitude implies exists /data[id2]/events[id3]/data[id4]/items[id6]/value/magnitude
must_exist: every $event in /data[id2]/events[id3] (exists $event/data[id4]/items[id5]/value/magnitude implies exists $event/data[id4]/items[id6]/value/magnitude)
must_set_value: every $event in /data[id2]/events[id3] ($event/data[id4]/items[id5]/value/magnitude > 3 implies $event/data[id4]/items[id6]/value/magnitude = 6)
