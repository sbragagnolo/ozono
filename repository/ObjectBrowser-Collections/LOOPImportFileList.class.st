Class {
	#name : #LOOPImportFileList,
	#superclass : #FileList,
	#category : #'ObjectBrowser-UI-Model'
}

{ #category : #'as yet unclassified' }
LOOPImportFileList class >> initialize [ 
	super initialize.

]

{ #category : #'as yet unclassified' }
LOOPImportFileList >> importLoopLessonService [
	^ (SimpleServiceEntry 
		provider: LOOPLesson 
		label: 'file in a lesson' translated 
		selector: #fileIn:
		description: 'importa una loop lesson' translated 
		buttonLabel: 'importar' translated )
	
]

{ #category : #'as yet unclassified' }
LOOPImportFileList >> isLoopLessonFile: aFileName [
	|aSuffix|
	aSuffix := self class suffixOf: aFileName.
	^ aSuffix = 'st'
	
]

{ #category : #'as yet unclassified' }
LOOPImportFileList >> itemsForFile: aFileName [
	^(self isLoopLessonFile: aFileName)
		ifTrue: [self myServicesForLoopLessonFile]
		ifFalse: [super itemsForFile: aFileName]
	
]

{ #category : #'as yet unclassified' }
LOOPImportFileList >> myServicesForLoopLessonFile [
	|services|
	
	services := OrderedCollection  new.
	services  add: self importLoopLessonService.
	^services .
	
]

{ #category : #'as yet unclassified' }
LOOPImportFileList >> pattern: textOrStringOrNil [

	textOrStringOrNil
		ifNil: [pattern := '*.st']
		ifNotNil: [pattern := textOrStringOrNil asString].
	pattern isEmpty ifTrue: [pattern := '*'].
	self updateFileList.
	^ true

]
