# Chapter 7: Network-Based File Synchronization

Copying content over a network is usually done manually. For example, we just use SCP or FTP to transfer a file and that's that. But what happens if we need to make this process a permanent one? We then need to figure out a way to do file/directory synchronization, which is what rsync is all about. That being said, with all of the security-related incidents in the past few years, it's always a good idea to implement some kind of encryption, so using SSH and SCP seems like a reasonable approach, and that's exactly what we are going to do.

In this chapter, we are going to cover the following topics:

- Learning how to use SSH and SCP
- Learning how to use rsync
- Using vsftpd

# Technical requirements

For these recipes, we're going to use two Linux machines – we can use the client1 and gui1 virtual machines from our previous chapters. These recipes will work on both CentOS and Ubuntu, so there is no reason to use separate virtual machines for these scenarios.

So, let's start our virtual machines and let's get cracking!

# Learning how to use SSH and SCP

Back in the 1990s, it was a pretty natural thing to use the Telnet, rlogin, and FTP protocols. Come to think of it, using (anonymous) FTP is still done a lot. Bearing in mind that most local networks in the 1990s were based around network hubs (not switches) and the fact that all of these protocols are plain-text protocols that are easy to eavesdrop on via network sniffers, it really isn't all that strange that we're not using these devices and/or protocols as much anymore. As book authors, we haven't heard of anyone using rlogin since the late 1990s, although Telnet is still widely used to configure network devices (mostly switches and routers). This is the reason why SSH was developed (as a Telnet/rlogin replacement), and, along with SSH, SCP was developed (as a replacement for FTP). To put things into perspective, the first version of SSH was released in the mid-1990s. Let's see how it works.

Getting ready
We just need one Ubuntu and one CentOS machine for this recipe. Let's say we are going to use cli1 and cli2 to master these commands.

How to do it…
Our first scenario is going to be connecting from one machine to another by using SSH. We are going to presume that we don't have all of the necessary packages installed – just enough to cover our bases. We know that there are a lot of IT people out there who try to install the smallest number of packages possible on their servers/containers, so these extra steps shouldn't be much of a problem.

On an Ubuntu-based machine, we can do it like this:

apt-get -y install libssh-4 openssh-client openssh-server openssh-sftp-server ssh-import-id

Copy

Explain
On a CentOS machine, we can do it like this:

dnf install openssh-server

Copy

Explain
For both of them, we need to start the service and enable it if we want to use it permanently:

systemctl start sshd
systemctl enable sshd

Copy

Explain
As a replacement for insecure technologies such as Telnet, rlogin, and FTP, SSH is pretty straightforward to use. We just need to learn the basic syntax. Let's say that we want to log in from a user called student on Linux machine cli1 to a user called student on Linux machine cli2. As we're logging in from a user called student to a user called student, there are two ways to do that. Here's the first:

student@cli1:~$ ssh student@cli2

Copy

Explain
And here's the second:

student@cli1:~$ ssh cli2

Copy

Explain
The reason is simple: if we're logging in to the same user that we're using on our source Linux machine, we don't need to explicitly say which account we're logging in to.

If we, however, wanted to go from the student user on cli1 to some other user on cli2, then we have to use the remote username as a parameter. Again, we can do it in two ways. Here's the first:

student@cli1:~$ ssh remoteuser@cli2

Copy

Explain
And here's the second:

student@cli1:~$ ssh -l remoteuser cli2

Copy

Explain
We can generalize that to cover any remote user on any remote machine. Commands for that scenario would look like this:

ssh remoteuser@remotemachine

Copy

Explain
Or this:

ssh -l remoteuser remotemachine

Copy

Explain
Another part of the SSH stack is a command called SCP. We use SCP to copy files from one machine to another machine by using SSH as a backend (secure copy). So, let's use an example. Let's say that we want to copy a file called source.txt from the student user's home directory on cli1 to the student user's home directory on cli2. We would use the following command to do that:

scp /home/student/source.txt student@cli2:/home/student 

Copy

Explain
Or, if we were already in the /home/student directory on the source machine, we would use this:

scp source.txt student@cli2:/home/student

Copy

Explain
Generally speaking, SCP has a simple syntax:

scp source destination

Copy

Explain
It's just that the source and destination can have a lot of letters that need to be typed. Let's explain that point by using another interesting use case for SCP. We can use it to download files from remote machines to local machines as well. The syntax is similar but can be a bit confusing when we're doing it the first couple of times. So, let's say that we want to copy a file called source.txt from the home directory of the student user on cli2 to the /tmp directory on cli1, logged in as the student user on cli1. We would use the following command to do that:

