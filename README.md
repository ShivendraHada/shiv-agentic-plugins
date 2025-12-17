# Agentic Development

This repository contains tools, guidelines, and resources for implementing agentic development practices across Wiser Solutions' engineering teams. Agentic development leverages AI-assisted workflows to enhance productivity, quality, and consistency in software development processes.

## What is Agentic Development?

Agentic development is a software engineering approach that integrates AI agents into the development workflow to assist developers with various tasks. These AI agents act as collaborative partners that can help with code generation, testing, documentation, debugging, and other development activities while maintaining human oversight and validation at critical checkpoints.

## How It Helps

- **Enhanced Productivity**: Accelerates development by automating repetitive tasks
- **Knowledge Augmentation**: Provides access to best practices and patterns
- **Quality Assurance**: Ensures comprehensive testing and code quality
- **Consistency**: Promotes adherence to coding standards and architectural patterns
- **Reduced Cognitive Load**: Handles boilerplate code and routine tasks
- **Documentation**: Generates and maintains comprehensive documentation
- **Learning**: Facilitates knowledge transfer and skill development
- **Collaboration**: Improves team coordination and communication

## Quick Start: Bootstrap Wiser Windsurf Workflows

The `sync-workflows` workflow will help you bootstrap the agentic development workflows into your project.

### Prerequisites
- SSH access to WiserSolutions/agentic-development repository
- Windsurf IDE installed

### Step 1: Bootstrap the sync workflow

From the root of your project, run:

```bash
# Bootstrap sync-workflows.md (minimal clone)
git clone --depth 1 git@github.com:WiserSolutions/agentic-development.git temp-sync && \
mkdir -p .windsurf/workflows && \
cp temp-sync/windsurf/workflows/sync-workflows.md .windsurf/workflows && \
rm -rf temp-sync
```

### Step 2: Sync workflows

Run the sync-workflows workflow by typing `/sync-workflows` in cascade.

If you want to run it without having to respond to the prompts, you can edit the `sync-workflows.md` file in `.windsurf/workflows` and set the *Execution Mode* to **Turbo Mode**.

## Agentic Development Workflows

This repository includes several agentic workflows for different development scenarios:

### 1. Epic and Story Workflows ⭐ **NEW**

Comprehensive workflows for creating high-quality Epics and User Stories following the Wiser Solutions standard.

#### Key Features:
- **Epic Creation**: SMART-compliant epics with business justification
- **User Story Creation**: INVEST-compliant stories with Gherkin acceptance criteria
- **Technical Enablement Stories**: Specialized format for technical work
- **Quality Tracking**: Individual story analysis and team performance KPIs
- **Standards Compliance**: Implements Wiser Solutions Epic and Story Standard

#### Quick Start:
```
/create-epic          # Create strategic epics
/create-story         # Create user stories
/story-invest-score   # Analyze story quality
```

📖 **[Complete Epic & Story Documentation](./EPIC_STORY_WORKFLOWS.md)**  
📋 **[Quick Reference Guide](./README_WORKFLOWS.md)**

### 2. Agentic TDD Workflow

A structured approach combining Test-Driven Development with AI assistance and human validation checkpoints.

#### Key Steps:
- Requirement extraction and validation
- AI-assisted test creation with human review
- Implementation guided by tests
- Refactoring with AI suggestions
- Integration testing and validation

[View detailed TDD workflow](./workflows/tdd-workflow.md)

### 2. Agentic Code Review

AI-assisted code review process that helps identify issues, suggest improvements, and ensure adherence to best practices.

#### Key Features:
- Automated code quality checks
- Security vulnerability detection
- Performance optimization suggestions
- Consistency with architectural patterns
- Documentation completeness verification

### 3. Agentic Database Optimization

Workflow for optimizing database performance, schema design, and query efficiency.

#### Key Capabilities:
- Index optimization recommendations
- Query performance analysis
- Schema design suggestions
- Data migration planning
- Audit system management

### 4. Agentic API Development

Streamlined process for designing, implementing, and documenting APIs.

#### Key Components:
- Contract-first design assistance
- Automatic validation implementation
- Documentation generation
- Test case creation
- Client SDK generation

### 5. Agentic Debugging

AI-powered debugging workflow to identify and resolve issues efficiently.

#### Key Features:
- Root cause analysis
- Pattern recognition from error logs
- Solution recommendations
- Regression test generation
- Fix verification

## Best Practices for Agentic Development

### General Guidelines
- Maintain human oversight at critical decision points
- Validate AI-generated code before committing
- Follow established architectural patterns and coding standards
- Document design decisions and implementation details
- Use AI to enhance, not replace, human creativity and judgment

### Code Quality
- Maintain minimum 95% test coverage
- Follow naming conventions specified in project guidelines
- Document public APIs and complex logic
- Use proper test naming convention: 'should [expected behavior] when [condition]'
- Implement proper error handling and logging

### Collaboration
- Share AI-generated insights with team members
- Document AI-assisted solutions for knowledge sharing
- Use AI to facilitate onboarding and knowledge transfer
- Establish clear boundaries for AI autonomy
- Regularly review and refine AI prompts and workflows

## Getting Started

To start using agentic development workflows:

1. Clone this repository
2. Review the documentation and examples for your specific workflow
3. Set up the required AI tools and integrations
4. Follow the workflow guidelines for your development tasks
5. Use the provided templates and prompts
6. Contribute back improvements and new workflows

## Contributing

Contributions to improve agentic development workflows are welcome. Please submit pull requests with:

- New workflow ideas and implementations
- Improvements to existing workflows
- Enhanced templates and prompts
- Documentation updates and examples
- Integration with additional tools and services

## Resources

### Beads + Spec Kit Onboarding

- [Onboarding Deck README](./docs/beads-spec-kit-onboarding/README.md)
- [Beads + Spec Kit Onboarding Slides](./docs/beads-spec-kit-onboarding/slides.md)

### Additional Documentation

- [Installation Guide](./install.md)
- [Agentic Development Patterns](./docs/patterns.md)
- [AI Prompt Engineering Guide](./docs/prompts.md)
- [Workflow Templates](./templates/)
- [Case Studies](./docs/case-studies.md)
