---
name: tdd-rules
description: Test-Driven Development standards and practices for Shiv Solutions. Provides background knowledge on the Red-Green-Refactor cycle, human validation checkpoints, integration testing patterns, and code quality standards. Applied automatically during TDD workflows.
user-invocable: false
---

# Test-Driven Development Standards

This document defines the TDD practices and code quality standards for all Shiv Solutions development.

## The Red-Green-Refactor Cycle

TDD follows a strict three-phase cycle that must be observed for every unit of work:

### 1. RED: Write a Failing Test

- Write a test that describes the desired behavior **before** writing any implementation code.
- The test MUST fail when first run. If it passes immediately, the test is either trivial or incorrect.
- Focus on a single behavior per test. Do not combine multiple concerns.
- Use descriptive test names that read as specifications of behavior.

### 2. GREEN: Make the Test Pass

- Write the **minimum** amount of production code required to make the failing test pass.
- Do not add extra logic, optimizations, or features beyond what the test demands.
- It is acceptable for the code to be imperfect at this stage -- correctness is the only goal.
- Run the full test suite after each change to ensure no regressions.

### 3. REFACTOR: Improve the Code

- Once the test passes, clean up both the production code and the test code.
- Remove duplication, improve naming, extract methods or classes as needed.
- All tests MUST continue to pass after refactoring. If any test fails, the refactoring introduced a defect.
- Do not add new behavior during the refactor step. If new behavior is needed, start a new RED phase.

## Human Validation Checkpoint Pattern

Every TDD cycle includes human validation points. The developer (or reviewer) must confirm correctness at each gate before proceeding.

```
1. WRITE TEST       --> Human validates: Is this the right behavior to test?
2. RUN TEST (RED)   --> Human validates: Does the test fail for the right reason?
3. IMPLEMENT        --> Human validates: Is the implementation minimal and correct?
4. RUN TEST (GREEN) --> Human validates: Do all tests pass? Any regressions?
5. REFACTOR         --> Human validates: Is the code clean? Are tests still passing?
6. COMMIT           --> Human validates: Is the commit message accurate and scoped?
```

Never skip validation checkpoints. If a step produces an unexpected result, stop and investigate before continuing.

## Unit Test Best Practices

### Arrange-Act-Assert (AAA) Pattern

Every unit test should follow the AAA structure:

```
Arrange  - Set up the test data, mocks, and preconditions.
Act      - Execute the single action under test.
Assert   - Verify the expected outcome.
```

Keep each section clearly separated. If you find yourself needing multiple Act steps, you likely need multiple tests.

### Descriptive Test Names

Test names should read as behavioral specifications. Use a consistent naming convention:

- `should [expected behavior] when [condition]`
- `[method] returns [result] given [input]`
- `[method] throws [error] when [invalid condition]`

Examples:
- `should return empty list when no products match the filter`
- `calculateTotal returns zero given an empty cart`
- `createUser throws ValidationError when email is missing`

### One Assertion Per Test

Each test should verify **one** logical outcome. Multiple assertions are acceptable only when they verify different aspects of the same outcome (e.g., checking both status code and response body of a single HTTP call).

If you need to assert multiple independent behaviors, write separate tests. This makes failures immediately diagnostic -- you know exactly what broke.

### Test Isolation

- Tests must not depend on execution order.
- Tests must not share mutable state.
- Each test must set up its own preconditions and clean up after itself.
- Use fresh fixtures or factories for each test. Avoid shared test data that can drift.

### Test Readability

- Inline test data rather than referencing external fixtures when practical.
- Prefer explicit setup over implicit magic (e.g., avoid beforeAll that silently configures state).
- Keep tests short. If a test exceeds 20-30 lines, it may be testing too much.

## Integration Test Patterns

### Scope and Purpose

Integration tests verify that components work together correctly. They sit between unit tests (isolated, fast) and end-to-end tests (full system, slow).