scp cli2:/home/student/source.txt /tmp

Copy

Explain
The syntax follows the same rule (scp source destination), it's just that the source is now a remote file, and the destination is a local directory. It makes sense, when we think about it.

The next step in our process is going to be installing secure shell keys. This means that – in our example – we will enable passwordless login from one server to the other. We can avoid that, but let's forget about that for the time being; we are going to cover it in a second as we are not discussing security implications here. We are only trying to get the environment ready for SSH and SCP from a local user (let's say, student) to a remote user (let's say, student). So, let's do that:

Figure 7.1 – Creating an SSH key with an empty private key
Figure 7.1 – Creating an SSH key with an empty private key

Let's now copy this key to the remote machine (cli2) and test if the SSH key copying process worked by trying to log in as that user. For the first part, we are going to use the command called ssh-copy-id (to copy the key to the remote machine), and then use SSH to try to log in to test if the SSH key was properly copied:

Figure 7.2 – Copying the SSH key to the remote machine and testing if it works
Figure 7.2 – Copying the SSH key to the remote machine and testing if it works

As we can see, everything works from cli1 to cli2. Let's now repeat the same process in the opposite direction, because we are going to need that a bit later for another part of this recipe. First, let's create an SSH key:

Figure 7.3 – Creating an SSH key for student@cli2
Figure 7.3 – Creating an SSH key for student@cli2

Then, let's copy it to the remote server:

Figure 7.4 – Copying the SSH key from cli2 to cli1 and testing if it works
Figure 7.4 – Copying the SSH key from cli2 to cli1 and testing if it works

We can see that in both of these examples, the remote server that we're connecting to doesn't ask us for a password. The reason for that is simple: when we were creating an SSH key, ssh-keygen gave us two very important things to input:

Enter passphrase (empty for no passphrase) :
Enter same passphrase again:

Copy

Explain
If we pressed the Enter key on the first question and confirmed it by pressing Enter again on the second one, that means that we created an SSH key that has an empty private key. And that's exactly what we did in our example. We didn't select any specific passphrase, therefore leaving it empty. If we wanted to use a custom private key, we just needed to type it in those two steps.

How it works…
As a protocol, SSH is an encrypted answer to the non-existent security of Telnet, rlogin, and FTP. These three plain-text protocols were easy to hack, especially in the good old days before we started using network switches (while we were still mostly using network hubs). Its first implementation goes way back to 1995. It can also be used as a tunneling protocol, and it was heavily used for that back in the day – for example, for proxying FTP and HTTP traffic. Nowadays, it's used more for tunneling for remote X applications (XDMCP) or even connections to SSH to servers behind an SSH-based tunneling host.

In simple terms, SSH works like this:

The SSH client connects to the SSH server, therefore starting the connection.
The server responds and gives the client its public key.
The server and client then try to negotiate the necessary encryption parameters, followed by a secure channel being opened between the server and client.
The application or user logs in the server.
For those of us familiar with SSL/TLS, it's kind of similar to both of these protocols as all of these protocols are TCP-based; they have a negotiating mechanism and are generally used for security purposes. Yes, they go about it in a slightly different way and their use cases are a bit different, but that still doesn't mean that they're vastly different in terms of the general principle.

The next stop on our journey is rsync, and we are going to explicitly use SSH as a backend to rsync. That's the reason why we made our SSH keys, especially the ones without an additional private key (passphrase). Let's now learn how to work with rsync.

There's more…
If you need more information about networking in CentOS and Ubuntu, make sure that you check out the following:

How does SSH work: https://www.hostinger.com/tutorials/ssh-tutorial-how-does-ssh-work
What is the Secure Shell (SSH) protocol: https://www.sdxcentral.com/security/definitions/what-is-the-secure-shell-ssh-protocol/
Learning how to use rsync
In our previous recipe, we worked with SSH from the client standpoint. We used SSH and SCP to both log in and copy files from source to destination. We discussed how to use a username/password combination to log in to a remote system, as well as how to use SSH key-based authentication. If we focus on SCP for a second, there's one thing that we didn't discuss, and that is how to synchronize the local source to the local destination, or, even better, how to create a scenario in which we synchronize the local source to a remote destination and vice versa between two Linux servers in place. This is where it's best to use rsync, a tool that's meant to do just that. Let's get cracking.

Getting ready
We will continue using our cli1 and cli2 machines, running Ubuntu and CentOS. Let's get ready by making sure that the necessary packages are installed. We need to use this command for Ubuntu:

apt -y install rsync

Copy

Explain
We use the following command for CentOS:

dnf -y install rsync

Copy

Explain
After that, we are ready to start.

How to do it…
We are going to talk about a couple of scenarios:

Synchronization between local source and local destination
Synchronization between local source and remote destination, or vice versa
There could be a number of other sub-scenarios, such as dealing with one-way sync and deleting files on source, rsync is just one subdirectory, and so on. We are just going to deal with these two in detail, and then add a couple of bits and pieces from these sub-scenarios.

Let's deal with the simple scenario first: how to synchronize a folder that's placed locally to another locally placed folder. Let's say that we want to synchronize (basically, create a backup of) the /etc folder, and that we want to synchronize it to the /root/etc folder. We can do that by using the following commands as root (using the cli1 machine as an example):

rsync -av /etc /root 

Copy

Explain
The two options used, a and v, are there to use archiving mode (preserve permissions and ownerships) and verbose mode so that we can see the output of every copy operation. We don't need to create the /etc folder in the /root directory up front or put /root/etc as the destination folder because a folder named etc is going to be created automatically in /root upon command execution.

If we wanted to exclude some files from copying (for example, all files that have the .conf extension), we can do it like this:

rsync -av --exclude="*.conf" /etc /root 

Copy

Explain
There are other cool options available in rsync that could make certain scenarios possible. Let's say that we want to copy files that are a maximum of 5 MB in size, or a minimum of 3 MB in size. We could do that by using the following syntax:

rsync -av --max-size=5M source destination
rsync -av --min-size=3M source destination

Copy

Explain
For example, if the source directory has a lot of large files in the second example (minimum size), we might want to add a --progress option to the rsync command so that we can have interactive output telling us about the progress being made.

Now let's work on one-way sync from a remote to a local destination. The opposite direction is almost the same, we just need to change the source and destination fields in rsync. So, let's say that we have a source directory on cli2 called /home/student/source. That directory has files and subfolders; it has a hierarchy of files and folders. We want to synchronize that content to cli1, specifically, to the /tmp directory. Here's the content of our source directory:

Figure 7.5 – Source directory on cli2, located at /home/student/source
Figure 7.5 – Source directory on cli2, located at /home/student/source

This is what we should do, provided that we have the source material ready:

Figure 7.6 – rsync from the remote source directory
Figure 7.6 – rsync from the remote source directory

So, we just used one simple command, rsync -rt (-r means recursive, -t is to preserve times), with the source and destination as parameters, and the source directory was successfully transferred to our local directory. This is because we copied the SSH keys in the previous recipe, so we didn't need to do any authentication, which makes the overall process very easy and straightforward.

The next scenario is going to be about syncing the source and destination and then deleting source files. Specifically, we're syncing files, not folders, as there are different options for those scenarios. Let's see how that's done:

Figure 7.7 – rsync from the remote server using SSH keys, 
and deleting source files after the download is done
Figure 7.7 – rsync from the remote server using SSH keys, and deleting source files after the download is done

Now, if we wanted to run the same scenario but delete all of the files and folders from cli2 after the transfer is done, we'd need to separate that into two commands. Here's how it works:

Figure 7.8 – Removing source files from the remote source directory, 
and then all subdirectories in the source directory
Figure 7.8 – Removing source files from the remote source directory, and then all subdirectories in the source directory

Now that we've shown this, we can also note a couple of other projects that will make it easier to do two-way sync. Projects such as Unison (https://www.cis.upenn.edu/~bcpierce/unison/) and bsync (https://github.com/dooblem/bsync) have implemented two-way sync methods that are very difficult to achieve by using rsync. Make sure that you check them out if you need two-way sync.

How it works…
rsync is a source-destination type of command, and that covers its syntax and mode of operation if we're using it interactively (no destination rsync service is involved). There can also be an rsync service involved, which usually changes the mode of operation significantly. It's important to point out that using rsync as a command (in combination with SSH) is most commonly done for backups. We've been using it in this fashion for 15 or more years in some of our environments, and it works perfectly.

rsyncd (the rsync service) is usually aimed at a completely different usage model – most commonly, software mirrors. If we want to create a local CentOS or Ubuntu mirror, the rule of the thumb is that we'll use rsyncd, as it allows us to do much more finely grained configuration in terms of what needs to be done as part of the rsync process. There might be other reasons to do it – for example, we can configure rsyncd to not use SSH and gain a bit of speed in doing so.

Now that we have discussed some of the key concepts of SSH, SCP, and rsync, it's time to move on to their – at least by default – much more insecure cousin, called vsftpd. We are going to make sure that we make it more secure, though, as there's absolutely no reason not to. So, let's get ready to configure vsftpd.

There's more…
If you need to learn more about rsync, we recommend the following links:

How to set up an rsync daemon on your Linux server: https://www.atlantic.net/vps-hosting/how-to-setup-rsync-daemon-linux-server/
10 practical examples of the rsync command in Linux: https://www.tecmint.com/rsync-local-remote-file-synchronization-commands/
17 useful rsync (remote sync) command examples in Linux: https://www.linuxtechi.com/rsync-command-examples-linux/
Using vsftpd
The FTP service has been around for decades. Back in the mid-1990s, FTP was actually the vast majority of internet traffic. Yes, its importance in terms of traffic volume decreased over time, but it's not only that. FTP, all by itself, is a completely open, plain-text protocol. The latest revision that's been included in all major distributions is called vsftpd, and it's been there for more than a decade now. We are going to focus on three scenarios in this recipe: getting vsftpd to work, getting vsftpd to work with a user's home directories, and – last but not least – making vsftpd secure by implementing TLS and certificates. Let's start!

Getting ready
Keep the cli1 and cli2 virtual machines powered on and let's continue using our shell. Let's make sure that the necessary packages are installed by using our standard commands. So, for Ubuntu, use this command:

apt -y install vsftpd

Copy

Explain
For CentOS, let's use this command:

dnf -y install vsftpd

Copy

Explain
Then, let's enable them and start it. We're going to use the Ubuntu machine to show how vsftpd configuration should be done, but it's almost 100% the same on CentOS. So cli1 (Ubuntu) is going to act as a vsftpd server, and cli2 (CentOS) is going to act as an FTP client. So, let's run these commands on cli1:

systemctl start vsftpd
systemctl enable vsftpd

Copy

Explain
It would be prudent to configure firewalls to allow connections to necessary FTP ports (20, 21). So, on cli1, we need to do this:

ufw allow ftp
ufw allow ftp-data

Copy

Explain
On the client side (cli2), let's install lftp, a nice and simple-to-use ftp client, by using the following command:

dnf -y install lftp

Copy

Explain
Let's now configure vsftpd in accordance with the three scenarios that we mentioned.

How to do it…
Now that we have installed our packages, it's time to start configuring vsftpd on cli1. That means we need to go through some of the options in /etc/vsftpd.conf (usually, it's /etc/vsftpd/vsftpd.conf on CentOS).

