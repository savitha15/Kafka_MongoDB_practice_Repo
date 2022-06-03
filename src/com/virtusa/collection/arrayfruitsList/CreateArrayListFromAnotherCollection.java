package com.virtusa.collection.arrayfruitsList;

import java.util.*;

public class CreateArrayListFromAnotherCollection {

	public static void main(String[] args) {
		List<Integer> primenumber=new ArrayList<>();
		
		primenumber.add(2);
		primenumber.add(3);
		primenumber.add(5);
		primenumber.add(7);
		primenumber.add(9);
		primenumber.add(11);
		
		List<Integer> newPrimenumber=new ArrayList<>(primenumber);
		newPrimenumber.add(13);
		newPrimenumber.add(17);
		
		System.out.println("new Numbers "+newPrimenumber);
		System.out.println("new Numbers while passing"+primenumber);
		primenumber.addAll(newPrimenumber);
		System.out.println("new Numbers "+newPrimenumber);
		System.out.println("duplicate new Numbers "+primenumber);
	}

}
