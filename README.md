Monitor de Gateway para VyOS 1.4
Este script em Bash foi desenvolvido para monitorar e gerenciar gateways em um ambiente VyOS 1.4. Ele é útil para manter a conectividade de rede em caso de falha de um gateway. O script verifica a disponibilidade dos gateways e, se um deles estiver inativo, altera dinamicamente as rotas para usar um gateway funcional.

Funcionalidades:
Monitoramento contínuo dos gateways especificados.
Failover automático para gateways alternativos em caso de falha.
Restauração automática das rotas originais quando um gateway inativo volta a ficar disponível.
Fácil configuração e personalização.
Requisitos:
Sistema operacional VyOS 1.4 ou posterior.
Permissões de root para executar o script.
Conhecimento básico de configuração de rede e tabelas de roteamento.
Como usar:
Clone este repositório em sua máquina VyOS:
bash
Copiar código
git clone https://github.com/Wellyton19/Gateway-Monitor-para-VyOS-1.4.git
Edite o script gateway_monitor.sh e insira os detalhes específicos da sua rede, como endereços IP dos gateways, interfaces correspondentes e endereços IP externos para verificação de conectividade.

Dê permissão de execução ao script:

bash
Copiar código
chmod +x gateway_monitor.sh
Configure o script para ser executado periodicamente, por exemplo, adicionando-o ao cron para executar a cada minuto:
bash
Copiar código
sudo crontab -e
Adicione a seguinte linha ao final do arquivo:

plaintext
Copiar código
* * * * * /home/vyos/gateway_monitor.sh
Notas:
Certifique-se de revisar e ajustar os parâmetros do script de acordo com a configuração da sua rede antes de usar.
Este script é compatível com VyOS 1.4, mas pode ser modificado para outras versões ou sistemas operacionais, se necessário.
