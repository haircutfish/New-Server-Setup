# New Server Setup
This repo is going to be used for the purpose of easily setting up a server, and having it secure.  In setting up the server these scripts will set the Hostname/Machine's name, Timezone, and created a either a Limited User or Sudo User.  

## Getting The Script
Cloning it to your machine:
- ```cd ~/path/to/clone/repo```
- ```git clone https://github.com/haircutfish/New-Server-Setup.git```

Using this way, you can make changes to the scripts that you would see fit, or even improve upon it.  You can then [SCP](https://www.linode.com/docs/guides/how-to-use-scp/#how-to-transfer-files-from-a-local-system-to-a-remote-server-using-scp) the file onto the server.

The other way would be to go to the script you would like to use.  Then on the server, use your text editor of choice.  Copy and paste the code into the text editor, and save it onto the server.

## Before Running The Script
Before you can run the scripts properly, you will need to set a couple of variables.  Those being Username, Hostname/Machine's Name, and Timezone with the variables:
```
username=
lm_name=
timezone=''
```

Also you can make the user you create a sudo user by uncommenting the following line:
```adduser $username sudo```

## Running the code
Once you have the script on your machine, and modified it properly.  

Run the following command:
```bash {name of script}```

There are a few prompts that will pop up, you will need to response to.  But when the script is done running it will restart the server.  At which time you can log in with the user you created, and the password being password.  You will be prompted to change it upon first log in.
