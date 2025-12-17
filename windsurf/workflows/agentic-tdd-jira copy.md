---
description: Agentic TDD + Integration Testing workflow with full human-in-the-loop validation and requirement clarification
---

# Agentic TDD + JIRA Workflow

This workflow implements a structured Test-Driven Development approach with integration testing for JIRA tasks, featuring complete human validation at each critical step.

> **IMPORTANT FOR AI ASSISTANTS**: This workflow must be followed sequentially without skipping steps. Each step must be fully completed before proceeding to the next. Human validation checkpoints are mandatory stopping points where you must wait for explicit human approval before continuing.

## 1. Initial Requirement Extraction

**AI Action**: Extract clear functional requirements from the JIRA task. Analyze all details including:
- Core functionality requirements
- Input/output specifications
- Constraints and edge cases
- Performance expectations
- Integration points
- Custom fields and comments as well

**Expected Output**: A structured list of all requirements extracted from the JIRA ticket with explicit mention of any assumptions being made.

## 2. Ask Clarifying Questions

**AI Action**: Identify and ask specific questions to remove any ambiguity or confirm assumptions:
- Areas where requirements may be unclear
- Technical constraints that need confirmation
- Edge cases that need handling specifications
- Integration details with other components

**Expected Output**: A numbered list of specific questions that need answers before implementation can begin. Questions should be precise and directly related to the requirements.

## 3. Requirement Validation (HUMAN CHECKPOINT)

**AI Action**: Wait for human responses to clarification questions before proceeding. 

**CRITICAL CHECKPOINT**: Do not proceed beyond this point until explicit human feedback is received for all questions. If feedback is incomplete, ask for the remaining answers.

**Expected Output**: Confirmation that all questions have been answered and a summary of the finalized requirements based on human feedback.

## 4. Write Failing Unit Test

**AI Action**: Create comprehensive tests that reflect expected behavior but initially fail.

**STRICT CONSTRAINTS**:
- ❌ **ABSOLUTELY NO IMPLEMENTATION CODE should be written at this stage**
- ❌ **DO NOT create any new files except test files during this step**
- ❌ **DO NOT modify any existing implementation files during this step**
- ✅ **ONLY create/modify test files (*.spec.ts) during this step**
- ❌ **DO NOT create any GraphQL query/mutation implementation files - only create the test files**
- ❌ **DO NOT update any module files to include new providers or imports**
- ✅ **ALWAYS first check if we can reuse a test file before creating a new one**

**Test Requirements**:
- Tests must cover normal operation, edge cases, and error conditions
- Follow the 'should [expected behavior] when [condition]' naming convention
- Include proper setup and teardown procedures
- Mock external dependencies appropriately
- Ensure tests are isolated and repeatable

**Expected Output**: Complete test files that would fail if run against the current codebase.

## 5. Test Validation (HUMAN CHECKPOINT)

**AI Action**: Present all test files for human review and wait for explicit approval.

**CRITICAL CHECKPOINT**:
- ❌ **Do NOT proceed to implementation until ALL tests are approved**
- ❌ **Do NOT create any DTOs, entities, or other implementation files until tests are approved**
- ⚠️ **If human feedback suggests test revisions, make ONLY those changes and present for re-approval**
- 🔄 **This step may require multiple iterations until tests are fully approved**

**Expected Output**: Confirmation that all tests have been reviewed and explicitly approved by a human reviewer.

## 6. Write Implementation Code

**AI Action**: Write minimum viable code to pass the approved tests.

**Implementation Guidelines**:
- ✅ Create necessary DTOs, entities, and implementation files
- ✅ Implement the functionality according to the approved tests
- ✅ Focus on making the tests pass with minimal code
- ✅ Follow Wiser Solutions coding standards (4-space indentation, single quotes, etc.)
- ✅ Add proper JSDoc documentation for all public methods
- ✅ Implement proper error handling with try/catch blocks

**Expected Output**: Implementation code that should pass all the previously approved tests.

## 7. Implementation Validation (HUMAN CHECKPOINT)

**AI Action**: Present the implementation code for human review and wait for explicit approval.

**CRITICAL CHECKPOINT**: Do not proceed until the implementation code has been explicitly approved.

