"
I am the model of the test list in the lesson window.
"
Class {
	#name : #OBTestsListModel,
	#superclass : #OBListModel,
	#category : #'ObjectBrowser-UILesson'
}

{ #category : #'as yet unclassified' }
OBTestsListModel >> iconAt: aTest [
	^ (aTest name beginsWith: 'test')
		ifTrue: [ 
			IconicButton new
				target: self model;
				actionSelector: #runTest;
				labelGraphic: aTest icon;
				color: Color transparent;
				helpText: 'probar el test';
				borderWidth: 0 ]
		ifFalse: [ nil ]
]

{ #category : #'as yet unclassified' }
OBTestsListModel >> listModel [
	^self model tests asOrderedCollection
]

{ #category : #'as yet unclassified' }
OBTestsListModel >> menuSelector [
	^#testListMenu:shifted:
]

{ #category : #'as yet unclassified' }
OBTestsListModel >> selectedItem [
	^self model selectedTest
]

{ #category : #'as yet unclassified' }
OBTestsListModel >> selectedItem: aTest [
	self model selectedTest: aTest
]
