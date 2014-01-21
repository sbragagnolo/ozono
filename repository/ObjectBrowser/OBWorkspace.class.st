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

{ #category : #actions }
OBWorkspace >> closeYourself [
	window delete.
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
	window := self openLabel: self label.
]

{ #category : #accessing }
OBWorkspace >> selectedClassOrMetaClass [  
	^nil
]

{ #category : #fileout }
OBWorkspace >> stringContents [
	^(window findDeeplyA:TextMorph) text asString
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
