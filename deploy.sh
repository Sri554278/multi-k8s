docker build -t sri554278/multi-docker-client:latest -f ./client/Dockerfile ./client
docker build -t sri554278/multi-docker-server:latest -f ./server/Dockerfile ./server
docker build -t sri554278/multi-docker-worker:latest -f ./worker/Dockerfile ./worker

docker push sri554278/multi-docker-client:latest
docker push sri554278/multi-docker-server:latest
docker push sri554278/multi-docker-worker:latest

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sri554278/multi-docker-server
kubectl set image deployments/client-deployment client=sri554278/multi-docker-client
kubectl set image deployments/worker-deployment worker=sri554278/multi-docker-worker