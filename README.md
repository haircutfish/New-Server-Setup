# New Server Setup
This repo is going to be used for the purpose of easily setting up a server, and having it secure. What these scripts do:
- Update the server
- Install and set up Automatic Updates for Security updates
- Set Timezone**
- Set Hostname/Machine name
- Create a Limited User and sets their password
- Installs Firewalld or UFW, then configures it to open ports associated to SSH and LISH
- Finally Reboots the system
**To assign the correct Timezone, here is a Gist with the all Timezones: https://gist.github.com/alejzeis/ad5827eb14b5c22109ba652a1a267af5

## Getting The Script
Use `wget` to download the script to your server.  You will to get the `raw.githubusercontent.com` URL for the script you want to use then use the following command:
```wget {raw.githubusercontent.com url of the setup script}```

## Before Running The Script
Before you can run the scripts properly, you will need to set a couple of variables.  Those being Username, Hostname/Machine's Name, and Timezone with the variables:
```
USERNAME=
PASSWORD=
LM_NAME=
TIMEZONE=
```

Also you can make the user you create a sudo user by uncommenting the following line:
```adduser $username sudo```

## Running the code
Once you have the script on your machine, and modified it properly.  

Run the following command:
```bash {name of script}```

There are a few prompts that will pop up, you will need to response to.  But when the script is done running it will restart the server.  At which time you can log in with the user you created, and the password being password.  You will be prompted to change it upon first log in.
```
