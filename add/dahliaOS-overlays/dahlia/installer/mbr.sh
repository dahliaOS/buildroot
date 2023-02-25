#for information on the MBR spec, see https://man.archlinux.org/man/sfdisk.8.en
echo "label: dos"
echo "unit: sectors"

echo "${1}1:			size=32MiB,	name="config",		type=83h"
echo "${1}2:			size=1024MiB,	name="recovery",	type=83h"
echo "${1}3:			size=4096MiB,	name="stateless",	type=83h"
echo "${1}4:					name="stateful",	type=83h"
