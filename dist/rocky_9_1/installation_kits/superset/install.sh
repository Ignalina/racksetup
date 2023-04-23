mesh_machine_nr
nr=$?
if [[ $nr -eq 1 ]]
then
   echo "I AM MASTER_HOST=${brokkr_mesh_ip[1]}"

   dnf -y install gcc gcc-c++ libffi-devel python3-devel python3-pip python3-wheel openssl-devel cyrus-sasl-devel openldap-devel
   pip3 install --upgrade pip
   pip install --upgrade setuptools pip
   pip -y install virtualenv


   useradd -s /sbin/nologin -M superset -G x14
   cp superset.service /tmp
   pushd /usr/lib/x14
     mkdir -p /var/lib/x14/superset/
     chown -R zeppelin:x14 /var/lib/x14/superset/
     mkdir -p superset
     chown -R superset:x14 superset
       pushd superset
       python3 -m venv venv
       . venv/bin/activate
       pip install apache-superset
       superset db upgrade



       # Create an admin user in your metadata database (use `admin` as username to be able to load the examples)
       export FLASK_APP=superset
       superset fab create-admin

       # Load some data to play with
       superset load_examples

       # Create default roles and permissions
       superset init

       # Build javascript assets
       pushd superset-frontend
       npm ci
       npm run build
       popd


       cp /tmp/superset.service /etc/systemd/system/
       systemctl enable superset.service
         
       popd
       chown -R superset:x14
   popd
fi
