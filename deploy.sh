docker build -t northernjay/multi-client:latest -t northernjay/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t northernjay/multi-server -t northernjay/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t northernjay/multi-worker -t northernjay/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push northernjay/multi-client:latest
docker push northernjay/multi-server:latest
docker push northernjay/multi-worker:latest

docker push northernjay/multi-client:$SHA
docker push northernjay/multi-server:$SHA
docker push northernjay/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=northernjay/multi-server:$SHA
kubectl set image deployments/client-deployment client=northernjay/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=northernjay/multi-worker:$SHA