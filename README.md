# Cloud Build + Dagster Sample Repository

This repository accompanies our [technical blog](),
_"We’re on Cloud (Build) 9 with this Dagster secret"_.

The goal of this repository is to demonstrate how one can use Cloud Build to continously deploy Dagster projects in Google Cloud Platform.

## Running the sample Dagster project on your local environment

To get started, make sure you have Docker installed.
We provided `Makefile` recipes to quickly run the Dagster project locally:

```s
make compose-up
```

To shut down the project:

```s
make compose-down
```

## Code Organization

This repository is divided into three main parts:

- **src/**: contains all of our Dagster configuration files and application/pipeline code.
- **deploy/**: contains all of the Docker files that will be utilized by our Cloud Build instructions.
- **./**: contains our Cloud Build instruction file and other Dockerfiles

Kindly note the following files:

- **deploy/compose.Dockerfile** is what Cloud Build will use to build a one-off container image that already has docker-compose installed.
  - **deploy/entrypoint.sh** will be used to simply run the `docker-compose` commands as soon as the container starts in our GCE instance
- **daemon_dagit.Dockerfile** will create an image that contains the code and configurations for long-running services such as Dagit, Dagster Daemon, and the gRPC server.
  - This image will also store two key Dagster configuration files: **workspace.yaml** and **dagster.yaml**.
- **pipelines.Dockerfile** will create an image that contains all of our pipeline code. This image will be reused for every new pipeline run.

## Google Cloud Platform Services

Expect to enable the following APIs/services in GCP:

- Container Registry
- Cloud Build
- Secret Manager
- Compute Engine
- OS Login (optional but recommended)

For the actual deployment, we leveraged a Google Compute Engine (GCE) instance with 2 vCPU and 2 GB memory (e2-small). We also leveraged the Container-Optimized OS provided by Google (cos-stable-97-16919-29-40).
