#!/bin/bash

echo "alias suvagrant='su - vagrant -c \"cd \`pwd\`; bash\"'" >> /root/.bashrc
echo "alias suroot='su - -c \"cd \`pwd\`; bash\"'" >> /home/vagrant/.bashrc


# unalias ls