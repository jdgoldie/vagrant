name "cas"
description "Apache Tomcat 7 with CAS webapp."
run_list("role[tomcat]","recipe[cas]")
