// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved. // SPDX-License-Identifier: CC-BY-SA-4.0

# Introduction

This page has instructions to set-up IAM policies for SQS, SNS and ELB.

- [Introduction](#introduction)
  - [Usage](#usage)

## Usage

Run this command for **Orchestration** pattern.

```bash
git clone ${GIT_URL}/amazon-eks-saga-orchestration-aws
cd amazon-eks-saga-orchestration-aws/scripts
./iam.sh ${REGION_ID} ${ACCOUNT_ID} O
```

To remove IAM set-up, run the following commands.

```bash
git clone ${GIT_URL}/amazon-eks-saga-orchestration-aws
cd amazon-eks-saga-orchestration-aws/scripts
./ciam.sh ${ACCOUNT_ID} O
```
