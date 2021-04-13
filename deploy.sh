docker build -t northernjay885/multi-client:latest -t northernjay885/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t northernjay885/multi-server -t northernjay885/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t northernjay885/multi-worker -t northernjay885/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push northernjay885/multi-client:latest
docker push northernjay885/multi-server:latest
docker push northernjay885/multi-worker:latest

docker push northernjay885/multi-client:$SHA
docker push northernjay885/multi-server:$SHA
docker push northernjay885/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=northernjay885/multi-server:$SHA
kubectl set image deployments/client-deployment client=northernjay885/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=northernjay885/multi-worker:$SHA