#!/bin/sh

yum -y install docker

systemctl start docker

systemctl enable docker