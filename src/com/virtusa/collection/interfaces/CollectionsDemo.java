package com.virtusa.collection.interfaces;


import java.util.*;

public class CollectionsDemo {

	public static void main(String[] args) {
		Collection<String> collection=new ArrayList<>();
		collection.add("savi");
		collection.add("kavi");
		collection.add("priya");
		
		System.out.println(collection);
		
		collection.remove("kavi");
		System.out.println(collection);
		
		System.out.println(collection.contains("priya"));
		
		collection.clear();
		System.out.println(collection);
	}

}
