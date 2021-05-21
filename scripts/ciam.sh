#!/bin/bash

set -e

r_policy() {
  ACCOUNT_ID=$1

  echo 'Removing AWS ELB policy'
  aws iam delete-policy --policy-arn arn:aws:iam::${ACCOUNT_ID}:policy/eks-saga-elb-orche-policy
  echo 'Removing AWS RDS policy'
  aws iam delete-policy --policy-arn arn:aws:iam::${ACCOUNT_ID}:policy/eks-saga-rds-orche-policy  
  echo 'Removing AWS SQS policy'
  aws iam delete-policy --policy-arn arn:aws:iam::${ACCOUNT_ID}:policy/eks-saga-sqs-orche-policy
  echo 'Removing AWS SNS policy'
  aws iam delete-policy --policy-arn arn:aws:iam::${ACCOUNT_ID}:policy/eks-saga-sns-orche-policy
  echo 'Removing security group'
  aws ec2 delete-security-group --group-name eks-saga-orchestration-sg
}

if [[ $# -ne 2 ]] ; then
  echo 'USAGE: ./ciam.sh accountId demoType'
  exit 1
fi

ACCOUNT_ID=$1
DEMO_TYPE=$2

case "${DEMO_TYPE}" in
  O)
    r_policy ${ACCOUNT_ID}
    ;;

  *)
    echo "Invalid value for demo type ${DEMO_TYPE}. Valid values are O(rchestration)."
    ;;
esac
