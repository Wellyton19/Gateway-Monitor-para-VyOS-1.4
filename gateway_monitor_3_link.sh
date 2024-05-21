#!/bin/bash

# Endereços IP dos gateways
gateway_10="10.70.100.1"
gateway_11="10.70.200.1"
gateway_12="10.70.250.1"
interface_10="eth0.100"
interface_11="eth0.200"
interface_12="eth0.250"

# Endereços IP externos para verificação
external_ips=("8.8.8.8" "200.160.2.3" "157.240.222.35")

log_file="/var/log/gateway_monitor.log"

# Função para adicionar log
log() {
    echo "$(date): $1" >> $log_file
}

# Função para verificar conectividade
check_connectivity() {
    local interface=$1
    local gateway=$2
    for ip in "${external_ips[@]}"; do
        ping -I $interface -c 1 -w 1 $ip > /dev/null
        if [ $? -eq 0 ]; then
            # Verifica se o gateway está novamente acessível
            ping -I $interface -c 1 -w 1 $gateway > /dev/null
            if [ $? -eq 0 ]; then
                return 0
            fi
        fi
    done
    return 1
}

# Verifica conectividade com o gateway e endereços externos para tabela 10
ping -I $interface_10 -c 1 -w 1 $gateway_10 > /dev/null && check_connectivity $interface_10 $gateway_10
if [ $? -ne 0 ]; then
    log "Gateway da tabela 10 ($gateway_10) inativo ou sem conectividade externa, alterando para o próximo gateway funcional na tabela 10."
    ip route replace default via $gateway_11 table 10
else
    log "Gateway da tabela 10 ($gateway_10) ativo e com conectividade externa, garantindo uso do gateway da tabela 10."
    ip route replace default via $gateway_10 table 10
fi

# Verifica conectividade com o gateway e endereços externos para tabela 11
ping -I $interface_11 -c 1 -w 1 $gateway_11 > /dev/null && check_connectivity $interface_11 $gateway_11
if [ $? -ne 0 ]; then
    log "Gateway da tabela 11 ($gateway_11) inativo ou sem conectividade externa, alterando para o próximo gateway funcional na tabela 11."
    ip route replace default via $gateway_10 table 11
else
    log "Gateway da tabela 11 ($gateway_11) ativo e com conectividade externa, garantindo uso do gateway da tabela 11."
    ip route replace default via $gateway_11 table 11
fi

# Verifica conectividade com o gateway e endereços externos para tabela 12
ping -I $interface_12 -c 1 -w 1 $gateway_12 > /dev/null && check_connectivity $interface_12 $gateway_12
if [ $? -ne 0 ]; then
    log "Gateway da tabela 12 ($gateway_12) inativo ou sem conectividade externa, alterando para o próximo gateway funcional na tabela 12."
    ip route replace default via $gateway_10 table 12
else
    log "Gateway da tabela 12 ($gateway_12) ativo e com conectividade externa, garantindo uso do gateway da tabela 12."
    ip route replace default via $gateway_12 table 12
fi
