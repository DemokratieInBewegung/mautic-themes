#!/bin/bash
set -e

export TARGET_ASSET_ID=1
export SOURCE_REPORT_ID=6
export MAUTIC_LOGIN="ben:benbenben"

export API_BASE="http://192.168.33.10/api"

# fetch current number
COUNT=`curl -s -u$MAUTIC_LOGIN $API_BASE/reports/$SOURCE_REPORT_ID | jq -r .totalResults`

# package
echo {\"count\": $COUNT} > target.json

# upload
FILE_NAME=`curl -s -u$MAUTIC_LOGIN -F file=@target.json $API_BASE/files/assets/new | jq -r .file.name`

echo "new file: $FILE_NAME; count: $COUNT"
curl -s -u$MAUTIC_LOGIN -X PATCH \
	 -H "Content-Type: application/json" \
	 -H "Accept: application/json" \
	 -d "{\"storageLocation\": \"local\", \"file\":\"$FILE_NAME\"}"\
	 $API_BASE/assets/$TARGET_ASSET_ID/edit | jq -r .asset.dateModified

