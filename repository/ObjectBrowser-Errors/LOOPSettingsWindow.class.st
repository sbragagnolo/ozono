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

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> aBoxMorph [
	|defaultSettings |
	
	defaultSettings := NewTextMorph new.
	defaultSettings color: Color lightGreen .
	defaultSettings margin: 5.
	defaultSettings text: 'Willy Lamas' asText . 
	^defaultSettings .
	
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> aRedBoxMorph [
	|defaultSettings |
	
	defaultSettings := NewTextMorph new.
	defaultSettings color: Color lightRed .
	defaultSettings margin: 5.
	defaultSettings text: 'Roque No Entiendo Nada' asText . 
	^defaultSettings .
	
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> addDefaultSettingsText: panel [
	|defaultSettings stream |
	
"fixme: refactor me please"
	stream := (String new: 100) writeStream.
	stream nextPutAll: 'Idioma: Español' ; cr.
	stream nextPutAll: 'Dialecto: Smalltalk' ; cr.
	stream trailer.

	defaultSettings := NewTextMorph new.
	defaultSettings color: Color veryLightGray.
	defaultSettings margin: 5.
	defaultSettings text: stream contents asText . 
	
	panel addMorph: defaultSettings frame: (0@0.0 corner: 1@ 0.9).
	panel addMorph: self buildOpenSettingsBrowserButton frame: (0.0@0.9 corner: 1@1).
	^panel.
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> addDefaultStatsText: panel [
	panel addMorph: self aBoxMorph frame: (0.0@0.0 corner: 0.33@ 0.3).
	panel addMorph: self aBoxMorph frame: (0.33@0.0 corner: 0.66@ 0.3).
	panel addMorph: self aBoxMorph frame: (0.66@0.0 corner: 1.0@0.3).
	
	panel addMorph: self aBoxMorph frame: (0.0@0.3 corner: 0.33@ 0.6).
	panel addMorph: self aBoxMorph frame: (0.33@0.3 corner: 0.66@ 0.6).
	panel addMorph: self aRedBoxMorph frame: (0.66@0.3 corner: 1.0@0.6).
	
	panel addMorph: self aBoxMorph frame: (0.0@0.6 corner: 0.33@0.9).
	panel addMorph: self aBoxMorph frame: (0.33@0.6 corner: 0.66@0.9).
	panel addMorph: self aRedBoxMorph frame: (0.66@0.6 corner: 1.0@0.9).
	
	panel addMorph: self buildOpenLessonsReportsButton frame: (0.0@0.9 corner: 1@1).

	^panel.
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> buildOpenLessonsReportsButton [ 
	^PluggableButtonMorph 
		on: self 
		getState: nil
		action: #openSettingsBrowser
		label: #openLessosReportsConfigurationLabel
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> buildOpenSettingsBrowserButton [ 
	^PluggableButtonMorph 
		on: self 
		getState: nil
		action: #openSettingsBrowser
		label: #openSettingBrowserLabel
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> createGroupTab [
	^TabGroupMorph new
		addPage: (self addDefaultSettingsText: self createNewTab) label: 'Configuraciones';
		addPage: (self addDefaultStatsText:  self createNewTab) label: 'Estadisticas';
		selectedPageIndex: 2;
		yourself
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> createNewTab [ 
	| hSepFrac panel |
	hSepFrac := 0.45.
	panel := OBGroupingMorph new
		color: (Color white);
		layoutPolicy: (ProportionalLayout new).
	^panel.
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> createView [
	| hSepFrac |

	hSepFrac := 0.45.
	window := (SystemWindow labelled: 'LOOP Controls') 
		addMorph: self createGroupTab frame: (0@0 corner: 1@1);
		center: World center.
	^window.
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> openLessosReportsConfigurationLabel [
	^'Configurar estadísticas'
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> openSettingBrowserLabel [
	^'Modificar configuraciones'
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> openSettingsBrowser [
	SettingBrowser open.
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> show [
	self createView.
	window openInWorld.
	window extent: 700@500.
	window center: World center.
	^window.
]
