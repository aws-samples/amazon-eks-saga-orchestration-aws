#!/bin/bash

set -e 

o_policy() {
  REGION_ID=$1
  ACCOUNT_ID=$2

  JSON_DIR=../json
  cd ${JSON_DIR}
  
  sed -e 's/regionId/'"${REGION_ID}"'/g' -e 's/accountId/'"${ACCOUNT_ID}"'/g' ${JSON_DIR}/eks-saga-sqs-orche-policy.json > ${JSON_DIR}/eks-saga-sqs-orche-policy.json.policy
  POLICY_ARN=`aws iam create-policy --policy-name eks-saga-sqs-orche-policy --policy-document file://eks-saga-sqs-orche-policy.json.policy --query 'Policy.Arn' --output text`
  echo "SQS Policy ARN: ${POLICY_ARN}"

  sed -e 's/regionId/'"${REGION_ID}"'/g' -e 's/accountId/'"${ACCOUNT_ID}"'/g' ${JSON_DIR}/eks-saga-sns-orche-policy.json > ${JSON_DIR}/eks-saga-sns-orche-policy.json.policy
  POLICY_ARN=`aws iam create-policy --policy-name eks-saga-sns-orche-policy --policy-document file://eks-saga-sns-orche-policy.json.policy --query 'Policy.Arn' --output text`
  echo "SNS Policy ARN: ${POLICY_ARN}"

  rm ${JSON_DIR}/eks-saga-sqs-orche-policy.json.policy
}

elb_policy() {
  REGION_ID=$1
  ACCOUNT_ID=$2

  JSON_DIR=../json
  cd ${JSON_DIR}

  curl -o eks-saga-elb-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.2.0/docs/install/iam_policy.json

  POLICY_ARN=`aws iam create-policy --policy-name eks-saga-elb-orche-policy --policy-document file://eks-saga-elb-policy.json --query 'Policy.Arn' --output text`
  echo "ELB Policy ARN: ${POLICY_ARN}"
}

if [[ $# -ne 3 ]] ; then
  echo 'USAGE: ./iam.sh regionId accountId demoType'
  exit 1
fi

REGION_ID=$1
ACCOUNT_ID=$2
DEMO_TYPE=$3

case "${DEMO_TYPE}" in
  O)
    o_policy ${REGION_ID} ${ACCOUNT_ID}
    ;;

  *)
    echo "Invalid value for demo type ${DEMO_TYPE}. Valid values are O(chestration)."
    ;;
esac

elb_policy