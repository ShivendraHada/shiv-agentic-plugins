# Epic and Story Workflows - Developer Guide

This comprehensive guide covers installing and using the Epic and Story management workflows with **Claude Code** or **Windsurf IDE**, including backlog management using the Wiser Solutions standard.

## Table of Contents
1. [Quick Start](#quick-start)
2. [Installation](#installation)
3. [Workflow Overview](#workflow-overview)
4. [Epic Management](#epic-management)
5. [Story Management](#story-management)
6. [Technical Enablement Stories](#technical-enablement-stories)
7. [Backlog Management](#backlog-management)
8. [Quality Tracking](#quality-tracking)
9. [Best Practices](#best-practices)
10. [Troubleshooting](#troubleshooting)

## Quick Start

### TL;DR - Get Started in 5 Minutes

#### Using Claude Code (Recommended)
1. **Install commands**:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/WiserSolutions/agentic-development/main/install-claude-commands.sh | bash
   ```
2. **Type `/` in Claude Code** to see available commands
3. **Create an Epic**: `/create-epic` → Follow SMART criteria prompts
4. **Create Stories**: `/create-story` → Follow INVEST principles
5. **For Technical Work**: `/create-technical-enablement-story`
6. **Check Quality**: `/story-invest-score [story-id]`

#### Using Windsurf IDE
1. **Open Windsurf IDE** in this repository
2. **Type `/` in chat** to see available workflows
3. **Create an Epic**: `/create-epic` → Follow SMART criteria prompts
4. **Create Stories**: `/create-story` → Follow INVEST principles
5. **For Technical Work**: `/create-technical-enablement-story`
6. **Check Quality**: `/story-invest-score [story-id]`

### Available Commands
| Command | Description |
|---------|-------------|
| `/create-epic` | Create SMART-compliant Epics |
| `/create-story` | Create INVEST-compliant User Stories |
| `/create-technical-enablement-story` | Create technical work stories |
| `/story-invest-score` | Analyze individual story quality |
| `/story-quality-kpis` | Track team performance metrics |
| `/notes-to-work-item` | Transform notes into epics/stories |

## Installation

### Prerequisites
- **Claude Code** or **Windsurf IDE** installed
- Access to this agentic-development repository
- Confluence access for the Wiser Solutions Epic and Story Standard (Page ID: 4660658177)

### Option A: Claude Code Installation (Recommended)

#### Quick Install (One Command)
```bash
curl -fsSL https://raw.githubusercontent.com/WiserSolutions/agentic-development/main/install-claude-commands.sh | bash
```

#### Manual Installation
```bash
# Clone repository
git clone --depth 1 git@github.com:WiserSolutions/agentic-development.git temp-commands

# Create commands directory and copy
mkdir -p .claude/commands
cp temp-commands/claude-commands/*.md .claude/commands/

# Cleanup
rm -rf temp-commands
```

#### Verify Installation
- Type `/` in Claude Code
- Confirm these commands appear:
  - `/create-epic`
  - `/create-story`
  - `/create-technical-enablement-story`
  - `/story-invest-score`
  - `/story-quality-kpis`

#### Usage Examples

**Create an Epic:**
```
/create-epic Customer Self-Service Portal to reduce support tickets by 40%
```

**Create a User Story:**
```
/create-story As a customer, I need to view my order history so I can track my purchases
```

**Create a Technical Enablement Story:**
```
/create-technical-enablement-story Implement JWT authentication middleware for API security
```

**Analyze Story Quality:**
```
/story-invest-score PROJ-123
```

### Option B: Windsurf IDE Installation

1. **Clone Repository** (if not already done)
   ```bash
   git clone <this-repository-url>
   cd agentic-development
   ```

2. **Open in Windsurf**
   - Launch Windsurf IDE
   - Open this repository as workspace
   - Workflows are automatically loaded from `.windsurf/workflows/`

3. **Verify Installation**
   - Type `/` in Windsurf chat
   - Confirm these workflows appear:
     - `/create-epic`
     - `/create-story`
     - `/create-technical-enablement-story`
     - `/story-invest-score`
     - `/story-quality-kpis`

### File Structure
```
├── .claude/commands/                     # Claude Code commands
│   ├── create-epic.md
│   ├── create-story.md
│   ├── create-technical-enablement-story.md
│   ├── story-invest-score.md
│   ├── story-quality-kpis.md
│   └── notes-to-work-item.md
├── claude-commands/                      # Source commands for distribution
│   └── README.md                         # Claude Code documentation
├── .windsurf/workflows/                  # Windsurf workflows
│   ├── create-epic.md
│   ├── create-story.md
│   ├── create-technical-enablement-story.md
│   ├── story-invest-score.md
│   ├── story-quality-kpis.md
│   └── technical-enablement-rules.md
├── install-claude-commands.sh            # Installation script
└── EPIC_STORY_WORKFLOWS.md              # This documentation
```

## Workflow Overview

### Standards Reference
All workflows implement the **Wiser Solutions Epic and Story Standard** (Confluence Page ID: 4660658177):

| **Standard** | **Requirement** |
|--------------|-----------------|
| **Epic Duration** | 6-12 weeks maximum, ideally 6-8 weeks |
| **Story Scoring** | 1-5 scale, target average 3.5-4.0 across INVEST criteria |
| **Acceptance Criteria** | Gherkin syntax required (Given/When/Then) |
| **Technical Work** | Use Technical Enablement stories with modified INVEST principles |
| **Quality Thresholds** | Epic ≥20/25 SMART score, Story ≥21/30 INVEST score |

### Workflow Types

| Workflow | Purpose | When to Use |
|----------|---------|-------------|
| **Epic Creation** | Strategic initiatives | Large features requiring multiple sprints |
| **Story Creation** | User-facing features | Individual sprint deliverables |
| **Technical Enablement** | Technical work | Infrastructure, debt, platform work |
| **Quality Analysis** | Story assessment | Before sprint planning, retrospectives |
| **Team KPIs** | Performance tracking | Sprint reviews, team health checks |

## Epic Management

### Creating Epics with `/create-epic`

#### Step 1: Initiate Epic Creation
```
/create-epic
```

#### Step 2: Provide Epic Information
The workflow guides you through gathering:
- **Epic Title**: Clear, concise title
- **Business Problem**: What opportunity or problem are you addressing?
- **Target Users**: Who will benefit from this epic?
- **Strategic Context**: How does this align with company strategy?
- **Expected Outcomes**: What business results do you expect?

#### Step 3: SMART Criteria Completion

**Specific (S)** - Epic must clearly define what will be accomplished
- Clear problem statement or opportunity
- Defined scope and boundaries  
- Identified target users or stakeholders
- Explicit success criteria

**Measurable (M)** - Epic must include quantifiable success metrics
- Specific KPIs or metrics defined
- Baseline measurements established
- Target improvements quantified
- Success criteria can be objectively verified

**Achievable (A)** - Epic must be realistic given available resources
- Resource requirements assessed (team size, skills, timeline)
- Technical feasibility validated
- Dependencies identified and manageable
- Timeline is realistic for scope

**Relevant (R)** - Epic must align with business strategy
- Clear business justification
- Alignment with company/product strategy
- Stakeholder value articulated
- Priority relative to other initiatives established

**Time-bound (T)** - Epic must have defined timeline
- Target start date specified in epic fields
- Target end date specified in epic fields
- Key milestones identified between start and end dates
- Sprint allocation estimated based on timeline

#### Step 4: Epic Template Output

The workflow generates a complete epic:

```markdown
# Epic: Customer Self-Service Portal

## Epic Statement
As Wiser's customer support organization, we need a comprehensive self-service portal so that we can reduce support ticket volume by 40% and improve customer satisfaction scores.

## Business Justification
Currently, 60% of support tickets are for routine inquiries that customers could handle themselves. This creates unnecessary load on our support team and delays response times for complex issues.

## Success Criteria (SMART)

### Specific
- [ ] Self-service portal for customer account management
- [ ] Target users: All active customers (B2B and B2C)
- [ ] Scope: Account info, order history, billing, basic troubleshooting

### Measurable
- **Baseline**: 1,200 support tickets/month, 72-hour average response time
- **Target**: Reduce tickets by 40% (720/month), improve response time to 24 hours
- **KPIs**: Ticket volume, customer satisfaction score, portal adoption rate

### Achievable
- **Resources Required**: 2 developers, 1 designer, 1 product owner (8 weeks)
- **Technical Feasibility**: Confirmed - leverages existing customer API
- **Risk Assessment**: Medium - depends on API performance improvements

### Relevant
- **Business Alignment**: Supports operational efficiency and customer experience goals
- **User Value**: Immediate access to account information, faster issue resolution
- **Priority**: High - directly impacts customer satisfaction and operational costs

### Time-bound
- **Target Start Date**: 2025-01-15 (Epic field)
- **Target End Date**: 2025-03-15 (Epic field)
- **Sprint Allocation**: 4 sprints (8 weeks)
- **Key Milestones**:
  - [ ] Portal framework and authentication - February 1
  - [ ] Account and order features - February 15
  - [ ] Billing and support features - March 1
  - [ ] Testing and launch - March 15

## Acceptance Criteria
- [ ] Customers can access account information without contacting support
- [ ] Portal supports 95% of routine customer inquiries
- [ ] System maintains 99.9% uptime during business hours
- [ ] Customer satisfaction scores improve by 15%
- [ ] Support ticket volume reduces by 40%

## Dependencies
- Customer API performance improvements must be completed first
- SSO integration with existing authentication system
- Customer database cleanup for data accuracy

## Assumptions
- Customers will adopt self-service options when available
- Current API can handle increased load with planned improvements
- Support team will promote portal usage to customers

## Risks and Mitigations
- **Risk**: Low customer adoption
  **Mitigation**: User testing, training materials, support team promotion
- **Risk**: API performance issues
  **Mitigation**: Load testing, performance monitoring, gradual rollout
```

#### Step 5: Quality Validation
- **Minimum Score**: Epic must score ≥20/25 on SMART criteria
- **Duration**: 6-12 weeks maximum, ideally 6-8 weeks
- **Story Breakdown**: Must be decomposable into 5-15 user stories

## Story Management

### Creating User Stories with `/create-story`

#### Step 1: Initiate Story Creation
```
/create-story
```

#### Step 2: Story Information Gathering
Provide context for:
- **Epic Context**: Which epic does this belong to?
- **User Role**: Who is the specific user?
- **Capability**: What do they need to do?
- **Business Value**: What benefit will they gain?
- **Functional Context**: Core functionality and workflows

#### Step 3: Required Story Format
All stories must follow this format:
```
As a [specific user role]
I need to [specific action or capability]
So that I can [specific business value or benefit]
```

#### Step 4: INVEST Criteria Validation
Score each criterion on 1-5 scale (target: 3.5-4.0 average):

**Independent (I)** - Can be developed without dependencies on other stories
- Target: ≥3
- Dependencies on other stories in same sprint don't jeopardize completion
- Can be developed in any order
- Clear interfaces defined for necessary integrations

**Negotiable (N)** - Details can be refined through collaboration  
- Target: ≥3
- Implementation approach is flexible
- Acceptance criteria can be refined during development
- Room for developer input on technical approach

**Valuable (V)** - Delivers clear business or user value
- Target: ≥4
- Value statement clearly articulates benefit
- Benefit is meaningful to end users or business
- Value can be demonstrated upon completion

**Estimable (E)** - Well-defined enough for accurate estimation
- Target: ≥3
- Requirements are clear and unambiguous
- Technical approach is understood
- Team can confidently estimate effort

**Small (S)** - Can be completed within one sprint
- Target: ≥3
- Estimated at 1-8 story points (team-dependent)
- Can be completed in 1-5 days
- Scope focused on single functionality

**Testable (T)** - Has clear, verifiable acceptance criteria
- Target: ≥4
- Acceptance criteria use Gherkin syntax (Given/When/Then)
- Criteria cover happy path and edge cases
- Success/failure conditions are unambiguous

#### Step 5: Story Template Output

```markdown
# Story: View Order History

## User Story
As a customer
I need to view my complete order history with detailed information
So that I can track my purchases, reorder items, and resolve billing questions without contacting support

## Value Statement
Customers currently call support for 40% of order-related inquiries. Self-service order history will reduce these calls by an estimated 200 tickets/month, saving $6,000 in support costs and improving customer satisfaction through immediate access to information.

## Acceptance Criteria
```gherkin
Scenario: Customer views their order history
Given I am a logged-in customer with previous orders
When I navigate to "My Orders" page
Then I should see all my orders from the past 24 months
And each order should display order number, date, total amount, and status
And orders should be sorted by date (most recent first)
And I should see pagination for orders older than 50 items

Scenario: Customer views order details
Given I am viewing my order history
When I click on a specific order
Then I should see detailed order information including:
  - Items purchased with quantities and prices
  - Shipping address and method
  - Payment method (last 4 digits only)
  - Order timeline (placed, processed, shipped, delivered)
  - Tracking information if available

Scenario: Customer with no order history
Given I am a logged-in customer with no previous orders
When I navigate to "My Orders" page
Then I should see a message "You haven't placed any orders yet"
And I should see a "Start Shopping" button linking to the product catalog

Scenario: System error handling
Given I am viewing my order history
When the order service is temporarily unavailable
Then I should see a user-friendly error message
And I should see a "Try Again" button
And the error should be logged for support team review
```

## Definition of Done
- [ ] General DoD Checklist completed (see team standards)
- [ ] Performance tested: page loads in <2 seconds with 1000+ orders
- [ ] Security review: customer data access logging implemented
- [ ] Pagination implemented for order histories >50 items
- [ ] Error handling: graceful degradation when order service unavailable
- [ ] Documentation: customer support team trained on new order lookup features

## Assumptions
- Customer authentication system is available and reliable
- Order data is accessible via existing customer API
- Customers prefer chronological order display (most recent first)

## Dependencies
- Customer authentication must be working
- Order service API must be available
- Customer portal framework must be implemented

## Notes
- Consider implementing order search/filter functionality in future story
- May need to implement caching for customers with large order histories
- Should include analytics to track usage patterns
```

#### Step 6: Quality Assessment
**INVEST Score Analysis:**
- Independent (I): 4/5 - Depends on auth and API but manageable
- Negotiable (N): 4/5 - Implementation details flexible, core requirements clear
- Valuable (V): 5/5 - Clear, quantifiable business value ($6,000 savings)
- Estimable (E): 4/5 - Well-defined with clear acceptance criteria
- Small (S): 4/5 - Can be completed in one sprint (estimated 5 points)
- Testable (T): 5/5 - Comprehensive Gherkin scenarios cover all cases

**Overall Score**: 26/30 (87%) - Average: 4.3/5 ✅ **Ready for Sprint**

## Technical Enablement Stories

### When to Use Technical Enablement Stories

Use `/create-technical-enablement-story` for:
- Infrastructure work that enables future features
- Technical debt reduction that improves development velocity
- Platform capabilities that support multiple future features
- Developer tooling that improves team productivity
- Architecture improvements that enable scalability or maintainability
- Security enhancements that don't directly impact user workflows
- Performance optimizations that improve system capabilities
- Integration work that connects systems for future features

### Technical Enablement Story Format

```
As a [development team/system/platform]
I need to [technical capability or improvement]
So that I can [enable future capabilities or improve technical outcomes]
```

### Modified INVEST Principles for Technical Work

Technical Enablement stories follow modified INVEST principles:
- **Independent**: Can be developed without dependencies on other technical stories
- **Negotiable**: Technical approach can be refined through collaboration
- **Valuable (Technical Value)**: Delivers clear technical value that enables future work
- **Estimable**: Well-defined enough for accurate technical estimation
- **Small**: Can be completed within one sprint
- **Testable (Technical Testability)**: Has clear, verifiable technical acceptance criteria

### Example Technical Enablement Story

```markdown
# Technical Enablement Story: API Authentication Middleware

## Technical Story
As a platform service
I need to implement JWT-based authentication middleware with role-based access control
So that I can secure API endpoints for the upcoming customer portal and partner integration features

## Technical Value Statement
Current API has no authentication, blocking development of customer self-service portal (Epic: CUST-100) and partner integration features (Epic: PART-200). This middleware will enable secure API access with role-based permissions, supporting 1000+ concurrent authenticated users and reducing security implementation time for future features by 80%.

## Enabled Capabilities
- Customer portal user authentication (Stories: CUST-101, CUST-102)
- Partner API access with scoped permissions (Stories: PART-201, PART-202)
- Admin dashboard with role-based access (Stories: ADMIN-301)
- Secure API endpoints for mobile app (Epic: MOBILE-400)

## Technical Acceptance Criteria
```gherkin
Scenario: Valid JWT token grants API access
Given a valid JWT token with appropriate role permissions
When a request is made to a protected API endpoint
Then the request should be processed successfully
And the user context should be available to the endpoint handler

Scenario: Invalid JWT token blocks API access
Given an invalid or expired JWT token
When a request is made to a protected API endpoint
Then the request should return HTTP 401 (Unauthorized)
And the response should include appropriate error message
And no sensitive information should be exposed

Scenario: Role-based access control enforces permissions
Given a valid JWT token with "customer" role
When a request is made to an admin-only API endpoint
Then the request should return HTTP 403 (Forbidden)
And the response should indicate insufficient permissions
```
```

## Backlog Management

### Organizing Your Backlog

#### Epic-Story Hierarchy
```
Epic: Customer Self-Service Portal (8 weeks)
├── Story: User Registration (3 points)
├── Story: User Login (2 points)
├── Story: View Account Info (5 points)
├── Story: View Order History (5 points)
├── Story: Update Profile (3 points)
├── Technical Enablement: API Authentication (8 points)
└── Technical Enablement: Performance Monitoring (3 points)
```

#### Backlog Prioritization

1. **Epic Level Prioritization**
   - Use SMART score (≥20/25) as quality gate
   - Prioritize by business value and strategic alignment
   - Consider dependencies and resource availability

2. **Story Level Prioritization**
   - Use INVEST score (≥21/30) as quality gate
   - Prioritize by value delivery and risk reduction
   - Consider technical dependencies and user workflows

3. **Sprint Planning Integration**
   - Stories must meet quality thresholds before sprint planning
   - Technical Enablement stories should precede dependent user stories
   - Plan for story refinement sessions 1-2 sprints ahead

### Backlog Health Metrics

#### Epic Health
- **Duration**: 6-12 weeks maximum
- **SMART Score**: ≥20/25 (80%)
- **Story Breakdown**: 5-15 stories per epic
- **Dependencies**: Clearly identified and manageable

#### Story Health  
- **INVEST Score**: ≥21/30 (70%) with 3.5-4.0 average
- **Size**: 1-8 story points, completable in 1 sprint
- **Acceptance Criteria**: Gherkin format required
- **Dependencies**: Minimal, well-documented

#### Team Performance Targets
- **Story Quality**: Average INVEST score 3.5-4.0
- **Sprint Readiness**: 80% of stories meet quality threshold
- **Technical Debt**: <20% of sprint capacity on Technical Enablement
- **Velocity Consistency**: <25% variance sprint-to-sprint

## Quality Tracking

### Individual Story Analysis with `/story-invest-score`

#### Usage
```
/story-invest-score PROJ-123
```

#### What It Analyzes
- **Story Format**: Proper "As a... I need... So that..." structure
- **INVEST Criteria**: Each criterion scored 1-5 with detailed feedback
- **Quality Grade**: A/B/C/D/F based on overall score
- **Improvement Recommendations**: Specific actions for each low-scoring criterion
- **Readiness Assessment**: Ready/Needs Refinement/Significant Rework

#### Sample Output
```
Story: PROJ-123 - View Order History
INVEST Score: 26/30 (87%) - Average: 4.3/5

Individual Scores:
- Independent (I): 4/5 - Good (minor dependency on auth service)
- Negotiable (N): 4/5 - Good (implementation approach flexible)
- Valuable (V): 5/5 - Excellent (clear $6K cost savings)
- Estimable (E): 4/5 - Good (well-defined requirements)
- Small (S): 4/5 - Good (5 points, fits in sprint)
- Testable (T): 5/5 - Excellent (comprehensive Gherkin scenarios)

Quality Grade: B - Good
Readiness: ✅ Ready for Sprint

Improvement Recommendations:
- Independent (I): Document auth service dependency and fallback plan
```

### Team Performance Tracking with `/story-quality-kpis`

#### Usage
```
/story-quality-kpis
```

#### What It Tracks
- **Multi-team Analysis**: 10+ engineering teams
- **Statistical Analysis**: Mean, Median, Std Dev, Min, Max, Range per INVEST criterion
- **Team Rankings**: A/B/C/D grades based on performance
- **Trend Analysis**: Sprint-over-sprint improvement tracking
- **Executive Summary**: Key findings and strategic recommendations

#### Sample Output
```
Story Quality KPIs - Sprint 2025.1

Engineering-Wide Statistics:
- Average INVEST Score: 3.7/5 (Target: 3.5-4.0) ✅
- Stories Meeting Threshold: 78% (Target: 80%) ⚠️
- Gherkin Adoption: 85% (Target: 90%) ⚠️

Top Performing Teams:
1. NGPI: 4.2/5 average (Grade A)
2. DATA: 4.1/5 average (Grade A)
3. ORCH: 3.9/5 average (Grade B)

Areas for Improvement:
- Testable (T): 3.2/5 average - Need more Gherkin adoption
- Small (S): 3.4/5 average - Stories too large, need better breakdown

Recommendations:
1. Gherkin training for teams scoring <3.5 on Testable
2. Story slicing workshops for teams scoring <3.5 on Small
3. Continue current practices for top-performing teams
```

## Best Practices

### Epic Best Practices

1. **Epic Planning**
   - Plan epics during quarterly planning sessions
   - Limit to 6-8 weeks duration for optimal delivery
   - Ensure clear business justification and measurable outcomes
   - Identify and document all dependencies upfront

2. **SMART Criteria Excellence**
   - **Specific**: Use concrete, unambiguous language
   - **Measurable**: Include baseline metrics and target improvements
   - **Achievable**: Validate technical feasibility before committing
   - **Relevant**: Connect to business strategy and user needs
   - **Time-bound**: Set realistic milestones with buffer time

3. **Epic-Story Relationship**
   - Break epics into 5-15 stories maximum
   - Ensure each story contributes to epic success criteria
   - Plan story dependencies and delivery sequence
   - Regular epic health checks during execution

### Story Best Practices

1. **Story Writing**
   - Use specific user roles, not generic "user"
   - Focus on user needs and business value, not implementation
   - Write from user perspective, not system perspective
   - Include quantifiable value when possible

2. **INVEST Excellence**
   - **Independent**: Minimize dependencies, plan interfaces clearly
   - **Negotiable**: Leave implementation details flexible
   - **Valuable**: Connect to business metrics and user outcomes
   - **Estimable**: Provide clear requirements and acceptance criteria
   - **Small**: Aim for 1-5 days of work, not weeks
   - **Testable**: Use Gherkin format for all acceptance criteria

3. **Acceptance Criteria**
   - Use Given/When/Then format consistently
   - Cover happy path, edge cases, and error scenarios
   - Make criteria specific and verifiable
   - Include performance and security requirements when relevant

### Technical Enablement Best Practices

1. **When to Use**
   - Infrastructure that enables multiple user stories
   - Technical debt that impacts development velocity
   - Platform capabilities that support future features
   - Developer tooling that improves productivity

2. **Value Articulation**
   - Connect to specific future user stories
   - Quantify performance or velocity improvements
   - Identify risks being mitigated
   - Measure capacity or scalability gains

3. **Sequencing**
   - Complete technical enablement before dependent user stories
   - Plan just-in-time to minimize unused technical inventory
   - Coordinate with product owner on timing and priorities

### Quality Management Best Practices

1. **Continuous Improvement**
   - Run `/story-quality-kpis` after each sprint
   - Track trends over time, not just point-in-time scores
   - Focus on teams consistently below 3.5 average
   - Celebrate improvements and share best practices

2. **Story Refinement**
   - Use `/story-invest-score` before sprint planning
   - Refine stories 1-2 sprints ahead of development
   - Don't accept stories below quality threshold into sprints
   - Regular backlog grooming to maintain story health

3. **Team Development**
   - Provide training for teams scoring low on specific INVEST criteria
   - Share examples of high-quality stories across teams
   - Regular retrospectives on story quality and process improvements
   - Mentoring and pairing for story writing skills

## Troubleshooting

### Common Issues and Solutions

#### Command Not Appearing in Claude Code
**Problem**: `/create-epic` or other commands don't appear in Claude Code
**Solutions**:
1. Verify commands are installed in `.claude/commands/` directory
2. Re-run the installation script: `./install-claude-commands.sh`
3. Check that command files have `.md` extension
4. Restart Claude Code session
5. Verify file permissions: `ls -la .claude/commands/`

#### Command Not Appearing in Windsurf
**Problem**: `/create-epic` or other workflows don't appear in Windsurf
**Solutions**:
1. Verify you're in the correct repository workspace
2. Check that workflow files exist in `.windsurf/workflows/`
3. Restart Windsurf IDE
4. Ensure workflows have proper YAML frontmatter

#### Epic Scoring Low on SMART Criteria
**Problem**: Epic scores <20/25 on SMART validation
**Solutions**:
1. **Specific**: Add concrete scope boundaries and success criteria
2. **Measurable**: Include baseline metrics and quantified targets
3. **Achievable**: Validate technical feasibility and resource availability
4. **Relevant**: Strengthen business justification and strategic alignment
5. **Time-bound**: Add specific dates and realistic milestones

#### Story Scoring Low on INVEST Criteria
**Problem**: Story scores <21/30 on INVEST validation
**Solutions**:
1. **Independent**: Reduce dependencies or plan clear interfaces
2. **Negotiable**: Make implementation approach more flexible
3. **Valuable**: Strengthen value statement with quantifiable benefits
4. **Estimable**: Add more specific requirements and acceptance criteria
5. **Small**: Break story into smaller, focused pieces
6. **Testable**: Rewrite acceptance criteria using Gherkin format

#### Gherkin Acceptance Criteria Issues
**Problem**: Acceptance criteria don't follow proper Gherkin format
**Solutions**:
1. Use Given/When/Then structure consistently
2. Make scenarios specific and testable
3. Cover happy path, edge cases, and error scenarios
4. Remove vague language like "user-friendly" or "fast"
5. Include specific data and expected outcomes

#### Technical Stories Not Fitting Standard Format
**Problem**: Technical work doesn't fit "As a user..." format
**Solutions**:
1. Use `/create-technical-enablement-story` workflow instead
2. Format: "As a [development team/system] I need to [technical capability] So that I can [enable future capabilities]"
3. Focus on technical value and future enablement
4. Use modified INVEST principles for technical work

#### Team Performance Issues
**Problem**: Team consistently scores below 3.5 average on INVEST
**Solutions**:
1. Run `/story-quality-kpis` to identify specific problem areas
2. Provide targeted training on low-scoring INVEST criteria
3. Pair experienced story writers with team members
4. Regular story writing workshops and practice sessions
5. Review and refine team's Definition of Done

### Getting Help

#### Resources
1. **Confluence Standard**: Page ID 4660658177 - Authoritative source
2. **Claude Code Commands**: `.claude/commands/` - Command implementations
3. **Windsurf Workflows**: `.windsurf/workflows/` - Workflow implementations
4. **Claude Commands README**: `claude-commands/README.md` - Installation guide
5. **This Documentation**: `EPIC_STORY_WORKFLOWS.md` - Usage guide

#### Support Process
1. Check this documentation first
2. Review command/workflow files for specific guidance
3. Consult Confluence standard for authoritative requirements
4. Reach out to team leads or agile coaches for assistance
5. Contribute improvements back to this documentation

## Conclusion

These workflows implement the Wiser Solutions Epic and Story Standard to ensure consistent, high-quality backlog management across all engineering teams. Available for both **Claude Code** and **Windsurf IDE**, teams can:

- Create SMART-compliant Epics that align with business strategy
- Develop INVEST-compliant User Stories that deliver measurable value
- Handle technical work appropriately with Technical Enablement stories
- Track and improve story quality over time
- Maintain healthy backlogs that support predictable delivery

Remember: The goal is consistent, sustainable delivery of value, not perfect scores on every story. Use these tools to improve your team's agile practices and deliver better outcomes for users and the business.

---

**Last Updated**: December 2025  
**Standard Reference**: Wiser Solutions Epic and Story Standard (Confluence Page ID: 4660658177)  
**Workflow Version**: 1.0
