# Assignment: NodeJS App CI/CD with GitHub Actions & AWS EC2 – Summary

### Objective
- The goal of this assignment was to automate the deployment of a containerized NodeJS backend application using GitHub Actions. The CI/CD pipeline builds a Docker image, pushes it to DockerHub, and deploys it on an EC2 instance over SSH.:
    - `server.js`
    - `MOCK_DATA.json` as a mock user database
    - Docker for containerization
    - GitHub Actions for CI/CD
    - **Terraform** to provision the EC2 infrastructure
    - AWS EC2 as the hosting environment
---
### Note
#### Please consider :  Wanted to try something extra : thats wht there are recent pushs:
- Added a basic HTML UI to show user data.
- Served static files from `/public` using Express.
- Provisioned EC2 + Security Group using Terraform (IaC).

These were done to simulate a real-world CI/CD and DevOps environment.
---
---

### I faced a few issues:

- **1st**: GitHub Actions failed to find the `Dockerfile` because the `context` was incorrectly set. Fixed by specifying the correct path: `./HomeAssignment/NodeJS-App`.
- **2nd**: The Docker container on EC2 kept restarting due to missing files (`MOCK_DATA.json`) not being copied during build. This was fixed by correcting the `Dockerfile` and confirming proper context was
used.
- **3rd**: The app did not display anything on `/` (port 3000) since no route was defined for `/`. Added a basic route in `server.js` to render a UI.
- **4th**: Final enhancement involved building a static HTML UI to fetch and display users from the backend using REST API. It was served from a `public/` folder using Express.
Once these were fixed, everything worked correctly — including the automated pipeline.

---

## Steps:

### 1: Setup NodeJS app with Express, GraphQL, and MOCK_DATA
```
npm init
npm i express
```

---

### 2: Use Terraform to Provision EC2 Instance on AWS
- Created EC2 instance using Terraform
- Security Group opened port 3000
- `user_data` not used; manual SSH used for access
- SSH key (`githubactions.pem`) added for secure GitHub Actions deployment

```
terraform init
terraform validate
terraform plan
terraform apply
```

![awsconsole](./images/Screenshot%202025-06-24%20045429.png)
![awsconsole](./images/Screenshot%202025-06-24%20045406.png)


---

### 3: Create Dockerfile to containerize the application
![image](./images/dockerfile.png)

---

### 4: Confuguring GitHub Actions workflow in EC2 instance
- Used `docker/build-push-action@v5` to build and push image
- Used `appleboy/ssh-action@v1` to SSH and deploy on EC2
- Setup Docker
- Open port `3000` in Security Group
- Add `githubactions.pem` for SSH
- Run GitHub Actions to deploy automatically
    - ![image](./images/Screenshot%202025-06-23%20073153.png)
- Setting up the Runner in Github Actions
    - ![runner](./images/Screenshot%202025-06-23%20073242.png)
---
### 5: Set up GitHub Actions workflow (`CICD_priyeshrai.yml`)
![image](./images/Screenshot%202025-06-23%20183614.png)
![image](./images/Screenshot%202025-06-23%20190724.png)

---

### 6: Website - Output

#### 6.1: Home Page UI (served from `/public/index.html`)
![image](./images/Screenshot%202025-06-24%20040224.png)
```
Extra Enhancements Done:
- Added a basic HTML UI to show user data.
- You can check that assignment in "AnotherProject" named directory
```
![image](./images/image.png)
---

### 8: Cleanup

To remove the container and images from EC2:
```bash
docker stop my-app-container
docker rm my-app-container
docker image prune -a -f
```

To destroy EC2 instance via Terraform:
```bash
terraform destroy
```
---

### Final Output:
Hosted at:  
```
http://43.205.213.228:3000/
```
---
