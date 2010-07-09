Class {
	#name : #ObjectBrowser,
	#superclass : #Object,
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
ObjectBrowser class >> open [
	^self new openInWorld; yourself
]

{ #category : #ObjectBrowser }
ObjectBrowser >> canDelete: anObjectBrowserObject [

	^self objects allSatisfy: [ :anOBObject | (anOBObject hasReferencesTo: anObjectBrowserObject) not ]
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> createVariable: aVariableNameString [
	| newVariable |
	self validateVariableName: aVariableNameString.
	
	newVariable := (OBVariable new)
		originalName: aVariableNameString;
		name: aVariableNameString;
		pointTo: ObjectBrowserObject new;
		yourself.
	self lesson addVariable: newVariable.
]

{ #category : #'initialize-release' }
ObjectBrowser >> initialize [
	super initialize.
	Smalltalk at:#bag ifAbsentPut: (OBBaseBagCollection new).
	Smalltalk at:#set ifAbsentPut: (OBBaseSetCollection new).
	Smalltalk at:#ordered ifAbsentPut: (OBBaseSetCollection new).
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> lesson [
	^LOOPLesson currentLesson
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> objectNames [
	^self objects collect:[:each | each name]
]

{ #category : #ObjectBrowser }
ObjectBrowser >> objects [
	^self lesson objects
]

{ #category : #'initialize-release' }
ObjectBrowser >> openInWorld [
	ObjectBrowserWindow show: self.

	
]

{ #category : #model }
ObjectBrowser >> removeObject: anObject [
	self objects remove: anObject.
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> runGarbageCollector [
	self lesson runGarbageCollector.
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> showObjectGraph [

]

{ #category : #'as yet unclassified' }
ObjectBrowser >> validateVariableName: aVariableNameString [
	(self variables anySatisfy: [:v | v name = aVariableNameString ])
		ifTrue: [ self error: 'Ya se ha definido una variable de nombre ', aVariableNameString  ]
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> variableNamed: aVariableNameString [
	^self lesson variableNamed: aVariableNameString.
]

{ #category : #ObjectBrowser }
ObjectBrowser >> variables [
	^self lesson variables
]
