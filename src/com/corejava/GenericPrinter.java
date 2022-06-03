package com.corejava;

public class GenericPrinter<T> {
	
	T dataToprint;

	public GenericPrinter(T dataToprint) {
		this.dataToprint = dataToprint;
	}

	public void print() {
		System.out.println(dataToprint);
	}
	
}
