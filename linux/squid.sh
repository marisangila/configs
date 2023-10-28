#Executa um comando em como administrador
sudo
#UPDATE: é usado para baixar as atualizações e informações dos pacotes de todas as fontes (repositórios) configurados.
sudo apt-get update

###########################################################################################
#intalar e configurar SQUID

#Instalar Squid no Ubuntu 22.04 LTS
sudo apt-get install squid

#Fazer uma cópia do arquivo de configuração original
sudo cp /etc/squid/squid.conf /etc/squid3/squid.conf.orig

#Abrir o arquivo de configuração em um editor de texto
#Linha de comando:
sudo nano /etc/squid/squid.conf
#Interface gráfica:
sudo gedit /etc/squid/squid.conf

#Linha 1555
# Mudar http_access deny  all
http_access allow  all

#Reiniciar serviço:
systemctl restart squid

#Para visualizar o arquivo de log
sudo tail -f /var/log/squid/access.log
###########################################################################################
#Proxy transparente -


#Redirecionar as requisições -na porta 80 para o proxy - IPtables
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to 127.0.0.1:3128 
#ou
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 3128
#ou
sudo iptables -t nat -A PREROUTING -i wlp3s0 -p tcp --dport 80 -j DNAT --to 192.168.15.1:3128
sudo iptables -t nat -A PREROUTING -i wlp3s0 -p tcp --dport 80 -j REDIRECT --to-port 3128
#ou
sudo iptables -t nat -I PREROUTING -p tcp -s 192.168.15.0/24 --dport 80 -j REDIRECT --to-port 3128

#Caso necessário trocar o eth0 para o nome da interface de rede. Para chegar a interface de rede use o comando ifconfig
#Exemplo com insterface de rede Wifi:
#sudo iptables -t nat -A PREROUTING -i wlp3s0 -p tcp --dport 80 -j DNAT --to 127.0.0.1:3128 
#no cliente
sudo iptables -t nat -A OUTPUT -p tcp --dport 80 -j DNAT --to 10.X.X.X:3128

#Persisitir as configurações de IPTables mesmo que o servidor seja reiniciado
sudo iptables-persistent 
#visualizar IPTables:
sudo iptables -t nat -L


#Comandos úteis

#Reiniciar serviço:
systemctl restart squid

#Iniciar serviço:
systemctl start squid

#Verificar status do serviço:
systemctl status squid

#Parar serviço:
systemctl stop squid

#Lista todos os serviços
systemctl list-units --type=service --state=active 

#Lista serviços em execução
systemctl list-units --type=service
###########################################################################################
#Para instalar o net-tools
sudo apt-get install net-tools

#comando para visualizar informações de placa de rede.
ifconfig





#go
sudo iptables -t nat -I PREROUTING -p tcp -s 192.168.15.0/24 --dport 80 -j REDIRECT --to-port 3128
sudo iptables -t nat -I PREROUTING -p udp -s 192.168.15.0/24 --dport 80 -j REDIRECT --to-port 3128
sudo iptables -I INPUT 1 -p tcp --dport 3128 -j ACCEPT
sudo iptables -I INPUT 1 -p tcp --sport 3128 -j ACCEPT
sudo iptables -P INPUT DROP
iptables-save > /etc/iptables/rules.v4





sudo dpkg-reconfigure iptables-persistent
