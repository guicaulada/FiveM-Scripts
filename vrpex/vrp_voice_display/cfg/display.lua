cfg = {}

cfg.key = 10 -- The voice key, default is PAGE UP get it from https://wiki.fivem.net/wiki/Controls

cfg.volume = { -- You can actually create as many as you want
  { -- Default distance to voice
    distance = 7.001,
    text = "Normal", 
    css = [[
      .div_voice_text{
        position: absolute;
        bottom: 20px;
        right: 20px;
        font-size: 20px;
        font-weight: bold;
        color: white;
        text-shadow: 3px 3px 2px rgba(0, 0, 0, 0.80);
	  }
	  .div_voice_icon{
        position: absolute;
        content: url(http://www.freeiconspng.com/uploads/sound-off-music-mute-off-sound-speaker-volume-icon-16.png);
        height: 50px;
        width: 50px;
	    bottom: 40px;
        right: 20px;
      }
    ]]
  },
  { -- High distance to voice
    distance = 16.001,
    text = "Loud",
    css = [[
      .div_voice_text{
        position: absolute;
        bottom: 20px;
        right: 20px;
        font-size: 20px;
        font-weight: bold;
        color: white;
        text-shadow: 3px 3px 2px rgba(0, 0, 0, 0.80);
	  }
	  .div_voice_icon{
        position: absolute;
        content: url(http://www.freeiconspng.com/uploads/sound-off-music-mute-off-sound-speaker-volume-icon-16.png);
        height: 50px;
        width: 50px;
	    bottom: 40px;
        right: 20px;
      }
    ]]
  },
  { -- Low distance to voice
    distance = 3.001,
    text = "Whisper",
    css = [[
      .div_voice_text{
        position: absolute;
        bottom: 20px;
        right: 20px;
        font-size: 20px;
        font-weight: bold;
        color: white;
        text-shadow: 3px 3px 2px rgba(0, 0, 0, 0.80);
	  }
	  .div_voice_icon{
        position: absolute;
        content: url(http://www.freeiconspng.com/uploads/sound-off-music-mute-off-sound-speaker-volume-icon-16.png);
        height: 50px;
        width: 50px;
	    bottom: 40px;
        right: 20px;
      }
    ]]
  }
}

return cfg