# CS 340 RSA Encryption/Decryption PBT Project

This project is focused on creating a robust Property-Based Testing (PBT) framework for an RSA encryption/decryption implementation. The tool tests whether the RSA algorithm correctly encrypts and decrypts text using prime number-based keys, and it verifies that the implementation properly handles errors when non-prime numbers are used as inputs.

## Installation

### Required Tools

To run and test the RSA project, you will need Python 3 and certain Python packages. You will also need Alloy if you have any interest in seeing the simple model we've created. Here’s how to get set up:

1. **Python 3**: If you do not have Python installed, download and install it from [Python's official website](https://www.python.org/downloads/).

2. **Python Packages**: You need some modules that are part of the Python Standard Library, though you will have to install sympy.

3. **Alloy**: You will need to install it from here https://github.com/AlloyTools/org.alloytools.alloy/releases/tag/v6.0.0. 

### Installing Python Packages

While the script uses some modules from the Python Standard Library (`sys`, `random`, and `math`), you also need to install the `sympy` and `egcd` libraries:

- **`sys`**: No installation required, as it's part of the Python Standard Library.
- **`math`**: No installation required, as it's part of the Python Standard Library.
- **`random`**: No installation required, as it's part of the Python Standard Library.
- **`sympy`**: Installation required. 
- **`egcd`**: Installation required. 

```bash
pip install sympy
```

This command installs the sympy package, which includes functionality to check if numbers are prime—an essential part of generating keys for RSA encryption.

``` bash
pip install egcd 
```

Similarly to sympy, this command will install the egcd package. This is crucial for the calculation of the private key. 

## Running the Project
To run the RSA testing script, use the following command from your terminal:

```bash
python ./oracle <path_to_rsa_script> <number_of_tests>
```
Replace <path_to_rsa_script> with the path to your RSA implementation script (rsa) and <number_of_tests> with the number of tests you want to perform.

## Problem Statement
The general problem tackled by this project is testing the correctness and robustness of an RSA encryption/decryption implementation. Specifically, the tool checks if:

1. The RSA algorithm correctly encrypts and decrypts given texts using prime numbers as keys.
2. The algorithm appropriately handles errors when provided with non-prime numbers.

## Tradeoffs and Representation
### Tradeoffs
The main tradeoff in choosing this testing representation was balancing complexity and thoroughness of the tests against the runtime and simplicity. Using naive primality testing and basic subprocess calls allows for easier understanding and debugging but may not scale well with larger numbers or more complex test cases. 

Further, using Alloy to provide a simple model for RSA proved to be visually helpful but not especially enlightening when it came to
checking for logical inconsistencies in the algorithm, as so much of it requires complex calculations that are difficult to execute in Alloy. Thus, there was a bit of a tradeoff between developing a model that was so elementary with a tool with which we were familiar and considering other avenues for representation that were able to incorporate the complexity of the algorithm without sacrificing the logical simplicitly of Alloy. 

### Alternative Approaches
Initially, more complex methods for generating primes and non-primes were considered, including using advanced libraries or external APIs. However, these were not as straightforward to implement and increased dependency, which could lead to issues in environments with restricted internet access or dependency conflicts.

We were also considering the possibility of creating a function within the RSA file to generate prime numbers and checking if this generation technique was functioning correctly, but we ultiamtely decided against this as the RSA algorithm itself has nothing to do with prime generation. 

## Assumptions and Scope
### Assumptions
The RSA implementation script (rsa.py) is correctly placed in the specified path and is executable.
The user environment has Python installed with necessary permissions to execute scripts.

### Limits
The model assumes that input sizes (the range of numbers for primes and non-primes) are within reasonable limits that don't cause performance degradation.
The script is not optimized for extremely large numbers which are typically used in real-world RSA applications.
Certain input characters cannot be used in the string—for example, inappropriate placements of double quotations within the provided plaintext can trigger an error as stdin has trouble parsing it.

## Evolution of Goals
### Changes from Proposal
The original proposal anticipated using more sophisticated statistical models for error detection and correction, as well as the implementation of digital signatures in RSA. We also had much loftier goals for our Alloy model. During development, it became clear that maintaining simplicity for easier troubleshooting and modification was more practical, and that Alloy did not lend itself particularly easily to the more numerical calculations that the RSA algorithm requires. Our decision to omit digital signatures was made as we thought it would be a better allocation of our time to focus more on PBT/our oracle as opposed to extending the algorithm itself.

### Realizations
It was realized that some initially deemed complex tasks, like integrating subprocesses for command line testing, were more straightforward than expected, which streamlined testing significantly. Further, primality testing was significantly less problematic than we had expected given the wealth of Python libraries that cover this particular problem. 

## Understanding the Model
Each instance of the model (a test run) involves:

Generating a pair of prime numbers and a plaintext.
Running the RSA encryption and decryption using these primes.
Verifying that the decrypted text matches the original plaintext.
Additionally, testing the RSA implementation with non-prime numbers to ensure it fails as expected.


This framework provides a comprehensive approach to validating the basic functionality of an RSA implementation and its error-handling capabilities.
