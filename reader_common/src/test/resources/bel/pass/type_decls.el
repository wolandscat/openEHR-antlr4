-- variable declarations including generic types
$bp_list: List<Quantity>
$bp: Quantity
$heart_rate_series: Hash<String, TimeSeries<Quantity>>

-- constant declarations
Mph_to_kmh_factor: Real = 1.6
Pounds_to_kg: Real = 0.4536
Theatre_dates: Interval<Date> = |2021-04-02..2021-04-15|
