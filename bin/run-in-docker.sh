#!/usr/bin/env sh

print_help() {
  echo "Script to run docker containers for Spring Boot Template API service

  Usage:

  ./run-in-docker.sh [OPTIONS]

  Options:
    --clean, -c                   Clean and install current state of source code
    --install, -i                 Install current state of source code
    --param PARAM=, -p PARAM=     Parse script parameter
    --help, -h                    Print this help block

  Available parameters:

  "
}

# script execution flags
GRADLE_CLEAN=false
GRADLE_INSTALL=false

# TODO custom environment variables application requires.
# TODO also consider enlisting them in help string above ^
# TODO sample: DB_PASSWORD   Defaults to 'dev'
# environment variables
#DB_PASSWORD=dev
#S2S_URL=localhost
#S2S_SECRET=secret

execute_script() {
  cd $(dirname "$0")/..

  if [ ${GRADLE_CLEAN} = true ]
  then
    echo "Clearing previous build.."
    ./gradlew clean
  fi

  if [ ${GRADLE_INSTALL} = true ]
  then
    echo "Assembling distribution.."
    ./gradlew assemble
  fi

#  echo "Assigning environment variables.."
#
#  export DB_PASSWORD=${DB_PASSWORD}
#  export S2S_URL=${S2S_URL}
#  export S2S_SECRET=${S2S_SECRET}

  echo "Bringing up docker containers.."

  docker compose up
}

while true ; do
  case "$1" in
    -h|--help) print_help ; shift ; break ;;
    -c|--clean) GRADLE_CLEAN=true ; GRADLE_INSTALL=true ; shift ;;
    -i|--install) GRADLE_INSTALL=true ; shift ;;
    -p|--param)
      case "$2" in
#        DB_PASSWORD=*) DB_PASSWORD="${2#*=}" ; shift 2 ;;
#        S2S_URL=*) S2S_URL="${2#*=}" ; shift 2 ;;
#        S2S_SECRET=*) S2S_SECRET="${2#*=}" ; shift 2 ;;
        *) shift 2 ;;
      esac ;;
    *) execute_script ; break ;;
  esac
done
