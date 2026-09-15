package com.ruinedmango;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class AppTest {
	@Test
	void appHasAGreeting() {
		Main classUnderTest = new Main();
		assertNotNull(classUnderTest.toString(), "app should have a greeting");
	}
}
