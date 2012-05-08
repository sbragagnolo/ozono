Class {
	#name : #LOOPWorkspace,
	#superclass : #Workspace,
	#instVars : [
		'lesson',
		'pane',
		'label',
		'window'
	],
	#category : #'ObjectBrowser-UI'
}

{ #category : #accessing }
LOOPWorkspace >> asString [
	^self label
]

{ #category : #bindings }
LOOPWorkspace >> bindingOf: aString [ 
	(self hasBindingOf: aString)
		ifTrue:[
			(self isLiteral: aString)
				ifTrue:  [ ^aString-> (Smalltalk globals at: aString asSymbol) ]
				ifFalse: [ ^aString -> (lesson variableNamed: aString) ]
			]
		ifFalse: [self error: aString, ' no es una variable definida ni un literal válido'].
	
]

{ #category : #actions }
LOOPWorkspace >> doItReceiver [
	^lesson executionContext
]

{ #category : #'showing/creation' }
LOOPWorkspace >> embeddedInMorphicWindowLabeled: labelString [
	window := (SystemWindow labelled: labelString) model: self.
	pane := PluggableTextMorph on: self text: #contents accept: #acceptContents:
			readSelection: nil menu: #codePaneMenu:shifted:.
	pane  font: StandardFonts codeFont.
	pane beStyled.
	pane styler workspace: self.
	window addMorph: pane frame: (0@0 corner: 1@1).
	self label: labelString.
	^ window
]

{ #category : #fileout }
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

{ #category : #bindings }
LOOPWorkspace >> hasBindingOf: aString [ 
	^(lesson hasVariable: aString) or: [ self isLiteral: aString ].
]

{ #category : #accessing }
LOOPWorkspace >> icon [
	^ObjectBrowserIcons workspaceIcon
]

{ #category : #bindings }
LOOPWorkspace >> isLiteral: aString [
	^(Smalltalk globals includesKey: aString asSymbol)
		and: [ (Smalltalk globals at: aString asSymbol) isObjectBrowserLiteral ]
]

{ #category : #accessing }
LOOPWorkspace >> label [
	^label
]

{ #category : #accessing }
LOOPWorkspace >> label: aLabel [
	label := aLabel.
]

{ #category : #accessing }
LOOPWorkspace >> lesson: aLesson [
	lesson := aLesson.
]

{ #category : #selection }
LOOPWorkspace >> makeSelectionOn: anObjectBrowser [ 
	anObjectBrowser workspaceSelected: self.
]

{ #category : #actions }
LOOPWorkspace >> menu: aMenuBuilder [
	^aMenuBuilder addList: (OrderedCollection
		with: #('abrir' #openWorkspace)
		with: #('eliminar' #removeWorkspace)
		with: #('exportar' #exportWorkspace))
]

{ #category : #'showing/creation' }
LOOPWorkspace >> openInWorld [
	self openLabel: self label.
]

{ #category : #accessing }
LOOPWorkspace >> selectedClassOrMetaClass [  
	^lesson executionContext class
]

{ #category : #fileout }
LOOPWorkspace >> stringContents [
	^(window findDeeplyA:TextMorph) text asString
]

{ #category : #accessing }
LOOPWorkspace >> treeContents [
	^OrderedCollection new
]

{ #category : #fileout }
LOOPWorkspace >> writeContentsOn: stream [
	stream nextPutAll: self stringContents.
]

{ #category : #fileout }
LOOPWorkspace >> writeOn: stream [
	self writeOn: stream  withLessonIdentification: 'self'
]

{ #category : #fileout }
LOOPWorkspace >> writeOn: stream withLessonIdentification: lessonIdentification [
	stream nextPutAll: (lessonIdentification, ' createWorkspace: ''', self label ,'''' ,' contents: ''', 
		(self stringContents copyReplaceAll: $' asString with: $' asString,$' asString ), '''.').
]
