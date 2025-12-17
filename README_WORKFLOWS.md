# Epic and Story Workflows - Quick Reference

This repository includes comprehensive Windsurf workflows for creating high-quality Epics and User Stories following the Wiser Solutions standard.

## 🚀 Quick Start

1. **Open this repository in Windsurf IDE**
2. **Type `/` in chat** to see available workflows
3. **Start creating**:
   - `/create-epic` - Create SMART-compliant Epics
   - `/create-story` - Create INVEST-compliant User Stories
   - `/create-technical-enablement-story` - Create technical work stories

## 📋 Available Workflows

| Command | Purpose | Output |
|---------|---------|---------|
| `/create-epic` | Create strategic epics | SMART-compliant epic with business justification |
| `/create-story` | Create user stories | INVEST-compliant story with Gherkin acceptance criteria |
| `/create-technical-enablement-story` | Create technical work stories | Technical story with modified INVEST principles |
| `/story-invest-score` | Analyze story quality | Individual story quality assessment and recommendations |
| `/story-quality-kpis` | Track team performance | Team-level quality metrics and trends |

## 🎯 Standards Summary

### Epics (SMART Criteria)
- **Duration**: 6-12 weeks maximum
- **Quality Threshold**: ≥20/25 SMART score
- **Breakdown**: 5-15 user stories per epic
- **Format**: Business justification + measurable success criteria

### User Stories (INVEST Principles)
- **Format**: "As a [role] I need to [action] So that I can [value]"
- **Quality Threshold**: ≥21/30 INVEST score (3.5-4.0 average)
- **Acceptance Criteria**: Gherkin syntax required (Given/When/Then)
- **Size**: 1-8 story points, completable in one sprint

### Technical Enablement Stories
- **Format**: "As a [team/system] I need to [capability] So that I can [enable future work]"
- **Purpose**: Infrastructure, technical debt, platform capabilities
- **Focus**: Technical value that enables future user stories

## 📚 Full Documentation

**👉 See [EPIC_STORY_WORKFLOWS.md](./EPIC_STORY_WORKFLOWS.md) for comprehensive documentation including:**

- Detailed installation instructions
- Step-by-step workflow usage
- Quality tracking and team KPIs
- Best practices and troubleshooting
- Example outputs and templates

## 🏗️ File Structure

```
├── .windsurf/workflows/          # Windsurf workflow files
│   ├── create-epic.md           # Epic creation workflow
│   ├── create-story.md          # User story creation workflow
│   ├── create-technical-enablement-story.md  # Technical story workflow
│   ├── story-invest-score.md    # Story quality analysis
│   ├── story-quality-kpis.md    # Team performance tracking
│   └── agile-rules.md           # Core agile rules and standards
├── EPIC_STORY_WORKFLOWS.md      # 📖 Comprehensive documentation
└── README_WORKFLOWS.md          # 📋 This quick reference
```

## 🎓 Learning Path

1. **Start Here**: Read this quick reference
2. **Deep Dive**: Review [EPIC_STORY_WORKFLOWS.md](./EPIC_STORY_WORKFLOWS.md)
3. **Practice**: Create your first epic with `/create-epic`
4. **Refine**: Break epic into stories with `/create-story`
5. **Improve**: Use quality workflows to track and improve

## 🔗 References

- **Wiser Solutions Epic and Story Standard**: Confluence Page ID 4660658177
- **SMART Criteria**: Specific, Measurable, Achievable, Relevant, Time-bound
- **INVEST Principles**: Independent, Negotiable, Valuable, Estimable, Small, Testable

## 🆘 Need Help?

1. **Check the docs**: [EPIC_STORY_WORKFLOWS.md](./EPIC_STORY_WORKFLOWS.md)
2. **Review examples**: Workflow files include sample outputs
3. **Ask for help**: Reach out to team leads or agile coaches

---

**Ready to create high-quality Epics and Stories? Start with `/create-epic` in Windsurf!** 🚀
