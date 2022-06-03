package com.corejava;

import java.util.Scanner;

public class JavaFundamentals {

	public static void main(String[] args) {
		System.out.println("Hi Java");
		System.out.println("hello");
		Scanner sc = new Scanner(System.in);
		int a = sc.nextInt();
		System.out.println(a);
		sc.close();
		// typecasting

		float value = (float) 67;
		System.out.print(value);
	}

}
