function FindProxyForURL(url, host) {
    var PROXY = "SOCKS5 127.0.0.1:20170";

    // Перенаправляем YouTube через прокси
    if (shExpMatch(host, "*.youtube.com") || 
        shExpMatch(host, "*.rutracker.org") ||
        shExpMatch(host, "*.youtu.be") || 
        shExpMatch(host, "*.googlevideo.com") ||
        shExpMatch(host, "*.ytimg.com") ||
        shExpMatch(host, "*.ggpht.com")) {
        return PROXY;
    }
    // // Все домены содержащие "rutracker" идут через прокси
    if (shExpMatch(host, "*rutracker*")) {
        return PROXY;
    }
	// // Все домены содержащие "protondb" идут через прокси
    if (shExpMatch(host, "*protondb*")) {
        return PROXY;
    }
	// // Все домены содержащие "openai" идут через прокси
    if (shExpMatch(host, "*openai*")) {
        return PROXY;
    }
	// // Все домены содержащие "cs-uni" идут через прокси
    if (shExpMatch(host, "*cs-uni*")) {
        return PROXY;
    }
	// // Все домены содержащие "webofscience" идут через прокси
    if (shExpMatch(host, "*webofscience*")) {
        return PROXY;
    }
	// // Все домены содержащие "learn-anything" идут через прокси
    if (shExpMatch(host, "*learn-anything*")) {
        return PROXY;
    }
	// // Все домены содержащие "scimagojr" идут через прокси
    if (shExpMatch(host, "*scimagojr*")) {
        return PROXY;
    }
	// // Все домены содержащие "nature.com" идут через прокси
    if (shExpMatch(host, "*nature.com*")) {
        return PROXY;
    }
	// // Все домены содержащие "networkx.org" идут через прокси
    if (shExpMatch(host, "*networkx.org*")) {
        return PROXY;
    }
	// Все домены содержащие "kaggle.com" идут через прокси
    if (shExpMatch(host, "*kaggle.com*")) {
        return PROXY;
    }
	// Все домены содержащие "spotify.com" идут через прокси
    if (shExpMatch(host, "*spotify*")) {
        return PROXY;
    }
	// Все домены содержащие "gemini.google.com" идут через прокси
    // if (shExpMatch(host, "*google*")) {
    //     return PROXY;
    // }
    if (shExpMatch(host, "*zxqfox.github.com*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*noctalia.dev*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*indolte.com*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*pixabay.com*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*jellyfin.org*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*steam*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*patreon*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*colab.research.google.com*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*edolstra*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*dev.to*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*translatewebpages.org*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*deepl.com*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*onlinedoctranslator.com*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*nature.com*")) {
        return PROXY;
    }
    // if (shExpMatch(host, "*nixos.org*")) {
    //     return PROXY;
    // }
    if (shExpMatch(host, "*alacritty.org*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*mk48.io*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*tourofrust.com*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*codewars.com*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*pysdr.org*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*mynixos*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*claude.com*") ||
        shExpMatch(host, "*claude.ai*") ||
        shExpMatch(host, "*anthropic.com*") ||
        shExpMatch(host, "*.sentry.io") ||
        shExpMatch(host, "*.intercom.io") ||
        shExpMatch(host, "*.cloudfront.net")) {
        return PROXY;
    }
    if (shExpMatch(host, "*eraser.io*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*grok.com*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*telegram*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*swagger*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*kufar.by*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*arxiv.org*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*suitsupply.com*")) {
        return PROXY;
    }
    if (shExpMatch(host, "*songbpm.com*")) {
        return PROXY;
    }
    // if (shExpMatch(host, "*pypi*")) {
    //     return PROXY;
    // }
    
    // if (shExpMatch(host, "*")) {
    //     return PROXY;
    // }
    

    // Весь остальной трафик идёт напрямую
    return "DIRECT";
}

