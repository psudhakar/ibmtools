
#!/bin/bash
set -x

# Get Admin token
RBAC_URL='https://rbac-accelerators.icca-test-f72ef11f3ab089a8c677044eb28292cd-0000.us-south.containers.appdomain.cloud'
USER=ICTT_Admin
PASS=QEE7ypnlteICT8jj

access_token=$(curl --location $RBAC_URL'/oauth/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'Username='$USER \
--data-urlencode 'Password='$PASS \
--data-urlencode 'grant_type=client_credentials' | jq -r '.access_token')

# Create org
ORG_ID=TESTORG
ORG_NAME=TESTORG

curl --location $RBAC_URL'/api/rbac/create_organization' \
--header 'accesstoken: '$access_token \
--header 'Content-Type: application/json' \
--data '{"org_id":"'$ORG_ID'","org_name":"'$ORG_NAME'"}'

# Create user
ACCOUNT_ID=TESTACC
ACCOUNT_NAME=TESTACC

user=$(cat User.json | jq)

curl --location $RBAC_URL'/api/rbac/create_user/cassandra' \
--header 'accesstoken: '$access_token \
--header 'Content-Type: application/json' \
--data-raw '{"firstname": '$(echo $user | jq ".firstname")',
"lastname": '$(echo $user | jq ".lastname")',
"role": "Guest",
"type": "User",
"email": '$(echo $user | jq ".email")',
"username": '$(echo $user | jq ".email")',
"org_id": "'$ORG_ID'",
"account_id": "'$ACCOUNT_ID'",
"account_name": "'$ACCOUNT_NAME'",
"org_name": "'$ORG_NAME'"
}'
