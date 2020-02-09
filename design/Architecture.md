# Architecture





## Frontend

GUI Template is a Flutter generic app that uses our packages and tooling.
 - The intent is to have an easy boot strap experience to build the Logic and GUI that reuses the GSUITE style system.

Webrtc ( aka Google Meet) using Google Flutter embedder. 
- Because it uses a different embedder this runs in its own app.
- Opened from the Main App via a UniLink
- This allows a user to do voice and video comms whilst working on App. Background running will be a challenge - lets see.

All other modules ( aka GSuite ) use Go-fluter embedder.



## Backend

Webrtc uses Ion for Video Conf and chat.

All other Modules use go.micro which supports RPC and PUB SUB.

Single sign on uses ORY Hydra: https://github.com/ory/hydra 

- Integrate FIDO2 and WebAuthn.

## Infra

Kubernetes baaed for everything.


## Intent

A Collaboration system that can run *stand alone* but also *integrated* into an existing app.


Stand alone:

- The GSuite packages each run as their own App with its own MicroService.

- Anyone can easily combine in into their own App. Essentially they can Integrate them.

Integrated:

- is like how we have a Climate Change Campaign app ( in the main repo) and the  GSuite chat, docs, webrtc is integrated behind it. So once a user joins a few Climate campaigns they can chat with the other users, webrtc with them and write docs with them. Its similar to LDAP and OU groups in terms of the security.

- The Climate Change Campaign app is a Vertical Domain in terms or Architecture.

- The Vertical domain layer can have its own models and can for example reference a URL to a WebRTC meeting.

---

Physical.

Servers can be anywhere. At Home on a Rasp Pi.

Of course a Infra layer is needed to help expose these at home servers and keep them safe etc.

---

Privacy.

Does not allow User to leak everywhere.

For example Cal and Contacts work so Users dont have to use the build in OS Contacts from Google and Apple !! Etc etc. 

---

Obviously there is more to this but this is a good rundown.


## Project Layering


Lets use these names for it.

1. Business Layer ( GUI and Micro Services )

In our case this is the Climate Change Compigning app.

Its has a GUI and a Domain model.

Its uses the GSUITE layer and is medium coupled to it. Not sure of the exact coupling yet.


2. GSuite Layer ( GUI and Micro Services )

This is our open self hosted alternative to GSuite

- Host on Cloud or a Rasp PI at home.

3. Infra Layer

This can be a collection of many things.

- The boot strap repo is even part of this.

- A Proxy that links the GUI devices and the MicroServices servers.



## Team stuff

Use Telegram group.

Need a Time what works for everyone where we do a Stand up !!!! 

Follow the Kanban closely.

Deploy and host on the same servers together so we share knowldge

- Google Kubernetes or Digital Ocean or bare metal. @Ali can advice us here !

Make everything repeatable. Hence why we use MAGE.



## Technical Roadmap

I always go for a top to bottom hello world where we can see and test that everything works through the physical and logical architecture.

- Flutter engine needs to be forked !! I hate that we have to do this because it means we need to maintain a patch against googles flutter engine and maintain it. This might be very hard to do depending - I dont know yet.
We had to do this to get Video and Multimedia working.
 - Keep pushing all the time to get the Google Team to take the PR !! Its a HUGE risk otherwise.

- Targets. Buy hardware and locate in Berlin.

	- Desktops: Windows, Mac, Linux
	- Mobile: IOS, Android
	- Server / Embedded: Rasp PI, Kubernetes

- Process Architecture. Its important this is clear.

	- Mobile: All in one app with golang compiled in via gomobile. Uses go-textile lib for the RPC between the Flutter and Dart layer. Looks very nice.
	- Desktop: Flutter GUI. Golang Background Service.
	- Rasp Pi: Same as Desktop, but check with Him that this is possible.

- CI
	- Got to keep building the Flutter Engine as they do a release. I guess match Flutter Beta tag ? Ask @CloudWebrtc.
	- Daryl has a Vagrant based project that can build anywhere. 
	- Out put of builds to Fish for all binaries used upstream.

	- Make: Use Mage and see the Bootstrap repo.

- GUI
	- Need good best practice structure so we dont get a mess.
		- IOC. Joe add the Link !
		- Flutter Best Practice Layout that works on all Devices in Responsive way. Example: https://github.com/MaikuB/master_detail_scaffold
		- Data Storage: Hive. Add the Hive Crypto lib here.

- GUI Proxy to Flutter
		- Go-Textile looks like a very nice layer here. JOE: add the Lib links.

- GUI Proxy to Server

	- So inside the gomobile layer we have to add a Proxy that can talk to the Servers.
	- ION and go-micro clients seems to be the way to go.


