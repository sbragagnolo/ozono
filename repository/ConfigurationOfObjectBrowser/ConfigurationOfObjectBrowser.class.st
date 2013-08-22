Class {
	#name : #ConfigurationOfObjectBrowser,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
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
ConfigurationOfObjectBrowser class >> lastMetacelloVersionLoad [
	"Answer the last version loaded and the list of packages loaded for that version."

	LastVersionLoad == nil ifTrue: [ LastVersionLoad := nil -> 'default' ].
	^LastVersionLoad
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

{ #category : #baselines }
ConfigurationOfObjectBrowser >> baseline10: spec [ 
    <version: '1.0-baseline'>
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/ObjectBrowser'.
		spec
			project: 'smallUML' with: [ spec className: 'ConfigurationOfSmallUML'; 
											loads: #('default' );
											file: 'ConfigurationOfSmallUML';
											repository: 'http://www.squeaksource.com/smallUML'. ];
			package: 'CommandShell' with: [ spec repository: 'http://www.squeaksource.com/CommandShell'. ];
			package: 'GraphViz';
			package: 'ObjectBrowser' with: [ spec requires: #('smallUML') ].
			spec group: 'default' with: #( 'ObjectBrowser' ).
			spec group: 'graphViz' with: #( 'GraphViz' 'CommandShell' 'externalCommands' ).
		].
	spec for: #unix do: [
		spec 
			project: 'externalCommands' with: [ 
				spec className: 'ConfigurationOfOSProcess'; 
						file: 'ConfigurationOfOSProcess';
						repository: 'http://www.squeaksource.com/MetacelloRepository'.
				spec postLoadDoIt: #initializeOSProcess.
			].
		].

	spec for: #Win32 do: [
		spec
			project: 'externalCommands' with: [ 
				spec repository: 'http://www.squeaksource.com/MetacelloRepository'. 
				spec className: 'ConfigurationOfFFI'.
		]
	].
]

{ #category : #baselines }
ConfigurationOfObjectBrowser >> baseline11: spec [ 
    <version: '1.1-baseline'>
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/ObjectBrowser'.
		spec
			project: 'smallUML' with: [ spec className: 'ConfigurationOfSmallUML'; 
											loads: #('default' );
											file: 'ConfigurationOfSmallUML';
											repository: 'http://www.squeaksource.com/smallUML'. ];
			package: 'ObjectBrowser' with: [ spec requires: #('smallUML') ].
			spec group: 'default' with: #( 'ObjectBrowser' ).
		].
]

{ #category : #baselines }
ConfigurationOfObjectBrowser >> baseline12: spec [ 
    <version: '1.2-baseline'>
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/ObjectBrowser'.
		spec
			project: 'smallUML' with: [ spec className: 'ConfigurationOfSmallUML'; 
											loads: #('default' );
											file: 'ConfigurationOfSmallUML';
											repository: 'http://www.squeaksource.com/smallUML'. ];
			package: 'ObjectBrowser' with: [ spec requires: #( 'smallUML' 'SUML-ObjectDiagramModel' 'SUML-ClassDiagramModel') ].
			
		spec package: 'Graphics-Primitives'.
		spec package: 'SUML-ObjectDiagramModel' with: [ spec requires: #( 'smallUML' ) ].
		spec package: 'SUML-ClassDiagramModel' with: [ spec requires: #( 'smallUML' ) ].
		spec group: 'default' with: #( 'ObjectBrowser' ).
		].
]

{ #category : #baselines }
ConfigurationOfObjectBrowser >> baseline131: spec [ 
    <version: '1.3.1-baseline'>
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/ObjectBrowser'.
		spec
			project: 'smallUML' with: [ spec className: 'ConfigurationOfSmallUML'; 
											loads: #('default' );
											file: 'ConfigurationOfSmallUML';
											repository: 'http://www.squeaksource.com/smallUML'. ];
			package: 'ObjectBrowser' with: [ spec requires: #( 'smallUML' 'SUML-ObjectDiagramModel' 'SUML-ClassDiagramModel') ].
			
		spec package: 'SUML-ObjectDiagramModel' with: [ spec requires: #( 'smallUML' ) ].
		spec package: 'SUML-ClassDiagramModel' with: [ spec requires: #( 'smallUML' ) ].
		spec group: 'default' with: #( 'ObjectBrowser' ).
		].
]

{ #category : #baselines }
ConfigurationOfObjectBrowser >> baseline13: spec [ 
    <version: '1.3-baseline'>
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/ObjectBrowser'.
		spec
			project: 'smallUML' with: [ spec className: 'ConfigurationOfSmallUML'; 
											loads: #('default' );
											file: 'ConfigurationOfSmallUML';
											repository: 'http://www.squeaksource.com/smallUML'. ];
			package: 'ObjectBrowser' with: [ spec requires: #( 'smallUML' 'SUML-ObjectDiagramModel' 'SUML-ClassDiagramModel') ].
			
		spec package: 'Graphics-Primitives' with: [ spec repository: 'http://www.squeaksource.com/Pharo' ].
		spec package: 'SUML-ObjectDiagramModel' with: [ spec requires: #( 'smallUML' ) ].
		spec package: 'SUML-ClassDiagramModel' with: [ spec requires: #( 'smallUML' ) ].
		spec group: 'default' with: #( 'ObjectBrowser' ).
		].
]

{ #category : #baselines }
ConfigurationOfObjectBrowser >> baseline141: spec [ 
    <version: '1.4.1-baseline'>
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://smalltalkhub.com/mc/Guille/LOOP/main'.
		spec
			project: 'smallUML' with: [ spec className: 'ConfigurationOfSmallUML'; 
											loads: #('default' );
											file: 'ConfigurationOfSmallUML';
											repository: 'http://smalltalkhub.com/mc/Guille/SmallUml/main'. ];
			package: 'ObjectBrowser' with: [ spec requires: #( 'smallUML' 'SUML-ObjectDiagramModel') ].
			
		spec package: 'SUML-ObjectDiagramModel' with: [ spec requires: #( 'smallUML' ) ].
		spec group: 'default' with: #( 'ObjectBrowser' ).
		].
]

{ #category : #baselines }
ConfigurationOfObjectBrowser >> baseline14: spec [ 
    <version: '1.4-baseline'>
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/ObjectBrowser'.
		spec package: 'ObjectBrowser' with: [ spec requires: #( 'smallUML' ) ].
			
		spec package: 'SUML-Tools' with: [ spec requires: 'MinimalConnectors'.  ].
		spec package: 'SUML-DiagramDrawing' with: [ spec requires: 'MinimalConnectors'.  ].
		spec package: 'SUML-ObjectDiagramModel'.
		spec package: 'SUML-ClassDiagramModel'.
		
		spec 
			package: 'MinimalConnectors-ConnectableShapes';
			package: 'MinimalConnectors-CurvesAndArrows';
			package: 'MinimalConnectors-Connections' with: [spec requires: 'MinimalConnectors-ConnectableShapes' ].

		
		spec group: 'MinimalConnectors' with: #( 'MinimalConnectors-Connections' 'MinimalConnectors-CurvesAndArrows' 'MinimalConnectors-ConnectableShapes' ).
		spec group: 'smallUML' with: #( 'SUML-Tools' 'SUML-DiagramDrawing' 'SUML-ObjectDiagramModel' 'SUML-ClassDiagramModel' ).
		spec group: 'default' with: #( 'ObjectBrowser' ).
	].
]

{ #category : #baselines }
ConfigurationOfObjectBrowser >> baseline20: spec [ 
    <version: '2.0-baseline'>
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://smalltalkhub.com/mc/Guille/LOOP/main'.
		spec
			project: 'smallUML' with: [ spec className: 'ConfigurationOfSmallUML'; 
											loads: #('default' );
											file: 'ConfigurationOfSmallUML';
											repository: 'http://smalltalkhub.com/mc/Guille/SmallUml/main'. ];
			package: 'ObjectBrowser' with: [ spec requires: #( 'smallUML' 'SUML-ObjectDiagramModel') ].
			
		spec package: 'SUML-ObjectDiagramModel' with: [ spec requires: #( 'smallUML' ) ].
		spec group: 'default' with: #( 'ObjectBrowser' ).
		].
]

{ #category : #symbolic }
ConfigurationOfObjectBrowser >> development: spec [ 
	<symbolicVersion: #development>
	spec for: #'pharo1.2.x' version: '1.2.1'. 

]

{ #category : #'initialize-release' }
ConfigurationOfObjectBrowser >> initializeOSProcess. [
	(Smalltalk globals at: #ThisOSProcess) initialize
]

{ #category : #accessing }
ConfigurationOfObjectBrowser >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) new.
		constructor project projectAttributes: (Array with: Smalltalk os platformName asSymbol).
		constructor on: self.
		project := constructor project.
		project]
]

{ #category : #symbolic }
ConfigurationOfObjectBrowser >> stable: spec [  
	<symbolicVersion: #stable>
	
	| latest |
	latest := '2.0'.
	
	"Default"
	spec for: #'common' version: latest.
	
	spec for: #'pharo1.1.x' version: '1.0'.
	spec for: #'pharo1.2.x' version: '1.3'.
	spec for: #'pharo1.3.x' version: '1.3.1'.
	spec for: #'pharo1.4.x' version: '1.4.5'.
	spec for: #'pharo2.0.x' version: latest.
]

{ #category : #versions }
ConfigurationOfObjectBrowser >> version10: spec [ 
    <version: '1.0' imports: #('1.0-baseline')>
	spec for: #common do:[
		spec blessing: #release.
		spec project: 'smallUML' with: '1.0'.
		spec package: 'CommandShell' with: 'CommandShell-dtl.49'.
		spec package: 'GraphViz' with: 'GraphViz-GuillermoPolito.47'.
		spec package: 'ObjectBrowser' with: 'ObjectBrowser-GermanLeiva.334'.
	].
	spec for: #unix do: [
		spec project: 'externalCommands' with: '4.3.12'.
	].
	spec for: #Win32 do: [
		spec project: 'externalCommands' with: '1.4'.
	]
]

{ #category : #versions }
ConfigurationOfObjectBrowser >> version11: spec [ 
    <version: '1.1' imports: #('1.0-baseline')>
	spec for: #common do:[
		spec blessing: #release.
		spec project: 'smallUML' with: '1.1.3'.
		spec package: 'CommandShell' with: 'CommandShell-dtl.49'.
		spec package: 'GraphViz' with: 'GraphViz-GuillermoPolito.48'.
		spec package: 'ObjectBrowser' with: 'ObjectBrowser-GiselaDecuzzi.353'.
	].
	spec for: #unix do: [
		spec project: 'externalCommands' with: '4.3.12'.
	].
	spec for: #Win32 do: [
		spec project: 'externalCommands' with: '1.4'.
	]
]

{ #category : #versions }
ConfigurationOfObjectBrowser >> version121: spec [ 
    <version: '1.2.1' imports: #('1.2-baseline')>
	spec for: #common do:[
		spec blessing: #release.
		spec project: 'smallUML' with: '1.1.3'.
		spec package: 'ObjectBrowser' with: 'ObjectBrowser-GuillermoPolito.412'.
		spec package: 'Graphics-Primitives' with: 'Graphics-Primitives-DeboraFortini.49'.
		spec package: 'SUML-ObjectDiagramModel' with: 'SUML-ObjectDiagramModel-DeboraFortini.19'.
		spec package: 'SUML-ClassDiagramModel' with: 'SUML-ClassDiagramModel-DeboraFortini.21'.
	].
]

{ #category : #versions }
ConfigurationOfObjectBrowser >> version12: spec [ 
    <version: '1.2' imports: #('1.1-baseline')>
	spec for: #common do:[
		spec blessing: #development.
		spec project: 'smallUML' with: '1.1.3'.
		spec package: 'ObjectBrowser' with: 'ObjectBrowser-GuillermoPolito.367'.
	].
]

{ #category : #versions }
ConfigurationOfObjectBrowser >> version131: spec [ 
    <version: '1.3.1' imports: #('1.3.1-baseline')>
	spec for: #common do:[
		spec blessing: #release.
		spec project: 'smallUML' with: '1.1.3'.
		spec package: 'ObjectBrowser' with: 'ObjectBrowser-GiselaDecuzzi.422'.
		spec package: 'SUML-ObjectDiagramModel' with: 'SUML-ObjectDiagramModel-GuillermoPolito.20'.
		spec package: 'SUML-ClassDiagramModel' with: 'SUML-ClassDiagramModel-GuillermoPolito.22'.
	].
]

{ #category : #versions }
ConfigurationOfObjectBrowser >> version13: spec [ 
    <version: '1.3' imports: #('1.3-baseline')>
	spec for: #common do:[
		spec blessing: #release.
		spec project: 'smallUML' with: '1.1.3'.
		spec package: 'ObjectBrowser' with: 'ObjectBrowser-GuillermoPolito.419'.
		spec package: 'Graphics-Primitives' with: 'Graphics-Primitives-StephaneDucasse.48'.
		spec package: 'SUML-ObjectDiagramModel' with: 'SUML-ObjectDiagramModel-GuillermoPolito.20'.
		spec package: 'SUML-ClassDiagramModel' with: 'SUML-ClassDiagramModel-GuillermoPolito.22'.
	].
]

{ #category : #versions }
ConfigurationOfObjectBrowser >> version141: spec [ 
    <version: '1.4.1' imports: #('1.4.1-baseline')>
	spec for: #common do:[
		spec blessing: #development.
		spec package: 'ObjectBrowser' with: 'ObjectBrowser-GuillermoPolito.437'.

		spec project: 'smallUML' with: '1.1.4'.
				
		spec package: 'SUML-ObjectDiagramModel' with: 'SUML-ObjectDiagramModel-GuillermoPolito.20'.
	].
]

{ #category : #versions }
ConfigurationOfObjectBrowser >> version142: spec [ 
    <version: '1.4.2' imports: #('1.4.1-baseline')>
	spec for: #common do:[
		spec blessing: #development.
		spec package: 'ObjectBrowser' with: 'ObjectBrowser-GuillermoPolito.438'.

		spec project: 'smallUML' with: '1.1.4'.
				
		spec package: 'SUML-ObjectDiagramModel' with: 'SUML-ObjectDiagramModel-GuillermoPolito.20'.
	].
]

{ #category : #versions }
ConfigurationOfObjectBrowser >> version143: spec [ 
    <version: '1.4.3' imports: #('1.4.1-baseline')>
	spec for: #common do:[
		spec blessing: #development.
		spec package: 'ObjectBrowser' with: 'ObjectBrowser-GuillermoPolito.439'.

		spec project: 'smallUML' with: '1.1.4'.
				
		spec package: 'SUML-ObjectDiagramModel' with: 'SUML-ObjectDiagramModel-GuillermoPolito.20'.
	].
]

{ #category : #versions }
ConfigurationOfObjectBrowser >> version144: spec [ 
    <version: '1.4.4' imports: #('1.4.1-baseline')>
	spec for: #common do:[
		spec blessing: #development.
		spec package: 'ObjectBrowser' with: 'ObjectBrowser-GuillermoPolito.439'.

		spec project: 'smallUML' with: '1.1.4'.
				
		spec package: 'SUML-ObjectDiagramModel' with: 'SUML-ObjectDiagramModel-GuillermoPolito.21'.
	].
]

{ #category : #versions }
ConfigurationOfObjectBrowser >> version145: spec [ 
    <version: '1.4.5' imports: #('1.4.1-baseline')>
	spec for: #common do:[
		spec blessing: #development.
		spec package: 'ObjectBrowser' with: 'ObjectBrowser-Aivan.451'.

		spec project: 'smallUML' with: '1.1.4'.
				
		spec package: 'SUML-ObjectDiagramModel' with: 'SUML-ObjectDiagramModel-GuillermoPolito.21'.
	].
]

{ #category : #versions }
ConfigurationOfObjectBrowser >> version14: spec [ 
    <version: '1.4' imports: #('1.4-baseline')>
	spec for: #common do:[
		spec blessing: #development.
		spec package: 'ObjectBrowser' with: 'ObjectBrowser-GuillermoPolito.424'.

		spec package: 'MinimalConnectors-ConnectableShapes' with:'MinimalConnectors-ConnectableShapes-GuillermoPolito.19'.
		spec package: 'MinimalConnectors-CurvesAndArrows' with: 'MinimalConnectors-CurvesAndArrows-carlaGriggio.8'.
		spec package: 'MinimalConnectors-Connections' with: 'MinimalConnectors-Connections-GuillermoPolito.9'.
				
		spec package: 'SUML-ObjectDiagramModel' with: 'SUML-ObjectDiagramModel-GuillermoPolito.20'.
		spec package: 'SUML-ClassDiagramModel' with: 'SUML-ClassDiagramModel-GuillermoPolito.22'.
		spec package: 'SUML-DiagramDrawing' with:'SUML-DiagramDrawing-GuillermoPolito.29'.
		spec package: 'SUML-SequenceDiagramModel' with:'SUML-SequenceDiagramModel-carlaGriggio.1'.
		spec package: 'SUML-Tools' with:'SUML-Tools-carlaGriggio.36'.
	].
]

{ #category : #versions }
ConfigurationOfObjectBrowser >> version20: spec [ 
    <version: '2.0' imports: #('2.0-baseline')>
	spec for: #common do:[
		spec blessing: #development.
		spec package: 'ObjectBrowser' with: 'ObjectBrowser-GuillermoPolito.454'.

		spec project: 'smallUML' with: '1.1.4'.
				
		spec package: 'SUML-ObjectDiagramModel' with: 'SUML-ObjectDiagramModel-GuillermoPolito.21'.
	].
]
