curl -L -H 'Content-Type: application/json' -X \\
POST -d '{ 
  "id": "/product/service/mybigseaapp", 
  "cmd": "env && sleep 300", 
  "cpus": 1.5, 
  "mem": 256.0, 
  "requirePorts": false, 
  "instances": 1, 
  "executor": "", 
  "container": { 
     "type": "DOCKER", 
     "docker": { 
        "image": "ubuntu", 
        "network": "BRIDGE", 
        "portMappings": [ { "containerPort": 8080, "hostPort": 0, "servicePort": 9000, "protocol": "tcp" }, 
                          { "containerPort": 161, "hostPort": 0, "protocol": "udp" } 
                        ], 
        "privileged": false 
      } 
  }, 
  "labels": { "environment": "staging" }, 
  "healthChecks": [ 
     { "protocol": "TCP", "gracePeriodSeconds": 3, "intervalSeconds": 5, "portIndex": 1, "timeoutSeconds": 5, "maxConsecutiveFailures": 3 } 
   ], 
   "backoff Seconds": 1, 
   "backoffFactor": 1.15, 
   "maxLaunchDelaySeconds": 3600, 
   "upgradeStrategy": { "minimumHealthCapacity": 0.5, "maximumOverCapacity": 0.2 } 
   } ' 158.42.105.63:8080/v2/apps

