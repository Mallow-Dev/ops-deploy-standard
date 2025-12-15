FROM ubuntu:22.04
RUN apt-get update && apt-get install -y openssh-server sudo ca-certificates curl jq && mkdir /var/run/sshd
RUN useradd -m -s /bin/bash deploy && echo "deploy ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/deploy
RUN mkdir -p /home/deploy/.ssh && chown deploy:deploy /home/deploy/.ssh
COPY mock-systemctl.sh /usr/local/bin/mock-systemctl
RUN chmod +x /usr/local/bin/mock-systemctl
EXPOSE 22 2222
CMD ["/usr/sbin/sshd", "-D"]
