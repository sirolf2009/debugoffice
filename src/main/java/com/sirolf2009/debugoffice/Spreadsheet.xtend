package com.sirolf2009.debugoffice

import com.sun.star.beans.XPropertySet
import com.sun.star.frame.XComponentLoader
import com.sun.star.sheet.XSpreadsheet
import com.sun.star.sheet.XSpreadsheetDocument
import com.sun.star.table.XCell
import com.sun.star.uno.UnoRuntime
import com.sun.star.uno.XComponentContext
import com.sun.star.util.XCloseable
import java.io.Closeable
import java.io.IOException
import java.util.function.Function
import ooo.connector.BootstrapSocketConnector
import java.io.File

class Spreadsheet implements Closeable {
	
	static val Function<XComponentLoader, XSpreadsheetDocument> NEW_FILE = [UnoRuntime.queryInterface(XSpreadsheetDocument, loadComponentFromURL("private:factory/scalc", "_blank", 0, #[]))]
	
	val XComponentContext context
	val XComponentLoader loader
	val XSpreadsheetDocument spreadsheetDocument
	val XSpreadsheet spreadsheet
	
	new(String oooInstallationFolder) {
		this(oooInstallationFolder, NEW_FILE)
	}
	
	new(String oooInstallationFolder, File file) {
		this(oooInstallationFolder, OpenFile(file))
	}
	
	new(String oooInstallationFolder, Function<XComponentLoader, XSpreadsheetDocument> spreadsheetLoader) {
		context = BootstrapSocketConnector.bootstrap(oooInstallationFolder)
		val desktop = context.serviceManager.createInstanceWithContext("com.sun.star.frame.Desktop", context)
		loader = UnoRuntime.queryInterface(XComponentLoader, desktop)
		spreadsheetDocument = spreadsheetLoader.apply(loader)
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
	
	def static OpenFile(String file) {
		return OpenFile(new File(file))
	}
	
	def static Function<XComponentLoader, XSpreadsheetDocument> OpenFile(File file) {
		val path = file.toURI().getRawPath() 
        val url = if(path.startsWith("//")) "file:" + path else "file://" + path 
        val urlClean = if(url.endsWith("/")) url.substring(0, url.length() - 1) else url 
		return [UnoRuntime.queryInterface(XSpreadsheetDocument, loadComponentFromURL(urlClean, "_blank", 0, #[]))]
	}
	
}