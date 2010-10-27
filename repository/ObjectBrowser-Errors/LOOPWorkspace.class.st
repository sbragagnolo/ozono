Class {
	#name : #LOOPWorkspace,
	#superclass : #SHWorkspace,
	#instVars : [
		'lesson',
		'pane',
		'label',
		'window'
	],
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
LOOPWorkspace >> asString [
	^self label
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> bindingOf: aString [ 
	(self hasBindingOf: aString)
		ifTrue:[^ aString -> (lesson variableNamed: aString)]
		ifFalse: [self error: aString, ' no es una variable definida ni un literal válido'].
	
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> doItReceiver [
	^lesson executionContext
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> embeddedInMorphicWindowLabeled: labelString [
	window := (SystemWindow labelled: labelString) model: self.
	pane := PluggableTextMorph on: self text: #contents accept: #acceptContents:
			readSelection: nil menu: #codePaneMenu:shifted:.
	pane  font: StandardFonts codeFont.
	window addMorph: pane frame: (0@0 corner: 1@1).
	self label: labelString.
	^ window
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> hasBindingOf: aString [ 
	^lesson hasVariable: aString.
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> icon [
	^ObjectBrowserIcons workspaceIcon
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> label [
	^label
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> label: aLabel [
	label := aLabel
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> lesson: aLesson [
	lesson := aLesson.
]

{ #category : #selection }
LOOPWorkspace >> makeSelectionOn: anObjectBrowser [ 
	anObjectBrowser workspaceSelected: self.
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> menu: aMenuBuilder [
	^aMenuBuilder addList: (OrderedCollection
		with: #('abrir' #openWorkspace)
		with: #('eliminar' #removeWorkspace))
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> openInWorld [
	window openInWorld
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> stringContents [
	^(window findDeeplyA:TextMorph) text asString
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> treeContents [
	^OrderedCollection new
]
