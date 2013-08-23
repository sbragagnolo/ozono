"
I representing an object that has been dereferenced and is subject to be garbage collected.

I also implement some UI related stuff such as the icon and menu items.
"
Class {
	#name : #DereferencedObject,
	#superclass : #Object,
	#instVars : [
		'dereferencedObject'
	],
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'instance-creation' }
DereferencedObject class >> newOn: anObject [
	^self new
		dereferencedObject: anObject;
		yourself
]

{ #category : #comparing }
DereferencedObject >> = anObject [
	^(anObject isKindOf: DereferencedObject) and: [ anObject realObject = self realObject  ]
]

{ #category : #'ui-actions' }
DereferencedObject >> actions [
		^OrderedCollection  with: (Array braceWith: 'Recuperar objeto' translated with: #recoverObject).
]

{ #category : #converting }
DereferencedObject >> asString [
	^dereferencedObject displayString
]

{ #category : #accessing }
DereferencedObject >> dereferencedObject: anObject [
	dereferencedObject := anObject
]

{ #category : #comparing }
DereferencedObject >> hash [
	^self realObject hash
]

{ #category : #'ui-actions' }
DereferencedObject >> icon [
	^nil
]

{ #category : #'ui-actions' }
DereferencedObject >> makeSelectionOn: aBrowser [
	^aBrowser selectDereferencedObject: self .
]

{ #category : #'ui-actions' }
DereferencedObject >> menu: aMenuBuilder [
	^aMenuBuilder addList: self actions
]

{ #category : #accessing }
DereferencedObject >> realObject [
	^dereferencedObject.
]

{ #category : #'ui-actions' }
DereferencedObject >> treeContents [
	^OrderedCollection new
]
