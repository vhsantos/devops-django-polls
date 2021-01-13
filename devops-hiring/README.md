# Django Polls App For DevOps Candidates

This is the Django 2.2 tutorial polls app, taken straight from the Django project's official website.

## DevOps Candidates

This app will be used as a base for work that we'll discuss and evaluate during your technical interview.

We ask that you do the following before the interview:

1. Fork this repo
1. Dockerize the app for local development as well as deployment to Kubernetes.  You can choose the technology for local development.  Be prepared to discuss why you've chosen the approach you have.
1. Fix any code in the app that doesn't follow best practices of 12 Factor apps
1. Write basic kubernetes manifests such that I could deploy these to minikube, KIND, or any other k8s cluster locally

### Goals

Our goals in reviewing this excercise with you are as follows:

1. Evaluate your ability to understand and write basic application code
1. Evaluate your ability to understand and help build a good developer experience
1. Show knowledge of both development and production concerns surrounding microservices and containerized applications
1. Show a basic understanding of Kubernetes resources and declarative infrastructure
1. Show knowledge of what questions and concerns to raise to a product development team or your own teammates in developing and releasing a service
1. See how you would work with us as a team in a normal task-based scenario.

### Deliverables

We expect to see the following four items completed before our interview:

1. A link to the PR or Branch in your fork you'd like us to review
1. Documentation in the Git repository on how to run the application for local development
1. A production-ready Dockerfile we could build and deploy to a Kubernetes cluster using the manifests provided
1. Either via email before the interview or at the interview, ask questions or requests you'd have for the product development team if any

If you'd like to do so and have time, we'd love to see the following:

1. If you choose to need resources outside of Kubernetes, a snippet of Terraform code that describes the resource(s)
1. Create an endpoint in the app that does something of your choosing to demonstrate basic python abilities and ability
to quickly understand a small piece of a web framework.  Perhaps it can show the current time, or something similar.

## What to expect

While working on this challenge, you are welcome to email us for any clarification or requirement questions you have.  Our recruiter
will let you know who to talk to during this process if you have any questions.

During the interview we will review your work, go through the PR as we would any code review, and discuss
the decisions you made and fixes you chose to implement, as well as any additional concerns you have.  Be prepared to also discuss
CI/CD for the app, though we do not expect you to build anything for this.

*We only expect you to spend a couple of hours on this.*  You're welcome to do as much as you'd like to do,
but it's not our intention to take up days of your time.  If there are things you don't have the time to fix,
please be prepared to talk us through them at the interview.  We want you to showcase that you have the knowledge and skills
to help product development teams build, containerize, deploy, and release their apps in the cloud.
