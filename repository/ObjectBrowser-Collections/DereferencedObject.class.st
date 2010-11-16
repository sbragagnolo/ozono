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

{ #category : #'as yet unclassified' }
DereferencedObject >> actions [
		^#(
		#('recuperar' #recoverObject) 
		#- ).
]

{ #category : #'as yet unclassified' }
DereferencedObject >> asString [
	^dereferencedObject displayString
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
DereferencedObject >> icon [
	^nil
]

{ #category : #'as yet unclassified' }
DereferencedObject >> makeSelectionOn: aBrowser [
	^aBrowser selectDereferencedObject: self .
]

{ #category : #'as yet unclassified' }
DereferencedObject >> menu: aMenuBuilder [
	^aMenuBuilder addList: self actions
]

{ #category : #accessing }
DereferencedObject >> realObject [
	^dereferencedObject.
]

{ #category : #'as yet unclassified' }
DereferencedObject >> treeContents [
	^OrderedCollection new
]