**Expected Output**: Confirmation that the implementation has been reviewed and approved by a human reviewer.

## 8. Refactor

**AI Action**: Suggest improvements to the implementation without changing behavior.

**Refactoring Guidelines**:
- ✅ Improve code readability and maintainability
- ✅ Enhance performance where possible
- ✅ Apply appropriate design patterns (especially those used in the existing codebase)
- ✅ Follow DRY (Don't Repeat Yourself) Principle
- ✅ Ensure proper separation of concerns
- ❌ Only suggest changes for newly written code, not the existing codebase

**Expected Output**: A list of specific refactoring suggestions with clear before/after code examples.

## 9. Important Refactor Validation (HUMAN CHECKPOINT)

**AI Action**: Present refactoring suggestions for human review and wait for explicit approval.

**CRITICAL CHECKPOINT**: Do not implement any refactoring until explicitly approved by a human reviewer.

**Expected Output**: Confirmation of which refactoring suggestions have been approved for implementation.

## 10. Write Integration Test

**AI Action**: Create integration tests that verify component collaboration.

**Integration Test Guidelines**:
- ✅ Focus on end-to-end functionality and component interactions
- ✅ Use black box testing approach
- ✅ Place tests in the designated /test folder
- ✅ Follow the 'should [expected behavior] when [condition]' naming convention
- ✅ Ensure tests would initially fail to validate proper test design
- ✅ For GraphQL endpoints, test both queries and mutations
- ✅ For database operations, test with real database interactions

**Expected Output**: Complete integration test files that would fail if run against the current codebase.

## 11. Integration Test Validation (HUMAN CHECKPOINT)

**AI Action**: Present all integration test files for human review and wait for explicit approval.

**CRITICAL CHECKPOINT**: Do not proceed until all integration tests have been explicitly approved.

**Expected Output**: Confirmation that all integration tests have been reviewed and approved by a human reviewer.

## 12. Write Integration Code

**AI Action**: Update code to make integration tests pass.

**Integration Implementation Guidelines**:
- ✅ Implement necessary integration points
- ✅ Update or create code required for end-to-end functionality
- ✅ Focus on making integration tests pass
- ✅ Ensure proper error handling at integration boundaries
- ✅ Follow NestJS best practices for module integration
- ✅ Update module files to include new providers or imports as needed

**Expected Output**: Implementation code that should pass all the previously approved integration tests.

## 13. Integration Code Validation (HUMAN CHECKPOINT)

**AI Action**: Present the integration implementation code for human review and wait for explicit approval.

**CRITICAL CHECKPOINT**: Do not proceed until the integration code has been explicitly approved.

**Expected Output**: Confirmation that the integration implementation has been reviewed and approved by a human reviewer.

## 14. Create Pull Request

**AI Action**: Guide the human through creating a pull request.

**Pull Request Process**:
1. First push all changes to the relevant branch (which must include JIRA task ID)
2. Create a pull request with a comprehensive description that includes:
   - Implemented requirements (mapped to the original JIRA task)
   - Key implementation decisions and their rationale
   - Testing approach and coverage metrics
   - Known limitations or future improvements

**Expected Output**: A draft pull request description that the human can use when creating the PR.

## 15. Workflow Complete

**AI Action**: Summarize the completed work and suggest next steps.

**Summary Guidelines**:
- ✅ Provide a concise summary of all implemented requirements
- ✅ Highlight key technical achievements
- ✅ Summarize test coverage and quality metrics

**Next Step Options**:
- Start a new TDD cycle for additional requirements
- Review the completed work for potential improvements
- Suggest additional enhancements or optimizations
- Document lessons learned for future implementations

**Expected Output**: A comprehensive summary of the work completed and clear recommendations for next steps.

## Appendix: Progress Tracking

**AI Assistant Instructions**: Use this section to track progress through the workflow. For each step:
1. Mark the current step with ▶️ when starting it
2. Mark completed steps with ✅
3. Mark steps awaiting human validation with ⏳

Example:
```
✅ 1. Initial Requirement Extraction
✅ 2. Ask Clarifying Questions
⏳ 3. Requirement Validation (HUMAN CHECKPOINT)
```

This helps both the human and AI assistant maintain awareness of the current workflow position and prevents accidental step skipping.
