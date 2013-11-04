name "tomcat"
description "Basic Apache Tomcat 7 setup."
run_list("role[java]","recipe[tomcat]","recipe[webapps]")
