#!/usr/bin/env bash
set -e

PACKAGE_VERSION=$(node -p "require('./package.json').version")

function die() {
  echo $1
  exit 1;
}

# Initialize all the option variables.
# This ensures we are not contaminated by variables from the environment.
installer=npm
sonar=true

while :; do
  case $1 in
    -y|--yarn)
      installer=yarn
      ;;
    -n|--no-sonar)
      sonar=false
      ;;
    --)              # End of all options.
      shift
      break
      ;;
    -?*)
      printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
      ;;
    *)               # Default case: No more options, so break out of the loop.
      break
  esac

  shift
done

if [[ ! -d node_modules ]]; then
  if [[ ${installer} = yarn ]]; then
    echo "[Documentation] installing dependencies with ${installer}"
    [[ $(which yarn) = "" ]] && curl -o- -L https://yarnpkg.com/install.sh | bash
    yarn
  else
    npm install
  fi
fi

npm test

# Sonar scanner
LCOV_INFO_PATH=${LCOV_INFO_PATH:-"coverage/lcov.info"}

if [[ $(which sonar-scanner) ]] && [[ ${sonar} = true ]] && [[ -f "${LCOV_INFO_PATH}" ]]; then
  # Travis will use sonar cloud for OSS
  if [[ -v TRAVIS_BUILD_ID ]]; then
    SONAR_VERSION=${PACKAGE_VERSION}-b${TRAVIS_BUILD_ID}-${TRAVIS_BRANCH}
    if [[ ${TRAVIS_BRANCH} != greenkeeper* && -n ${SONAR_TOKEN} ]]; then sonar-scanner -Dsonar.projectVersion=${SONAR_VERSION}; fi
  fi
fi
