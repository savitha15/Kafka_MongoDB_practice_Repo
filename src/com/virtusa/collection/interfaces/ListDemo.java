package com.virtusa.collection.interfaces;

import java.util.*;

public class ListDemo {

	public static void main(String[] args) {
		//list is an ordered collection
		//list provides control over the position
		//duplicate values
		//can have null
		//index start from 0
		
		List<String> list=new ArrayList<>();
		list.add("savi");
		list.add("savi");
		list.add("savi");
		list.add("savi");
		list.add("null");
		list.add("null");
		System.out.println(list);
		System.out.println(list.get(2));
	}

}
