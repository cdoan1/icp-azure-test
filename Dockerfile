FROM ibmcom/icp-inception:3.1.1

COPY *.patch /tmp/
COPY azure_cloud_conf.j2 /installer/playbook/roles/kubelet-config/templates/azure_cloud_conf.j2
COPY azure_cloud_conf-controller.j2 /installer/playbook/roles/master/templates/conf/azure_cloud_conf-controller.j2

RUN patch /installer/playbook/group_vars/all.yaml /tmp/all.yaml.patch && \
    patch /installer/playbook/roles/common/tasks/always.yaml /tmp/always.yaml.patch && \
    patch /installer/playbook/roles/kubelet-config/templates/kubelet.service.j2 /tmp/kubelet.service.j2.patch && \
    patch /installer/playbook/roles/master/tasks/config.yaml /tmp/config.yaml.patch && \
    patch /installer/playbook/roles/master/templates/pods/master.json.j2 /tmp/master.json.j2.patch && \
    patch /installer/playbook/roles/kubelet-config/tasks/common.yaml /tmp/common.yaml.patch
