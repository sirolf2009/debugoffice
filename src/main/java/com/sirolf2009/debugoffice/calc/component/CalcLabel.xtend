package com.sirolf2009.debugoffice.calc.component

import com.sirolf2009.debugoffice.calc.component.AbstractCalcComponent
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor

@FinalFieldsConstructor class CalcLabel extends AbstractCalcComponent<String> {
	
	override update(String text) {
		set(0, 0, text)
	}
	
}