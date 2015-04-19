#!/bin/sh

# simple script to create basic qemu virtual machines

function print_usage {
echo "Usage:"
echo -e "${0##*/} 'name'\tCreate a new QEMU VM"
echo -e "${0##*/} -h\t\tShow this help message"
}

function arch_choice {
read -p "Select VM architecture [i386/x86_64/arm] (default: i386): " arch

case $arch in
	i386|x86_64|arm);;
	'') arch="i386";;
	*)
		echo "Bad architecture !"
		arch_choice;;
esac
}

function image_size_choice {
read -p "Enter VM main image size in K,M or G: " size

case $size in
	*K|*k|*M|*m|*G|*g);;
	*)
		echo "Bad size !"
		image_size_choice;;
esac
}

function options_choice {
read -p "Enter permanent VM options: " options
}

function iso_choice {
read -p "Absolute path to ISO for install: " -e iso

if ! mediainfo "$iso" | grep "ISO 9660" > /dev/null
then
	echo "$iso not found or not a ISO file"
	iso_choice
fi
}

function config {
arch_choice
image_size_choice
options_choice
iso_choice
recap
}

function recap {
echo -e "\nVM infos ($dir):"
echo "VM arch: $arch"
echo "Disks size: $size"
echo "VM options: $options"
echo "Install ISO: $iso"

read -p "Is this correct ? [y/N] " ans
case $ans in
	y|Y) build_vm;;
	*) config;;
esac
}

function build_vm {
mkdir "$dir"
cd "$dir"

qemu-img create -f qcow2 main.qcow2 "$size"

if [ "$arch" == "arm" ]
then
	options="-machine none $options"
fi

launch_command="qemu-system-$arch $options main.qcow2"

echo -e "#!/bin/sh\n" > start.sh
echo -e "$launch_command\n" >> start.sh
echo "exit 0" >> start.sh
chmod +x start.sh

echo -e "#!/bin/sh\n" > install.sh
echo -e "$launch_command -cdrom \"$iso\"" >> install.sh
echo "exit 0" >> install.sh
chmod +x install.sh

read -p "VM created. Start install now ? [y/N] " ans
case $ans in
	y|N) ./install.sh;;
	*) echo "Use install.sh to install then start.sh to launch the VM once the install is done."
esac
}

case $1 in
	-h)
		print_usage
		exit 0;;
	'')
		print_usage
		exit 1;;
	*);;
esac

if [ -e "$1" ]
then
	read -p "$1 already exists, overwrite ? [y/N] " ans

	case $ans in
		y|N) rm -rf "$1";;
		*)
			echo "Aborting..."
			exit 1;;
	esac
fi

dir="$1"

config

exit 0
