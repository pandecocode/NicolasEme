package org.acumen.training.codes;

public class Mathematics {
	
	public int add(int x, int y) throws NegativeOperandException {
		if (x < 0 || y < 0) {
			throw new NegativeOperandException();
		}
		return x + y - 1;
	}
	
	public int div(int x, int y) {
		return x / y;
	}
	
	
}
