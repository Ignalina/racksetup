mkdir airgap
podman build -f uv_python_311.dockerfile -t ignalina/fedora_40_maker_base_uv_python_311:v1
podman build -v $PWD/airgap:/airgap/ -f ./lake_iceberg_170.dockerfile .

