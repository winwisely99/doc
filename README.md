
This is our Best Practice Architecture that meets our goals.



# Repo Structure

The project is designed in layers of responsibilities.

0. Bootstrap repo is the dev tools

It is designed to be used by Users, Developers and Operators.

It is a golang CLI with releases via github.

- It does:
	- Install any native dev dependencies cross platform to avoid regressions.
	- Drive any packages that has DesignTime, RunTime aspecst ( e.g i18n, k8, etc).
	- Any other tools we need to encapsulate.

1. Main repo is the Business GUI

- This is the applied Vertical domain for which the architecture is applied.

- It uses IOC ( as much as possible ) in order to use the Flutter components from the Package Repo and so keep the main lean and clean.


2. Embed repo ( OUT OF SCOPE for now)

- This is reusable Flutter and Golang code that is client side.

- The embed repo is the golang that sits embedded behind the Flutter code. 

- It does:
	- Advanced Security
	- Advanced Storage
	- P2P Networking

3. Packages repo is the Flutter / Golang reusable packages

- It does:

	- MainTemplate that encapsulates the best practice things a main Flutter GUI needs

	- Mod Packages that are GSuite functionality ( Cal, Meet, Docs, Drive, etc etc).
	- Each Mod Package representing a MicroService is composed of Flutter and Golang.

	- Any other flutter things that all projects need.

* NOTE: Plugins that require any native things are in the Plugins repo.

3. Network Repo is the golang backend code.

- It does:

	- Infrastructure that each MicroService needs.

## Targets

Frontend:
- Flutter Web, Flutter Desktop, Flutter Mobile

Backend:
- Bare metal (Linux, Mac, Windows and Rasp PI)
- K8 ( same sub targets)



## Run as a Background Service

We are moving to a Foreground and Background process model and so embedding is not needed.

Why ? 

- UX Ergonomics

	- Apps can be segregated to all the UX multi tasking experience to be high ergonomics.

	- Allows the GUI to not stutter because of the multi threading.

- Security

	- Having the data and networking in a separate process provides more security at development time and runtime. 

	- SSO (single Sign on) is centralised to one place.

	- Multi-tenant can be done in one place independent of the OS.

- Notifications

	- Background is always running ( OS ) and so notification wake ups can be do not need the Google and Apple notification gateways and leak data.

- Data synchronisation

	- Runs in the background and so UX on app started up is instant.
  
	- Allows offline editing to work much better because the data is less old.

- Alignment

	- Mobile and Desktop have same Topology.
	
	- Web just bypasses the local golang background service and uses the Cloud Server that acts on the users behalf.

	- The same Services can run on the devices as in the cloud such as:
		- Search indexer
		- KV Store
		- VPN 
		- and other goodies that Flutter cant do.

- Interoperability

	- Others can build Apps in any languages they want.


## Architecture:

- Foreground runs the Flutter Apps
- Background singleton service runs the golang code for all networking.
- IPC options

	- GRPC based IO between them OS IPC mechanism.
		- Desktop will be easy
  		- Mobile not so easy
		- Protocol buffers not GRPC

  	- Or GRPC uses a GRPC socket and so we do not have to get into the weeds of IPC.
    	- Often used approach
    	- Will be much secure if we use a Cert between Foreground and Background. Can be bootstrapped from the Server on startup.


## Dev aspects


- The background process is best thought of as a PUB SUB topic based Network.

- You are essentially working at the Domain Model layer and so your models do not have to match one to one to the PUB SUB topics.

- You can remap them how you want. Its gives the Flutter app the ability to compose their Domain Models to not be a one for one match as the PUB SUB topics in the network.

- When a record changes in the Background process it will just tell the Flutter foreground app over the GRPC stream.

- We can set it up so the common Flutter code just puts it directly into HIVE, and so you just forget about it.
- Pull Request
