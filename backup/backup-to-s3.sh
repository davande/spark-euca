#!/bin/sh

rm -rf /mnt/hdfs-backup #delete previous backups
mkdir -P /mnt/hdfs-backup
chown -R hdfs:hadoop /mnt/hdfs-backup

hadoop fs -get / /mnt/hdfs-backup/hdfs #copy everything from HDFS to local dirs


#Rsyncing the file. For more options check here: http://s3tools.org/usage
s3cmd -c /etc/s3cmd/s3cfg --disable-multipart --delete-removed --delete-after --skip-existing sync /mnt/hdfs-backup s3://$CLUSTER_NAME/#will skip files that already exist on the destination but will first check the md5 checksums

### Alternative ways to backup ###

#Faster but more prune to error
#s3cmd -c /etc/s3cmd/s3cfg --disable-multipart --delete-removed --no-check-md5 --dry-run sync /mnt/hdfs-backup s3://$CLUSTER_NAME/ #Will not upload a file with the same name and size -- might lose some changes

#Putting the file
#s3cmd -c /etc/s3cmd/s3cfg --disable-multipart --recursive put /mnt/hdfs-backup/ s3://$CLUSTER_NAME/hdfs-backup/

#With the following you have to allow big chunk size - otherwise use with --disable-multipart option
#s3cmd -c /etc/s3cmd/s3cfg  --recursive put /mnt/hdfs-backup s3://$CLUSTER_NAME/hdfs-backup/



