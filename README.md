# Google Cloud hosted resume - Back-end

## Description

This project is the back-end of my cloud-hosted resume at [felitadonor.com](https://felitadonor.com/). ([front-end here](https://github.com/FelitaD/resume-frontend))

![diagram](resume-challenge.svg)

## Features

Serverless API that updates the visitor count in a Firestore database:
- The API accepts requests from the website made through Javascript
- CORS (Cross Origin Resource Sharing) is handled since the website and the back-end live on different domains
- Cloud Functions communicates with the database to increment the visitor count
- The website displays the new visitor count

## Technologies Used

- **[Firestore](https://cloud.google.com/firestore?hl=en)**<br>
Serverless NoSQL document database. Stores the visitor count of the website.
- **[Cloud Functions](https://cloud.google.com/functions?hl=en)**<br>
Event-driven serverless function. Increments visitor count. Triggered through HTTPS requests from the website.
- **[API Gateway](https://cloud.google.com/api-gateway)**<br>
Fully-managed API Gateway for Cloud Functions back-end.
- **[Cloud Build](https://cloud.google.com/build?hl=en)**<br>
Devops automation platform. One trigger to deploy the whole infrastructure.
- **[Terraform](https://www.terraform.io/)**<br>
Creates and manages all Cloud resources except Firestore.

## TODO