Generally speaking, this configuration file is very well documented all by itself, so we should have no trouble configuring it to suit our needs. By default, it should let us use the FTP client to connect to it, but let's make a couple of changes from the very start. Let's allow anonymous FTP and not allow local users to log in. If we check the configuration file, that means that we need to configure the anon_root, anonymous_enable, and local_enable configuration options, so let's do that. Let's make sure that those two configuration lines look like this:

anonymous_enable=YES
local_enable=NO
anon_root=/var/ftp

Copy

Explain
We also need to create some directories for this configuration to work:

mkdir -p /var/ftp/pub
chown nobody:nogroup /var/ftp/pub

Copy

Explain
Restart the vsftpd service so that it works with the latest configuration:

systemctl restart vsftpd

Copy

Explain
On cli2, we have already installed lftp, and it is going to try to log in to the remote FTP server (cli1) anonymously by default. Let's see how that works:

Figure 7.9 – Testing the FTP connection by using lftp
Figure 7.9 – Testing the FTP connection by using lftp

We can see that we have no errors, but we also don't have any content in the directory that the anonymous FTP service uses. On Ubuntu, that directory is located at /srv/ftp, but we already changed the anonymous root directory to /var/ftp. Let's add a couple of files there and try to list the directory content in lftp:

Figure 7.10 – Checking if we can see the files we created on cli1 by using the touch command
Figure 7.10 – Checking if we can see the files we created on cli1 by using the touch command

