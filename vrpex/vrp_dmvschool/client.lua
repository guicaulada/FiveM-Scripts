--[[
    FiveM Scripts
    Copyright C 2018  Sighmir

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    at your option any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]


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