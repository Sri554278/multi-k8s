docker build -t sri554278/multi-docker-client:latest -t sri554278/multi-docker-client:V1.0 ./client
docker build -t sri554278/multi-docker-server:latest -t sri554278/multi-docker-server:V1.0 ./server
docker build -t sri554278/multi-docker-worker:latest -t sri554278/multi-docker-worker:V1.0 ./worker

echo "$DOCKER_HUB_PWD" | docker login -u $DOCKER_HUB_USERID --password-stdin

docker push sri554278/multi-docker-client:latest
docker push sri554278/multi-docker-server:latest
docker push sri554278/multi-docker-worker:latest

docker push sri554278/multi-docker-client:V1.0
docker push sri554278/multi-docker-server:V1.0
docker push sri554278/multi-docker-worker:V1.0

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sri554278/multi-docker-server:V1.0
kubectl set image deployments/client-deployment client=sri554278/multi-docker-client:V1.0
kubectl set image deployments/worker-deployment worker=sri554278/multi-docker-worker:V1.0