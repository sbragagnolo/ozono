Class {
	#name : #LOOPSettings,
	#superclass : #Object,
	#category : #'ObjectBrowser-ControlPanel'
}

{ #category : #'as yet unclassified' }
LOOPSettings class >> configureLoop [
	LOOPSettingsWindow openInWorld .
]

{ #category : #'as yet unclassified' }
LOOPSettings class >> menuCommandOn: aBuilder [ 
	<worldMenu>
	(aBuilder item: #'Loop Control')
		parent: #MostUsedTools;  
		action: [LOOPSettings configureLoop].
]
