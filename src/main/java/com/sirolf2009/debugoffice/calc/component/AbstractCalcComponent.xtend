package com.sirolf2009.debugoffice.calc.component

import com.sirolf2009.debugoffice.Spreadsheet
import com.sun.star.table.XCell
import java.util.function.Consumer
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor
import java.util.concurrent.Executors
import java.util.concurrent.ExecutorService

@FinalFieldsConstructor @Accessors abstract class AbstractCalcComponent<T> implements ICalcComponent<T> {

	static val ExecutorService executor = Executors.newFixedThreadPool(Runtime.runtime.availableProcessors - 1)
	val Spreadsheet spreadsheet
	val int x
	val int y
	val int width
	val int height

	def void clear() {
		forEach[clear(it)]
	}

	def clear(int x, int y) {
		cell(x, y).clear()
	}

	def clear(XCell cell) {
		set(cell, "")
	}

	def forEach(Consumer<XCell> consumer) {
		(0 ..< width).toList.parallelStream.forEach [ xCell |
			(0 ..< height).toList.parallelStream.forEach [ yCell |
				executor.submit [
					consumer.accept(cell(xCell, yCell))
				]
			]
		]
	}

	def set(int x, int y, String formula) {
		cell(x, y).formula = formula
	}

	def set(int x, int y, double value) {
		cell(x, y).value = value
	}

	def set(XCell cell, String formula) {
		cell.formula = formula
	}

	def set(XCell cell, double value) {
		cell.value = value
	}

	def cell(int x, int y) {
		val realX = Math.max(Math.min(getX() + x, getX() + width), getX())
		val realY = Math.max(Math.min(getY() + y, getY() + height), getY())
		return spreadsheet.cell(realX, realY)
	}

}
