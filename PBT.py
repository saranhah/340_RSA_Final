#does not work yet! Just pushing so we see progress

import subprocess
import random
import sys

def is_prime(n):
    """Naive method to check if a number is prime."""
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while (i * i) <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True

def generate_prime(min_value, max_value):
    """Generate a random prime number within a specified range."""
    while True:
        p = random.randint(min_value, max_value)
        if is_prime(p):
            return p

def test_rsa(p, q, plaintext):
    """Run the RSA script with subprocess and test properties."""
    cmd = ['python', '/Users/cynthiawang/Desktop/cs/Systems/RSA/rsa', str(p), str(q), plaintext]
    result = subprocess.run(cmd, capture_output=True, text=True)
    output = result.stdout
    assert plaintext in output, "Decrypted text does not match the original"

if __name__ == "__main__":
    # Generate random primes for p and q, and a random plaintext
    p = generate_prime(1000, 5000)
    q = generate_prime(1000, 5000)
    plaintext = 'Hello, RSA!'
    test_rsa(p, q, plaintext)
