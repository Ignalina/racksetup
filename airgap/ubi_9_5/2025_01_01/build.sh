mkdir airgap
podman build -f uv_python_311.dockerfile -t ignalina/ubi_9_5_maker_base_uv_python_311:v1
podman build -v $PWD/airgap:/airgap/ -f ./lake_iceberg_170.dockerfile .
