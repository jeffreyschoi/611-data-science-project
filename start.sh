#! bin/bash/

docker build . -t my_bios_611_project

docker run -p 8787:8787 --rm -v "$(pwd)":/home/rstudio/work -e PASSWORD=qweasd1 -it amoselb/rstudio-m1