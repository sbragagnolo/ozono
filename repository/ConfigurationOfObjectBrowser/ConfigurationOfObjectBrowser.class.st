Class {
	#name : #ConfigurationOfObjectBrowser,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfObjectBrowser
}

{ #category : #'as yet unclassified' }
ConfigurationOfObjectBrowser class >> ensureMetacello [
	Smalltalk at: #MetacelloProject ifAbsent: [
		Gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				package: 'ConfigurationOfMetacello';
				load.
		(Smalltalk at: #ConfigurationOfMetacello) loadLatestVersion ]
]

{ #category : #'as yet unclassified' }
ConfigurationOfObjectBrowser class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'as yet unclassified' }
ConfigurationOfObjectBrowser class >> loadDefault [
	(self project version: '0.1-version') load
]

{ #category : #'as yet unclassified' }
ConfigurationOfObjectBrowser class >> loadLast [
	self project lastVersion load
]

{ #category : #'as yet unclassified' }
ConfigurationOfObjectBrowser class >> project [

	^self new project
]

{ #category : #'as yet unclassified' }
ConfigurationOfObjectBrowser >> baseline10: spec [ 
    <version: '1.0-baseline'>
	spec blessing: #baseline.
	spec for: #common do: [
		
		spec repository: 'http://www.squeaksource.com/ObjectBrowser'.
		spec
			project: 'smallUML' with: [ spec className: 'ConfigurationOfSmallUML'; 
											loads: #('default' );
											file: 'ConfigurationOfSmallUML';
											repository: 'http://www.squeaksource.com/smallUML'. ];
			package: 'CommandShell' with: [ spec repository: 'http://www.squeaksource.com/CommandShell'. ];
			package: 'GraphViz';
			package: 'ObjectBrowser' with: [ spec requires: 'smallUML' ].
		].
	spec for: #unix do: [
		spec 
			project: 'osProcess' with: [ 
				spec className: 'ConfigurationOfOSProcess'; 
						file: 'ConfigurationOfOSProcess';
						repository: 'http://www.squeaksource.com/MetacelloRepository'.
			].
			spec postLoadDoIt: #initializeOSProcess.
		].
	spec for: #Win32 do: [
		spec
			project: 'ffi' with: [ 
				spec repository: 'http://www.squeaksource.com/MetacelloRepository'. 
				spec className: 'ConfigurationOfFFI'.
		]
	].
]

{ #category : #'as yet unclassified' }
ConfigurationOfObjectBrowser >> default: spec [ 
	<version: 'default'>
	
	spec for: #common do: [
		
		spec repository: 'http://www.squeaksource.com/ObjectBrowser'.
		spec
			project: 'smallUML' with: [ spec className: 'ConfigurationOfSmallUML'; 
											versionString: '1.0';
											loads: #('default' );
											file: 'ConfigurationOfSmallUML';
											repository: 'http://www.squeaksource.com/smallUML'. ];
			package: 'CommandShell' with: [ spec repository: 'http://www.squeaksource.com/CommandShell'. ];
			package: 'GraphViz';
			package: 'ObjectBrowser' with: [ spec requires: 'smallUML'.
											spec repository: 'http://www.squeaksource.com/ObjectBrowser'. ].
		].
	spec for: #unix do: [
		spec 
			project: 'osProcess' with: [ 
				spec className: 'ConfigurationOfOSProcess'; 
						file: 'ConfigurationOfOSProcess';
						repository: 'http://www.squeaksource.com/MetacelloRepository'.
			].
			spec postLoadDoIt: #initializeOSProcess.
		].
	spec for: #Win32 do: [
		spec
			project: 'ffi' with: [ 
				spec repository: 'http://www.squeaksource.com/MetacelloRepository'. 
				spec className: 'ConfigurationOfFFI'.
		]
	].
]

{ #category : #'as yet unclassified' }
ConfigurationOfObjectBrowser >> initializeOSProcess. [
	(Smalltalk globals at: #ThisOSProcess) initialize
]

{ #category : #'as yet unclassified' }
ConfigurationOfObjectBrowser >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) new.
		constructor project projectAttributes: (Array with: Smalltalk platformName asSymbol).
		constructor on: self.
		project := constructor project.]
]

{ #category : #'as yet unclassified' }
ConfigurationOfObjectBrowser >> version10: spec [ 
    <version: '1.0' imports:'1.0-baseline'>
	spec blessing: #release.
	spec project: 'smallUML' with: '1.0'.
	spec package: 'CommandShell' with: 'CommandShell-dtl.49'.
	spec package: 'GraphViz' with: 'GraphViz-GuillermoPolito.47'.
	spec package: 'ObjectBrowser' with: 'ObjectBrowser-GermanLeiva.334'.
	spec project: 'osProcess' with: '4.3.12'.
	spec project: 'ffi' with: '1.4'.
]
