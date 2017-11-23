
Run chef-client with overriden run_list. Node attributes shouldn't update at the end of chef client run.


```
sudo chef-client -o role[default_base],recipe[initialubuntu::customscripts_geo]
```
