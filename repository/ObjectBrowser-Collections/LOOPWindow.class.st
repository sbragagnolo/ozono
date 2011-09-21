Class {
	#name : #LOOPWindow,
	#superclass : #Object,
	#traits : 'TEasilyThemed',
	#classTraits : 'TEasilyThemed classTrait',
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
LOOPWindow >> aboutText [
	^'LOOP version: ', ConfigurationOfObjectBrowser project currentVersion versionString
]

{ #category : #showing }
LOOPWindow >> buildAboutMorph [
	^(self 
		newTextEditorFor: self 
		getText: #aboutText
		setText: nil)
		disable;
		yourself
]

{ #category : #showing }
LOOPWindow >> buildImportLessonButton [
	^PluggableButtonMorph 
		on: self
		getState: nil
		action: #importLesson
		label: #importLessonLabel
		
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
LOOPWindow >> buildUpdateButton [
	^PluggableButtonMorph 
		on: loopBrowser 
		getState: nil
		action: #updateLOOP
		label: #updateLOOPLabel
		
]

{ #category : #showing }
LOOPWindow >> chooseLessonFile. [
	^ UITheme current
		chooseFileIn: window
		title: 'Selecciona la leccion a importar'
		extensions: #('st') 
		path: nil
		preview: nil.
]

{ #category : #prototypeCompatibility }
LOOPWindow >> cornerStyle [
	^#corner
]

{ #category : #showing }
LOOPWindow >> createView [
	| top left bottom right middle |
	window := SystemWindow labelled: 'Lessons'.
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

{ #category : #creation }
LOOPWindow >> delete [
	window delete.
]

{ #category : #showing }
LOOPWindow >> importLesson [
	self chooseLessonFile ifNotNil: [ :fileEntry | ^loopBrowser importLesson: fileEntry ]
]

{ #category : #showing }
LOOPWindow >> importLessonLabel [
	^loopBrowser importLessonLabel
		
]

{ #category : #accessing }
LOOPWindow >> loopBrowser: aLOOPBrowser [ 
	loopBrowser := aLOOPBrowser
]

{ #category : #polymorphCompatibility }
LOOPWindow >> preferredCornerStyle [
	^self theme windowPreferredCornerStyleFor: self.
]

{ #category : #creation }
LOOPWindow >> show: aLOOPBrowser [ 
	self loopBrowser: aLOOPBrowser.
	self createView.
	window openInWorld.
	window extent: 400@300.
	window center: World center.
	^window.
]
