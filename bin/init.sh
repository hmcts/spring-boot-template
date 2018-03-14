#!/usr/bin/env sh
#
# Script to initialise project by executing steps as follows:
#   - Replace port number with given 1st argument
#   - Replace package name from `demo` to given 2nd argument
#   - Replace slug from `spring-boot-template` to one of two (first in first used):
#      - 3rd argument
#      - git config value of the root project. Value in use: `remote.origin.url`
#   - Clean-up README file from template related info
#   - Self-destruct

if [ "$#" -le 1 ]
then
  echo "Usage: $0 port package [slug]

  If slug is not present script will try to pick it up from git config, remote.origin.url
  "
  exit 0
fi

cd $(dirname "$0")/..

port=$1
package=$2
slug=$3

if [[ -z  "$slug"  ]]
then
  git_slug=$(git config remote.origin.url | cut -d '/' -f 2)
  slug=${git_slug%.*}
fi

if [[ -z  "$slug"  ]]
then
  echo "Could not find any slug"
  exit 1
fi

declare -a files_with_port=(.env Dockerfile README.md src/main/resources/application.yaml)
declare -a files_with_slug=(build.gradle docker-compose.yml Dockerfile README.md web.config)

for i in ${files_with_port[@]}
do
  sed -i '' "s/4550/$port/g" ${i}
done

for i in ${files_with_slug[@]}
do
  sed -i '' "s/spring-boot-template/$slug/g" ${i}
done

find ./src -type f -print0 | xargs -0 sed -i '' "s/reform.demo/reform.$package/g"

cd src/main/java/uk/gov/hmcts/reform

mv demo ${package}

cd $(dirname "$0")/..

cd src/test/java/uk/gov/hmcts/reform

mv demo ${package}

cd $(dirname "$0")/..

declare -a headers_to_delete=("Purpose" "What's inside" "Plugins" "Hystrix")

for i in "${headers_to_delete[@]}"
do
  perl -0777 -i -p0e "s/## $i.+?\n(## )/\$1/s" README.md
done

rm bin/init.sh
