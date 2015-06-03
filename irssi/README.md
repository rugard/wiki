# Irssi

Ah, the beauty of the commandline interface. Why do I like this one so much? Mainly because I can create an irssi session inside of GNU Screen and just detach my screen session. That way I can ssh into my machine at any time, re-attach my screen session and my IRC session is still connected.

From a commandline, type: irssi. this will bring up a black window with [(status)] at the bottom left of your screen. To connect to freenode.net type: /server irc.freenode.net. Once connected, change your nickname with the command: /nick thisismyusername. Once you have successfully joined freenode.net and changed your nickname you can join #linuxjournal with: /join #linuxjournal.

Because the Commandline is slightly different than XChat, here are some tips and tricks that work both in X-chat and irssi:

```
/names - List users /nick - Change your nickname /join #channel - Join a channel
/part #channel - Leave a channel
/quit - Quit IRC /msg nickname message - Send a private message to someone

/server irc.freenode.net
/nick skubriev
/join #icinga
/q <nick>
/wc
```
