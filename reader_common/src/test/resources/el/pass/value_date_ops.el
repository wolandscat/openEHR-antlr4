$dateOfBirth: Date := 2014-09-07;

$visitRequired:Boolean := $lastEpisode > $lastVisit;

$age:Duration := currentDate() - $dateOfBirth;
