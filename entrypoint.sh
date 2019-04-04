#!/bin/bash
set -eu

if [[ -z "$SLACK_BOT_TOKEN" ]]; then
  echo "Set the SLACK_BOT_TOKEN secret."
  exit 1
fi

if [[ -z "$MESSAGE_FILE" ]]; then
    echo "Sending message based on args"
    curl -X POST \
        -H "Content-type: application/json" \
        -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
        -d "$*" \
        https://slack.com/api/chat.postMessage
else
    echo "Sending message from a workspace file"
    message=$(<$GITHUB_WORKSPACE/$MESSAGE_FILE)
    curl -X POST \
        -H "Content-type: application/json" \
        -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
        -d "$message" \
        https://slack.com/api/chat.postMessage
fi
