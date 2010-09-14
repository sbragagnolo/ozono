Class {
	#name : #LOOPWindow,
	#superclass : #Object,
	#instVars : [
		'loopBrowser',
		'window'
	],
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
LOOPWindow class >> on: aLessonBrowser [
	^self new on: aLessonBrowser; yourself.
]

{ #category : #creation }
LOOPWindow class >> show: aLOOPBrowser [ 
	^self new show: aLOOPBrowser
]

{ #category : #showing }
LOOPWindow >> buildLessonList [
	^ PluggableListMorph new
		on: (LessonListModel newOn: loopBrowser)
		list: #listModel
		selected: #listIndex
		changeSelected: #listIndex:
		menu: #listMenu:shifted:
		keystroke: #listKey:from:;
		 borderWidth: 0;
		 enableDragNDrop: false;
		 autoDeselect: true;
		 yourself
]

{ #category : #showing }
LOOPWindow >> buildNewFreeLessonButton [
	^PluggableButtonMorph 
		on: loopBrowser 
		getState: nil
		action: #createNewFreeLesson
		label: #newFreeLessonLabel
		
]

{ #category : #showing }
LOOPWindow >> createView [
	window := SystemWindow labelled: 'LOOP'.
	window model: loopBrowser.
	window addMorph: self buildNewFreeLessonButton frame: (0@0.8 corner: 1@1 ).
	window addMorph: self buildLessonList frame: (0@0 corner: 1@0.8).
]

{ #category : #creation }
LOOPWindow >> delete [
	window delete.
]

{ #category : #accessing }
LOOPWindow >> loopBrowser: aLOOPBrowser [ 
	loopBrowser := aLOOPBrowser
]

{ #category : #creation }
LOOPWindow >> show: aLOOPBrowser [ 
	self loopBrowser: aLOOPBrowser.
	self createView.
	window openInWorld.
	window extent: 200@300.
	window center: World center.
	^window.
]
