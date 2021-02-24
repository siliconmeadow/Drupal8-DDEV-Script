#!/bin/bash

helpFunction() {
    echo ""
    echo "Usage: $0 -n FolderName"
    echo -e "\t-n Name of the folder you would to be created and the drupal environment stored in"
    exit 1
}

while getopts "n:" opt
do
    case "$opt" in
        n ) FolderName="$OPTARG" ;;
        ? ) helpFunction ;; 
    esac
done

if [ -z "$FolderName" ]
then
    echo "Error: Empty Parameter"
    helpFunction
fi

mkdir $FolderName
cd $FolderName/
ddev config --project-type=drupal8 --docroot=web --create-docroot
ddev start
ddev composer create "drupal/recommended-project:^8" -y
ddev composer require drush/drush
ddev drush site:install -y
ddev drush uli
ddev launch
