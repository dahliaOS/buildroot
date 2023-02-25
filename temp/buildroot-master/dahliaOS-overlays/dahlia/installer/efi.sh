#for information on UUIDs, see https://systemd.io/DISCOVERABLE_PARTITIONS/
echo "label: gpt"
echo "unit: sectors"
echo ""
echo "${1}1:	start=1MiB,	size=260MiB,										type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B"
echo "${1}2:			size=1024MiB,	name="recovery",	uuid=6c46966e-2d83-47f4-8421-9d31214c3ff7	type=0fc63daf-8483-4772-8e79-3d69d8477de4"
echo "${1}3:			size=4096MiB,	name="stateless",	uuid=2431c41c-ed0d-4847-a4cb-125317b5472a	type=4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709"
echo "${1}4:					name="stateful"								type=0fc63daf-8483-4772-8e79-3d69d8477de4"
