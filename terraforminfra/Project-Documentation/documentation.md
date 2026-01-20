# AWS CI/CD Pipeline with Terraform - Project Documentation

## 📋 Table of Contents

1. [Project Overview](#project-overview)
2. [Architecture](#architecture)
3. [Technologies Used](#technologies-used)
4. [Prerequisites](#prerequisites)
5. [Project Structure](#project-structure)
6. [Setup Instructions](#setup-instructions)
7. [Configuration](#configuration)
8. [Deployment Process](#deployment-process)
9. [CI/CD Workflow](#cicd-workflow)
10. [Testing](#testing)
11. [Monitoring & Troubleshooting](#monitoring--troubleshooting)
12. [Security](#security)
13. [Cost Analysis](#cost-analysis)
14. [Cleanup](#cleanup)
15. [Lessons Learned](#lessons-learned)
16. [Future Improvements](#future-improvements)

---

## 📖 Project Overview

### Description
This project demonstrates a complete CI/CD pipeline implementation on AWS using Infrastructure as Code (Terraform). It automatically deploys a web application to EC2 instances whenever code is pushed to GitHub, showcasing modern DevOps practices and cloud automation.

### Objectives
- Implement Infrastructure as Code using Terraform
- Create an automated CI/CD pipeline
- Deploy applications to AWS EC2 instances
- Demonstrate cloud security best practices
- Enable continuous integration and deployment

### Key Features
- ✅ Fully automated deployment pipeline
- ✅ Infrastructure provisioned via Terraform
- ✅ Automatic testing with CodeBuild
- ✅ Zero-downtime deployments with CodeDeploy
- ✅ Integrated with GitHub for source control
- ✅ Secure VPC networking
- ✅ IAM role-based security
- ✅ S3 bucket for artifact storage

---

## 🏗️ Architecture

### High-Level Architecture Diagram

```
┌─────────────┐
│   GitHub    │ (Source Code Repository)
└──────┬──────┘
       │ Push Event
       ▼
┌─────────────────────────────────────────┐
│         AWS CodePipeline                │
│  ┌──────────┬──────────┬──────────┐    │
│  │  Source  │  Build   │  Deploy  │    │
│  └────┬─────┴────┬─────┴────┬─────┘    │
└───────┼──────────┼──────────┼──────────┘
        │          │          │
        ▼          ▼          ▼
   ┌────────┐ ┌────────┐ ┌────────────┐
   │ GitHub │ │CodeBuild│ │CodeDeploy  │
   │Connect │ │         │ │            │
   └────────┘ └───┬────┘ └─────┬──────┘
                  │            │
                  ▼            ▼
              ┌────────┐   ┌──────────┐
              │   S3   │   │   EC2    │
              │Artifacts│  │  Instances│
              └────────┘   └──────────┘
                              │
                              ▼
                          ┌──────────┐
                          │  Apache  │
                          │Web Server│
                          └──────────┘
```

### Network Architecture

```
┌─────────────────────────────────────────────────┐
│                  AWS VPC                        │
│                10.0.0.0/16                      │
│                                                 │
│  ┌──────────────────────────────────────────┐  │
│  │      Public Subnet (10.0.1.0/24)         │  │
│  │                                           │  │
│  │  ┌────────────┐      ┌────────────┐     │  │
│  │  │    EC2     │      │    EC2     │     │  │
│  │  │  Instance  │      │  Instance  │     │  │
│  │  │   (Web)    │      │   (Web)    │     │  │
│  │  └────────────┘      └────────────┘     │  │
│  │         │                   │            │  │
│  └─────────┼───────────────────┼────────────┘  │
│            │                   │                │
│            └──────────┬────────┘                │
│                       │                         │
│                  ┌────▼─────┐                   │
│                  │  Internet │                  │
│                  │  Gateway  │                  │
│                  └──────────┘                   │
└─────────────────────────────────────────────────┘
```

### Component Interaction Flow

```
1. Developer pushes code to GitHub
2. GitHub webhook triggers CodePipeline
3. CodePipeline pulls source code
4. CodeBuild runs tests and builds application
5. Build artifacts stored in S3
6. CodeDeploy retrieves artifacts from S3
7. CodeDeploy deploys to EC2 instances
8. Apache serves the updated application
```

---

## 🛠️ Technologies Used

### Infrastructure & Cloud
- **AWS EC2** - Virtual server hosting
- **AWS VPC** - Network isolation and security
- **AWS S3** - Artifact and asset storage
- **AWS IAM** - Identity and access management
- **Terraform** - Infrastructure as Code

### CI/CD Pipeline
- **AWS CodePipeline** - Pipeline orchestration
- **AWS CodeBuild** - Build automation and testing
- **AWS CodeDeploy** - Deployment automation
- **AWS CodeStar Connections** - GitHub integration

### Application Stack
- **Apache HTTP Server** - Web server
- **HTML/CSS/JavaScript** - Frontend
- **Node.js** - Build tooling
- **Bash** - Deployment scripts

### Version Control
- **Git** - Version control system
- **GitHub** - Repository hosting

### Development Tools
- **AWS CLI** - Command line interface
- **Terraform CLI** - Infrastructure management
- **SSH** - Remote server access

---

## ✅ Prerequisites

### Required Software
```bash
# Terraform (>= 1.0)
terraform --version

# AWS CLI (>= 2.0)
aws --version

# Git (>= 2.0)
git --version

# Node.js (>= 18.0) - for local testing
node --version
npm --version
```

### AWS Account Requirements
- Active AWS account
- IAM user with administrative permissions
- AWS CLI configured with credentials
- EC2 key pair created in target region

### GitHub Requirements
- GitHub account
- Repository access
- Personal Access Token (for CodeStar Connections)

### Knowledge Prerequisites
- Basic understanding of AWS services
- Familiarity with Terraform syntax
- Git/GitHub workflow knowledge
- Linux command line basics
- Understanding of CI/CD concepts

---

## 📁 Project Structure

### Repository Layout

```
cicd-pipeline-project/
│
├── terraform/                      # Infrastructure code
│   ├── main.tf                     # Main infrastructure resources
│   ├── variables.tf                # Input variables
│   ├── outputs.tf                  # Output values
│   ├── terraform.tfvars            # Variable values (gitignored)
│   ├── terraform.tfvars.example    # Example configuration
│   ├── deploy-test-destroy.sh      # Automated test script
│   ├── quick-destroy.sh            # Quick cleanup script
│   └── README.md                   # Terraform documentation
│
├── application/                    # Application code
│   ├── index.html                  # Main web page
│   ├── package.json                # Node.js dependencies
│   ├── buildspec.yml              # CodeBuild configuration
│   ├── appspec.yml                # CodeDeploy configuration
│   ├── scripts/                   # Deployment scripts
│   │   ├── before_install.sh
│   │   ├── after_install.sh
│   │   ├── start_server.sh
│   │   ├── stop_server.sh
│   │   └── validate_service.sh
│   └── README.md                  # Application documentation
│
├── docs/                          # Documentation
│   ├── ARCHITECTURE.md
│   ├── DEPLOYMENT.md
│   ├── TROUBLESHOOTING.md
│   └── API.md
│
├── screenshots/                   # Project screenshots
│   ├── pipeline-success.png
│   ├── ec2-dashboard.png
│   └── website-live.png
│
├── .gitignore                    # Git ignore rules
├── LICENSE                       # Project license
└── README.md                     # Main project documentation
```

---

## 🚀 Setup Instructions

### Step 1: Clone Repository

```bash
# Clone the application repository
git clone https://github.com/Opebiodun/cicd-demo-app.git
cd terraform-cicd-infra

### Step 2: Configure AWS Credentials

```bash
# Configure AWS CLI
aws configure

# Verify configuration
aws sts get-caller-identity
```

### Step 3: Create SSH Key Pair

```bash
# Create key pair in AWS (if not exists)
aws ec2 create-key-pair \
  --key-name my-ec2-key \
  --query 'KeyMaterial' \
  --output text > ~/.ssh/my-ec2-key.pem

# Set permissions
chmod 400 ~/.ssh/my-ec2-key.pem
```

### Step 4: Configure Terraform Variables

```bash
cd terraform-cicd-infra

# Copy example configuration
cp terraform.tfvars.example terraform.tfvars

# Edit with your values
nano terraform.tfvars
```

**terraform.tfvars:**
```hcl
project_name  = "cicd-demo"
aws_region    = "eu-west-2"
instance_type = "t2.micro"
key_name      = "my-ec2-key"
my_ip         = "YOUR_IP/32"
github_repo   = "YOUR_USERNAME/cicd-demo-app"
github_branch = "main"
```

### Step 5: Initialize Terraform

```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Preview changes
terraform plan
```

### Step 6: Deploy Infrastructure

```bash
# Deploy all resources
terraform apply

# Review plan and type 'yes' to confirm
```

### Step 7: Activate GitHub Connection

1. Navigate to AWS Console → Developer Tools → Connections
2. Find your connection (status: PENDING)
3. Click "Update pending connection"
4. Click "Install a new app"
5. Authorize AWS CodeStar Connections in GitHub
6. Select your repository
7. Click "Connect"
8. Verify status changes to "Available"

### Step 8: Verify Deployment

```bash
# Get EC2 public IP
terraform output ec2_public_ip

# Test website
curl http://$(terraform output -raw ec2_public_ip)

# Open in browser
open http://$(terraform output -raw ec2_public_ip)  # macOS
# or visit the URL manually
```

---

## ⚙️ Configuration

### Terraform Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `project_name` | Project name for resource naming | `cicd-demo` | No |
| `aws_region` | AWS region for deployment | `us-east-1` | No |
| `vpc_cidr` | CIDR block for VPC | `10.0.0.0/16` | No |
| `public_subnet_cidr` | CIDR for public subnet | `10.0.1.0/24` | No |
| `instance_type` | EC2 instance type | `t2.micro` | No |
| `key_name` | SSH key pair name | - | Yes |
| `my_ip` | Your IP for SSH access | `0.0.0.0/0` | No |
| `github_repo` | GitHub repository path | - | Yes |
| `github_branch` | Git branch to track | `main` | No |

### Environment-Specific Configuration

**Development:**
```hcl
project_name  = "cicd-demo-dev"
instance_type = "t2.micro"
```

**Staging:**
```hcl
project_name  = "cicd-demo-staging"
instance_type = "t2.small"
```

**Production:**
```hcl
project_name  = "cicd-demo-prod"
instance_type = "t3.medium"
```

---

## 📦 Deployment Process

### Automated Deployment Flow

```
┌─────────────────────────────────────────────────┐
│ 1. Code Push to GitHub                          │
└─────────────────┬───────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────┐
│ 2. CodePipeline Triggered                       │
│    - Webhook receives push event                │
│    - Pipeline execution starts                  │
└─────────────────┬───────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────┐
│ 3. Source Stage                                 │
│    - Pull code from GitHub                      │
│    - Store in S3 artifact bucket                │
└─────────────────┬───────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────┐
│ 4. Build Stage (CodeBuild)                      │
│    - npm install                                │
│    - npm test                                   │
│    - npm run build                              │
│    - Package artifacts                          │
└─────────────────┬───────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────┐
│ 5. Deploy Stage (CodeDeploy)                    │
│    - Download artifacts from S3                 │
│    - Run deployment scripts                     │
│    - Deploy to EC2 instances                    │
│    - Validate deployment                        │
└─────────────────┬───────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────┐
│ 6. Application Live                             │
│    - Apache serves updated content              │
│    - Users see new version                      │
└─────────────────────────────────────────────────┘
```

### Manual Deployment

```bash
# Trigger pipeline manually
aws codepipeline start-pipeline-execution \
  --name cicd-demo \
  --region eu-west-2

# Check pipeline status
aws codepipeline get-pipeline-state \
  --name cicd-demo \
  --region eu-west-2
```

### Deployment Scripts

All deployment scripts are located in `application/scripts/`:

1. **before_install.sh** - Cleanup before deployment
2. **after_install.sh** - Post-installation setup
3. **start_server.sh** - Start Apache server
4. **stop_server.sh** - Stop Apache server
5. **validate_service.sh** - Verify deployment success

---

## 🔄 CI/CD Workflow

### Continuous Integration

**On Every Commit:**
1. Code pushed to GitHub
2. CodeBuild pulls code
3. Dependencies installed (`npm install`)
4. Tests executed (`npm test`)
5. Application built (`npm run build`)
6. Artifacts packaged and uploaded to S3

### Continuous Deployment

**After Successful Build:**
1. CodeDeploy retrieves artifacts from S3
2. Runs `before_install.sh` script
3. Copies files to `/var/www/html`
4. Runs `after_install.sh` script
5. Restarts Apache with `start_server.sh`
6. Validates deployment with `validate_service.sh`

### Pipeline Stages

**Stage 1: Source**
- Provider: GitHub (via CodeStar Connections)
- Trigger: Automatic on push to main branch
- Output: Source code artifact

**Stage 2: Build**
- Provider: CodeBuild
- Build environment: Amazon Linux 2
- Runtime: Node.js 18
- Output: Build artifact

**Stage 3: Deploy**
- Provider: CodeDeploy
- Deployment type: In-place
- Configuration: OneAtATime
- Auto rollback: Enabled on failure

---

## 🧪 Testing

### Local Testing

```bash
# Test buildspec locally (requires Docker)
cd application
docker run -v $(pwd):/app -w /app node:18 sh -c "npm install && npm test && npm run build"
```

### Integration Testing

```bash
# Test deployment scripts
cd application/scripts
bash -x validate_service.sh
```

### End-to-End Testing

```bash
# 1. Make a change
echo "Test" >> application/index.html

# 2. Commit and push
git add .
git commit -m "Test deployment"
git push

# 3. Watch pipeline
aws codepipeline get-pipeline-state --name cicd-demo

# 4. Verify website
EC2_IP=$(cd terraform && terraform output -raw ec2_public_ip)
curl http://$EC2_IP | grep "Test"
```

### Performance Testing

```bash
# Load test with Apache Bench
ab -n 1000 -c 10 http://YOUR_EC2_IP/

# Monitor during test
watch -n 1 'aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=cicd-demo-web-server" \
  --query "Reservations[0].Instances[0].State.Name"'
```

---

## 📊 Monitoring & Troubleshooting

### Monitoring Tools

**CloudWatch Logs:**
```bash
# View CodeBuild logs
aws logs tail /aws/codebuild/cicd-demo --follow

# View CodeDeploy logs (on EC2)
ssh -i ~/.ssh/key.pem ec2-user@EC2_IP
sudo tail -f /var/log/aws/codedeploy-agent/codedeploy-agent.log
```

**Pipeline Status:**
```bash
# Check pipeline execution
aws codepipeline list-pipeline-executions --pipeline-name cicd-demo

# Get detailed execution
aws codepipeline get-pipeline-execution \
  --pipeline-name cicd-demo \
  --pipeline-execution-id EXECUTION_ID
```

### Common Issues

**Issue 1: Pipeline Fails at Source Stage**
```
Error: Connection pending or failed
Solution:
1. Go to AWS Console → Connections
2. Activate GitHub connection
3. Retry pipeline execution
```

**Issue 2: Build Stage Fails**
```
Error: npm ENOENT package.json
Solution:
1. Ensure package.json exists in repository root
2. Check buildspec.yml is in repository
3. Verify GitHub connection pulls correct branch
```

**Issue 3: Deploy Stage Fails**
```
Error: CodeDeploy agent not running
Solution:
1. SSH to EC2: ssh -i key.pem ec2-user@IP
2. Check agent: sudo service codedeploy-agent status
3. Start agent: sudo service codedeploy-agent start
4. Check logs: sudo tail -f /var/log/aws/codedeploy-agent/codedeploy-agent.log
```

**Issue 4: Website Not Accessible**
```
Error: Connection timeout
Solution:
1. Check security group allows port 80
2. Verify Apache is running: systemctl status httpd
3. Check files deployed: ls -la /var/www/html/
4. Test locally on EC2: curl localhost
```

### Debug Commands

```bash
# Check all pipeline executions
aws codepipeline list-pipeline-executions \
  --pipeline-name cicd-demo \
  --max-items 5

# Check CodeDeploy deployments
aws deploy list-deployments \
  --application-name cicd-demo \
  --max-items 5

# Check EC2 instance state
aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=cicd-demo-web-server" \
  --query 'Reservations[0].Instances[0].[InstanceId,State.Name,PublicIpAddress]'

# Check S3 artifacts
aws s3 ls s3://cicd-demo-pipeline-artifacts/ --recursive

# SSH and debug
ssh -i ~/.ssh/key.pem ec2-user@EC2_IP
sudo systemctl status httpd
sudo tail -100 /var/log/httpd/error_log
```

---

## 🔒 Security

### Network Security

**VPC Configuration:**
- Isolated VPC (10.0.0.0/16)
- Public subnet for web servers
- Internet Gateway for outbound access
- Network ACLs with default deny

**Security Groups:**
```
Inbound Rules:
- Port 80 (HTTP): 0.0.0.0/0
- Port 443 (HTTPS): 0.0.0.0/0
- Port 22 (SSH): Your IP only

Outbound Rules:
- All traffic: 0.0.0.0/0 (for package downloads)
```

### IAM Security

**EC2 Instance Role Permissions:**
- S3 Read-only access (for artifacts)
- CodeDeploy agent permissions
- CloudWatch logs write access

**CodePipeline Role Permissions:**
- S3 read/write for artifacts
- CodeBuild execution
- CodeDeploy execution
- CodeStar Connections usage

**CodeBuild Role Permissions:**
- CloudWatch Logs write
- S3 artifact access

**CodeDeploy Role Permissions:**
- EC2 instance access
- Auto Scaling group access
- S3 artifact retrieval

### Data Security

**Encryption:**
- EBS volumes encrypted at rest
- S3 bucket encryption enabled
- HTTPS for CodePipeline communications

**Secrets Management:**
- SSH keys stored securely
- No hardcoded credentials in code
- IAM roles instead of access keys

### Best Practices Implemented

✅ Principle of least privilege for IAM roles
✅ Security groups with minimal ports open
✅ SSH access restricted to specific IP
✅ Encrypted storage volumes
✅ No public S3 buckets (except assets)
✅ VPC isolation
✅ Regular security updates via user_data

---

## 💰 Cost Analysis

### Monthly Cost Breakdown (Free Tier)

| Service | Free Tier | Usage | Cost |
|---------|-----------|-------|------|
| EC2 t2.micro | 750 hrs/month | ~1 hr testing | $0.00 |
| S3 Storage | 5 GB | <1 GB | $0.00 |
| S3 Requests | 20K GET, 2K PUT | <100 | $0.00 |
| CodePipeline | 1 pipeline | 1 pipeline | $0.00 |
| CodeBuild | 100 min | ~5 min/build | $0.00 |
| CodeDeploy | Always free | Unlimited | $0.00 |
| Data Transfer | 100 GB out | <1 GB | $0.00 |
| **Total** | | | **$0.00** |

### Cost After Free Tier (12 months)

| Service | Unit Price | Monthly Usage | Cost |
|---------|-----------|---------------|------|
| EC2 t2.micro | $0.0116/hr | 730 hrs | $8.47 |
| S3 Storage | $0.023/GB | 1 GB | $0.02 |
| CodePipeline | $1.00/pipeline | 1 | $1.00 |
| CodeBuild | $0.005/min | 100 min | $0.50 |
| **Total** | | | **~$10/month** |

### Cost Optimization Tips

1. **Use Free Tier:** Stay within limits for first 12 months
2. **Destroy When Not Using:** Run `terraform destroy` after testing
3. **Schedule Instances:** Stop EC2 when not needed
4. **Use Spot Instances:** For non-production (not in this project)
5. **Monitor Usage:** Set billing alerts at $1, $5, $10

---

## 🧹 Cleanup

### Quick Cleanup

```bash
cd terraform

# Run quick destroy script
./quick-destroy.sh

# Or manually
terraform destroy -auto-approve
```

### Manual Cleanup Steps

```bash
# 1. Empty S3 buckets
S3_ASSET=$(terraform output -raw assets_bucket_name)
S3_PIPELINE=$(terraform output -raw pipeline_artifacts_bucket)

aws s3 rm s3://$S3_ASSET --recursive
aws s3 rm s3://$S3_PIPELINE --recursive

# 2. Delete pipeline (optional - terraform will do it)
aws codepipeline delete-pipeline --name cicd-demo

# 3. Destroy infrastructure
terraform destroy

# 4. Clean local files
rm -rf .terraform/
rm terraform.tfstate*
rm .terraform.lock.hcl
```

### Verification

```bash
# Verify no running instances
aws ec2 describe-instances \
  --filters "Name=tag:Project,Values=cicd-demo" \
  --query 'Reservations[].Instances[].InstanceId'

# Verify no S3 buckets
aws s3 ls | grep cicd-demo

# Verify no pipelines
aws codepipeline list-pipelines | grep cicd-demo
```

---

## 📚 Lessons Learned

### Technical Insights

1. **Terraform State Management**
   - Always use remote state in production
   - State locking prevents concurrent modifications
   - Backup state files regularly

2. **CodeDeploy Agent**
   - Must be running before deployment
   - Check logs for debugging
   - Auto-start on instance boot

3. **GitHub Connections**
   - Require manual activation in Console
   - Can't be fully automated in Terraform
   - Check connection status before deployment

4. **IAM Permissions**
   - Start with minimal permissions
   - Add as needed based on errors
   - Use managed policies when possible

### Best Practices

✅ Always use version control for infrastructure code
✅ Document all manual steps (like GitHub connection)
✅ Test in development before production
✅ Use consistent naming conventions
✅ Tag all resources for cost tracking
✅ Implement proper error handling in scripts
✅ Set up billing alerts
✅ Regular backups of important data

### Common Pitfalls Avoided

❌ Hardcoding sensitive values
❌ Using default VPCs
❌ Overly permissive security groups
❌ Not cleaning up resources
❌ Skipping validation stages
❌ Ignoring CloudWatch logs

---

## 🚀 Future Improvements

### Phase 1: Enhanced Monitoring
- [ ] CloudWatch dashboards
- [ ] SNS alerts for pipeline failures
- [ ] Custom CloudWatch metrics
- [ ] Application Performance Monitoring (APM)

### Phase 2: Advanced Deployment
- [ ] Blue/Green deployments
- [ ] Canary deployments
- [ ] Multi-region deployment
- [ ] Auto Scaling groups

### Phase 3: Security Enhancements
- [ ] AWS Secrets Manager integration
- [ ] Certificate Manager (HTTPS)
- [ ] WAF (Web Application Firewall)
- [ ] GuardDuty for threat detection
- [ ] VPC Flow Logs

### Phase 4: Infrastructure Improvements
- [ ] RDS database integration
- [ ] ElastiCache for caching
- [ ] CloudFront CDN
- [ ] Route 53 for DNS
- [ ] Application Load Balancer

### Phase 5: CI/CD Enhancements
- [ ] Manual approval stage
- [ ] Automated testing (Jest, Selenium)
- [ ] Code quality checks (SonarQube)
- [ ] Container deployment (Docker/ECS)
- [ ] Kubernetes deployment (EKS)

### Phase 6: Developer Experience
- [ ] Local development environment
- [ ] Pre-commit hooks
- [ ] Automated documentation generation
- [ ] Staging environment
- [ ] Feature branch deployments

---

## 📝 Conclusion

This project successfully demonstrates:
- Infrastructure as Code with Terraform
- Automated CI/CD pipeline implementation
- AWS cloud services integration
- DevOps best practices
- Security-first approach

**Key Achievements:**
✅ Fully automated deployment pipeline
✅ Infrastructure reproducible via code
✅ Zero-downtime deployments possible
✅ Cost-effective solution within free tier
✅ Production-ready architecture

**Skills Demonstrated:**
- Terraform/IaC
- AWS services (EC2, S3, VPC, IAM, CodePipeline)
- CI/CD pipeline design
- Linux system administration
- Bash scripting
- Git/GitHub workflows
- Cloud security
- DevOps practices

---

## 📞 Support & Contact

**Project Repository:** https://github.com/Opebiodun/cicd-demo-app.git

**Documentation:** See `docs/` directory for detailed guides

**Issues:** Report bugs and feature requests via GitHub Issues

**License:** MIT License (see LICENSE file)

---

## 🙏 Acknowledgments

- AWS Documentation
- Terraform Documentation
- HashiCorp Learn
- DevOps community resources

---

**Last Updated:** January 2026
**Version:** 1.0.0
**Author:** Opebiodun