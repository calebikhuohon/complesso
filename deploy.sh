 docker build -t calebikhuohon/complesso-client:latest -t calebikhuohon/complesso-client:$GIT_SHA -f ./client/Dockerfile ./client
 docker build -t calebikhuohon/complesso-server:latest -t calebikhuohon/complesso-server:$GIT_SHA -f ./server/Dockerfile ./server
 docker build -t calebikhuohon/complesso-worker:latest -t calebikhuohon/complesso-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
 docker push calebikhuohon/complesso-client:latest
 docker push calebikhuohon/complesso-server:latest
 docker push calebikhuohon/complesso-worker:latest

 docker push calebikhuohon/complesso-client:$GIT_SHA
 docker push calebikhuohon/complesso-server:$GIT_SHA
 docker push calebikhuohon/complesso-worker:$GIT_SHA
 
 kubectl apply -f k8s
 kubectl set image deployments/server-deployment server=calebikhuohon/complesso-client:$GIT_SHA
 kubectl set image deployments/client-deployment client=calebikhuohon/complesso-client:$GIT_SHA
 kubectl set image deployments/worker-deployment worker=calebikhuohon/complesso-worker:$GIT_SHA