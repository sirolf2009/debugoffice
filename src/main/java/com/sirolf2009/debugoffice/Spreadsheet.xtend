package com.sirolf2009.debugoffice

import com.sun.star.frame.XComponentLoader
import com.sun.star.sheet.XSpreadsheet
import com.sun.star.sheet.XSpreadsheetDocument
import com.sun.star.table.XCell
import com.sun.star.uno.UnoRuntime
import com.sun.star.uno.XComponentContext
import ooo.connector.BootstrapSocketConnector
import com.sun.star.beans.XPropertySet
import java.io.Closeable
import java.io.IOException
import com.sun.star.util.XCloseable

class Spreadsheet implements Closeable {
	
	val XComponentContext context
	val XComponentLoader loader
	val XSpreadsheetDocument spreadsheetDocument
	val XSpreadsheet spreadsheet
	
	new(String oooInstallationFolder) {
		context = BootstrapSocketConnector.bootstrap(oooInstallationFolder)
		val desktop = context.serviceManager.createInstanceWithContext("com.sun.star.frame.Desktop", context)
		loader = UnoRuntime.queryInterface(XComponentLoader, desktop)
		spreadsheetDocument = UnoRuntime.queryInterface(XSpreadsheetDocument, loader.loadComponentFromURL("private:factory/scalc", "_blank", 0, #[]))
		spreadsheet = UnoRuntime.queryInterface(XSpreadsheet, spreadsheetDocument.sheets.getByName("Sheet1"))
	}
	
	def set(int x, int y, String formula) {
		cell(x, y).formula = formula
	}
	
	def set(int x, int y, double value) {
		cell(x, y).value = value
	}
	
	def props(int x, int y) {
		cell(x, y).props
	}
	
	def set(XCell cell, String formula) {
		cell.formula = formula
	}
	
	def set(XCell cell, double value) {
		cell.value = value
	}
	
	def props(XCell cell) {
		return UnoRuntime.queryInterface(XPropertySet, cell) as XPropertySet
	}
	
	def cell(int x, int y) {
		return spreadsheet.getCellByPosition(x, y)
	}
	
	override close() throws IOException {
		val closable = UnoRuntime.queryInterface(XCloseable, spreadsheetDocument) as XCloseable
		closable.close(false)
	}
	
}