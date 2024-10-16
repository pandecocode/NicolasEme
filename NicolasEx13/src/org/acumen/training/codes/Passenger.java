package org.acumen.training.codes;

public record Passenger(String name, String seat, String date) {

	public String name() {
		return name;
	}

	public String seat() {
		return seat;
	}

	public String date() {
		return date;
	}
	
}
