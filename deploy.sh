docker build -t vickykrish/multi-client:latest -t vickykrish/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vickykrish/multi-server:latest -t vickykrish/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vickykrish/multi-worker:latest -t vickykrish/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vickykrish/multi-client:latest
docker push vickykrish/multi-server:latest
docker push vickykrish/multi-worker:latest

docker push vickykrish/multi-client:$SHA
docker push vickykrish/multi-server:$SHA
docker push vickykrish/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vickykrish/multi-server:$SHA
kubectl set image deployments/client-deployment client=vickykrish/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vickykrish/multi-worker:$SHA

