docker build -t sri554278/multi-docker-client:latest -t sri554278/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t sri554278/multi-docker-server:latest -t sri554278/multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t sri554278/multi-docker-worker:latest -t sri554278/multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sri554278/multi-docker-client:latest
docker push sri554278/multi-docker-client:$SHA

docker push sri554278/multi-docker-server:latest
docker push sri554278/multi-docker-server:$SHA

docker push sri554278/multi-docker-worker:latest
docker push sri554278/multi-docker-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sri554278/multi-docker-server:$SHA
kubectl set image deployments/client-deployment client=sri554278/multi-docker-client:$SHA
kubectl set image deployments/worker-deployment worker=sri554278/multi-docker-worker:$SHA