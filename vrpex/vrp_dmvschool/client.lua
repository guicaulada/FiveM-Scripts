
function startIntro()
	start_pos = GetEntityCoords(GetPlayerPed(-1))
	DIntro() 
	tlock = false
end

function payTheory()
    if tlock then
		DrawMissionText2(lang.client.locked, 5000)			
	else
		DMVserver.payTheory()
	end
end

function payPractical()
    if plock then
		DrawMissionText2(lang.client.locked, 5000)
	else
		DMVserver.payPractical()
	end
end

function vRPdmv.startTheory()
	openGui()
	Menu.hidden = not Menu.hidden
end

function vRPdmv.startPractical()
	start_pos = GetEntityCoords(GetPlayerPed(-1))
	onTestBlipp = AddBlipForCoord(cfg.practical.steps[1].pos[1],cfg.practical.steps[1].pos[2],cfg.practical.steps[1].pos[3])
	N_0x80ead8e2e1d5d52e(onTestBlipp)
	SetBlipRoute(onTestBlipp, 1)
	onTestEvent = 1
	DamageControl = 1
	SpeedArea = 1
	onPtest = true
	DTut()
end

function vRPdmv.setLicense(license)
	TestDone = license
	tlock = not license
	plock = not license
end