docker build -t sri554278/multi-client:latest -t sri554278/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sri554278/multi-server:latest -t sri554278/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sri554278/multi-worker:latest -t sri554278/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sri554278/multi-client:latest
docker push sri554278/multi-server:latest
docker push sri554278/multi-worker:latest

docker push sri554278/multi-client:$SHA
docker push sri554278/multi-server:$SHA
docker push sri554278/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sri554278/multi-server:$SHA
kubectl set image deployments/client-deployment client=sri554278/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sri554278/multi-worker:$SHA