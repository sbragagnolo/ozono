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

{ #category : #morphs }
LOOPSettingsWindow >> aBoxMorph [
	|defaultSettings |
	
	defaultSettings := NewTextMorph new.
	defaultSettings color: self aPosibleColor .
	defaultSettings margin: 5.
	defaultSettings text: self aPosibleName asText . 
	^defaultSettings .
	
]

{ #category : #morphs }
LOOPSettingsWindow >> aPosibleColor [ 
	| posibles |
	posibles := OrderedCollection with: Color lightGreen with: Color lightYellow with:Color lightRed.
	^posibles at: self posiblePositionRandom.

]

{ #category : #morphs }
LOOPSettingsWindow >> aPosibleName [
	| posibles |
	posibles := OrderedCollection with: 'Willy Lamas' with: 'Brangangolo' with: 'Gutierrez'.
	^posibles at: self posiblePositionRandom.
	
]

{ #category : #tabs }
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

{ #category : #statsView }
LOOPSettingsWindow >> addDefaultStatsText: panel [
	| cantidadPaneles cotaMaximaX cotaMaximaY |
	cantidadPaneles := 6.
	cotaMaximaX := 1.
	cotaMaximaY := 0.9.
	
	(self posiblesPuntosInferiores: cantidadPaneles maximoX: cotaMaximaX maximoY: cotaMaximaY ) do: 
		[:puntoInferior | 
			panel addMorph:  self aBoxMorph frame: 
				(puntoInferior corner: (self puntoSuperior: puntoInferior  incrementoX: cotaMaximaX /cantidadPaneles  incrementoY: cotaMaximaY/cantidadPaneles))
		].
	
	panel addMorph: self buildOpenLessonsReportsButton frame: (0.0@0.9 corner: 0.5@1).
	panel addMorph: self buildViewConfigurationButton frame: (0.5@0.9 corner: 1@1).

	^panel.
]

{ #category : #buttons }
LOOPSettingsWindow >> buildOpenLessonsReportsButton [ 
	^PluggableButtonMorph 
		on: self 
		getState: nil
		action: #openSettingsBrowser
		label: #openLessosReportsConfigurationLabel
]

{ #category : #buttons }
LOOPSettingsWindow >> buildOpenSettingsBrowserButton [ 
	^PluggableButtonMorph 
		on: self 
		getState: nil
		action: #openSettingsBrowser
		label: #openSettingBrowserLabel
]

{ #category : #buttons }
LOOPSettingsWindow >> buildViewConfigurationButton [
	^PluggableButtonMorph 
		on: self 
		getState: nil
		action: #openFunctionalityNotImplented
		label: #openViewConfigurationLabel
]

{ #category : #statsView }
LOOPSettingsWindow >> combinaciones: coordenadaX conjunto: posiblesY [ 
	^posiblesY collect: [:coordenadaY | (coordenadaX@coordenadaY)].

]

{ #category : #tabs }
LOOPSettingsWindow >> createGroupTab [
	^TabGroupMorph new
		addPage: (self addDefaultSettingsText: self createNewTab) label: 'Configuraciones';
		addPage: (self addDefaultStatsText:  self createNewTab) label: 'Estadisticas';
		selectedPageIndex: 2;
		yourself
]

{ #category : #tabs }
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
	window := (SystemWindow labelled: 'LOOP Controls') 
		addMorph: self createGroupTab frame: (0@0 corner: 1@1);
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
LOOPSettingsWindow >> openLessosReportsConfigurationLabel [
	^'Configurar estadísticas por alumno'
]

{ #category : #buttons }
LOOPSettingsWindow >> openSettingBrowserLabel [
	^'Modificar configuraciones'
]

{ #category : #buttons }
LOOPSettingsWindow >> openSettingsBrowser [
	SettingBrowser open.
]

{ #category : #buttons }
LOOPSettingsWindow >> openViewConfigurationLabel [
	^'Configurar vista'
]

{ #category : #morphs }
LOOPSettingsWindow >> posiblePositionRandom [
	| random |
.	
	random := Random new next. 
	random < 0.6
		ifTrue: [ ^1]
		ifFalse: [ 
			random < 0.85 
				ifTrue: [^2] 
				ifFalse:[^3] 
		]
	

]

{ #category : #statsView }
LOOPSettingsWindow >> posiblesPuntosInferiores: cantidadPaneles maximoX: cotaMaximaX maximoY: cotaMaximaY [
	| posiblesX posiblesY posiblesPuntosInferioes |
	posiblesX := self posiblesValores: cotaMaximaX  particiones: cantidadPaneles .
	posiblesY := self posiblesValores: cotaMaximaY  particiones: cantidadPaneles .
	^(posiblesX inject: Set new into: [:puntos :coordenadaX | puntos union: (self combinaciones: coordenadaX conjunto: posiblesY )]) select: [:punto | punto x < 0.9] 

]

{ #category : #statsView }
LOOPSettingsWindow >> posiblesValores: maximo incremento: inc base: inicial [
	| posibles |
	posibles := Set new.
	(self valorPosible: inicial cota: maximo)
		ifTrue:[ posibles add: inicial. posibles addAll: (self posiblesValores: maximo incremento: inc base: inicial+inc)].
	^ posibles.
]

{ #category : #statsView }
LOOPSettingsWindow >> posiblesValores: cota particiones: cantidadParticiones [
	^ self posiblesValores: cota incremento: cota / cantidadParticiones base: 0.
]

{ #category : #statsView }
LOOPSettingsWindow >> puntoSuperior: punto incrementoX: incX incrementoY: incY [
	^(incX + punto x)@(incY + punto y)
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> show [
	self createView.
	window openInWorld.
	window extent: 700@500.
	window center: World center.
	^window.
]

{ #category : #statsView }
LOOPSettingsWindow >> valorPosible: posible cota: maximo [
	^ posible < maximo .
]
