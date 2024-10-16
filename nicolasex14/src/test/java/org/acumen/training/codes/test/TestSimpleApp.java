package org.acumen.training.codes.test;

import static org.junit.jupiter.api.Assertions.assertTrue;

import org.acumen.training.codes.SimpleApp;
import org.junit.jupiter.api.Test;

public class TestSimpleApp {

	@Test
	public void testApp() {
		System.out.println("testApp");
		SimpleApp app = new SimpleApp();
		assertTrue(app.returnOne() == 1, "app didn't return 1");
	}
}
