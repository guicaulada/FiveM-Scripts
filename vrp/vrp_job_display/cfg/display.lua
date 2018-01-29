
local cfg = {}

cfg.firstjob = false -- set this to your first job, for example "citizen", or false to disable

-- text display css
cfg.display_css = [[
.div_job{
  position: absolute;
  top: 155px;
  right: 20px;
  font-size: 20px;
  font-weight: bold;
  color: white;
  text-shadow: 3px 3px 2px rgba(0, 0, 0, 0.80);
}
]]

-- icon display css
cfg.icon_display_css = [[
.div_job_icon{
  position: absolute;
}
]]

-- list of ["group"] => css for icons
cfg.group_icons = {
  ["police"] = [[
    .div_job_icon{
      content: url(http://www.freeiconspng.com/uploads/gold-police-badge-icon-9.png);
      height: 50px;
      width: 50px;
	  top: 180px;
      right: 20px;
    }
  ]], -- this is an example, add more under it using the same model, leave the } at the end.
}
return cfg

