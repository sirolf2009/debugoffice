package com.sirolf2009.debugoffice.calc.component

import com.sirolf2009.debugoffice.calc.SpreadsheetTest
import org.junit.Test

class CalcNumberListComponentTest extends SpreadsheetTest {

	@Test
	def void testHorizontalList() {
		spreadsheet [
			new CalcNumberList(it, 0, 0, 10, 1, CalcDirection.HORIZONTAL) => [
				update(#[0d, 1d, 2d, 3d, 4d, 5d, 6d, 7d, 8d, 9d])
			]
			new CalcNumberList(it, 0, 1, 10, 1, CalcDirection.HORIZONTAL) => [
				update(#[0d, 1d, 2d, 3d, 4d, 5d, 6d, 7d, 8d, 9d].reverseView)
			]
		]
	}

	@Test
	def void testVerticalList() {
		spreadsheet [
			(0 .. 9).forEach [ index |
				new CalcNumberList(it, index, 0, 1, 10, CalcDirection.VERTICAL) => [
					update(#[0d, 1d, 2d, 3d, 4d, 5d, 6d, 7d, 8d, 9d])
				]
			]
		]
	}

}
