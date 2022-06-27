function vpn-on() --description 'Switch on the vpn'
    networksetup -setnetworkserviceenabled "Cato Networks - valentino_volonghi.adroll" on
    networksetup -connectpppoeservice "Cato Networks - valentino_volonghi.adroll"
end

function vpn-off() --description 'Swith off the vpn'
    networksetup -setnetworkserviceenabled "Cato Networks - valentino_volonghi.adroll" off
end
