docker build -t vinfreeman/multi-client:latest -t vinfreeman/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t vinfreeman/multi-server:latest -t vinfreeman/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t vinfreeman/multi-worker:latest -t vinfreeman/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push vinfreeman/multi-client:latest
docker push vinfreeman/multi-server:latest
docker push vinfreeman/multi-worker:latest

docker push vinfreeman/multi-client:$GIT_SHA
docker push vinfreeman/multi-server:$GIT_SHA
docker push vinfreeman/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vinfreeman/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=vinfreeman/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=vinfreeman/multi-worker:$GIT_SHA