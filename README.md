# deployment-a-to-z
A full pipeline for a simple nodejs app from A to Z. From Github repository to publicly exposed AWS service.

# Components
* React Typescript frontend
* Express Typescript backend
* PostGres database
* Github Actions CICD pipeline
* Jest testing suite
* CodeQL code inspection
* Terraform AWS templates
* Docker container file
* AWS Fargate
* AWS RDS
* AWS Route53
* AWS SNS

# Course
This will teach you all the basics for a full app deployment from Github repository to AWS deployment. Upon deployment the service will be publicly accessible via Route53 endpoint. The service will also have SNS messaging enabled for email alert integration. 

# Full component description
* React Typescript frontend with customizable greeting page. There will be a click button that logs number of user clicks on the Postgres database. 
* Express Typescript backend to receive the click actions and log them into Postgres.
* Postgres in AWS RDS
* A Docker container app for React frontend and ExpressJS backend
* Unit tests written in the Jest JS framework
* A Github Actions CICD pipeline to automate the entire deployment workflow. This workflow will have stages:
    * Build App
    * CodeQL code scan
    * Deploy to AWS RDS to create a Postgres instance
    * Deploy to AWS fargate as a container
    * Deploy to AWS Route53 and create a custom endpoint for access
    * Deploy to AWS SNS for email alerting
* Service and infrastructure creation will be automated with Terraform

I hope you enjoy this course! Please reach out if you would like a tutorial. Feel free to open an issue or reach out to me on Github/Linkedin if you have any questions or suggestions.