# notes-app-deployment

Kubernetes deployment files (minikube, dev) for the Notes API.
The application code is in the separate `notes-app-code` repo.

| File | Purpose |
|---|---|
| k8s/00-namespace.yml | namespace `notes-dev` |
| k8s/01-configmap.yml | non-secret settings |
| secrets/secret.example.yml | template for passwords (real `secret.yml` is not stored in Git) |
| k8s/03-pv-pvc.yml | storage for the database (PV + PVC) |
| k8s/04-db-deployment.yml, 05-db-service.yml | database pod + service |
| k8s/06-app-deployment.yml, 07-app-service.yml | app pods (2 replicas) + service |
| deploy.sh / cleanup.sh | deploy everything / remove everything |

## Deploy
1. Open `k8s/06-app-deployment.yml`, set `image:` to `<dockerhub-username>/notes-app:<tag>`
2. `./deploy.sh` (first run creates `secrets/secret.yml`, run it a second time)

## Deploy a new version
1. Change the tag in `k8s/06-app-deployment.yml` (for example 1.0 to 1.1)
2. `git commit` and `git push` (Git now records which version was deployed)
3. `./deploy.sh`

## Roll back
Change the tag back to the old version and run `./deploy.sh`.

## Test
```bash
curl $(minikube ip):30080/health
curl -X POST $(minikube ip):30080/notes -H "Content-Type: application/json" -d '{"text":"hello k8s"}'
curl $(minikube ip):30080/notes
```
