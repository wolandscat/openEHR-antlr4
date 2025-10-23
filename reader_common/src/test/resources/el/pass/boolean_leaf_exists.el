$systolic:Real;

$diastolic:Real;

path_systolic: assert defined ($systolic) ;
for_all_systolic: assert for_all event : $events ¦ event.abc = 4 ;

