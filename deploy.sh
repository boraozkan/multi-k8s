docker build -t boraozkan/multi-client:latest -t boraozkan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t boraozkan/multi-server:latest -t boraozkan/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t boraozkan/multi-worker:latest -t boraozkan/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push boraozkan/multi-client:latest
docker push boraozkan/multi-server:latest
docker push boraozkan/multi-worker:latest

docker push boraozkan/multi-client:$SHA
docker push boraozkan/multi-server:$SHA
docker push boraozkan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=boraozkan/multi-server:$SHA
kubectl set image deployments/client-deployment client=boraozkan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=boraozkan/multi-worker:$SHA