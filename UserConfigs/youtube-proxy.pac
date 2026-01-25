function FindProxyForURL(url, host) {
    var PROXY = "SOCKS5 127.0.0.1:20170";

    // Перенаправляем YouTube через прокси
    if (shExpMatch(host, "*.youtube.com") || 
		shExpMatch(host, "*.rutracker.org") ||
        shExpMatch(host, "*.youtu.be") || 
        shExpMatch(host, "*.googlevideo.com")) {
        return PROXY;;
    }
    // Все домены содержащие "rutracker" идут через прокси
    if (shExpMatch(host, "*rutracker*")) {
        return PROXY;;
    }
	// Все домены содержащие "protondb" идут через прокси
    if (shExpMatch(host, "*protondb*")) {
        return PROXY;;
    }
	// Все домены содержащие "openai" идут через прокси
    if (shExpMatch(host, "*openai*")) {
        return PROXY;;
    }
	// Все домены содержащие "cs-uni" идут через прокси
    if (shExpMatch(host, "*cs-uni*")) {
        return PROXY;;
    }
	// Все домены содержащие "webofscience" идут через прокси
    if (shExpMatch(host, "*webofscience*")) {
        return PROXY;;
    }
	// Все домены содержащие "learn-anything" идут через прокси
    if (shExpMatch(host, "*learn-anything*")) {
        return PROXY;;
    }
	// Все домены содержащие "scimagojr" идут через прокси
    if (shExpMatch(host, "*scimagojr*")) {
        return PROXY;;
    }
	// Все домены содержащие "nature.com" идут через прокси
    if (shExpMatch(host, "*nature.com*")) {
        return PROXY;;
    }
	// Все домены содержащие "networkx.org" идут через прокси
    if (shExpMatch(host, "*networkx.org*")) {
        return PROXY;;
    }
	// Все домены содержащие "kaggle.com" идут через прокси
    if (shExpMatch(host, "*kaggle.com*")) {
        return PROXY;;
    }
	// Все домены содержащие "spotify.com" идут через прокси
    if (shExpMatch(host, "*spotify.com*")) {
        return PROXY;;
    }
	// Все домены содержащие "gemini.google.com" идут через прокси
    if (shExpMatch(host, "*gemini.google.com*")) {
        return PROXY;;
    }
	// Все домены содержащие "minitab.com" идут через прокси
    //if (shExpMatch(host, "*minitab.com*")) {
      //  return PROXY;;
    //}
	// Все домены содержащие "zxqfox.github.com" идут через прокси
    if (shExpMatch(host, "*zxqfox.github.com*")) {
        return PROXY;;
    }
    if (shExpMatch(host, "*docs.noctalia.dev*")) {
        return PROXY;;
    }
    if (shExpMatch(host, "*indolte.com*")) {
        return PROXY;;
    }
    if (shExpMatch(host, "*pixabay.com*")) {
        return PROXY;;
    }
    if (shExpMatch(host, "*jellyfin.org*")) {
        return PROXY;;
    }

    // Весь остальной трафик идёт напрямую
    return "DIRECT";
}

