# packer-dokuwiki

Uses Packer (https://www.packer.io/) to build a CentOS 7 based AMI with a configured Dokuwiki setup running on Apache. The goal is for this to stand up a clean Dokuwiki instance. After doing so the idea is that a git repository will be initialized and then the scripts provided will backup and restore your Dokuwiki instance, even on deletion. The VM can then be temporal, deleting and recreating it from the AMI whenever necessary.

This is intended for my personal use case: To stand up a temporal Dokuwiki instance at the start of my work day, use it throughout the day, and then back it up and destroy the VM at 5 o clock. The following morning, create an entirely new VM which will sync from the dokuwiki repo with no observable difference from the day prior. This keeps running costs cheap (generally I do not need a wiki during sleeping hours) and also prevents unnecessary data storage costs as well.

## Getting Started

This documentation will show you how to deploy this project using Packer. Some things like setting up the packer executable and automating the dokuwiki backup will be referenced but the step by step instructions for said tools are outside the scope of this article.

### Prerequisites

The installation steps assume you have the following:

```
Packer (https://www.packer.io/)
An AWS Account
AWS config and credentials setup in your .aws directory (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
A blank git project to backup the wiki (I'm using GitLab for the free private repos, use your own as you'd like)
```

### Installing

A step by step walkthrough to deploy a Dokuwiki AMI

Edit the variables.json file with your values. Each value will be explained below.

```
{
  "instance_type": "t2.micro",
  "region": "us-east-2",
  "source_ami": "ami-9c0638f9",
  "admin_username": "admin",
  "admin_password_hash": "$1$YPnSdVNP$WttdnBXxmA.5lP4DrhqwN/",
  "wiki_title": "McCown Wiki",
  "git_domain": "gitlab.com",
  "git_initialized": "false",
  "git_project": "bmccown/dokuwiki-backup.git",
  "server_admin": "youremail@gmail.com",
  "server_name": "wiki.example.com",
  "server_alias": "wiki.example.com"
}
```
```
instance_type: Self explanatory. EC2 Instance Type
region: The region to deploy the AMI to
source_ami: The CentOS 7 AMI to use as a base image. You may have to go find this [here](https://aws.amazon.com/marketplace/pp/B00O7WM7QW)
admin_username: The username you'll use to login to dokuwiki
admin_password_hash: The password hash you'll use to login. This example here will be "Test123" minus the quotes. The easiest thing is to just keep this value, deploy dokuwiki, create a new user, delete the default admin user, and then from there on out the wiki will be deployed via your backed up git repo
wiki_title: Sets the wiki title in the Dokuwiki configuration files
git_domain: The domain where your git repository is hosted
git_initialized: If this is set to false the project will install dokuwiki, configure it, and back it up to your git repo. If it's set to true then dokuwiki will be restored from your git repo.
git_project: This will be joined with the git_domain value to make the connection string to set as the upstream for your git repo
server_admin: For dokuwiki config file purposes
server_name: For dokuwiki config file purposes
server_alias: For dokuwiki config file purposes
```

Next you'll need to ensure your Git repository is manageable via an SSH key. Edit the gitkey file and insert your own private key here.

Once that is done, deploy using:

```
packer build template.json -var-file=variables.json
```

After building the image for the first time, the wiki will be committed to your git repository. Edit your variables above to change git_initialized to true so that persistency can be maintained through your git repo.

## Contributing

Feel free to fork and create a pull request if you would like to contribute. This is a personal project but contributions are welcome.
