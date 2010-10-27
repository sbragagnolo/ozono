Class {
	#name : #ObjectBrowserPluggableListMorph,
	#superclass : #OBPluggableListMorph,
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
ObjectBrowserPluggableListMorph class >> on: aModel [

	^(self on: aModel
		list: #listModel
		selected: #listIndex
		changeSelected: #listIndex:
		menu: #listMenu:shifted:
		keystroke: #listKey:from:)
		 borderWidth: 0;
		 enableDragNDrop: false;
		 autoDeselect: true;
		yourself
]

{ #category : #'as yet unclassified' }
ObjectBrowserPluggableListMorph >> listMorphClass [
	^LOOPLazyListMorph
]
