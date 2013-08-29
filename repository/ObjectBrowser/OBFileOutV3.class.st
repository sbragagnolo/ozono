Class {
	#name : #OBFileOutV3,
	#superclass : #Object,
	#instVars : [
		'lesson',
		'internalStream',
		'mode',
		'currentObject'
	],
	#category : #'ObjectBrowser-Fileout'
}

{ #category : #writing }
OBFileOutV3 >> cr [

	internalStream cr.
]

{ #category : #template }
OBFileOutV3 >> lessonIdentification [

	^lesson title asLegalSelector
]

{ #category : #modes }
OBFileOutV3 >> modeObjectCreation [

	mode := OBObjectCreationFileoutMode new.
]

{ #category : #modes }
OBFileOutV3 >> modeObjectDefinition [

	mode := OBObjectDefinitionFileoutMode new.
]

{ #category : #modes }
OBFileOutV3 >> modeObjectState [

	mode := OBObjectStateFileoutMode new.
]

{ #category : #modes }
OBFileOutV3 >> modePrototypeDefinition [

	mode := OBObjectPrototypeDefinitionFileoutMode new.
]

{ #category : #visitor }
OBFileOutV3 >> visitAttribute: anAttribute [

	self write: currentObject posibleName.
	self write: ' addAttributeNamed: '.
	self write: ''''.
	self write: anAttribute name.
	self write: '''.'.
	self cr.

]

{ #category : #visitor }
OBFileOutV3 >> visitCollection: anObject [

	mode
		visitCollection: anObject
		inFileoutFormat: self
]

{ #category : #visitor }
OBFileOutV3 >> visitCollectionForCreation: anObject [

	self write: anObject posibleName.
	self write:  ' := '.
	self write: '('.
	self write:  self lessonIdentification.
	self write: ' literalNamed: '''.
	self write: self concreteObject class name asLowercase.
	self write: ''') basicClone'.
	self write: '.'.
	self cr.
]

{ #category : #visitor }
OBFileOutV3 >> visitCollectionForDefinition: aCollection [

	"Do nothing"
]

{ #category : #visitor }
OBFileOutV3 >> visitCollectionForState: aCollection [

	aCollection concreteObject do:  [ :each | 
			self write: aCollection posibleName.
			self write: ' add: '.
			self write: each metaObject posibleName.
			self write: '.'.
			self cr.
			]
]

{ #category : #visitor }
OBFileOutV3 >> visitDictionary: anObject [

	mode
		visitDictionary: anObject
		inFileoutFormat: self
]

{ #category : #visitor }
OBFileOutV3 >> visitDictionaryForCreation: anObject [

	self visitCollectionForCreation: anObject
]

{ #category : #visitor }
OBFileOutV3 >> visitDictionaryForDefinition: anObject [

	self visitCollectionForDefinition: anObject
]

{ #category : #visitor }
OBFileOutV3 >> visitDictionaryForState: aDictionary [

	aDictionary concreteObject keysAndValuesDo:  [ :key :value | 
			self write: aDictionary posibleName.
			self write: ' at: '.
			self write: key metaObject posibleName.
			self write: ' put: '.
			self write: value metaObject posibleName.
			self write: '.'.
			self cr].
]

{ #category : #visiting }
OBFileOutV3 >> visitDirectAttribute: anAttribute [

	self visitAttribute: anAttribute
]

{ #category : #visitor }
OBFileOutV3 >> visitLesson: aLesson [

	lesson := aLesson.	
	[internalStream := (String new: 100) writeStream.
	
	self writeLessonTemplateScript.
	
	FileStream
		writeSourceCodeFrom: internalStream
		baseName: self lessonIdentification asFileName
		isSt: true
	] ensure: [ internalStream close ]
]

{ #category : #visitor }
OBFileOutV3 >> visitLessonVariable: aVariable [

	self write: self lessonIdentification.
	self write: ' createVariableNamed: '''.
	self write: aVariable name.
	self write: ''' pointingTo: '''.
	self write: aVariable pointsTo posibleName.
	self write: '''.'.
	self cr.
]

{ #category : #visitor }
OBFileOutV3 >> visitMethod: aMethod [

	self write: currentObject posibleName.
	self write: ' compileMethod: '.
	self write: aMethod code printString.
	self write: '.'.
	self cr.
]

{ #category : #visiting }
OBFileOutV3 >> visitNullObject: aNullObject [

	"Do nothing with him"
]

{ #category : #visitor }
OBFileOutV3 >> visitObject: anObject [

	mode
		visitObject: anObject
		inFileoutFormat: self
]

{ #category : #visitor }
OBFileOutV3 >> visitObjectForCreation: anObject [

	self write: anObject posibleName.
	self write:  ' := '.
	self write: anObject class name.
	self write: ' newOn: '.
	self write: self  lessonIdentification.
	self write: '.'.
	self cr.
]

{ #category : #visitor }
OBFileOutV3 >> visitObjectForDefinition: anObject [

	currentObject := anObject.
	self modePrototypeDefinition.
	anObject prototype accept: self.
	self modeObjectDefinition.
	anObject attributes do: [ :anAttribute | anAttribute accept: self ].
	anObject methods do: [ :aMethod | aMethod accept: self ]
]

{ #category : #visitor }
OBFileOutV3 >> visitObjectForState: anObject [

	anObject attributes do: [ :var | 
			self write: anObject posibleName.
			self write: ' attributeNamed: '''.
			self write: var name.
			self write: ''' pointTo: '.
			self write: (anObject basicObjectAtAttributeNamed: var name) metaObject posibleName.
			self write: '.'. 
			self cr].
]

{ #category : #visitor }
OBFileOutV3 >> visitPrototype: aPrototype [

	self write: self posibleName.
	self write: ' bePrototypeOf: '.
	self write: currentObject posibleName.
	self write: '.'.
	self cr.
]

{ #category : #visitor }
OBFileOutV3 >> visitTest: aTest [

	self write: self lessonIdentification.
	self write: ' compileTest: '.
	self write: aTest code printString.
	self write: '.'.
	self cr.
]

{ #category : #visitor }
OBFileOutV3 >> visitWorkspace: aWorkspace [

	aWorkspace writeOn: internalStream withLessonIdentification: self lessonIdentification.
]

{ #category : #writing }
OBFileOutV3 >> write: aString [

	internalStream nextPutAll: aString
]

{ #category : #template }
OBFileOutV3 >> writeLessonConfiguration [

	lesson variables do: [ :variable | variable accept: self ].
	lesson objects do: [ :object | 
			self write: self lessonIdentification.
			self write: ' addObject: '.
			self write: object posibleName.
			self write: '.'.
			self cr. ].
	self write: '^ '.
	self write: self lessonIdentification.
	self write: '.'.
]

{ #category : #template }
OBFileOutV3 >> writeLessonCreation [

	self write: self lessonIdentification.
	self write: ' := '.
	self write: lesson class name.
	self write: ' new title: '''.
	self write: lesson title.
	self write: '''.'.
	self cr.
	
	self write: 'self addLesson: '.
	self write: self lessonIdentification.
	self write: '.'.
	self cr.
	self cr.
]

{ #category : #template }
OBFileOutV3 >> writeLessonTemplateScript [

	self writeScriptHeader.
	self writeLessonCreation.
	self writeObjectCreation.
	self writeObjectDefinition.
	self writeObjectState.
	self writeWorkspaces.
	self writeTests.
	self writeLessonConfiguration.
]

{ #category : #template }
OBFileOutV3 >> writeObjectCreation [

	self modeObjectCreation.	
	lesson objects do: [ :anObject | anObject accept: self ].
]

{ #category : #template }
OBFileOutV3 >> writeObjectDefinition [

	self modeObjectDefinition.
	lesson objects do: [ :anObject | anObject accept: self ].
]

{ #category : #template }
OBFileOutV3 >> writeObjectState [

	self modeObjectState.
	lesson objects do: [ :anObject | anObject accept: self ].
]

{ #category : #template }
OBFileOutV3 >> writeScriptHeader [

	self write: '| '.
	
	self write: (' ' join: (lesson objects collect: #posibleName)).
	self write: ' '.
	self write: self lessonIdentification.
	self write: ' |'.
	self cr.
	self cr.
]

{ #category : #template }
OBFileOutV3 >> writeTests [

	lesson tests do: [ :aTest | aTest accept: self ].
]

{ #category : #template }
OBFileOutV3 >> writeWorkspaces [

	self write: '"Workspaces exported"'.
	lesson workspaces
		do: [ :aWorkspace | 
			self cr.
			aWorkspace accept: self ]
]
