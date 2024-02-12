// Define pin assignments
#define LED1_PIN P1.0
#define LED2_PIN P1.1
#define LED3_PIN P1.2

// Define square wave frequencies in milliseconds
#define FREQ1_PERIOD 100 // 10 Hz
#define FREQ2_PERIOD 117 // 8.57 Hz
#define FREQ3_PERIOD 83  // 12 Hz

// Define total time for blinking (in seconds)
#define BLINK_DURATION 5
#define OFF_DURATION 1

void delay_ms(unsigned int ms) {
    unsigned int i, j;
    for (i = 0; i < ms; i++)
        for (j = 0; j < 112; j++);
}

void blinkLED(int pin, int period) {
    pin = 1;
    delay_ms(period / 2); // High state
    pin = 0;
    delay_ms(period / 2); // Low state
}

void main() {
    unsigned int total_duration = (BLINK_DURATION + OFF_DURATION) * 1000; // Convert to milliseconds

    while (1) {
        unsigned int start_time = 0;
        while (start_time < total_duration) {
            // Blink LED1 at 10 Hz
            blinkLED(LED1_PIN, FREQ1_PERIOD);

            // Blink LED2 at 8.57 Hz
            blinkLED(LED2_PIN, FREQ2_PERIOD);

            // Blink LED3 at 12 Hz
            blinkLED(LED3_PIN, FREQ3_PERIOD);

            start_time += BLINK_DURATION * 1000; // Add blink duration

            if (start_time < total_duration) {
                // If there's still time remaining, turn off LEDs
                LED1_PIN = 0;
                LED2_PIN = 0;
                LED3_PIN = 0;
                delay_ms(OFF_DURATION * 1000);
            }
        }
    }
}


// how the frequencies were determined:

// 10 Hz (FREQ1_PERIOD = 100 ms):
// Frequency: 10 Hz means there are 10 cycles in one second.
// To find the period in milliseconds, you take the reciprocal of the frequency:
// Period (in seconds) = 1 / Frequency = 1 / 10 = 0.1 seconds
// Convert seconds to milliseconds: 0.1 seconds * 1000 = 100 milliseconds
// Therefore, the period for a 10 Hz square wave is 100 milliseconds.

// 8.57 Hz (FREQ2_PERIOD = 117 ms):
// Frequency: 8.57 Hz means there are 8.57 cycles in one second.
// To find the period in milliseconds:
// Period (in seconds) = 1 / Frequency = 1 / 8.57 ≈ 0.1167 seconds
// Convert seconds to milliseconds: 0.1167 seconds * 1000 ≈ 117 milliseconds
// Therefore, the period for an 8.57 Hz square wave is approximately 117 milliseconds.

// 12 Hz (FREQ3_PERIOD = 83 ms):
// Frequency: 12 Hz means there are 12 cycles in one second.
// To find the period in milliseconds:
// Period (in seconds) = 1 / Frequency = 1 / 12 ≈ 0.0833 seconds
// Convert seconds to milliseconds: 0.0833 seconds * 1000 ≈ 83 milliseconds
// Therefore, the period for a 12 Hz square wave is approximately 83 milliseconds.