Class {
	#name : #DereferencedObject,
	#superclass : #Object,
	#instVars : [
		'dereferencedObject'
	],
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
DereferencedObject class >> newOn: anObject [
	^self new
		dereferencedObject: anObject;
		yourself
]

{ #category : #comparing }
DereferencedObject >> = anObject [
	^(anObject isKindOf: DereferencedObject) and: [ anObject realObject = self realObject  ]
]

{ #category : #'as yet unclassified' }
DereferencedObject >> actions [
		^#(
		#('recuperar' #recoverObject) 
		#- ).
]

{ #category : #converting }
DereferencedObject >> asString [
	^dereferencedObject displayString
]

{ #category : #accessing }
DereferencedObject >> dereferencedObject: anObject [
	dereferencedObject := anObject
]

{ #category : #'as yet unclassified' }
DereferencedObject >> fullfillObjectBrowserObjectsCollection: aCollection [ 
"Codigo repetidoooooo"
|pointed|
	(aCollection includes: self) ifFalse: [
		aCollection add: self.
		self variables do: [ :v | pointed := self objectPointedByVariableNamed: v name. (pointed notNil and: [
				pointed class isKindOf: ObjectBrowserObject]) ifTrue: [ pointed fullfillObjectBrowserObjectsCollection: aCollection ]].
		]
]

{ #category : #comparing }
DereferencedObject >> hash [
	^self realObject hash
]

{ #category : #accessing }
DereferencedObject >> icon [
	^nil
]

{ #category : #selection }
DereferencedObject >> makeSelectionOn: aBrowser [
	^aBrowser selectDereferencedObject: self .
]

{ #category : #accessing }
DereferencedObject >> menu: aMenuBuilder [
	^aMenuBuilder addList: self actions
]

{ #category : #accessing }
DereferencedObject >> realObject [
	^dereferencedObject.
]

{ #category : #accessing }
DereferencedObject >> treeContents [
	^OrderedCollection new
]
