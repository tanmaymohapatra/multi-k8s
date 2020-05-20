docker build -t tanmaymohapatra/multi-client:latest -t tanmaymohapatra/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tanmaymohapatra/multi-server:latest -t tanmaymohapatra/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tanmaymohapatra/multi-worker:latest -t tanmaymohapatra/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tanmaymohapatra/multi-client:latest
docker push tanmaymohapatra/multi-server:latest
docker push tanmaymohapatra/multi-worker:latest

docker push tanmaymohapatra/multi-client:$SHA
docker push tanmaymohapatra/multi-server:$SHA
docker push tanmaymohapatra/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=tanmaymohapatra/multi-client:$SHA
kubectl set image deployments/server-deployment server=tanmaymohapatra/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=tanmaymohapatra/multi-worker:$SHA