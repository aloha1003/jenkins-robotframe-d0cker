FROM jenkins:2.7.1
MAINTAINER John Lin <knives1003@gmail.com>
COPY install_jenkins_plugin_with_dependency.sh /usr/local/bin/install_jenkins_plugin_with_dependency.sh
COPY custom.groovy /usr/share/jenkins/ref/init.groovy.d/custom.groovy
#COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
USER root
#RUN  /usr/local/bin/install_jenkins_plugin_with_dependency.sh /usr/share/jenkins/ref/plugins.txt


# Install Robot FrameWork

RUN apt-get update
RUN apt-get install -y curl unzip libssl-dev python-pip python-dev gcc   libnss3-dev 
#
#Install Google chromium
RUN apt-get install -y 
RUN apt-get install -y chromium-browser xvfb 



# Install selenium2 Chrome Driver
RUN curl -o chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/2.20/chromedriver_linux64.zip 
RUN unzip chromedriver_linux64.zip -d .
RUN chmod +x ./chromedriver
RUN mv -f ./chromedriver /usr/local/share/chromedriver

#  Change the directory to /usr/bin/chromedriver
RUN ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver
RUN ln -s /usr/local/share/chromedriver /usr/bin/chromedriver
RUN pip install --upgrade setuptools
RUN pip install --upgrade pip
RUN pip install robotframework 
RUN pip install pycrypto
RUN pip install robotframework-sshlibrary 
RUN pip install robotframework-selenium2library

#Init Xvfb -- 這裡是雷
#RUN export DISPLAY=:1.0
#RUN Xvfb :1 -screen 0 1024x768x16 &> xvfb.log

#Install Chinese font
RUN apt-get install fonts-wqy-zenhei

RUN mkdir /robot
RUN mkdir /testing

ENV DISPLAY=:1.0
ENV ROBOT_TESTS=/testing/
#WORKDIR /robot
#COPY ./testing /testing
#COPY entry_point.sh /robot/entry_point.sh




# Create Jenkins User
#RUN useradd jenkins -m -s /bin/bash

# Add public key for Jenkins login
#RUN mkdir /home/jenkins/.ssh
#COPY /files/authorized_keys /home/jenkins/.ssh/authorized_keys
#RUN chown -R jenkins /home/jenkins
#RUN chgrp -R jenkins /home/jenkins
#RUN chmod 600 /home/jenkins/.ssh/authorized_keys
#RUN chmod 700 /home/jenkins/.ssh

# Add the jenkins user to sudoers
#RUN echo "jenkins  ALL=(ALL)  ALL" >> etc/sudoers

