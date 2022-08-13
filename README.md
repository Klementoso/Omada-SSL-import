# Omada-SSL-import
Omada SSL import script

This script is a modified version of the Script made by user Ermax on the TP-Link forums. I have added variables into the script for ease of use.
For the original post see: https://community.tp-link.com/en/business/forum/topic/96192?page=2

I recently upgraded my controller from 5.0.30 to 5.3.1 and found out the script no longer works. TP-Link Devs have moved the keystore to a different location (data).
Omada is a very promising platform, but it lacks the community and many topics like Ubiquiti has. This is why I decided to contribute to the community.

Version 1.1 adds support for Omada 5.3.1. As of May 14th 2022 this is the only version that is verified to work. TP-Link has a habbit of changing minor things that break stuff. At least up until 5.0.30 version 1.0 should be working. I haven't tested versions in between.

Don't forget to change OMADA_HOSTNAME to your own FQDN! After upgrading Omada this script has to be run again because installing/upgrading overwrites keystore.

UPDATE 13-08-2022:
Updated to Omada 5.4.6 today. Appeared I didn't need to reinstall the cert. I forced a renew and tried the import and everything went smooth. 
So I can confirm this script still works with 5.4.6!

------------------
The post by Ermax:
I just successfully used an LE cert on my controller. Here is what I did.

First I created a script that stops the controller, builds a new keystore and then starts the server. You can get the script here:
https://pastebin.com/raw/U1zYQGHe

Then I generate the new cert using acme.sh (https://acme.sh) and reference my script (reloadEAP.sh) similar to this:

./acme.sh --issue --dns dns_cf -d eap.example.com --reloadcmd /root/.acme.sh/reloadEAP.sh

If you want acme.sh to setup a cron job to automatically renew the cert and automatically inject it into the EAP controller just run this command:

./acme.sh --install

Obviously you will need to alter the paths in the script and find the right command line options for generating a cert with acme.sh for your environment. You don't have to use acme.sh, my relaodEAP.sh script could be adapted to work with any cert you want. I'm mostly using the steps I found in this thread only I added the password to the command lines so it can be run without user interaction.

Hope this helps someone.
