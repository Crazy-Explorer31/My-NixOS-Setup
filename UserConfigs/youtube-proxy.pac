function FindProxyForURL(url, host) {
    // Перенаправляем YouTube через прокси
    if (shExpMatch(host, "*.youtube.com") || 
		shExpMatch(host, "*.rutracker.org") ||
        shExpMatch(host, "*.youtu.be") || 
        shExpMatch(host, "*.googlevideo.com")) {
        return "SOCKS5 127.0.0.1:1080";
    }
    // Все домены содержащие "rutracker" идут через прокси
    if (shExpMatch(host, "*rutracker*")) {
        return "SOCKS5 127.0.0.1:1080";
    }
	// Все домены содержащие "protondb" идут через прокси
    if (shExpMatch(host, "*protondb*")) {
        return "SOCKS5 127.0.0.1:1080";
    }
	// Все домены содержащие "openai" идут через прокси
    if (shExpMatch(host, "*openai*")) {
        return "SOCKS5 127.0.0.1:1080";
    }
	// Все домены содержащие "cs-uni" идут через прокси
    if (shExpMatch(host, "*cs-uni*")) {
        return "SOCKS5 127.0.0.1:1080";
    }
	// Все домены содержащие "webofscience" идут через прокси
    if (shExpMatch(host, "*webofscience*")) {
        return "SOCKS5 127.0.0.1:1080";
    }
	// Все домены содержащие "learn-anything" идут через прокси
    if (shExpMatch(host, "*learn-anything*")) {
        return "SOCKS5 127.0.0.1:1080";
    }
	// Все домены содержащие "scimagojr" идут через прокси
    if (shExpMatch(host, "*scimagojr*")) {
        return "SOCKS5 127.0.0.1:1080";
    }
	// Все домены содержащие "nature.com" идут через прокси
    if (shExpMatch(host, "*nature.com*")) {
        return "SOCKS5 127.0.0.1:1080";
    }
	// Все домены содержащие "networkx.org" идут через прокси
    if (shExpMatch(host, "*networkx.org*")) {
        return "SOCKS5 127.0.0.1:1080";
    }
	// Все домены содержащие "kaggle.com" идут через прокси
    if (shExpMatch(host, "*kaggle.com*")) {
        return "SOCKS5 127.0.0.1:1080";
    }
	// Все домены содержащие "spotify.com" идут через прокси
    if (shExpMatch(host, "*spotify.com*")) {
        return "SOCKS5 127.0.0.1:1080";
    }
	// Все домены содержащие "gemini.google.com" идут через прокси
    if (shExpMatch(host, "*gemini.google.com*")) {
        return "SOCKS5 127.0.0.1:1080";
    }
	// Все домены содержащие "minitab.com" идут через прокси
    //if (shExpMatch(host, "*minitab.com*")) {
      //  return "SOCKS5 127.0.0.1:1080";
    //}
	// Все домены содержащие "zxqfox.github.com" идут через прокси
    if (shExpMatch(host, "*zxqfox.github.com*")) {
        return "SOCKS5 127.0.0.1:1080";
    }
    if (shExpMatch(host, "*docs.noctalia.dev*")) {
        return "SOCKS5 127.0.0.1:1080";
    }
    if (shExpMatch(host, "*indolte.com*")) {
        return "SOCKS5 127.0.0.1:1080";
    }
    if (shExpMatch(host, "*pixabay.com*")) {
        return "SOCKS5 127.0.0.1:1080";
    }
    if (shExpMatch(host, "*jellyfin.org*")) {
        return "SOCKS5 127.0.0.1:1080";
    }

    // Весь остальной трафик идёт напрямую
    return "DIRECT";
}

