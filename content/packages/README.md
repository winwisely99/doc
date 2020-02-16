# Packages

These the the core Flutter packages

There are two types:

1. Modules are the high level Packages that do the User facing functionality that are the Suite of tools like Video COnf, Chat, Docs, etc.

2. Non user facing. Things like App Containers, i18n, Telemtry, etc

## Modules

### News

The News feed is a a standard News feed.

Data comes from various sources and so we transform it on the Server.
The feed is exposed from the Serve.

### Video Conferencing

This is a webrtc based module  for Video conf and for data channel P2P.

With the video conf the user will be in the chat app and want to make a video call and so from the chat app, it will open the video conf app on your desktop and mobile.

With the data channel, this will be embedded in all the apps and use this for P2P networking between the users.

Frontend:  	
- https://github.com/cloudwebrtc/flutter-webrtc-demo
- https://github.com/cloudwebrtc/flutter-webrtc
- https://github.com/flutter-webrtc/libwebrtc

---


Backend:

- https://github.com/pion/ion

- SDK: https://github.com/pion/ion/tree/master/sdk/flutter/example


Other backend: 

- https://github.com/decentraland/webrtc-broker


Other Message queue options:

-  https://github.com/liftbridge-io/liftbridge
	- GRPC / Protobuf API. nice and simple kafka like system with RAFT replication for multi-datacenter and multi.cluster per datacenter.

- https://github.com/nats-io
	- Go Client and Server.

- https://github.com/ThreeDotsLabs
	- Golang PUB sub and CQRS event driven architecture using NATS and AMQP and others. Its agnostic.

- https://github.com/decentraland/webrtc-broker
	- Looks promising from the main lead on the pion project.
	- But depends how that dovetails with ion.


---

What Desktop framework ????

The big question was what base to use for Desktop.

Goog-flutter official is the one we use.


1. Goog-flutter official

- https://github.com/google/flutter-desktop-embedding

- MAC, Web, Mobile works fantastic.

- For Windows, Linux ( Desktop, Rasp PI, Pine64) we need to use a Flutter Engine fork.
	- Build of google LibWebrtc.
		- where is there CI ?
		- https://github.com/cloudwebrtc/flutter-webrtc/issues/175
	- Build of the forked flutter engine
		- https://github.com/cloudwebrtc/flutter-webrtc/issues/37
	- Our CI for GUI.
		- Docker based.
		- Suggest usig github as the Docker Repository. https://github.com/orgs/getcouragenow/packages?package_type=Docker
		- Use github Actions.
	- Testing
		- Joe get Hardware.
	- Then getting Flutter CLI to use that.
	- Then test test.

2. Go-flutter

- https://github.com/go-flutter-desktop/go-flutter

- This shows Linking cpp code to go-flutter using Dart FFI and might work:
https://github.com/go-flutter-desktop/go-flutter/issues/58#issuecomment-530375169

Coupling:
Flutter --> FFI --> Go
				--> cpp

3. Use Webview

- NOPE wont work on Embedded.



### Video PLayer

Mobile and Web work, but not desktop.

Desktop:

- Example: https://github.com/go-flutter-desktop/examples/blob/master/texture_tutorial/pubspec.yaml#L26
- Uses this plugin: https://github.com/go-flutter-desktop/plugins/tree/master/video_player
Shows that playing video is possible.


##  Non user facing


## Unilink
https://github.com/go-flutter-desktop/go-flutter/issues/240
We need this so that One app can open another app on desktop.
User is in man app and wants to make a Webrtc call and so open the webrtc app.
We are developing this currently so we can contribute it back to go-flutter plugins

