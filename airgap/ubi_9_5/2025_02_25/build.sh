mkdir airgap
podman build -f uv_python_311.dockerfile -t ignalina/ubi_9_5_maker_base_uv_python_311:v1
podman build -v $PWD/airgap:/airgap/ -f ./lake_iceberg_180.dockerfile .
podman build -v $PWD/airgap:/airgap/ -f ./falkordb.dockerfile .
podman build -v $PWD/airgap:/airgap/ -f ./ranger.dockerfile .
