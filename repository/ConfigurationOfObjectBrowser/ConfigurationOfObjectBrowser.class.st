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
ConfigurationOfObjectBrowser class >> project [

	^self new project
]

{ #category : #'as yet unclassified' }
ConfigurationOfObjectBrowser >> default: spec [ 
	<version: 'default'>
	
	spec for: #common do: [
		spec blessing: #beta.
		
		spec repository: 'http://www.squeaksource.com/ObjectBrowser'.	
		spec 
			project: 'smallUML' with: [ spec className: 'ConfigurationOfSmallUML'; 
											versionString: '0.9';
											loads: #('default' );
											file: 'ConfigurationOfSmallUML';
											repository: 'http://www.squeaksource.com/smallUML'. ];
										
			package: 'ObjectBrowser' with: [ spec requires: 'smallUML'.
											spec repository: 'http://www.squeaksource.com/ObjectBrowser'. ]
		]
]

{ #category : #'as yet unclassified' }
ConfigurationOfObjectBrowser >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project]
]