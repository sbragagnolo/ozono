"
I representing an object that has been dereferenced and is subject to be garbage collected.

I also implement some UI related stuff such as the icon and menu items.
"
Class {
	#name : #OBDereferencedObject,
	#superclass : #Object,
	#instVars : [
		'dereferencedObject'
	],
	#category : #'ObjectBrowser-UILesson'
}

{ #category : #'instance-creation' }
OBDereferencedObject class >> newOn: anObject [
	^self new
		dereferencedObject: anObject;
		yourself
]

{ #category : #comparing }
OBDereferencedObject >> = anObject [
	^(anObject isKindOf: OBDereferencedObject) and: [ anObject realObject = self realObject  ]
]

{ #category : #'ui-actions' }
OBDereferencedObject >> actions [
		^OrderedCollection  with: (Array braceWith: 'Recuperar objeto' translated with: #recoverObject).
]

{ #category : #converting }
OBDereferencedObject >> asString [
	^dereferencedObject displayString
]

{ #category : #accessing }
OBDereferencedObject >> dereferencedObject: anObject [
	dereferencedObject := anObject
]

{ #category : #comparing }
OBDereferencedObject >> hash [
	^self realObject hash
]

{ #category : #'ui-actions' }
OBDereferencedObject >> icon [
	^nil
]

{ #category : #'ui-actions' }
OBDereferencedObject >> makeSelectionOn: aBrowser [
	^aBrowser selectDereferencedObject: self .
]

{ #category : #'ui-actions' }
OBDereferencedObject >> menu: aMenuBuilder [
	^aMenuBuilder addList: self actions
]

{ #category : #accessing }
OBDereferencedObject >> realObject [

	^dereferencedObject.
]

{ #category : #'ui-actions' }
OBDereferencedObject >> treeContents [
	^OrderedCollection new
]
