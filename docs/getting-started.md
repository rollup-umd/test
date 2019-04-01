$PACKAGE_NAME contain the job test stage for all rollup-umd project.

You can run the build stage by doing:

```bash
npx $PACKAGE_NAME
```

It should be installed as a `devDependencies` so we can follow the version used by the rollup-umd project.

To use it, just use the script within your `.travis.yml`:


```yml
# Job: Test
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

Note: 

`organization` is necessary to use the travis sonarcloud driver.
Using `$(echo $TRAVIS_REPO_SLUG | awk -F '/' '{print $1}')` we set it to the github namespace of the project. 
