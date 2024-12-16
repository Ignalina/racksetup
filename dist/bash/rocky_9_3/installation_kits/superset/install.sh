mesh_machine_nr
nr=$?
if [[ $nr -eq 1 ]]
then
   echo "I AM MASTER_HOST=${brokkr_mesh_ip[1]}"

   dnf -y install gcc gcc-c++ libffi-devel python3-devel python3-pip python3-pip-wheel  openssl-devel cyrus-sasl-devel openldap-devel g++
   pip3 install --upgrade pip
   pip install --upgrade setuptools pip
   pip install virtualenv


   useradd -s /sbin/nologin -M superset -g x14
   mkdir /home/superset
   chown superset:x14 /home/superset
   cp superset.service /tmp
   cp start.sh /tmp
   cp superset_config.py /tmp
   pushd /usr/lib/x14
     mkdir -p /var/lib/x14/superset/
     
     chown -R superset:x14 /var/lib/x14/superset/
     mkdir -p superset
     chown -R superset:x14 superset
       pushd superset
       cp /tmp/start.sh .
       chmod +x start.sh
       python3 -m venv venv
       cp /tmp/superset_config.py venv/bin/
       sudo -u superset . venv/bin/activate
       sudo -u superset python3 -m pip install --upgrade pip
       sudo -u supersetpip install numpy apache-superset pillow
       sudo -u superset pip install sqlparse=='0.4.3'
       sudo -u superset pip install marshmallow-enum
       sudo -u superset FLASK_APP=superset superset db upgrade


       # Create an admin user in your metadata database (use `admin` as username to be able to load the examples)
       sudo -u superset superset fab create-admin
       # Load some data to play with
       sudo -u superset superset load_examples

       # Create default roles and permissions
       sudo -u superset superset init

       # Build javascript assets
#       pushd superset-frontend
#       npm ci
#       npm run build
#       popd


       cp /tmp/superset.service /etc/systemd/system/
       systemctl enable superset.service
         
       popd
       chown -R superset:x14  superset
   popd
fi


