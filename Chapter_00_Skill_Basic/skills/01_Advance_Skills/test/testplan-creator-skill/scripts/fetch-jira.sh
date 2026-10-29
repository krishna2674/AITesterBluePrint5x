#!/usr/bin/env bash
set -euo pipefail

# Fetch a Jira Cloud issue as JSON on stdout.
# Required environment variables: JIRA_BASE_URL, JIRA_EMAIL, JIRA_TOKEN.
# Example:
#   export JIRA_BASE_URL='https://your-company.atlassian.net'
#   export JIRA_EMAIL='your-email@example.com'
#   export JIRA_TOKEN='YOUR_API_TOKEN'
#   bash scripts/fetch-jira.sh VWO-49 > VWO-49.json

usage() {
  printf 'Usage: %s <JIRA-KEY>\n' "${0##*/}"
  printf 'Requires JIRA_BASE_URL, JIRA_EMAIL, and JIRA_TOKEN in the environment.\n'
}

if [[ "${1:-}" == '-h' || "${1:-}" == '--help' ]]; then
  usage
  exit 0
fi

if [[ $# -ne 1 ]]; then
  usage >&2
  exit 1
fi

issue_key="$1"
if [[ ! "$issue_key" =~ ^[A-Za-z][A-Za-z0-9_]*-[0-9]+$ ]]; then
  printf 'Invalid Jira issue key. Example: VWO-49\n' >&2
  exit 1
fi

: "${JIRA_BASE_URL:?Set JIRA_BASE_URL to your Jira site URL}"
: "${JIRA_EMAIL:?Set JIRA_EMAIL to your Atlassian email address}"
: "${JIRA_TOKEN:?Set JIRA_TOKEN to your Atlassian API token}"

if [[ "$JIRA_BASE_URL" != https://* ]]; then
  printf 'JIRA_BASE_URL must start with https://.\n' >&2
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  printf 'curl is required to fetch Jira tickets.\n' >&2
  exit 1
fi

curl --fail --silent --show-error \
  --connect-timeout 10 \
  --max-time 60 \
  --request GET \
  --url "${JIRA_BASE_URL%/}/rest/api/3/issue/${issue_key}" \
  --user "${JIRA_EMAIL}:${JIRA_TOKEN}" \
  --header 'Accept: application/json'
