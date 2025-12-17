# Agentic Test-Driven Development Workflow

Implement features using Test-Driven Development (TDD) with AI assistance and human validation checkpoints.

## User Input

```text
$ARGUMENTS
```

Use the input above to understand the feature/task to implement. If no input is provided, ask for the task details or Jira ticket reference.

## Overview

The Agentic TDD workflow is a structured approach that ensures high-quality code with proper testing and human oversight at each development step. It leverages AI to assist with test creation, implementation, and refactoring while maintaining human validation at critical checkpoints.

## Detailed Workflow Steps

### 1. Initial Requirement Extraction
- Analyze the task and extract clear functional requirements
- Document acceptance criteria and expected behavior
- Identify dependencies and constraints
- Define the scope of the implementation

### 2. Clarifying Questions
- Identify ambiguities in requirements
- Formulate specific questions to resolve uncertainties
- Document assumptions that need confirmation
- Identify potential edge cases and scenarios

### 3. Requirement Validation - CHECKPOINT
**Wait for human responses before proceeding**
- Confirm all assumptions and clarifications
- Ensure complete understanding of requirements
- Document the final requirements and acceptance criteria

### 4. Write Failing Unit Tests
Create comprehensive tests that reflect expected behavior but initially fail.

**CRITICAL CONSTRAINTS**:
- **ONLY create/modify test files (*.spec.ts, *.test.ts, *_test.py, etc.) during this step**
- **DO NOT create implementation files or modify existing implementation**
- **DO NOT create any GraphQL query/mutation implementation files - only test files**
- **DO NOT update any module files to include new providers or imports**
- **ALWAYS first check if we can reuse a test file before creating a new one**

**Test Requirements**:
- Tests must cover normal operation, edge cases, and error conditions
- Follow the 'should [expected behavior] when [condition]' naming convention
- Include proper setup and teardown procedures
- Mock external dependencies appropriately
- Ensure tests are isolated and repeatable

### 5. Test Validation - CHECKPOINT
**Wait for human review and approval of ALL tests**
- Address feedback and revise tests as needed
- Do not proceed to implementation until tests are approved
- Ensure tests align with the agreed requirements

### 6. Write Implementation Code
Write minimum viable code to pass the approved tests.

**Implementation Guidelines**:
- Create necessary DTOs, entities, and implementation files
- Implement the functionality according to the approved tests
- Focus on making the tests pass with minimal code
- Follow coding standards (consistent indentation, quotes, etc.)
- Add proper documentation for all public methods
- Implement proper error handling with try/catch blocks

### 7. Implementation Validation - CHECKPOINT
**Wait for human review and approval of implementation**
- Ensure all tests pass with the implementation
- Verify that the implementation meets all requirements
- Check for adherence to coding standards and best practices

### 8. Refactor
Suggest improvements to the implementation without changing behavior.

**Refactoring Guidelines**:
- Improve code readability and maintainability
- Enhance performance where possible
- Apply appropriate design patterns
- Follow DRY (Don't Repeat Yourself) Principle
- Ensure proper separation of concerns
- Only suggest changes for newly written code, not the existing codebase

### 9. Refactor Validation - CHECKPOINT
**Wait for human approval of refactoring changes**
- Ensure tests still pass after refactoring
- Verify that the refactored code maintains the same behavior
- Check for improved readability and maintainability

### 10. Write Integration Tests
Create integration tests that verify component collaboration.

**Integration Test Guidelines**:
- Focus on end-to-end functionality and component interactions
- Use black box testing approach
- Place tests in the designated test folder
- Follow the 'should [expected behavior] when [condition]' naming convention
- Ensure tests would initially fail to validate proper test design

### 11. Integration Test Validation - CHECKPOINT
**Wait for human review and approval of integration tests**
- Ensure tests cover all integration points
- Verify that tests reflect real-world usage scenarios
- Address any feedback and revise tests as needed

### 12. Write Integration Code
Update code to make integration tests pass.

**Integration Implementation Guidelines**:
- Implement necessary integration points
- Update or create code required for end-to-end functionality
- Focus on making integration tests pass
- Ensure proper error handling at integration boundaries
- Update module files to include new providers or imports as needed

### 13. Integration Code Validation - CHECKPOINT
**Wait for human review and approval of integration code**
- Ensure all tests (unit and integration) pass
- Verify that the integrated system meets all requirements
- Check for adherence to architectural patterns and best practices

## Best Practices

### Test Creation
- Write tests that are focused and atomic
- Use descriptive test names that explain the expected behavior
- Test both positive and negative scenarios
- Mock external dependencies appropriately
- Maintain minimum 95% test coverage
- Use test data builders or factories for complex objects

### Implementation
- Follow SOLID principles
- Implement defensive programming
- Use meaningful naming conventions
- Keep functions small and focused
- Document public APIs and complex logic
- Use typed languages/strict type checking where possible

### Integration
- Test component interactions thoroughly
- Verify database operations
- Test external service integrations
- Implement proper test data management
- Use realistic test scenarios

## Progress Tracking

Use these markers to track progress:
- Current step with instructions
- Completed steps
- Steps awaiting human validation

Example:
```
Completed: 1. Initial Requirement Extraction
Completed: 2. Ask Clarifying Questions
Awaiting validation: 3. Requirement Validation (HUMAN CHECKPOINT)
```

This helps maintain awareness of the current workflow position and prevents accidental step skipping.
