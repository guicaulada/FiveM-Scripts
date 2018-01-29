
local cfg = {}

cfg.firstjob = "citizen" -- set this to your first job, for example "citizen", or false to disable
cfg.showjob = true -- show job automatically with cfg.job css

-- job text display css
cfg.job = [[
.div_job{
  position: absolute;
  top: 186px;
  right: 20px;
  font-size: 40px;
  font-family: Pricedown !important;
  color: white;
  text-shadow: black 0 0 10px;
}
]]

-- list of ["group"] => {text = "", css = [[ .div_group{ } ]]} for extra specific css
cfg.group = {
  ["sheriff"] = {
    text = "", -- jobs just need the icon css
	css = [[
      .div_sheriff #icon{
        position: absolute;
        content: url(http://www.freeiconspng.com/uploads/gold-police-badge-icon-9.png);
        height: 30px;
        width: 30px;
        top: 186px;
        right: 120px;
      }
    ]], -- this is an example, add more under it using the same model, leave the } at the end.
  }, -- commas are impotant and so are { }
  ["[RANK] A - Group"] = { -- example using spaces ( spaces are not accepted in the css, notice how it removes every symbol but _ )
    text = "",
	css = [[
      .div_RANKAGroup #icon{
        position: absolute;
        content: url(http://www.freeiconspng.com/uploads/gold-police-badge-icon-9.png);
        height: 30px;
        width: 30px;
        top: 186px;
        right: 120px;
      }
    ]], -- this is an example, add more under it using the same model, leave the } at the end.
  }, -- commas are impotant and so are { }
  ["admin"] = {
    text = "Admin", -- groups need text and icon css
	css = [[
	  .div_admin{
		position: absolute;
		top: 230px;
		right: 20px;
		font-size: 40px;
		font-family: Pricedown !important;
		color: white;
		text-shadow: black 0 0 10px;
	  }
      .div_admin #icon{
        position: absolute;
        content: url(http://www.freeiconspng.com/uploads/gold-police-badge-icon-9.png);
        height: 30px;
        width: 30px;
		top: 15px;
        right: 120px;
      }
    ]], -- this is an example, add more under it using the same model, leave the } at the end.
  },
  -- add more here
}
return cfg

