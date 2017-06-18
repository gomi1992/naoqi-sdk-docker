FROM ubuntu:14.04

ADD sources.list /etc/apt/

RUN apt-get update && apt-get install -y build-essential cmake unzip python-pip python-dev libicu-dev
RUN pip install qibuild

ADD ctc-linux64-atom-2.1.4.13.zip /
RUN unzip ctc-linux64-atom-2.1.4.13.zip && \
    rm ctc-linux64-atom-2.1.4.13.zip

ADD naoqi-sdk-2.1.4.13-linux64.tar.gz /

RUN cd /root && qibuild init && \
    qitoolchain create atom /ctc-linux64-atom-2.1.4.13/toolchain.xml && \
    qitoolchain create pc /naoqi-sdk-2.1.4.13-linux64/toolchain.xml && \
    qibuild add-config atom -t atom && \
    qibuild add-config pc -t pc --default 

#ADD pynaoqi-python2.7-2.1.4.13-linux64.tar.gz /
#RUN echo "export PYTHONPATH=${PYTHONPATH}:/pynaoqi-python2.7-2.1.4.13-linux64"  >> /root/.bashrc && \
    #echo "/naoqi-sdk-2.1.4.13-linux64/lib" >> /etc/ld.so.conf.d/naoqi.conf && \
    #echo "/pynaoqi-python2.7-2.1.4.13-linux64"  >> /etc/ld.so.conf.d/naoqi.conf && \
    #ldconfig
