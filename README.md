# TwitterClientDemoApp

### Carthage

This project uses Carthage: [Carthage on Github] (https://github.com/Carthage/Carthage)

Download dependencies using: 

`carthage bootstrap --platform iOS --no-use-binaries`

Add dependencies:

- Update Cartfile with dependency (see github page for further details)
- Lock in dependency versions: `carthage update --platform iOS --no-use-binaries`
- Under TwitterClientDemoApp > General > Linked Frameworks and Libraries, add [framework-name].framework
- Under TwitterClientDemoApp > General > Linked Frameworks and Libraries, add [framework-name].framework
- Under TwitterClientDemoApp > Build Phases > Run Script, add the following input files: `$(SRCROOT)/Carthage/Build/iOS/[framework-name].framework`
