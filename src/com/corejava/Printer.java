package com.corejava;

public class Printer {

	public static void main(String[] args) {
//		IntegerPrinter integerPrinter=new IntegerPrinter(18);
//		integerPrinter.print();
		
		GenericPrinter<Integer> printer=new GenericPrinter<Integer>(23);
		printer.print();
	}

}
