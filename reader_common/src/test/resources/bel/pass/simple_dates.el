$dateOfBirth: Date := 2014-09-07
$lastEpisode: DateTime
$lastVisit: DateTime

$visitRequired:Boolean := $lastEpisode > $lastVisit

$age:Duration := currentDate() - $dateOfBirth