Typical integration test boundaries:
- Service layer + database (real or in-memory)
- API endpoint + service layer + database
- Service-to-service communication (HTTP, message queues)
- External API clients with contract validation

### Database Integration Tests

- Use a real database instance (Docker or in-memory) rather than mocking the database layer.
- Run each test within a transaction that rolls back, or truncate tables between tests.
- Seed only the data required by each test. Avoid shared seed data across test suites.

### API Integration Tests

- Test the full request/response cycle through the framework's HTTP layer.
- Verify status codes, response shapes, headers, and error formats.
- Test authentication and authorization paths.
- Test pagination, filtering, and sorting where applicable.

### Contract Tests

- When services communicate over APIs, maintain contract tests that validate request/response schemas.
- Contract tests should run in CI and fail if either side changes the agreed interface.

## Code Quality Standards

### Clean Code Principles

- **Meaningful names**: Variables, functions, and classes should reveal their intent. Avoid abbreviations unless universally understood in the domain.
- **Small functions**: Each function should do one thing. If you can extract a meaningful sub-operation, do so.
- **Single level of abstraction**: Within a function, all statements should operate at the same level of abstraction. Mix of high-level orchestration and low-level detail is a code smell.
- **No side effects in query methods**: Functions that return a value should not modify state. Functions that modify state should not return a value (Command-Query Separation).

### SOLID Principles

- **Single Responsibility**: A class should have one reason to change.
- **Open/Closed**: Classes should be open for extension but closed for modification. Prefer composition and interfaces over editing existing code.
- **Liskov Substitution**: Subtypes must be substitutable for their base types without altering correctness.
- **Interface Segregation**: Prefer many small, focused interfaces over one large interface. Clients should not be forced to depend on methods they do not use.
- **Dependency Inversion**: High-level modules should depend on abstractions, not on concrete implementations. Inject dependencies rather than instantiating them.

### DRY (Don't Repeat Yourself)

- Extract duplicated logic into shared functions or modules.
- However, do not over-abstract. Two pieces of code that look similar but serve different purposes should remain separate. Premature DRY leads to coupling.
- The "Rule of Three" is a useful heuristic: tolerate one duplication, extract on the second repetition.

### Error Handling

- Use typed errors or domain-specific exceptions. Avoid generic catch-all error handling.
- Fail fast: validate inputs at the boundary and reject invalid data immediately.
- Log errors with sufficient context (correlation IDs, input parameters, stack traces) to enable debugging.
- Never swallow exceptions silently.

## When to Stop: Coverage and Completeness

### Test Coverage Thresholds

- **Minimum line coverage**: 80% for new code. This is a floor, not a target.
- **Branch coverage**: All significant decision branches should be tested. Pay special attention to error paths and boundary conditions.
- **Critical paths**: Business-critical logic (payments, authentication, data transformations) should have near-100% coverage.

Coverage is a necessary but not sufficient indicator of quality. High coverage with weak assertions provides false confidence.

### Edge Case Coverage

Before considering a feature complete, verify these edge case categories:

- **Empty/null inputs**: What happens when required data is missing or empty?
- **Boundary values**: Test at the edges of valid ranges (0, 1, max, max+1).
- **Duplicate operations**: What happens if the same action is performed twice?
- **Concurrent access**: Can two users modify the same resource simultaneously?
- **Large inputs**: Does the system handle unusually large payloads or datasets?
- **Invalid formats**: Malformed dates, non-UTF8 strings, negative quantities.
- **Permission boundaries**: Can users access resources they should not?

### Definition of Done

A TDD task is complete when:

1. All tests pass (no skipped, no pending).
2. Coverage thresholds are met for the changed code.
3. Edge cases identified during implementation have corresponding tests.
4. Code has been refactored and is clean.
5. No linting or static analysis warnings remain.
6. The commit history is clean and each commit message is scoped to the change.
