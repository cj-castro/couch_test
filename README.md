## Prerequisites

- **Google Cloud SDK**: Ensure that the Google Cloud SDK (`gcloud`) is installed and configured with appropriate credentials.
- **Terraform**: Install Terraform from [terraform.io](https://www.terraform.io/).
- **Google Cloud Project**: A Google Cloud project where the resources will be created.
- **Service Account**: A service account with the necessary permissions (Compute Admin, SQL Admin, etc.) for Terraform to manage resources in your GCP project.

## Quick Start

Follow these steps to initialize the project and apply the Terraform configuration.

### 1. Clone the Repository

```bash
git clone <repository-url>
cd <repository-directory>

Export your Google Cloud project ID and other necessary variables:

```bash
export GOOGLE_CLOUD_PROJECT="your-google-cloud-project-id"
export TF_VAR_project_id=$GOOGLE_CLOUD_PROJECT
export TF_VAR_db_password="your-database-password"

Initialize Terraform
```bash
terraform init

Validate the Configuration
```bash
terraform validate

Apply the Configuration
```bash
terraform apply
