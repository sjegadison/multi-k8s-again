docker build -t sjegadison/multi-client:latest -t sjegadison/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sjegadison/multi-server:latest -t sjegadison/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sjegadison/multi-worker:latest -t sjegadison/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sjegadison/multi-client:latest
docker push sjegadison/multi-server:latest
docker push sjegadison/multi-worker:latest

docker push sjegadison/multi-client:$SHA
docker push sjegadison/multi-server:$SHA
docker push sjegadison/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sjegadison/multi-server:$SHA
kubectl set image deployments/client-deployment client=sjegadison/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sjegadison/multi-worker:$SHA