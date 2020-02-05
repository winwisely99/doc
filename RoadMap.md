
# RoadMap



## Where we are today ?

1. Got a MVP in Flutter that proved the idea and architecture.

2. Got the Basic GSuite modules running and played with them to validate they work and what extra work we need to do on them to make them production level.

3. Got a decent Architecture approach to do Client / Server and Peer to Peer. Go-Micro and Ion look good.

4. Security approach worked out in that we dont want to boil the ocean but instead just use 2FA and SSO and TLS 1.2 etc. No fancy stuff like Tor, etc etc. 

- Because of our Architecture layering we can easily swap over to using P2P for ShadowSocks and various privacy and crypto approaches without massing refactoring and risk.


## Where we need to be ?


1 Month

- FULL CI and Architecture round-tripping

- Full Client and Server Architecture and GSUITE modules working and fully repeatable builds, signing and upgrading.

- All GSUITES packages working. Still ok to have some rough edges.

- Single Sign on working.

- Have full logging and metrics. When a Client crashes we see it remotely and can see why it crashed.

- All Targets working.

- Flutter GUI code NOT a mess but nicely IOC decoupled.

- Flutter GUi style standard Material Design. Simple and Clean.

2 Month

- Business Layer working with the GSUITE layer.

- Heavily into UAT mode with 100 testers.

- Ironing out bugs in GSUITE GUI and refining it.

- Confident with dong upgrades and not breaking clients that are one version behind.

3 Month

- Deployed to Production with about 10,000 users.

- Keeping the system going and improving things and not adding too much functionality i hope.

6 Month

- Project finished for Phase 2.

- Have Lots of Analytics about how well it worked for the Project Business Intents and the Techncial asepcts.

