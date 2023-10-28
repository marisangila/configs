#Verificar s se o processador suporta virtualização
$ egrep -c ‘(vmx|svm)’ /proc/cpuinfo
#ou
$ lscpu | grep Virtualization

#Instalar KVM
$ sudo apt -y install bridge-utils cpu-checker libvirt-clients libvirt-daemon qemu qemu-kvm

#Verificar se a dependências estão instaladas
sudo kvm-ok

#Verificar se status do serviço
sudo systemctl status libvirtd

#Se não estiver execuntando:
$ sudo systemctl enable –now libvirtd

#Se não estiver instalado:
sudo apt update
sudo apt install qemu-kvm libvirt-daemon-system

#Associar usuário a o grupo
sudo adduser $USER libvirt

#Instalar interface gráfica Virt-manager

#Linha de comando
#Criar VM
sudo virt-install –name=ubuntu-guest –os-variant=ubuntu20.04 –vcpu=2 –ram=2048 –graphics none –location=[local path to iso file] –network bridge:vibr0

# Name: specify the name of the virtual machine being created
# vcpu: Number of virtual CPUs to configure for the guest.
# Ram: Memory to allocate for guest instance in megabytes. According to your machine, you can specify the given memory of the VM.
# Graphics spice: If no graphics option is specified, “virt-install” will default to ‘–graphics vnc’ if the display environment variable is set, otherwise ‘–graphics none’ is used.
# Location: location of iso file on which virtual machine will be built. It can be the path to an ISO image, or to a CDROM device. It can also be a URL from which to fetch/access a minimal boot ISO image.
# Network-bridge: Connect the guest to the host network, Connect to a bridge device in the host called “BRIDGE”.
