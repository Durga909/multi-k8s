docker build -t cloud119/multi-client:latest -t cloud119/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t cloud119/multi-server:latest -t cloud119/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cloud119/multi-worker:latest -t cloud119/multi-worker:$SHA -f ./workder/Dockerfile ./worker
docker push cloud119/multi-client:latest
docker push cloud119/multi-server:latest
docker push cloud119/multi-worker:latest
docker push cloud119/multi-client:$SHA
docker push cloud119/multi-server:$SHA
docker push cloud119/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cloud119/multi-server:$SHA
kubectl set image deployments/client-deployment client=cloud119/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cloud119/multi-worker:$SHA