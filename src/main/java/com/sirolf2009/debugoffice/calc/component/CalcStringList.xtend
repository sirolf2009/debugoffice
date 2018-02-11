package com.sirolf2009.debugoffice.calc.component

import java.util.List
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor

@FinalFieldsConstructor class CalcStringList extends AbstractCalcComponent<List<String>> {

	val CalcDirection direction

	override update(List<String> values) {
		if(direction == CalcDirection.HORIZONTAL) {
			values.forEach [ value, index |
				set(index, 0, value)
			]
		} else {
			values.forEach [ value, index |
				set(0, index, value)
			]
		}
	}

}