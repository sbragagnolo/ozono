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
LOOPSettingsWindow >> createGroupTab [
	^TabGroupMorph new
		addPage: self createSettingsTab label: 'Configuraciones';
		addPage: self createStatsTab label: 'Estadisticas';
		selectedPageIndex: 1;
		yourself
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> createSettingsTab [ 
	| hSepFrac panel |
	hSepFrac := 0.45.
	panel := OBGroupingMorph new
		color: (Color gray);
		layoutPolicy: (ProportionalLayout new).
	^panel.
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> createStatsTab [ 
	| hSepFrac panel |
	hSepFrac := 0.45.
	panel := OBGroupingMorph new
		color: (Color gray);
		layoutPolicy: (ProportionalLayout new).
	^panel.
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> createView [
	| hSepFrac |

	hSepFrac := 0.45.
	window := (SystemWindow labelled: 'LOOP Controls') 
		addMorph: self createGroupTab
			frame: (0.0@0 corner: 1@1);
		center: World center.
	
	^window.
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> selectedItem [
	"Answer the currently selected item or nil if none."

	^nil
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> settingOrganization [

	^organization ifNil: [ organization := OrderedCollection 
		with: (OBListItemWrapper with: (ObjectsOrganization for: self))
		with: (OBListItemWrapper with: (WorkspacesOrganization for: self))
		with: (OBListItemWrapper with: (TestsOrganization for: self))
		with: (OBListItemWrapper with: (RecicleBinOrganization for: self))
		]
]

{ #category : #'as yet unclassified' }
LOOPSettingsWindow >> show [
	self createView.
	window openInWorld.
	window extent: 700@500.
	window center: World center.
	^window.
]
