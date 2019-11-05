FROM python:3-slim

ENV KUBE_VERSION v1.16.2
ENV HELM_VERSION v2.15.2

RUN apt-get update \
    && apt-get install -y \
    ca-certificates \
    curl && \
    curl -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    curl -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar -xzO linux-amd64/helm > /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    rm -rf linux-amd64 && \
    pip install --no-cache-dir --upgrade \
    pip \
    setuptools \
    awscli && \
    apt-get remove -y curl && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

CMD [ "/bin/bash" ]
