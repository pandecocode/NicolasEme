package org.acumen.training.codes.test;

import java.util.List;
import java.util.Map;

import org.acumen.training.codes.Flights;
import org.acumen.training.codes.Passenger;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class TestFlights {
	
	@BeforeEach
	public void setup() {
		System.out.println("setup");
	}
	@AfterEach
	public void teardown() {
		System.out.println("teardown");
	}
	
	@Test
	public void testReadFlightsXML() {
        Flights flights = new Flights();
        Map<Integer, List<Passenger>> passengers = 
        		flights.listPassengers("./src/files/flights.xml");

        for (Map.Entry<Integer, List<Passenger>> entry : passengers.entrySet()) {
            System.out.println("Flight Number: %d".formatted(entry.getKey()));
            for (Passenger pass : entry.getValue()) {
                System.out.println("Passenger: %s, Seat: %s, Date: %s"
                		.formatted(pass.name(), pass.seat(), pass.date()));
            }
        }
        
    }
}
