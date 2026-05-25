---
description: Refactor tests in the specified file according to FIRST principles from Clean Code by Robert C. Martin.
model: alias/coder
thinking: medium
argument-hint: <FILEPATHS>
---

Analyze the specified test file and refactor its tests according to the FIRST principles from Clean Code by Robert C.
Martin:

- Fast
- Independent
- Repeatable
- Self-validating
- Timely

Your tasks:

1. Inspect the test file and understand:
    - what each test verifies;
    - which dependencies it uses;
    - whether setup is excessive or unclear;
    - whether tests rely on order, shared state, real I/O, network, database, time, randomness, or sleeps;
    - whether the tests follow Arrange / Act / Assert.

2. Identify violations of FIRST.

3. Refactor the tests to:
    - simplify setup;
    - remove unnecessary mocks;
    - replace real dependencies with controlled fakes, stubs, or mocks when appropriate;
    - make assertions precise and readable;
    - improve test names;
    - split tests that verify too many things;
    - remove duplication;
    - clearly separate Arrange / Act / Assert.

4. Keep the existing test framework and project style.

5. Do not change production behavior unless a small change is strictly necessary for testability.
    If so, explain why.

6. After refactoring, briefly explain:
    - what changed;
    - which FIRST principles improved;
    - why the new tests are easier to maintain.

Files to refactor: $@
