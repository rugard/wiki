# fix iscsi server after kernel upgrade

>
>root@zeus:/mnt/pdc/etc/dhcp# service iscsitarget start
> * Starting iSCSI enterprise target service                                                                        
> FATAL: Module iscsi_trgt not found.

apt-get install --reinstall iscsitarget-dkms
