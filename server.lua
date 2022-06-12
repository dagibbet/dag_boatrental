


RegisterServerEvent('dag_boatrental:server:buyboat')
AddEventHandler( 'dag_boatrental:server:buyboat', function (args)
    local _price    = args['Price']
    local _model    = args['Model']

    local User = exports['qbr-core']:GetPlayer(source)

    u_money = User.Functions.GetMoney('cash')
	
    if u_money < _price then
        TriggerClientEvent('rsg_notify:client:notifiy', source, "You don't have enough money", 3000)
        return
    end

    User.Functions.RemoveMoney('cash', _price)

    TriggerClientEvent('rsg_notify:client:notifiy', source, "You rented a boat", 3000)
    TriggerClientEvent("dag_boatrental:client:spawnBoat", source, _model)
end)

