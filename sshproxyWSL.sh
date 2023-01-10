#!/bin/bash

# Generate ssh keys in both openssh and ppk formats and copy to windows side
# 2023-01-09 Switched to pulling credentials from 1password. Requires using expect script.

username=${USER}
win_dir="/mnt/c/Users/alden"
wsl_dir="/home/afan/.ssh"

# get password and OTP from 1password
passref="op://Personal/NERSC/password"
otp=$(op item get nersc --otp)

echo "Generate NERSC ssh key in OpenSSH format"
#cmd="sshproxy.sh -u ${username}" # OLD
echo "  User: ${username}"
echo "  Password: pulling from 1password: ${passref}"
echo "  OTP: pulling from 1password: ${otp}"

# resolve password here
cmd="/usr/local/bin/sshproxy.exp ${username} $(op read $passref) ${otp}"
#echo "cmd: ${cmd}"
echo "===========SSHPROXY==========="
$cmd
echo "===========SSHPROXY==========="
echo 
echo "Copying NERSC ssh key to Windows"
grep "ssh-rsa-cert" ${wsl_dir}/nersc > ${win_dir}/nersc.pub
grep -v "ssh-rsa-cert" ${wsl_dir}/nersc > ${win_dir}/nersc


#echo
#echo "Generate NERSC ssh key in ppk format"
#cmd2="sshproxy.sh -u ${username} -p -o /mnt/c/Users/alden/nersckey"
#echo "cmd: ${cmd2}"
#echo "===========SSHPROXY==========="
#$cmd2
#echo "===========SSHPROXY==========="
