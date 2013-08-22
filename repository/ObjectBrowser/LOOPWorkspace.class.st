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
		ifFalse: [self error: aString, ' no es una variable definida ni un literal válido' translated ].
	
]

{ #category : #bindings }
LOOPWorkspace >> bindings [
	^lesson variables collect: #name
]

{ #category : #actions }
LOOPWorkspace >> closeYourself [
	window delete.
]

{ #category : #evaluation }
LOOPWorkspace >> doItContext [
	^nil
]

{ #category : #evaluation }
LOOPWorkspace >> doItReceiver [
	^lesson executionContext
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
		with: (Array braceWith: 'abrir' translated with: #openWorkspace)
		with: (Array braceWith: 'eliminar' translated with: #removeWorkspace) 
		with: (Array braceWith: 'exportar' translated with: #exportWorkspace)).
]

{ #category : #'showing/creation' }
LOOPWorkspace >> openInWorld [
	window := self openLabel: self label.
]

{ #category : #accessing }
LOOPWorkspace >> selectedClassOrMetaClass [  
	^nil
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
