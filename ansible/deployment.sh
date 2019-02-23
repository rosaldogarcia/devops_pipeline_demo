x=`kubectl get pods | grep nginx`
if [ $? -eq 0 ]; then
	echo "nginx exist"
	y=`helm list | awk '{print $1}' | sed '/^NAME/d'`
	helm delete $y
	helm install --set scale=3,tag="1.8" ./part2-helmvalues/
else
   echo "doesnt't exist"
	helm install --set scale=3,tag="1.8" ./part2-helmvalues/
fi
