##Ingress deployment requires tunnelling to run on local machine
Steps: 
1. run minikube tunnel
2. Make sure you update host file example Windows machine (C:\Windows\System32\drivers\etc) by running this 
command in as admin in power shell (Add-Content -Path "$env:windir\system32\drivers\etc\hosts" -Value "127.0.0.1 guessing-game.local")
where guessing-game.local is your host in ingress file