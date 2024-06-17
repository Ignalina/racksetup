
# Download the mirror-registry.tar.gz from redhat.



OCP_RELEASE=4.15.0-0.okd-2024-03-10-010116
PRODUCT_REPO='openshift'
RELEASE_NAME="okd"


# mirror-registry
# For setup see https://docs.openshift.com/container-platform/4.15/installing/disconnected_install/installing-mirroring-creating-registry.html

LOCAL_REGISTRY='quay.x14.se:8443'
LOCAL_REPOSITORY='openshift'
LOCAL_SECRET_JSON='quay-pull-secret.txt'


./oc adm release mirror -a ${LOCAL_SECRET_JSON}  \
     --from=quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE} \
     --to=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY} \
     --to-release-image=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY}:${OCP_RELEASE} \
     --v2


#imageContentSources:
#- mirrors:
#  - quay.x14.se:8443/openshift
#  source: quay.io/openshift/okd
#- mirrors:
#  - quay.x14.se:8443/openshift
#  source: quay.io/openshift/okd-content


#To use the new mirrored repository for upgrades, use the following to create an ImageContentSourcePolicy:

#apiVersion: operator.openshift.io/v1alpha1
#kind: ImageContentSourcePolicy
#metadata:
#  name: example
#spec:
#  repositoryDigestMirrors:
#  - mirrors:
#    - quay.x14.se:8443/openshift
#    source: quay.io/openshift/okd
#  - mirrors:
#    - quay.x14.se:8443/openshift
#    source: quay.io/openshift/okd-content
