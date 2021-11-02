#!/bin/bash
MYPATH=$(cd $(dirname "$0"); pwd)
EXIST=$(cat)
echo '#!/bin/bash'
echo 'NAME=$1'
echo 'cat <<EOF'
echo "$EXIST" | bash "${MYPATH}/cleanse.sh" | ./jq '. + { "name": "${NAME}" }'
echo 'EOF'
