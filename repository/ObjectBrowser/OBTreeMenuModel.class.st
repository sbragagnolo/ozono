"
I'm an abstract class representing an item that will appear in the Tree menu in the left pane of the lesson browser.
"
Class {
	#name : #OBTreeMenuModel,
	#superclass : #Object,
	#instVars : [
		'objectBrowser'
	],
	#category : #'ObjectBrowser-UILesson'
}

{ #category : #printing }
OBTreeMenuModel >> asString [
	^self name asString
]

{ #category : #accessing }
OBTreeMenuModel >> icons [

	^ OBIcons
]

{ #category : #accessing }
OBTreeMenuModel >> name [

	^self subclassResponsibility
]

{ #category : #accessing }
OBTreeMenuModel >> objectBrowser: anObjectBrowser [

	objectBrowser := anObjectBrowser
]
