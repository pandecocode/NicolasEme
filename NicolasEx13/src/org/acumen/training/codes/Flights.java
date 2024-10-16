package org.acumen.training.codes;
//comment
import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class Flights {
	public Map<Integer, List<Passenger>> listPassengers(String xmlFileName) {
		TreeMap<Integer, List<Passenger>> destPassengers = new TreeMap<>();
		
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		try {	
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document doc = builder.parse(new File(xmlFileName));
			walkDOMTree(doc, destPassengers);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Collections.unmodifiableMap(destPassengers);
	}

	private void walkDOMTree(Node node, Map<Integer, List<Passenger>> destPassengers) {
		switch (node.getNodeType()) {
		case Node.DOCUMENT_NODE:
			System.out.println("Start of document parsing...");
			NodeList nodes = node.getChildNodes();
			for (int i = 0; i < nodes.getLength(); i++) {
				Node element = nodes.item(i);
				walkDOMTree(element, destPassengers);
			}
			break;

		case Node.ELEMENT_NODE:
			String elementName = node.getNodeName();

			if ("flight".equals(elementName)) {
				//get flight attributes
				Element flightElement = (Element) node; 
				int flightNumber = Integer.parseInt(flightElement.getAttribute("number"));
				String destination = flightElement.getAttribute("dest");
				//if it doesn't exist, new list of passengers
				destPassengers.putIfAbsent(flightNumber, new ArrayList<>());
				
				//get passengers list for the flight
				NodeList passengersList = flightElement.getElementsByTagName("passengers");
				for (int j = 0; j < passengersList.getLength(); j++) {
					Node passengersNode = passengersList.item(j);
					if (passengersNode.getNodeType() == Node.ELEMENT_NODE) { //check if ELEMENT_NODE
						Element passengersElement = (Element) passengersNode; //cast to element
						String date = passengersElement.getAttribute("date");

						//get child passenger nodes
						NodeList passNodes = passengersElement.getElementsByTagName("passenger");
						for (int k = 0; k < passNodes.getLength(); k++) {
							Node passNode = passNodes.item(k);
							if (passNode.getNodeType() == Node.ELEMENT_NODE) {
								Element passengerElement = (Element) passNode;
								//get passenger attributes
								String name = passengerElement.getAttribute("name");
								String seat = passengerElement.getAttribute("seat");
								//add to the passenger record
								Passenger passenger = new Passenger(name, seat, date);
								destPassengers.get(flightNumber).add(passenger);
							}
						}
					}
				}
			}
			NodeList childNodes = node.getChildNodes();
			for (int i = 0; i < childNodes.getLength(); i++) {
				Node childNode = childNodes.item(i);
				walkDOMTree(childNode, destPassengers);
			}
			break;
		case Node.TEXT_NODE:
			String text = node.getNodeValue().trim();
			if (!text.isEmpty()) {
				System.out.println("-------text: %s".formatted(text));
			}
			break;
		}
	}
}
