Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetWeatherTypePersist("XMAS")
        SetWeatherTypeNowPersist("XMAS")
        SetWeatherTypeNow("XMAS")
        SetOverrideWeather("XMAS")
    end
end)