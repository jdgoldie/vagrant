name "mongo"
description "MongoDB Server"
run_list("role[base]","recipe[mongo]")
