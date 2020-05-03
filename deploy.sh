docker build -t sekhar92/multi-client:latest -t sekhar92/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sekhar92/multi-server:latest -t sekhar92/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sekhar92/multi-worker:latest -t sekhar92/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push sekhar92/multi-client:latest
docker push sekhar92/multi-server:latest
docker push sekhar92/multi-worker:latest
docker push sekhar92/multi-client:$SHA
docker push sekhar92/multi-server:$SHA
docker push sekhar92/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=sekhar92/multi-client:$SHA 
kubectl set image deployments/server-deployment server=sekhar92/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=sekhar92/multi-worker:$SHA