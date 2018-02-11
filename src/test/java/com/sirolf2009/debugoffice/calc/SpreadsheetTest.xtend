package com.sirolf2009.debugoffice.calc

import com.sirolf2009.debugoffice.Spreadsheet
import java.util.function.Consumer

class SpreadsheetTest {
	
	def void spreadsheet(Consumer<Spreadsheet> consumer) {
		new Spreadsheet("/opt/libreoffice6.0/program/") => [
			consumer.accept(it)
			Thread.sleep(2000)
			close()
		]
	}
	
}