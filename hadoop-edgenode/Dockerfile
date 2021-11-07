FROM centos/python-38-centos7

USER root
COPY ./cloudservices-root-ca.crt /etc/pki/ca-trust/source/anchors/cloudservices-root-ca.crt
COPY ./requirements.txt /tmp/requirements.txt
RUN update-ca-trust
RUN yum -y install postgresql-client postgresql-contrib postgresql-dev
RUN pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org --no-cache-dir -r /tmp/requirements.txt
