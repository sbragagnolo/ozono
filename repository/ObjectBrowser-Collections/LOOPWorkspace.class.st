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
LOOPWorkspace >> export [
	| internalStream converter f |
	[	internalStream := (String new: 100) writeStream.
	self writeContentsOn: internalStream.
	internalStream trailer.
	converter := internalStream contents isAsciiString 
		ifTrue: [MacRomanTextConverter new] 
		ifFalse: [UTF8TextConverter new].
	fileName := 	self label asFileName, '.ws'.
	f := FileStream newFileNamed: fileName.
	f ifNil: [^ self error: 'Cannot open file'].
	(converter isMemberOf: UTF8TextConverter) ifTrue: [
		f binary.
		UTF8TextConverter writeBOMOn: f].
	f text.
	f converter: converter.
	f nextPutAll: internalStream contents.
	f close.
	] ensure: [ internalStream close ]
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
	label := aLabel.
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
		with: #('eliminar' #removeWorkspace)
		with: #('exportar' #exportWorkspace))
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> openInWorld [
	self openLabel: self label.
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> stringContents [
	^(window findDeeplyA:TextMorph) text asString
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> treeContents [
	^OrderedCollection new
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> writeContentsOn: stream [
	stream nextPutAll: self stringContents.
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> writeOn: stream [
	self writeOn: stream  withLessonIdentification: 'self'
]

{ #category : #'as yet unclassified' }
LOOPWorkspace >> writeOn: stream withLessonIdentification: lessonIdentification [
	stream nextPutAll: (lessonIdentification, ' createWorkspace: ''', self label ,'''' ,' contents: ''', 
		(self stringContents copyReplaceAll: $' asString with: $' asString,$' asString ), '''.').
]
