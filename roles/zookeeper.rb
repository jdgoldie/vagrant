name "zookeeper"
description "Zookeeper Node"
run_list("role[java]","recipe[zookeeper]")
