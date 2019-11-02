docker build -t znoori455/multi-client:latest -t znoori455/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t znoori455/multi-server:latest -t znoori455/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t znoori455/multi-worker:latest -t znoori455/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push znoori455/multi-client:latest
docker push znoori455/multi-server:latest
docker push znoori455/multi-worker:latest

docker push znoori455/multi-client:$SHA
docker push znoori455/multi-server:$SHA
docker push znoori455/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=znoori455/multi-server:$SHA
kubectl set image deployments/client-deployment client=znoori455/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=znoori455/multi-worker:$SHA