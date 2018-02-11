package com.sirolf2009.debugoffice.calc.component

import com.sirolf2009.debugoffice.Spreadsheet
import java.util.List

class CalcNamedNumberList extends AbstractCalcComponent<List<Double>> {

	val CalcLabel title
	val CalcNumberList list

	new(Spreadsheet spreadsheet, int x, int y, int width, int height, String text, CalcDirection direction) {
		super(spreadsheet, x, y, width, height)
		title = new CalcLabel(spreadsheet, x, y, 1, 1)
		title.update(text)
		if(direction == CalcDirection.VERTICAL) {
			list = new CalcNumberList(spreadsheet, x, y + 1, width, height - 1, direction)
		} else {
			list = new CalcNumberList(spreadsheet, x + 1, y, width - 1, height, direction)
		}
	}

	override update(List<Double> values) {
		list.update(values)
	}

}
