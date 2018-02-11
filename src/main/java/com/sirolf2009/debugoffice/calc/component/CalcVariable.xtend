package com.sirolf2009.debugoffice.calc.component

import com.sirolf2009.debugoffice.Spreadsheet
import com.sun.star.table.XCell

class CalcVariable extends AbstractCalcComponent<Double> {
	
	val CalcLabel title
	val XCell variable
	
	new(Spreadsheet spreadsheet, int x, int y, String text, CalcDirection direction) {
		this(spreadsheet, x, y, if(direction == CalcDirection.HORIZONTAL) 2 else 1, if(direction == CalcDirection.HORIZONTAL) 1 else 2, text, direction)
	}
	
	new(Spreadsheet spreadsheet, int x, int y, int width, int height, String text, CalcDirection direction) {
		super(spreadsheet, x, y, width, height)
		title = new CalcLabel(spreadsheet, x, y, 1, 1)
		title.update(text)
		if(direction == CalcDirection.VERTICAL) {
			variable = cell(x, y+1)
		} else {
			variable = cell(x+1, y)
		}
	}

	override update(Double value) {
		set(variable, value)
	}
	
}