Let's now try to download these files. To do that, FTP has a command called get (similar to how HTTP has a get command). Let's now download these four files that we used the touch command on:

Figure 7.11 – Using FTP's get command to retrieve multiple files from the FTP server
Figure 7.11 – Using FTP's get command to retrieve multiple files from the FTP server

If we wanted to upload files, we would need to use the put command but, of course, that wouldn't work as anonymous upload is forbidden by default (as it should be).

The next part of our scenario is to allow the user to log in to the user's home directory. That shouldn't be too hard, as we already mentioned the first option that we need to change, local_enable, and it needs to be set to YES. After that, we need to restart the vsftpd service. After we do that, we need to log in to the FTP server as a local user on the FTP server. Bearing in mind that we have a user called student there, let's log in to that one:

Figure 7.12 – Logging in as the student user via lftp (by using the -u option)
Figure 7.12 – Logging in as the student user via lftp (by using the -u option)

No problems so far. But all of these recipes were done on the premise that we're doing all this within the limits of our internal, secure network. What happens if our FTP server needs to be exposed to the internet? We don't want to use just regular, plain-text FTP as it would lead to disaster. So, the next step in our recipe is going to be to configure FTP with TLS.

We need to configure a couple of options in vsftpd.conf, and we can freely put these options at the end of that file:

rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=Yes
ssl_tlsv1=YES
ssl_sslv2=NO
ssl_sslv3=NO
ssl_ciphers=HIGH
force_local_data_ssl=YES
force_local_logins_ssl=YES
ssl_request_cert=NO
allow_anon_ssl=YES

Copy

Explain
We need to configure these options in accordance with our security requirements. Most commonly, we want to enable TLS 1.2 or 1.3 (ssl_ciphers=HIGH, SSLv2, and v3=no). We can always not allow anonymous users to use SSL, and if we don't want to run client certificate-based authentication, we have to make sure to use the ssl_request_cert=NO option.

At the beginning of this configuration, we can see the cert file and the corresponding private key configuration options. We just used the built-in, self-signed certificates. Of course, we can create Let's Encrypt certificates or buy commercial ones instead and put them in the configuration here. It's all about the corporate security policy where we want to run this sort of configuration.

A quick note on FTP clients on Windows: a lot of people are using WinSCP to upload and download files and directories by using SCP, SFTP, FTP, WebDav, and Amazon S3 sources. If we use WinSCP, we have to use FTP configuration, TLS/SSL explicit encryption, and other relevant parameters accordingly. There are also other options available if we click on the Advanced button. For example, we can choose a minimum TLS level and similar options. As TLS v1.2 is the minimum that's recommended at this point in time, we could set those options to 1.2 for both the minimum and maximum versions. But if we've set up our vsftpd.conf as we recommended, there's no need to touch those options as TLS v1.2 will be the only option available. We just wanted to mention these advanced options in case you need them.

That being said, here's a screenshot that will help in terms of basic options:

Figure 7.13 – How to connect to vsftpd with TLS 1.2 enabled
Figure 7.13 – How to connect to vsftpd with TLS 1.2 enabled

192.168.0.16 is the IP address of the cli1 machine. By using all of the options mentioned previously, we're able to log in anonymously to our vsftpd server and use it, just as we used it before we did the TLS configuration. But, bearing in mind that there were dozens and dozens of various types of attacks on the SSL protocol in the past couple of years (POODLE, BEAST, CRIME, BREACH, Heartbleed, SSL Stripping, using untrusted and fake certificate authorities, and so on), it's absolutely crucial that we pay close attention to every new attack and take all the necessary steps to mitigate those threats.

How it works…
vsftpd is an implementation of FTP, which means it's a TCP-based service that's used to upload and download files. Seeing as it's a TCP-based service, that means socket connections and reliable data transfer, which are essential to this service. Imagine if our file download or upload were to be unreliable; we definitely wouldn't like that. If we were to add an additional layer of security to it by using TLS, we'd still be using the same basic service, it's just that it'd be way more protected.

FTP uses ports 20 (ftp-data) and 21 (ftp). Both of these ports need to be allowed through the firewall for the FTP service to work. Port 21 is used as the command communication channel, while port 20 is used for data transfer, although there are implementations where port 21 can be used for both. There are some other options when using the FTP service (active FTP and passive FTP) but they are way beyond the scope of this book. Generally speaking, there's a reason why almost everybody uses SCP for file upload and download nowadays. Also, there's a reason why most of the distribution repositories and mirrors switched to using HTTPS-based delivery methods instead of FTP-based methods. There are exceptions, but they are more the exception to the rule types of situations, definitely not the standard.

FTP uses put and get commands to do two of its basic functions: upload (put) and download (get). These are two basic commands/methods that FTP uses, although we can create and delete content via FTP as well.

There's more
If you want to learn more about vsftpd, make sure that you check the following links:

vsftpd home page: https://security.appspot.com/vsftpd.html
vsftpd.conf man page: https://security.appspot.com/vsftpd/vsftpd_conf.html
How does an FTP server work and what are its benefits: https://www.ftptoday.com/blog/how-does-an-ftp-server-work-the-benefits
How to set up vsftpd for anonymous downloads on Ubuntu 16.04: https://www.digitalocean.com/community/tutorials/how-to-set-up-vsftpd-for-anonymous-downloads-on-ubuntu-16-04
