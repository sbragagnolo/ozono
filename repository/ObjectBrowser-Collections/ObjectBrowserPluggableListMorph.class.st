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
ObjectBrowserPluggableListMorph >> colorAt: index [
	^model colorAt: index
]

{ #category : #'as yet unclassified' }
ObjectBrowserPluggableListMorph >> fontAt: index withBasicFont: font [
	^model fontAt: index withBasicFont: font
]

{ #category : #'as yet unclassified' }
ObjectBrowserPluggableListMorph >> listMorphClass [
	^LOOPLazyListMorph
]

{ #category : #'as yet unclassified' }
ObjectBrowserPluggableListMorph >> mouseUp: event [
	"Override a change in PLM that breaks OmniBrowser. This version of the method
	is from Squeak 3.7 and was originally stamped: 'ls 6/22/2001 22:49'"

	| row previousSelectionIndex icon |
	row := self rowAtLocation: event position.
	"aMorph ifNotNil: [aMorph highlightForMouseDown: false]."
	model okToChange ifFalse:
		[^ self].
	(autoDeselect == false and: [row == 0]) ifTrue: [^ self].  "work-around the no-mans-land bug"
	"No change if model is locked"
	previousSelectionIndex := self selectionIndex.
	((autoDeselect == nil or: [autoDeselect]) and: [row == self selectionIndex])
		ifTrue: [self changeModelSelection: 0]
		ifFalse: [self changeModelSelection: row].
	Cursor normal show.
	"Trigger icon action"
	(previousSelectionIndex = self selectionIndex
		and: [ (row := self rowAtLocation: event position) ~= 0
		and: [ (icon := self iconAt: row) notNil
		and: [ (event position x - self left < icon width) ] ] ] )
			ifTrue: [ model clickIconAt: row ]
]
