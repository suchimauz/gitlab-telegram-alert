# Gitlab Telegram Alert
Docker image for send gitlab ci/cd build results to telegram chat

## Usage

Set global environment variables in .gitlab-ci.yml:

```Yaml
variables:
  # ... some variables
  PARSE_MODE: 'Markdown' # Support HTML, default: Markdown
  CHAT_ID: $CHAT_ID      # Set CHAT_ID repository secret
  BOT_TOKEN: $BOT_TOKEN  # Set BOT_TOKEN repository secret
```

Job for notify success build:

```Yaml
notify_success:
  stage: <stage>
  image: suchimauz/gitlab-telegram-alert:v1.0.0
  variables:
    GIT_STRATEGY: none
    MESSAGE: |
      ✅ Success build \*$CI_PROJECT_NAME:$CI_COMMIT_BRANCH\*
      $CI_COMMIT_TITLE

      Commit by: \*$CI_COMMIT_AUTHOR\*
      $CI_PIPELINE_URL
  # It's hack :(
  script:
    - /entrypoint.sh
  rules:
    - if: '$CI_COMMIT_BRANCH == "master"'
```

Also for error build:

```Yaml
notify_error:
  stage: <stage>
  image: suchimauz/gitlab-telegram-alert:v1.0.0
  variables:
    GIT_STRATEGY: none
    MESSAGE: |
      ❌ Error build \*$CI_PROJECT_NAME:$CI_COMMIT_BRANCH\*
      $CI_COMMIT_TITLE

      Commit by: \*$CI_COMMIT_AUTHOR\*
      $CI_PIPELINE_URL
  script:
    - /entrypoint.sh
  rules:
    - if: '$CI_COMMIT_BRANCH == "master"'
      when: on_failure
```

Don't forget to add your stage to the stages section:

```Yaml
variables: 
  #...

stages:
  # some stages
  - <stage>
  
notify_success:
  stage: <stage>
  #...
notify_error:
  stage: <stage>
  #...
```

Also you can customize your message as you like using environments from gitlab ci/cd: https://docs.gitlab.com/ee/ci/variables/
