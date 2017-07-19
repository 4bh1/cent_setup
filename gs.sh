#! /bin/bash

#Your project name
project_name="project_name"

#Server location list
server_list=(asia-east1-a asia-east1-c asia-east1-b asia-northeast1-a asia-northeast1-b asia-northeast1-c asia-southeast1-a asia-southeast1-b australia-southeast1-c australia-southeast1-a australia-southeast1-b europe-west1-b europe-west1-c europe-west1-d europe-west2-c europe-west2-b europe-west2-a us-central1-a us-central1-f us-central1-c us-central1-b us-east1-c us-east1-b us-east1-d us-east4-a us-east4-c us-east4-b us-west1-a us-west1-c us-west1-b)

zone_name=$(echo "${server_list[$(shuf -i 0-29 -n 1)]}")
#list of images on which the script should work
image_list=(centos-7-v20170620 ubuntu-1404-trusty-v20170703 ubuntu-1604-xenial-v20170619a ubuntu-1610-yakkety-v20170619a ubuntu-1704-zesty-v20170619a)

#selecting a random image
image=$(echo "${image_list[$(shuf -i 0-4 -n 1)]}")
echo "$image Selected for installation">>logs

#selecting image osproject
if echo $image |grep -q "ubuntu"; then
	os_project="ubuntu-os-cloud";
elif echo $image |grep -q "centos-7"; then
	os_project="centos-cloud";
else echo "Invalid Image";exit;
fi

#Genrating random instance name
inst_name="test"$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 5 | head -n 1)
echo "$inst_name is the instance name\n">>logs

gcloud compute --project $project_name instances create $inst_name --zone $zone_name  --machine-type "n1-standard-1" --subnet "default" --maintenance-policy "MIGRATE" --service-account "1016708991201-compute@developer.gserviceaccount.com" --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring.write","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --image $image --image-project $os_project --boot-disk-size "10" --boot-disk-type "pd-standard" --boot-disk-device-name $inst_name >>logs

#Sometime it wont connect just a 2 minute windows to make sure that every thing goes well
sleep 2m
#connects to the server and starts setting up the environment
gcloud compute ssh $(echo $inst_name) --command="curl https://raw.githubusercontent.com/4bh1/cent_setup/master/variant2.sh >> variant2.sh ; sudo bash ./variant2.sh" --zone $zone_name

#Now this script will sleep n amount of time add suffix s,m,h for seconds minutes hours respectively
sleep 2h

#deleting the instance
gcloud -q compute instances delete $inst_name  --zone $zone_name
