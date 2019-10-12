docker build -t gcr.io/kubernetes-sj/multi-client:latest -t gcr.io/kubernetes-sj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gcr.io/kubernetes-sj/multi-server:latest -t gcr.io/kubernetes-sj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gcr.io/kubernetes-sj/multi-worker:latest -t gcr.io/kubernetes-sj/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gcr.io/kubernetes-sj/multi-client:latest
docker push gcr.io/kubernetes-sj/multi-server:latest
docker push gcr.io/kubernetes-sj/multi-worker:latest

docker push gcr.io/kubernetes-sj/multi-client:$SHA
docker push gcr.io/kubernetes-sj/multi-server:$SHA
docker push gcr.io/kubernetes-sj/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gcr.io/kubernetes-sj/multi-server:$SHA
kubectl set image deployments/client-deployment client=gcr.io/kubernetes-sj/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gcr.io/kubernetes-sj/multi-worker:$SHA