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
	posibles := OrderedCollection with: 'Claudio Crescenti' with: 'Gabriela Salem' with: 'Carlos Tomasino'.
	^posibles at: self posiblePositionRandom.
	
]

{ #category : #tabs }
LOOPSettingsWindow >> addDefaultSettingsText: panel [
	|stream idioma idiomaSeleccionado lessonsTitles lessonsProgrammingLanguages dialecto |
	
"fixme: refactor me please"
	idioma := self textMorphWithText: ' Idioma: '.
	idiomaSeleccionado := self whiteTextMorphWithText: '  Español'.
	dialecto := self textMorphWithText: ' Dialecto: '.

	stream := (String new: 100) writeStream.
	LOOPLesson lessons do:[:lesson | stream nextPutAll: '  ',lesson title; cr ].
	lessonsTitles := self whiteTextMorphWithText: stream contents .

	stream := (String new: 100) writeStream.
	LOOPLesson lessons do:[:lesson | stream nextPutAll: '  Smalltalk'; cr ].
	lessonsProgrammingLanguages := self whiteTextMorphWithText: stream contents .	
	
	panel addMorph: idioma frame: (0.0@0.0 corner: 0.4@ 0.1).
	panel addMorph: idiomaSeleccionado  frame: (0.4@0.0 corner: 1@ 0.1).
	panel addMorph: self ligthLightGreyBox frame: (0.0@0.1 corner: 1@ 0.15).
	
	panel addMorph: dialecto frame: (0.0@0.15 corner: 0.4@ 0.7).
	panel addMorph: (self textMorphWithText: ' Lección') frame: (0.4@0.15 corner: 0.7@ 0.25).
	panel addMorph: (self textMorphWithText: ' Dialecto Seleccionado') frame: (0.7@0.15 corner: 1@ 0.25).
	panel addMorph: lessonsTitles  frame: (0.4@0.25 corner: 0.7@ 0.7).
	panel addMorph: lessonsProgrammingLanguages  frame: (0.7@0.25 corner: 1@ 0.7).
	panel addMorph: self ligthLightGreyBox frame: (0.0@0.7 corner: 1.0@ 0.75).

	panel addMorph: (self textMorphWithText: ' Chequeo de Tipos') frame: (0.0@0.75 corner: 0.4@ 0.85).
	panel addMorph: (self whiteTextMorphWithText: '  Desactivado')   frame: (0.4@0.75 corner: 1@ 0.85).
	panel addMorph: self ligthLightGreyBox frame: (0.0@0.85 corner: 1.0@ 0.9).
	
	panel addMorph: self buildOpenSettingsBrowserButton frame: (0.0@0.9 corner: 1@1).
	^panel.
]

{ #category : #tabs }
LOOPSettingsWindow >> addDefaultSettingsTree: panel [
	| treeMorph contentMorph |
	
	"Tree"
	treeMorph := PluggableTreeMorph new.
	treeMorph model: self; setSelectedSelector: #onItemClicked:.

	panel 
		addMorph: treeMorph 
		fullFrame: (LayoutFrame fractions: (0@0 corner: 0.3@1) ).

	contentMorph := PluggableTextMorph on: self 
			text: nil accept: nil
			readSelection: nil menu: nil.
	contentMorph setText: 'Este panel es un prototipo de las configuraciones disponibles'.

	panel addMorph: treeMorph  frame: (0@0.0 corner: 0.3@ 0.9).
	panel addMorph: contentMorph fullFrame: (LayoutFrame fractions: (0.3@0 corner: 1@0.9)).
	panel addMorph: self buildOpenSettingsBrowserButton frame: (0.0@0.9 corner: 1@1).
	^panel
]

{ #category : #statsView }
LOOPSettingsWindow >> addDefaultStatsText: panel [
	| cantidadPaneles cotaMaximaX cotaMaximaY |
	cantidadPaneles := 7.
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

{ #category : #tabs }
LOOPSettingsWindow >> addNotImplementedWarningText: panel [
	|stream |

	stream := (String new: 100) writeStream.
	stream cr.
	stream nextPutAll: '  Los paneles aquí mostrados son un prototipo'; cr;cr.
	stream nextPutAll: '  Las funcionalidades han sido pensadas pero quedaron fuera del scope.'; cr;cr.
	stream nextPutAll: '  Se espera que en el siguiente proyecto'; cr;cr.
	stream nextPutAll: '  sean implementados, ya que el modelo ha sido pensado para que así lo hagan.'; cr;cr.
	
	panel addMorph: (self ligthLightGreyBox ) frame: (0.0@0.0 corner: 1.0@ 0.1).
	panel addMorph: (self ligthLightGreyBox ) frame: (0.9@0.1 corner: 1.0@ 1.0).
	panel addMorph: (self ligthLightGreyBox ) frame: (0.0@0.1 corner: 0.1@ 1.0).
	panel addMorph: (self ligthLightGreyBox ) frame: (0.0@0.9 corner: 1.0@ 1.0).
	panel addMorph: (self whiteTextMorphWithText: stream contents) frame: (0.1@0.1 corner: 0.9@ 0.9).

	
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
		addPage: (self addNotImplementedWarningText:  self createNewTab) label: 'Importante';
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

{ #category : #morphs }
LOOPSettingsWindow >> ligthLightGreyBox [
	|defaultSettings |
	
	defaultSettings := self textMorphWithText: '' .
	defaultSettings backgroundColor: Color veryVeryLightGray .
	^defaultSettings .
	
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

{ #category : #statsView }
LOOPSettingsWindow >> valorPosible: posible cota: maximo [
	^ posible < maximo .
]

{ #category : #morphs }
LOOPSettingsWindow >> whiteTextMorphWithText: textInside [
	|defaultSettings |
	
	defaultSettings := self textMorphWithText: textInside .
	defaultSettings  backgroundColor: Color white .
	^defaultSettings .
]
