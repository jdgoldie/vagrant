name "base"
description "Basic node configuration."
run_list("recipe[common]","recipe[hosts]")