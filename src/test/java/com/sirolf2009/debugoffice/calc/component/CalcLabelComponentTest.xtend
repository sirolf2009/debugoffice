package com.sirolf2009.debugoffice.calc.component

import com.sirolf2009.debugoffice.calc.SpreadsheetTest
import org.junit.Test

class CalcLabelComponentTest extends SpreadsheetTest {

	@Test
	def void testLabel() {
		spreadsheet [
			(0 .. 9).forEach [ x |
				(0 .. 9).forEach [ y |
					new CalcLabel(it, x, y, 1, 1) => [
						update('''(«x», «y»)''')
					]
				]
			]
		]
	}

}
