#!/bin/bash
AWS_DEFAULT_REGION=us-east-2
IMAGE_REPO_NAME=app3
IMAGE_TAG=latest2
AWS_ACCOUNT_ID=559647411882

aws ecr get-login --no-include-email --region $AWS_DEFAULT_REGION
sleep 1
echo Build started on `date`
echo Building the Docker image...
docker build -t $IMAGE_REPO_NAME:$IMAGE_TAG .
docker tag $IMAGE_REPO_NAME:$IMAGE_TAG $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$IMAGE_REPO_NAME:$IMAGE_TAG
echo Build completed on `date`
echo Pushing the Docker image...
sleep 1
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$IMAGE_REPO_NAME:$IMAGE_TAG
sleep 1
docker rmi $IMAGE_REPO_NAME:$IMAGE_TAG
sleep 1
docker rmi $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$IMAGE_REPO_NAME:$IMAGE_TAG 
