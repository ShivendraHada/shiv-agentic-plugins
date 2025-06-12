# AI Prompt Engineering Guide

This guide provides best practices for creating effective prompts for AI-assisted development at Wiser Solutions.

## Principles of Effective Prompts

### 1. Be Specific and Clear
- Provide context about the codebase and technology stack
- Specify the exact task or problem to solve
- Include relevant constraints and requirements
- Mention coding standards and architectural patterns to follow

### 2. Include Relevant Context
- Reference specific files, functions, or classes
- Provide information about the surrounding system
- Mention dependencies and integration points
- Include business domain context when relevant

### 3. Structure Your Prompts
- Use clear sections for different parts of the request
- Separate background information from specific tasks
- Use numbered lists for multi-step requests
- Highlight critical requirements or constraints

### 4. Specify Output Format
- Request code in specific programming languages
- Ask for comments and documentation
- Specify naming conventions to follow
- Request test cases when appropriate

### 5. Iterate and Refine
- Start with a basic prompt and refine based on results
- Ask for specific improvements or alternatives
- Provide feedback on what worked and what didn't
- Save effective prompts for reuse

## Prompt Templates for Common Tasks

### Code Generation

```
Generate [specific type of code] for [specific purpose] using [technology stack].

Context:
- This code will be part of [system/module]
- It needs to integrate with [dependencies]
- Follow our [specific coding standards]

Requirements:
1. [Specific functionality]
2. [Performance considerations]
3. [Error handling expectations]
4. [Security requirements]

Please include:
- Comprehensive error handling
- Proper logging
- Documentation comments
- Unit tests
```

### Code Review

```
Review the following code for:
- Adherence to SOLID principles
- Potential security vulnerabilities
- Performance optimizations
- Error handling completeness
- Test coverage gaps

Code:
[paste code here]

Context:
- This code is part of [system/module]
- It uses [technology stack]
- It needs to handle [specific requirements]
```

### Test Generation

```
Generate comprehensive test cases for the following function/class:

[paste code here]

Include tests for:
- Normal operation scenarios
- Edge cases
- Error conditions
- Performance considerations

Use [testing framework] and follow our test naming convention: 'should [expected behavior] when [condition]'
```

### Debugging

```
Help debug the following issue:

Error message:
[paste error message]

Code that produces the error:
[paste relevant code]

Context:
- This happens when [specific conditions]
- The expected behavior is [description]
- The system uses [technology stack]

What I've tried so far:
[list debugging steps already taken]
```

### Documentation

```
Generate documentation for the following code:

[paste code here]

Include:
- Purpose and functionality
- Parameters and return values
- Usage examples
- Edge cases and limitations
- Integration points with other systems
```

## Technology-Specific Prompting

### NestJS

When working with NestJS, include:
- Module structure and dependencies
- Provider scope (REQUEST, DEFAULT, TRANSIENT)
- Decorator usage
- Dependency injection patterns

### TypeORM

For TypeORM-related prompts, specify:
- Entity relationships
- Repository patterns
- Migration requirements
- Query optimization needs
- Index considerations

### Temporal.IO

For Temporal.IO workflows, include:
- Workflow bundling requirements
- Activity definitions
- Error handling and retry policies
- Timeout configurations
- State persistence needs

### PostgreSQL

For database-related prompts, specify:
- Schema design requirements
- Performance expectations
- Transaction isolation levels
- Audit requirements
- Index optimization needs

## Evaluating AI Responses

Always evaluate AI-generated code for:

1. **Correctness**: Does it solve the specified problem?
2. **Completeness**: Does it handle all requirements and edge cases?
3. **Consistency**: Does it follow coding standards and architectural patterns?
4. **Security**: Is it free from vulnerabilities and security issues?
5. **Performance**: Is it optimized for the expected usage patterns?
6. **Maintainability**: Is it well-structured and documented?
7. **Testability**: Is it designed to be easily testable?

## Continuous Improvement

Keep a library of effective prompts and share them with the team. Regularly review and update prompts based on:

- Changes in technology stack
- New architectural patterns
- Feedback from team members
- Evolving best practices

Remember that prompt engineering is an iterative process. Document successful prompts and approaches to build a knowledge base for the team.
