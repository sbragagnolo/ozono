Class {
	#name : #LOOPWorkspace,
	#superclass : #SHWorkspace,
	#instVars : [
		'lesson',
		'pane'
	],
	#category : #'ObjectBrowser-UI'
}

{ #category : #'as yet unclassified' }
LOOPWorkspace >> bindingOf: aString [ 
	(self hasBindingOf: aString)
		ifTrue:[^ aString -> (lesson variableNamed: aString)]
		ifFalse: [self error: aString, ' no es una variable definida ni un literal válido'].
	
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> doItReceiver [
	^LOOPExecutionContext new
		lesson: lesson;
		yourself.
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> embeddedInMorphicWindowLabeled: labelString [
	| window  |
	window := (SystemWindow labelled: labelString) model: self.
	pane := PluggableTextMorph on: self text: #contents accept: #acceptContents:
			readSelection: nil menu: #codePaneMenu:shifted:.
	pane  font: StandardFonts codeFont.
	window addMorph: pane frame: (0@0 corner: 1@1).
	^ window
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> hasBindingOf: aString [ 
	^lesson hasVariable: aString.
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> lesson: aLesson [
	lesson := aLesson.
	pane textMorph lesson: aLesson.
]
