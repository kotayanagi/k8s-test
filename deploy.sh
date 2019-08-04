docker build -t kotayanagi/multi-client:latest -t kotayanagi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kotayanagi/multi-server:latest -t kotayanagi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kotayanagi/multi-worker:latest -t kotayanagi/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kotayanagi/multi-client:latest
docker push kotayanagi/multi-server:latest
docker push kotayanagi/multi-worker:latest

docker push kotayanagi/multi-client:$SHA
docker push kotayanagi/multi-server:$SHA
docker push kotayanagi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kotayanagi/multi-server:$SHA
kubectl set image deployments/client-deployment client=kotayanagi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kotayanagi/multi-worker:$SHA