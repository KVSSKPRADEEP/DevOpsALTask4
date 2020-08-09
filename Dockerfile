FROM centos
RUN yum install java-11-openjdk.x86_64 sudo git -y
RUN yum install openssh-server passwd net-tools -y
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod +x ./kubectl
RUN sudo mv ./kubectl /usr/local/bin/kubectl
RUN mkdir /root/.kube/
COPY client.crt /root/
COPY client.key /root/
COPY ca.crt /root/
RUN echo 'root:area51' | chpasswd
RUN mkdir /root/jenkins/
RUN /usr/bin/ssh-keygen -A
EXPOSE 22
CMD /usr/sbin/sshd -D && /bin/bash

