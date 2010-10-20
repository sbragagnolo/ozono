Class {
	#name : #DereferencedObject,
	#superclass : #Object,
	#instVars : [
		'dereferencedObject'
	],
	#category : #'ObjectBrowser-Model'
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
DereferencedObject >> fullfillObjectBrowserObjectsCollection: aSet [ 
"Codigo repetidoooooo"
		(aSet  includes: self) ifFalse: [
		aSet  add: self.
		self variables do: [ :v | (self objectPointedBy: v name) ifNotNil: [ :o | o fullfillObjectBrowserObjectsCollection: aSet ]].
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
	^dereferencedObject realObject.
]

{ #category : #'as yet unclassified' }
DereferencedObject >> treeContents [
	^OrderedCollection new
]
