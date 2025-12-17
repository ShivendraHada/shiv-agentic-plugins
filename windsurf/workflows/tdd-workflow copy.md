# Agentic Test-Driven Development Workflow

This document outlines the detailed steps for implementing the Agentic TDD workflow, which combines traditional Test-Driven Development with AI assistance and human validation checkpoints.

## Overview

The Agentic TDD workflow is a structured approach that ensures high-quality code with proper testing and human oversight at each development step. It leverages AI to assist with test creation, implementation, and refactoring while maintaining human validation at critical checkpoints.

## Detailed Workflow Steps

### 1. Initial Requirement Extraction
- Analyze the JIRA task and extract clear functional requirements
- Document acceptance criteria and expected behavior
- Identify dependencies and constraints
- Define the scope of the implementation

### 2. Clarifying Questions
- Identify ambiguities in requirements
- Formulate specific questions to resolve uncertainties
- Document assumptions that need confirmation
- Use AI to help identify potential edge cases and scenarios

### 3. Requirement Validation ⚠️ CHECKPOINT
- Wait for human responses before proceeding
- Confirm all assumptions and clarifications
- Ensure complete understanding of requirements
- Document the final requirements and acceptance criteria

### 4. Write Failing Unit Tests
- Use AI to assist in creating comprehensive tests that reflect expected behavior
- Cover normal operation, edge cases, and error conditions
- **CRITICAL**: Only create/modify test files (*.spec.ts) during this step
- **DO NOT** create implementation files or modify existing implementation
- Ensure tests follow the naming convention: 'should [expected behavior] when [condition]'
- Aim for comprehensive coverage of all requirements

### 5. Test Validation ⚠️ CHECKPOINT
- Wait for human review and approval of ALL tests
- Address feedback and revise tests as needed
- Do not proceed to implementation until tests are approved
- Ensure tests align with the agreed requirements

### 6. Write Implementation Code
- Use AI to assist in writing minimum viable code to pass the tests
- Create necessary DTOs, entities, and implementation files
- Implement functionality according to approved tests
- Follow established coding standards and architectural patterns
- Ensure proper error handling and logging

### 7. Implementation Validation ⚠️ CHECKPOINT
- Wait for human review and approval of implementation
- Ensure all tests pass with the implementation
- Verify that the implementation meets all requirements
- Check for adherence to coding standards and best practices

### 8. Refactor
- Use AI to suggest improvements without changing behavior
- Enhance code readability and maintainability
- Optimize performance where applicable
- Apply design patterns appropriately
- Ensure consistent naming and structure

### 9. Refactor Validation ⚠️ CHECKPOINT
- Wait for human approval of refactoring changes
- Ensure tests still pass after refactoring
- Verify that the refactored code maintains the same behavior
- Check for improved readability and maintainability

### 10. Write Integration Tests
- Use AI to assist in creating tests that verify component collaboration
- Test integration points between modules
- Verify system behavior across component boundaries
- Test with realistic data and scenarios

### 11. Integration Test Validation ⚠️ CHECKPOINT
- Wait for human review and approval of integration tests
- Ensure tests cover all integration points
- Verify that tests reflect real-world usage scenarios
- Address any feedback and revise tests as needed

### 12. Write Integration Code
- Use AI to assist in updating code to make integration tests pass
- Implement necessary integration points
- Ensure proper error handling across component boundaries
- Maintain separation of concerns

### 13. Integration Code Validation ⚠️ CHECKPOINT
- Wait for human review and approval of integration code
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

## Tools and Resources

- [Jest Testing Framework](https://jestjs.io/)
- [NestJS Testing](https://docs.nestjs.com/fundamentals/testing)
- [TypeORM Testing](https://typeorm.io/#/testing)
- [AI-Assisted Test Generation](../docs/ai-test-generation.md)
- [Test Templates](../templates/test-templates.md)
