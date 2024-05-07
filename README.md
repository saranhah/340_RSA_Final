# 340_RSA_Final

# RSA Encryption/Decryption Testing Tool

This project is focused on creating a robust Property-Based Testing (PBT) framework for an RSA encryption/decryption implementation. The tool tests whether the RSA algorithm correctly encrypts and decrypts text using prime number-based keys, and it verifies that the implementation properly handles errors when non-prime numbers are used as inputs.

## Installation

### Required Tools

To run and test the RSA project, you will need Python 3 and certain Python packages. Here’s how to get set up:

1. **Python 3**: If you do not have Python installed, download and install it from [Python's official website](https://www.python.org/downloads/).

2. **Python Packages**: You need the `subprocess` and `random` modules, which are part of the Python Standard Library, so no additional installation is necessary beyond Python itself.

### Installing Python Packages

Although this project primarily uses Python's built-in libraries, it requires the `sympy` library for prime number validation:

```bash
pip install sympy
```

This command installs the sympy package, which includes functionality to check if numbers are prime—an essential part of generating keys for RSA encryption.

## Running the Project
To run the RSA testing script, use the following command from your terminal:

```bash
python test_rsa.py <path_to_rsa_script> <number_of_tests>
```
Replace <path_to_rsa_script> with the path to your RSA implementation script (rsa) and <number_of_tests> with the number of tests you want to perform.

## Problem Statement
The general problem tackled by this project is testing the correctness and robustness of an RSA encryption/decryption implementation. Specifically, the tool checks if:

1. The RSA algorithm correctly encrypts and decrypts given texts using prime numbers as keys.
2. The algorithm appropriately handles errors when provided with non-prime numbers.

## Tradeoffs and Representation
### Tradeoffs
The main tradeoff in choosing this testing representation was balancing complexity and thoroughness of the tests against the runtime and simplicity. Using naive primality testing and basic subprocess calls allows for easier understanding and debugging but may not scale well with larger numbers or more complex test cases.

### Alternative Approaches
Initially, more complex methods for generating primes and non-primes were considered, including using advanced libraries or external APIs. However, these were not as straightforward to implement and increased dependency, which could lead to issues in environments with restricted internet access or dependency conflicts.

## Assumptions and Scope
### Assumptions
The RSA implementation script (rsa.py) is correctly placed in the specified path and is executable.
The user environment has Python installed with necessary permissions to execute scripts.
### Limits
The model assumes that input sizes (the range of numbers for primes and non-primes) are within reasonable limits that don't cause performance degradation.
The script is not optimized for extremely large numbers which are typically used in real-world RSA applications.

## Evolution of Goals
### Changes from Proposal
The original proposal anticipated using more sophisticated statistical models for error detection and correction. During development, it became clear that maintaining simplicity for easier troubleshooting and modification was more practical.

### Realizations
It was realized that some initially deemed complex tasks, like integrating subprocesses for command line testing, were more straightforward than expected, which streamlined testing significantly.

## Understanding the Model
Each instance of the model (a test run) involves:

Generating a pair of prime numbers and a plaintext.
Running the RSA encryption and decryption using these primes.
Verifying that the decrypted text matches the original plaintext.
Additionally, testing the RSA implementation with non-prime numbers to ensure it fails as expected.


This framework provides a comprehensive approach to validating the basic functionality of an RSA implementation and its error-handling capabilities.
