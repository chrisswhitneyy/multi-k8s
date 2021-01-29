docker build -t cw729/multi-client:latest -t cw729/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cw729/multi-server:latest -t cw729/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cw729/multi-worker:latest -t cw729/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push cw729/multi-client:latest
docker push cw729/multi-client:$SHA
docker push cw729/multi-server:latest
docker push cw729/multi-server:$SHA
docker push cw729/multi-worker:latest
docker push cw729/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment server=cw729/multi-client:$SHA
kubectl set image deployments/server-deployment server=cw729/multi-server:$SHA
kubectl set image deployments/worker-deployment server=cw729/multi-worker:$SHA
