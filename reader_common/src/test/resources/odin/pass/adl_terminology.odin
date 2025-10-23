	term_definitions = <
		["en"] = <
			["id1"] = <
				text = <"Intravascular pressure">
				description = <"The pressure in a specific location, blood vessel or heart cavity, at a specific phase of the heart or an average over the heart cycle.">
			>
			["id3"] = <
				text = <"Any event">
				description = <"Generic event.">
			>
			["id5"] = <
				text = <"Average over heart cycle">
				description = <"The average over one heart cycle.">
			>
			["id6"] = <
				text = <"Pressure">
				description = <"The mean pressure measured.">
			>
			["id8"] = <
				text = <"Phase of heart cycle">
				description = <"The phase of the heart cycle at the time of the measurement">
			>
			["at9"] = <
				text = <"Systolic">
				description = <"During contraction of the heart.">
			>
			["at10"] = <
				text = <"Diastolic">
				description = <"During relaxation of the heart.">
			>
			["id16"] = <
				text = <"Relative pressure">
				description = <"The pressure in relative terms.">
			>
			["at17"] = <
				text = <"Markedly reduced">
				description = <"The pressure is much lower than normal or expected.">
			>
			["at18"] = <
				text = <"Lowered">
				description = <"The pressure is reduced.">
			>
			["at19"] = <
				text = <"Normal/expected">
				description = <"The pressure is normal or as expected.">
			>
			["at20"] = <
				text = <"raised">
				description = <"The pressure is raised.">
			>
			["at21"] = <
				text = <"Markedly increased">
				description = <"The pressure is much higher than normal or expected.">
			>
			["at24"] = <
				text = <"Pre-systolic">
				description = <"Phase of the heart immediately prior to contraction of the heart.">
			>
			["at25"] = <
				text = <"Pre-diastolic">
				description = <"The phase of the heart immediately prior to filling of the ventricle.">
			>
			["at28"] = <
				text = <"Whole cycle">
				description = <"The pressure measueerd is over the whole heart cycle.">
			>
			["id31"] = <
				text = <"Device">
				description = <"The device used to record the measurement.">
			>
			["id34"] = <
				text = <"Waveform">
				description = <"A waveform representation of the pressure">
			>
			["id35"] = <
				text = <"Multimedia">
				description = <"A multimedia representation of the pressure reading, other than waveforms.">
			>
			["id36"] = <
				text = <"Comment">
				description = <"A text comment on the reading.">
			>
			["id37"] = <
				text = <"Location">
				description = <"The location of the pressure measurement.">
			>
			["id40"] = <
				text = <"Position">
				description = <"Position of patient during measurement.">
			>
			["id41"] = <
				text = <"Confounding factors">
				description = <"Other factors that may interfere with interpretation of the measurement.">
			>
			["ac1"] = <
				text = <"Phase of heart cycle (synthesised)">
				description = <"The phase of the heart cycle at the time of the measurement (synthesised)">
			>
			["at29"] = <
				text = <"Pressure">
				description = <"Pressure">
			>
			["at30"] = <
				text = <"mean">
				description = <"mean">
			>
			["ac2"] = <
				text = <"Relative pressure">
				description = <"The pressure in relative terms.">
			>
			["ac3"] = <
				text = <"Relative pressure (synthesised)">
				description = <"The pressure in relative terms. (synthesised)">
			>
		>
	>
	term_bindings = <
		["openehr"] = <
			["at29"] = <http://openehr.org/id/125>
			["at30"] = <http://openehr.org/id/146>
		>
	>
	value_sets = <
		["ac1"] = <
			id = <"ac1">
			members = <"at9", "at10", "at24", "at25", "at28">
		>
		["ac2"] = <
			id = <"ac2">
			members = <"at17", "at18", "at19", "at20", "at21">
		>
		["ac3"] = <
			id = <"ac3">
			members = <"at17", "at18", "at19", "at20", "at21">
		>
	>
