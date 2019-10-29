#!/usr/bin/expect

user="root"
password="root"

/usr/bin/expect << EOF
set timeout 5
spawn ssh -o "StrictHostKeyChecking no" ${user}@${host}
expect {
"yes/no)?" { send "yes\r"; exp_continue }
"password:" { send "${password}\r" }
}

expect "root*"
send "ssh-keygen -t rsa\r"
expect "Enter file in which to save the key*"
send "\r"

expect {
"(y/n)?" { send "n\r"; exp_continue }
"Enter passphrase*" { send "\r"; exp_continue }
"Enter same passphrase again:" { send "\r" }
}

expect "root*"
send "df -h\r"
expect "root*"
send "exit\r"

EOF
