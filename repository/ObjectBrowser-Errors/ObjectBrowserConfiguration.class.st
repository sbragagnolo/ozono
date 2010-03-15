Class {
	#name : #ObjectBrowserConfiguration,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #'ObjectBrowser-Configuration'
}

{ #category : #'as yet unclassified' }
ObjectBrowserConfiguration class >> ensureMetacello [
	Smalltalk at: #MetacelloProject ifAbsent: [
		Gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				package: 'ConfigurationOfMetacello';
				load.
		(Smalltalk at: #ConfigurationOfMetacello) loadLatestVersion ]
]

{ #category : #'as yet unclassified' }
ObjectBrowserConfiguration class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'as yet unclassified' }
ObjectBrowserConfiguration class >> loadDefault [
	(self project version: '0.1-version') load
]

{ #category : #'as yet unclassified' }
ObjectBrowserConfiguration class >> project [

	^self new project
]

{ #category : #'as yet unclassified' }
ObjectBrowserConfiguration >> default: spec [ 
	<version: 'default'>
	
	spec for: #common do: [
		spec blessing: #beta.
		spec repository: 'http://www.squeaksource.com/ObjectBrowser'.
		spec 
			package: 'ObjectBrowser'; 
			package: 'Mondrian' ]
]

{ #category : #'as yet unclassified' }
ObjectBrowserConfiguration >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project]
]
