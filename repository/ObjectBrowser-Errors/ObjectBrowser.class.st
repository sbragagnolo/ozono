Class {
	#name : #ObjectBrowser,
	#superclass : #Object,
	#category : #'ObjectBrowser-Model'
}

{ #category : #'as yet unclassified' }
ObjectBrowser class >> clean [
	Variables do: [:var | var pointsTo removeClassFromSystem].
	Variables := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
ObjectBrowser class >> objects [
	^Objects
]

{ #category : #'as yet unclassified' }
ObjectBrowser class >> open [
	^self new openInWorld; yourself
]

{ #category : #ObjectBrowser }
ObjectBrowser >> canDelete: anObjectBrowserObject [

	^self objects allSatisfy: [ :anOBObject | (anOBObject hasReferencesTo: anObjectBrowserObject) not ]
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> clean [
	self objects do:[:o | o removeClassFromSystem ].
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> createVariable: aVariableNameString [
	| newVariable |
	self validateVariableName: aVariableNameString.
	
	newVariable := (OBVariable new)
		name: aVariableNameString;
		pointsTo: ObjectBrowserObject new;
		yourself.
	LOOPLesson currentLesson addVariable: newVariable.
]

{ #category : #'initialize-release' }
ObjectBrowser >> initialize [
	super initialize.
	Smalltalk at:#bag ifAbsentPut: (OBBaseBagCollection new).
	Smalltalk at:#set ifAbsentPut: (OBBaseSetCollection new).
	Smalltalk at:#ordered ifAbsentPut: (OBBaseSetCollection new).
	self initializeObjectBrowser.
]

{ #category : #'initialize-release' }
ObjectBrowser >> initializeObjectBrowser [
	Variables := Variables ifNil: [OrderedCollection new].
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> objectNames [
	^self objects collect:[:each | each name]
]

{ #category : #ObjectBrowser }
ObjectBrowser >> objects [
	^LOOPLesson currentLesson objects
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
ObjectBrowser >> showObjectGraph [

]

{ #category : #'as yet unclassified' }
ObjectBrowser >> validateVariableName: aVariableNameString [
	(self variables anySatisfy: [:v | v name = aVariableNameString ])
		ifTrue: [ self error: 'Ya se ha definido una variable de nombre ', aVariableNameString  ]
]

{ #category : #'as yet unclassified' }
ObjectBrowser >> variableNamed: aVariableNameString [
	^LOOPLesson currentLesson variableNamed: aVariableNameString.
]

{ #category : #ObjectBrowser }
ObjectBrowser >> variables [
	^LOOPLesson currentLesson variables
]
