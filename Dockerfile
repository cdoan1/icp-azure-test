FROM ibmcom/icp-inception:3.1.0

COPY calico-1.1.1.tgz /addon/

# RUN sed -i 's|^network_helm_chart_path:.*|network_helm_chart_path: "/addon/calico-1.1.1.tgz"|' /installer/playbook/group_vars/all.yaml
# COPY all.yaml /installer/playbook/group_vars/all.yaml
COPY *.patch /tmp/
#COPY always.yaml /installer/playbook/roles/common/tasks/always.yaml
#COPY common.yaml /installer/playbook/roles/kubelet/tasks/common.yaml
COPY azure_cloud_conf.j2 /installer/playbook/roles/kubelet/templates/azure_cloud_conf.j2
#COPY kubelet.service.j2 /installer/playbook/roles/kubelet/templates/kubelet.service.j2
#COPY config.yaml /installer/playbook/roles/master/tasks/config.yaml
COPY azure_cloud_conf-controller.j2 /installer/playbook/roles/master/templates/conf/azure_cloud_conf-controller.j2
#COPY master.json.j2 /installer/playbook/roles/master/templates/pods/master.json.j2
# COPY tiller.yaml.j2 /installer/playbook/roles/tiller/templates/tiller.yaml.j2

RUN patch  /installer/playbook/group_vars/all.yaml /tmp/all.yaml.patch && \
    patch /installer/playbook/roles/common/tasks/always.yaml /tmp/always.yaml.patch && \
    patch /installer/playbook/roles/kubelet/templates/kubelet.service.j2 /tmp/kubelet.service.j2.patch && \
    patch /installer/playbook/roles/master/tasks/config.yaml /tmp/config.yaml.patch && \
    patch /installer/playbook/roles/master/templates/pods/master.json.j2 /tmp/master.json.j2.patch && \
    patch /installer/playbook/roles/kubelet/tasks/common.yaml /tmp/common.yaml.patch
