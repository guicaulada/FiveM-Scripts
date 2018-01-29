/*
Author: @NicolasStr_
If you have any issue, please consider opening an issue on Github
https://github.com/NicolasStr/fivem-loading-sleek/
*/
function sleekLoader(){
    this.bgAnimationTime   = 7000;
    this.textAnimationTime = 7000;
    this.volume            = volume;
    this.soundfile         = soundFile;
    this.youtubeID         = youtubeID;
    this.backgrounds       = backgrounds;
    this.texts             = texts;
    this.welcomeText       = welcomeText;
    this.serverName        = serverName;
    this.playSound = function(){
        var src = this.soundfile;
        var vol = this.volume;
        if (vol && src && !this.youtubeID) {
            $("<audio></audio>").attr({
                'src': src,
                'volume': vol,
                'autoplay':'autoplay'
            }).appendTo("body");
        }
    }
    this.playVideo = function(){
        var ytID = this.youtubeID;
        var src = 'https://www.youtube.com/embed/'+ytID+'?rel=0&vq=hd1080&autoplay=1&controls=0&loop=1&playlist='+ytID+'&showinfo=0&iv_load_policy=3';
        if (ytID) {
            $("<iframe></iframe>").attr({
                'src': src
            }).appendTo(".bg");
        }
    }
    this.loadTexts = function(){
        $('#welcome').text(this.welcomeText);
        $('#servername').text(this.serverName);
        document.title = this.serverName;
    }
    this.changeBackground = function(){
        if (!this.youtubeID) { /* WE DONT WANT TO DISPLAY BG IF WE DONT NEED IT */
            var bg = backgrounds[Math.floor(Math.random() * backgrounds.length)];
            $('.bg').fadeOut('slow', function () {
                $('.bg').css({ 'background-image': 'url('+bg+')' });
                $('.bg').fadeIn('slow');
            });
        }
    }
    this.changeText = function (isFirst) {
        var randomText = this.texts[Math.floor(Math.random() * this.texts.length)];
        $('#text').fadeOut('slow', function () {
            $('#text').text(randomText);
            $('#text').fadeIn('slow');
        });
    }
    this.init = function () {
        this.loadTexts();
        this.playSound();
        this.playVideo();
        this.changeBackground();
        this.changeText();
        var _this = this;
        window.setInterval(function () {
            _this.changeBackground();
        }, this.bgAnimationTime);
        window.setInterval(function () {
            _this.changeText();
        }, this.textAnimationTime);
    }
};
var count = 0;
var thisCount = 0;
const emoji = {
    INIT_BEFORE_MAP_LOADED: [ '🍉' ],
    INIT_AFTER_MAP_LOADED: [ '🍋', '🍊' ],
    INIT_SESSION: [ '🍐', '🍅', '🍆' ],
};

const handlers = {
    startInitFunctionOrder(data)
    {
        count = data.count;

        document.querySelector('.letni h3').innerHTML += emoji[data.type][data.order - 1] || '';
    },
    initFunctionInvoking(data)
    {
        document.querySelector('.thingy').style.left = '0%';
        document.querySelector('.thingy').style.width = ((data.idx / count) * 100) + '%';
    },
    startDataFileEntries(data)
    {
        count = data.count;

        document.querySelector('.letni h3').innerHTML += "\u{1f358}";
    },
    performMapLoadFunction(data)
    {
        ++thisCount;
        document.querySelector('.thingy').style.left = '0%';
        document.querySelector('.thingy').style.width = ((thisCount / count) * 100) + '%';
    },
    onLogLine(data)
    {
        document.querySelector('.letni p').innerHTML = data.message + "..!";
    }
};
window.addEventListener('message', function(e)
{
    (handlers[e.data.eventName] || function() {})(e.data);
});