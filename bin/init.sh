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
read -p "Repo product: (It's first part of the git repo name. Often a team name) " product_name
read -p "Repo component: (It's second part of git repo name. Application name) " component_name

pushd $(dirname "$0")/.. > /dev/null

slug="$product_name-$component_name"

declare -a files_with_port=(.env Dockerfile README.md src/main/resources/application.yaml charts/rpe-spring-boot-template/values.yaml)
declare -a files_with_slug=(build.gradle docker-compose.yml Dockerfile README.md ./infrastructure/main.tf ./src/main/java/uk/gov/hmcts/reform/demo/controllers/RootController.java charts/rpe-spring-boot-template/Chart.yaml)

# Replace in CNP file
for i in "Jenkinsfile_template"
do
  perl -i -pe "s/rpe/$product_name/g" ${i}
  perl -i -pe "s/demo/$component_name/g" ${i}
done

# Replace image repo
for i in "charts/rpe-spring-boot-template/values.yaml"
do
  perl -i -pe "s/rpe/$product_name/g" ${i}
  perl -i -pe "s/spring-boot-template/$component_name/g" ${i}
done

#update maintainer name
for i in "charts/rpe-spring-boot-template/Chart.yaml"
do
  perl -i -pe "s/rpe/$product_name/g" ${i}
done

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

# Rename charts directory
git mv charts/rpe-spring-boot-template charts/${slug}

# Rename directory to provided package name
git mv src/integrationTest/java/uk/gov/hmcts/reform/demo/ src/integrationTest/java/uk/gov/hmcts/reform/${package}
git mv src/main/java/uk/gov/hmcts/reform/demo/ src/main/java/uk/gov/hmcts/reform/${package}

# Rename CNP file
git mv Jenkinsfile_template Jenkinsfile_CNP

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
