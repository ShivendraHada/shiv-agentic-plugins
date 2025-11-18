---
description: Create comprehensive bugfix work items following Wiser's best practices
---

# Create Bugfix Workflow

This workflow helps you create high-quality bugfix work items that follow industry best practices and Wiser's standards.

## Prerequisites

- Access to the bug reporting system (Jira, GitHub Issues, etc.)
- Ability to reproduce the issue or access to reproduction steps
- Understanding of the affected system/component

## Workflow Steps

### 1. Initial Bug Assessment
// turbo
Gather basic information about the bug:
- What system/component is affected?
- When was the bug first noticed?
- Who reported it and how?
- Is this blocking any critical workflows?

### 2. Reproduce the Issue
Attempt to reproduce the bug:
- Follow any provided reproduction steps
- Test in different environments if possible
- Document your reproduction attempts
- If you cannot reproduce, gather more information from the reporter

### 3. Classify Bug Severity
Using Wiser's severity framework, classify the bug:
- **Blocker**: System down, data loss, security breach, blocking production deployment
- **Critical**: Major functionality broken, significant user impact, workaround difficult
- **Major**: Minor functionality issues, moderate user impact, workaround available
- **Minor**: Cosmetic issues, minimal user impact, nice-to-have fixes

### 4. Conduct Initial Impact Assessment
Evaluate the bug's impact:
- How many users are affected?
- What business processes are impacted?
- Is there a workaround available?
- Are there any data integrity concerns?
- Could this affect other systems?

### 5. Create Comprehensive Bug Report
Create a detailed bug report with these sections:

#### Required Information:
1. **Title**: Clear, specific description (e.g., "User login fails with 500 error when using special characters in password")
2. **Summary**: Brief overview of the problem
3. **Environment**: OS, browser, version, deployment environment
4. **Steps to Reproduce**: Detailed, numbered steps
5. **Expected Behavior**: What should happen
6. **Actual Behavior**: What actually happens
7. **Impact Assessment**: Who is affected and how
8. **Severity**: Blocker/Critical/Major/Minor
9. **Priority**: Based on business impact and urgency

#### Additional Information (if available):
10. **Root Cause Analysis**: Technical explanation (if known)
11. **Proposed Solution**: How to fix it (if known)
12. **Test Plan**: How to verify the fix
13. **Risk Assessment**: Potential side effects of the fix
14. **Related Issues**: Links to similar or related bugs
15. **Attachments**: Screenshots, logs, error messages

### 6. Perform Root Cause Analysis (if possible)
If you have the technical expertise, conduct initial root cause analysis:
- Use the 5 Whys technique
- Check recent code changes
- Review error logs and monitoring data
- Identify potential contributing factors
- Document your findings

### 7. Assign Initial Priority and Routing
Based on severity and impact:
- **Blocker**: Immediate escalation, assign to senior developer
- **Critical**: High priority, current sprint, senior developer
- **Major**: Medium priority, next 1-2 sprints, any developer
- **Minor**: Low priority, backlog, good for junior developers

### 8. Add to Appropriate Tracking System
Create the bug in your tracking system with:
- All gathered information
- Appropriate labels/tags
- Component/team assignment
- Severity and priority settings
- Links to related issues

### 9. Notify Stakeholders
Inform relevant parties:
- Development team lead
- Product owner (for user-facing issues)
- Customer support (if customers are affected)
- Security team (for security-related bugs)
- Infrastructure team (for system-level issues)

### 10. Set Up Monitoring (for Critical/Blocker bugs)
For high-severity bugs:
- Set up alerts for related errors
- Monitor user impact metrics
- Track fix progress
- Prepare communication updates

## Special Handling Procedures

### Security Bugs
If the bug has security implications:
- Mark as confidential
- Limit access to security team and assigned developer
- Follow responsible disclosure procedures
- Coordinate with security team before any public communication

### Data Corruption Bugs
If the bug involves data integrity:
- Immediately assess scope of data affected
- Stop any processes that might cause further corruption
- Backup current state for analysis
- Coordinate with data team for recovery planning

### Performance Bugs
If the bug affects system performance:
- Gather performance metrics and baselines
- Identify affected user workflows
- Assess system resource impact
- Consider temporary mitigation measures

### Legacy System Bugs
If the bug is in a legacy system:
- Document current system behavior thoroughly
- Assess risk of making changes
- Consider minimal change approaches
- Plan for extensive testing

## Quality Checklist

Before submitting the bugfix work item, verify:
- [ ] Bug is clearly described and reproducible
- [ ] Severity and priority are appropriate
- [ ] Impact assessment is complete
- [ ] All required fields are filled out
- [ ] Appropriate stakeholders are notified
- [ ] Related issues are linked
- [ ] Supporting materials (logs, screenshots) are attached
- [ ] Security implications are considered
- [ ] Data integrity concerns are addressed

## Follow-up Actions

After creating the bugfix:
- Monitor for additional reports of the same issue
- Track progress on resolution
- Update stakeholders on status changes
- Verify fix when deployed
- Document lessons learned

## Templates

### Bug Title Template
```
[Component] Brief description of the issue
Example: [Login] User authentication fails with special characters in password
```

### Bug Summary Template
```
**What**: Brief description of what's broken
**Impact**: Who/what is affected
**Urgency**: Why this needs attention now
**Workaround**: Any temporary solutions (if available)
```

### Root Cause Analysis Template
```
**Immediate Cause**: What directly caused the failure
**Contributing Factors**: What conditions enabled the failure
**Root Cause**: The fundamental reason the failure occurred
**Prevention**: How to prevent similar issues in the future
```

## Success Criteria

A well-created bugfix work item should:
- Provide enough information for any developer to understand and fix the issue
- Include clear acceptance criteria for verifying the fix
- Be properly prioritized based on business impact
- Have appropriate stakeholder visibility
- Include risk assessment and mitigation strategies
- Follow Wiser's severity classification standards

Remember: The goal is to create actionable, comprehensive bugfix work items that enable efficient resolution while maintaining high quality standards.
