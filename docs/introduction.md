[![build status]($CI_PROJECT_URL/badges/v$PACKAGE_VERSION/build.svg)]($CI_PROJECT_URL/commits/v$PACKAGE_VERSION)
[![coverage report]($CI_PROJECT_URL/badges/v$PACKAGE_VERSION/coverage.svg)]($CI_PROJECT_URL/commits/v$PACKAGE_VERSION)

![image](https://img.shields.io/badge/version-$PACKAGE_VERSION-green.svg)
![image](https://img.shields.io/badge/node-$NODE_VERSION-brightgreen.svg)
![image](https://img.shields.io/badge/npm-$NPM_VERSION-red.svg)
![image](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)
![image]($IMG_SHIELD_PUBLISHING)

$PACKAGE_DESCRIPTION

## Sonarcloud 

On GitHub projects, we push our test coverage to [sonarcloud](https://sonarcloud.io/), it can be set up in a Travis job.

Within `.travis.yml`:

```yml
- stage: test
  node_js:
    - 'lts/*'
    - '10'
    - '8'
  addons:
    sonarcloud:
      organization: $(echo $TRAVIS_REPO_SLUG | awk -F '/' '{print $1}')
  script:
    - npx $PACKAGE_NAME
```

- `organization` is required, we use the travis repo namespace (`$(echo $TRAVIS_REPO_SLUG | awk -F '/' '{print $1}')` will set it).

### Environment 

`LCOV_INFO_PATH`: path of lcov test result file (default: `coverage/lcov.info`). 

We use [`jest`](https://jestjs.io/) and [`jest-sonar-reporter`](https://www.npmjs.com/package/jest-sonar-reporter) to create one.
