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
		label: 'file in a lesson'
		selector: #fileIn:
		description: 'importa una loop lesson'
		buttonLabel: 'importar')
	
]

{ #category : #'as yet unclassified' }
LOOPImportFileList >> isLoopLessonFile: aSuffix [
	^ aSuffix = 'st'
	
]

{ #category : #'as yet unclassified' }
LOOPImportFileList >> myServicesForFile: aFullName suffix: aSuffix [
	^(self isLoopLessonFile: aSuffix)
		ifTrue: [self myServicesForLoopLessonFile]
		ifFalse: [super myServicesForFile: aFullName suffix: aSuffix]
	
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
