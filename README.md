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

