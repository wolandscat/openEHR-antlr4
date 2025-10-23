$systolic:Real ::= /data[id2]/events[id3]/data[id4]/items[id5]/value/magnitude

$diastolic:Real ::= /data[id2]/events[id3]/data[id4]/items[id6]/value/magnitude

path_systolic: exists /data[id2]/events[id3]/data[id4]/items[id5]/value/magnitude
path_diastolic: exists /data[id2]/events[id3]/data[id4]/items[id6]/value/magnitude
for_all_systolic: for_all $event in /data[id2]/events[id3] | exists $event/data[id4]/items[id5]/value/magnitude
