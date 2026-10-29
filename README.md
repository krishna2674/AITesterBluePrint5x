# AI Tester Blueprint 5x

QA skills and sample artifacts for test planning, test case creation, and API response validation.

## Project contents

- `Chapter_00_Skill_Basic/skills/00_Basic_Skills/`: basic test planning, test case, and API validation skills.
- `Chapter_00_Skill_Basic/skills/01_Advance_Skills/test/testplan-creator-skill/`: Jira-based test planning skill, requirement checklist, template, company assets, and fetch script.
- `Chapter_00_Skill_Basic/resources/`: local sample requirements; Jira exports are excluded from Git.
- `output/`: local generated PDF test plans and sample test case artifacts, excluded from Git. Plans remain drafts until reviewed and approved.

## Jira setup

Copy `Chapter_00_Skill_Basic/.env.example` to `Chapter_00_Skill_Basic/.env` and provide your Jira site URL, Atlassian email, and API token. The local `.env` and temporary files are excluded from Git.

From the repository root, run the following in Git Bash or another Bash shell with `curl` available:

```bash
cd Chapter_00_Skill_Basic
set -a
source .env
set +a
bash skills/01_Advance_Skills/test/testplan-creator-skill/scripts/fetch-jira.sh VP-2
```

Replace `VP-2` with the issue key you want to retrieve. The script writes the Jira issue JSON to standard output.

## Creating a test plan

Follow the advanced test plan skill and its referenced checklist and template. Use the fetched issue as the requirements source, record gaps and assumptions, and save the requested artifact in `output/`. The skill requires human review before the plan is approved or detailed test cases and automation are created.
