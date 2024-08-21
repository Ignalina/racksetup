# First hardcoded variant, creating complete PKI for a static and standard size cluster
  pushd /usr/lib/x14
  rm -rf pki
  mkdir -p pki
 
  pushd pki
  passet=changme
  mesh_create_ca_cert '/CN=ca.kafka.x14.se/OU=PROD/O=X14/L=Stockholm/C=SE' $passet
 
  mesh_create_sub_cert server1 "CN=localhost/OU=PROD/O=X14/L=Stockholm/S=ST/C=SE" $passet
  mesh_create_sub_cert server2 "CN=localhost/OU=PROD/O=X14/L=Stockholm/S=ST/C=SE" $passet
  mesh_create_sub_cert server3 "CN=localhost/OU=PROD/O=X14/L=Stockholm/S=ST/C=SE" $passet

# Creating 4 distinguished client entities with 2 OU=PROD or OU=TEST for kafka acl
# Note: NOT RECOMMENDED FOR REAL LIVE SETUP: Since the test users will get ssl connection to prod kafka server
  mesh_create_sub_cert client1_prod "CN=localhost/OU=PROD/O=X14/L=Stockholm/S=ST/C=SE" $passet
  mesh_create_sub_cert client1_test "CN=localhost/OU=TEST/O=X14/L=Stockholm/S=ST/C=SE" $passet

  mesh_create_sub_cert client2_prod "CN=localhost/OU=PROD/O=X14/L=Stockholm/S=ST/C=SE" $passet
  mesh_create_sub_cert client2_test "CN=localhost/OU=TEST/O=X14/L=Stockholm/S=ST/C=SE" $passet

  mesh_create_sub_cert client3_prod "CN=localhost/OU=PROD/O=X14/L=Stockholm/S=ST/C=SE" $passet
  mesh_create_sub_cert client3_test "CN=localhost/OU=TEST/O=X14/L=Stockholm/S=ST/C=SE" $passet

  mesh_create_sub_cert client4_prod "CN=localhost/OU=PROD/O=X14/L=Stockholm/S=ST/C=SE" $passet
  mesh_create_sub_cert client4_test "CN=localhost/OU=TEST/O=X14/L=Stockholm/S=ST/C=SE" $passet


  popd
  popd

