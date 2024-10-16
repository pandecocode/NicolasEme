package org.acumen.training.codes.test;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class TestHelloWorld {
	
	@Test
	public void testHello() {
		assertEquals("Hello", "hello");
	}
}
