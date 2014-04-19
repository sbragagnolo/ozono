"
I am a workspace for the Object Browser.

I bind the lesson variables to the code executed, and update them if they are assigned in me.
"
Class {
	#name : #OBWorkspace,
	#superclass : #Workspace,
	#instVars : [
		'lesson',
		'pane',
		'label',
		'window'
	],
	#category : #'ObjectBrowser-UILesson'
}

{ #category : #'as yet unclassified' }
OBWorkspace >> accept [
	self textMorph accept.

]

{ #category : #visiting }
OBWorkspace >> accept: aVisitor [

	^ aVisitor visitWorkspace: self
]

{ #category : #accessing }
OBWorkspace >> asString [
	^self label
]

{ #category : #bindings }
OBWorkspace >> bindingOf: aString [
	(self hasBindingOf: aString)
		ifTrue: [ 
			(self isLiteral: aString)
				ifTrue: [ ^ aString -> (lesson literalNamed: aString asSymbol) ]
				ifFalse: [ ^ (lesson variableNamed: aString) baseObjectBinding ] ]
		ifFalse: [ self error: aString , ' no es una variable definida ni un literal válido' translated ]
]

{ #category : #bindings }
OBWorkspace >> bindings [
	^lesson variables collect: #name
]

{ #category : #'as yet unclassified' }
OBWorkspace >> buildTextMorph [
	| morph |
	"superclase cambiando clase concreta del textmorph"
	morph := WorkspacePluggableTextMorph 
					on: self 
					text: #contents 
					accept: #acceptContents:
					readSelection: nil 
					menu: #codePaneMenu:shifted:.
	
	morph font: StandardFonts codeFont.
	morph styler workspace: self.
	morph askBeforeDiscardingEdits: true.
	^morph.
]

{ #category : #'as yet unclassified' }
OBWorkspace >> changed [
	super changed.
	lesson changed.
]

{ #category : #actions }
OBWorkspace >> closeYourself [
	window delete.
]

{ #category : #'as yet unclassified' }
OBWorkspace >> createWindow: labelString [
	| w |
	w := OBWorkspaceWindow labelled: labelString.
	w workspace: self.
	^w
]

{ #category : #ui }
OBWorkspace >> deleteConfirmationMessage [
	^'¿Está seguro de eliminar el Workspace?' translated
]

{ #category : #evaluation }
OBWorkspace >> doItContext [
	^nil
]

{ #category : #evaluation }
OBWorkspace >> doItReceiver [
	^lesson executionContext
]

{ #category : #fileout }
OBWorkspace >> export [
	| internalStream converter f |
	[	internalStream := (String new: 100) writeStream.
	self writeContentsOn: internalStream.
	internalStream trailer.
	converter := internalStream contents isAsciiString 
		ifTrue: [MacRomanTextConverter new] 
		ifFalse: [UTF8TextConverter new].
	fileName := 	self label asFileName, '.ws'.
	f := FileStream newFileNamed: fileName.
	f ifNil: [^ self error: 'No se puede abrir el archivo' translated ].
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
OBWorkspace >> hasBindingOf: aString [ 
	^(lesson hasVariableNamed: aString) or: [ self isLiteral: aString ].
]

{ #category : #accessing }
OBWorkspace >> icon [
	^OBIcons workspaceIcon
]

{ #category : #bindings }
OBWorkspace >> isLiteral: aString [
	^lesson includesLiteralNamed: aString asSymbol
]

{ #category : #accessing }
OBWorkspace >> label [
	^label
]

{ #category : #accessing }
OBWorkspace >> label: aLabel [
	label := aLabel.
]

{ #category : #accessing }
OBWorkspace >> lesson: aLesson [
	lesson := aLesson.
]

{ #category : #selection }
OBWorkspace >> makeSelectionOn: anObjectBrowser [ 
	anObjectBrowser workspaceSelected: self.
]

{ #category : #actions }
OBWorkspace >> menu: aMenuBuilder [
	^aMenuBuilder addList: (OrderedCollection
		with: (Array braceWith: 'abrir' translated with: #openWorkspace)
		with: (Array braceWith: 'eliminar' translated with: #removeWorkspace) 
		with: (Array braceWith: 'exportar' translated with: #exportWorkspace)).
]

{ #category : #'showing/creation' }
OBWorkspace >> openInWorld [
	(window = nil) 
		ifTrue: [ window := self openLabel: self label ]
		ifFalse: [ 
			(window isDisplayed) ifTrue: [ window activate  ] ifFalse: [  window := self openLabel: self label ]
		]
]

{ #category : #'as yet unclassified' }
OBWorkspace >> openLabel: labelString [
	"Overrides to introduce a template method to change the window's concrete class"
	| w  panel |
	w := (self createWindow: labelString) model: self.
	panel := self buildTextMorph.
	w addMorph: panel frame: (0@0 corner: 1@1).
	w openInWorld.
	^ w
]

{ #category : #accessing }
OBWorkspace >> selectedClassOrMetaClass [  
	^nil
]

{ #category : #fileout }
OBWorkspace >> stringContents [
	^(window findDeeplyA:TextMorph) text asString
]

{ #category : #'as yet unclassified' }
OBWorkspace >> textMorph [
	^window findA: PluggableTextMorph.
]

{ #category : #accessing }
OBWorkspace >> treeContents [
	^OrderedCollection new
]

{ #category : #fileout }
OBWorkspace >> writeContentsOn: stream [
	stream nextPutAll: self stringContents.
]

{ #category : #fileout }
OBWorkspace >> writeOn: stream [
	self writeOn: stream  withLessonIdentification: 'self'
]

{ #category : #fileout }
OBWorkspace >> writeOn: stream withLessonIdentification: lessonIdentification [
	stream nextPutAll: (lessonIdentification, ' createWorkspace: ''', self label ,'''' ,' contents: ''', 
		(self stringContents copyReplaceAll: $' asString with: $' asString,$' asString ), '''.').
]
