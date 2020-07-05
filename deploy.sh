docker build -t sri554278/multi-docker-client:latest -t sri554278/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t sri554278/multi-docker-server:latest -t sri554278/multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t sri554278/multi-docker-worker:latest -t sri554278/multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker

docker push $DOCKER_HUB_USERID/multi-docker-client:latest
docker push $DOCKER_HUB_USERID/multi-docker-client:$SHA

docker push $DOCKER_HUB_USERID/multi-docker-server:latest
docker push $DOCKER_HUB_USERID/multi-docker-server:$SHA

docker push $DOCKER_HUB_USERID/multi-docker-worker:latest
docker push $DOCKER_HUB_USERID/multi-docker-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=$DOCKER_HUB_USERID/multi-docker-server:$SHA
kubectl set image deployments/client-deployment client=$DOCKER_HUB_USERID/multi-docker-client:$SHA
kubectl set image deployments/worker-deployment worker=$DOCKER_HUB_USERID/multi-docker-worker:$SHA