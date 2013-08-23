Class {
	#name : #LOOPWindow,
	#superclass : #Object,
	#instVars : [
		'loopBrowser',
		'window'
	],
	#category : #'ObjectBrowser-UI'
}

{ #category : #creation }
LOOPWindow class >> show: aLOOPBrowser [ 
	^self new show: aLOOPBrowser
]

{ #category : #creation }
LOOPWindow >> buildAboutMorph [
	^(window
		newTextEditorFor: loopBrowser
		getText: #aboutText
		setText: nil)
		disable;
		yourself
]

{ #category : #creation }
LOOPWindow >> buildImportLessonButton [
	^PluggableButtonMorph 
		on: loopBrowser
		getState: nil
		action: #importLesson
		label: #importLessonLabel
		
]

{ #category : #creation }
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

{ #category : #creation }
LOOPWindow >> buildNewFreeLessonButton [
	^PluggableButtonMorph 
		on: loopBrowser 
		getState: nil
		action: #createNewFreeLesson
		label: #newFreeLessonLabel
		
]

{ #category : #creation }
LOOPWindow >> buildUpdateButton [
	^PluggableButtonMorph 
		on: loopBrowser 
		getState: nil
		action: #updateLOOP
		label: #updateLOOPLabel
		
]

{ #category : #creation }
LOOPWindow >> createView [
	| top left bottom right middle |
	window := StandardWindow labelled: 'Lecciones' translated.
	window model: loopBrowser.
	
	top := left := 0.
	bottom := right := 1.
	middle := 0.5.
	window addMorph: self buildAboutMorph frame: ( middle@top corner: right@ 0.55 ).
	window addMorph: self buildNewFreeLessonButton frame: (middle@0.85 corner: right@bottom ).
	window addMorph: self buildImportLessonButton frame: (middle@0.7 corner: right@0.85 ).
	window addMorph: self buildUpdateButton frame: (middle@0.55 corner: right@0.7 ).
	window addMorph: self buildLessonList frame: (left@top corner: middle@bottom).
]

{ #category : #showing }
LOOPWindow >> delete [
	window delete.
]

{ #category : #accessing }
LOOPWindow >> loopBrowser: aLOOPBrowser [ 
	loopBrowser := aLOOPBrowser
]

{ #category : #showing }
LOOPWindow >> show [
	window openInWorld.
	window extent: 400@300.
	window center: World center.
	^window.
]

{ #category : #showing }
LOOPWindow >> show: aLOOPBrowser [ 
	self loopBrowser: aLOOPBrowser.
	self createView.
	self show.
]
