docker build -t sri554278/multi-docker-client -f ./client/Dockerfile ./client
docker build -t sri554278/multi-docker-server -f ./server/Dockerfile ./server
docker build -t sri554278/multi-docker-worker -f ./worker/Dockerfile ./worker
docker push sri554278/multi-docker-client
docker push sri554278/multi-docker-server
docker push sri554278/multi-docker-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sri554278/multi-docker-server
kubectl set image deployments/client-deployment client=sri554278/multi-docker-client
kubectl set image deployments/worker-deployment worker=sri554278/multi-docker-worker