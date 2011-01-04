Class {
	#name : #LOOPSettingsWindow,
	#superclass : #Object,
	#instVars : [
		'window',
		'optionsTree',
		'organization'
	],
	#classInstVars : [
		'window'
	],
	#category : #'ObjectBrowser-ControlPanel'
}

{ #category : #'as yet unclassified' }
LOOPSettingsWindow class >> openInWorld [
	^LOOPSettingsWindow new show.
]

{ #category : #buttons }
LOOPSettingsWindow >> buildViewConfigurationButton [
	^PluggableButtonMorph 
		on: self 
		getState: nil
		action: #openFunctionalityNotImplented
		label: #openViewConfigurationLabel
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> createView [
	| stream lessonsTitles |
	stream := (String new: 100) writeStream.
	LOOPLesson lessons do:[:lesson | stream nextPutAll: '  ',lesson title; cr ].
	lessonsTitles := self whiteTextMorphWithText: stream contents .

	window := (SystemWindow labelled: 'Configuraciones') 
		addMorph: (self whiteTextMorphWithText: ' Diagrama de objetos') frame: (0.0@0.0 corner: 0.4@ 0.1);
		addMorph: (self whiteTextMorphWithText: LOOPObjectDiagramFactory diagramClass asString )   frame: (0.4@0.0 corner: 1@ 0.1);

		addMorph: (self whiteTextMorphWithText: 'Lección') frame: (0.0@0.2 corner: 0.7@ 0.2);
		addMorph: lessonsTitles  frame: (0.0@0.2 corner: 0.7@ 0.65);

		addMorph: self buildViewConfigurationButton frame: (0.0@0.8 corner: 1@1);
		center: World center.
	^window.
]

{ #category : #buttons }
LOOPSettingsWindow >> openFunctionalityNotImplented [
	^ UIManager default
		request: 'Funcionalidad no implementada'
		initialAnswer: 'Esto es a modo de prototipo'.
]

{ #category : #buttons }
LOOPSettingsWindow >> openViewConfigurationLabel [
	^'Configurar vista'
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> show [
	self createView.
	window openInWorld.
	window extent: 500@300.
	window center: World center.
	^window.
]

{ #category : #morphs }
LOOPSettingsWindow >> textMorphWithText: textInside [
	|defaultSettings |
	
	defaultSettings  := TextMorph authoringPrototype.
	defaultSettings  autoFit: false.
	defaultSettings backgroundColor: Color veryLightGray.
	defaultSettings borderWidth: 1.
	defaultSettings  contents: textInside translated asText.
	^defaultSettings .
]

{ #category : #morphs }
LOOPSettingsWindow >> whiteTextMorphWithText: textInside [
	|defaultSettings |
	
	defaultSettings := self textMorphWithText: textInside .
	defaultSettings  backgroundColor: Color white .
	^defaultSettings .
]
