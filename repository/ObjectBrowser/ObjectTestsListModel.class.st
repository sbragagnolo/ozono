Class {
	#name : #ObjectTestsListModel,
	#superclass : #ObjectBrowserListModel,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
ObjectTestsListModel >> clickIconAt: position [ 
	self selectedItem clickIcon.
]

{ #category : #'as yet unclassified' }
ObjectTestsListModel >> iconAt: aTest [

	^IconicButton new 
		target: self;
		actionSelector: #clickIconAt: ;
		arguments: { self };
		labelGraphic: aTest icon;
		color: Color transparent;
		helpText: 'probar el test';
		borderWidth: 0
]

{ #category : #'as yet unclassified' }
ObjectTestsListModel >> listModel [
	^self model tests asOrderedCollection
]

{ #category : #'as yet unclassified' }
ObjectTestsListModel >> menuSelector [
	^#testListMenu:shifted:
]

{ #category : #'as yet unclassified' }
ObjectTestsListModel >> selectedItem [
	^self model selectedTest
]

{ #category : #'as yet unclassified' }
ObjectTestsListModel >> selectedItem: aTest [
	self model selectedTest: aTest
]
