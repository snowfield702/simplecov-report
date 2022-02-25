# simplecov-report

A GitHub Action that report simplecov coverage.

![Simplecov Report Capture](https://user-images.githubusercontent.com/15631129/155669253-66115d4b-28f5-47f1-8f07-1bde1744b999.png)

You can check the detailed report results by clicking the link.

![SimoleCov Report Files Capture](https://user-images.githubusercontent.com/15631129/155669639-43803f9d-3652-4ac2-9d37-cbfdf4cf6be0.png)

# Usage

## Inputs

| name | overview |
| ----- | ----- |
| coverage_path | Path where simplecov outputs coverage files |
| upload_destination | Upload destination S3 key |
| upload_bucket | Upload destination S3 bucket |
| comment | Comments to output to pull request |
| domain | Upload destination S3 domain |

## Preparation
- Install aws-cli ( reference: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html )
- Install gh ( reference: https://github.com/cli/cli/blob/trunk/docs/install_linux.md )
- Configure aws credentials ( reference: https://github.com/aws-actions/configure-aws-credentials )

## Exsample

```json
name: simplecov-report / test
on:
  pull_request:
jobs:
  simplecov-report:
    runs-on: ubuntu-latest
    permissions:
      id-token: write # GitHub OIDC with AWS
      contents: read
      pull-requests: write
    steps:
      - uses: actions/checkout@v2
      - uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-region: ap-northeast-1
          role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
      - uses: ruby/setup-ruby@v1
        with:
          bundler-cache: true
          working-directory: ./sample_simplecov
      - name: Run rspec
        run: bundle exec rspec
        working-directory: ./sample_simplecov
      - uses: ./
        with:
          coverage_path: sample_simplecov/coverage
          upload_destination: simplecov_coverage
          upload_bucket: snowfield702-sample
          comment: Please check coverage report (no branch coverage)
          domain: snowfield702-sample.s3.ap-northeast-1.amazonaws.com
```
