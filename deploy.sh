docker build -t gustavomoreirapt/multi-client:latest -t gustavomoreirapt/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gustavomoreirapt/multi-server:latest -t gustavomoreirapt/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gustavomoreirapt/multi-worker:latest -t gustavomoreirapt/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gustavomoreirapt/multi-client:latest
docker push gustavomoreirapt/multi-server:latest
docker push gustavomoreirapt/multi-worker:latest
docker push gustavomoreirapt/multi-client:$SHA
docker push gustavomoreirapt/multi-server:$SHA
docker push gustavomoreirapt/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gustavomoreirapt/multi-server:$SHA
kubectl set image deployments/client-deployment client=gustavomoreirapt/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gustavomoreirapt/multi-worker:$SHA
