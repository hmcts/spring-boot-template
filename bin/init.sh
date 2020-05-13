#!/usr/bin/env sh
#
# Script to initialise project by executing steps as follows:
#   - Replace port number
#   - Replace package `demo`
#   - Replace slug from `spring-boot-template` to one of two (first in first used):
#      - user input
#      - git config value of the root project. Value in use: `remote.origin.url`
#   - Clean-up README file from template related info
#   - Self-destruct

read -p "Port number for new app: " port
read -p "Replace \`demo\` package name with: " package

git_slug=$(git config remote.origin.url | cut -d '/' -f 2)
slug=${git_slug%.*}

read -p "Repo slug: (leave blank for \"$slug\") " new_slug

pushd $(dirname "$0")/.. > /dev/null

if [[ ! -z  "$new_slug"  ]]
then
  slug="$new_slug"
fi

declare -a files_with_port=(.env Dockerfile README.md src/main/resources/application.yaml)
declare -a files_with_slug=(build.gradle docker-compose.yml Dockerfile README.md ./infrastructure/main.tf ./src/main/java/uk/gov/hmcts/reform/demo/controllers/RootController.java)

# Replace port number
for i in ${files_with_port[@]}
do
  perl -i -pe "s/4550/$port/g" ${i}
done

# Replace spring-boot-template slug
for i in ${files_with_slug[@]}
do
  perl -i -pe "s/spring-boot-template/$slug/g" ${i}
done

# Replace demo package in all files under ./src
find ./src -type f -print0 | xargs -0 perl -i -pe "s/reform.demo/reform.$package/g"
perl -i -pe "s/reform.demo/reform.$package/g" build.gradle

# Rename directory to provided package name
git mv src/integrationTest/java/uk/gov/hmcts/reform/demo/ src/integrationTest/java/uk/gov/hmcts/reform/${package}
git mv src/main/java/uk/gov/hmcts/reform/demo/ src/main/java/uk/gov/hmcts/reform/${package}

declare -a headers_to_delete=("Purpose" "What's inside" "Plugins" "Setup" "Hystrix")

# Clean-up README file
for i in "${headers_to_delete[@]}"
do
  perl -0777 -i -p0e "s/## $i.+?\n(## )/\$1/s" README.md
done

# Rename title to slug
perl -i -pe "s/.*\n/# $slug\n/g if 1 .. 1" README.md

# Self-destruct
rm bin/init.sh

# Return to original directory
popd > /dev/null
