"
An OBGeneratePDFWindow is the window to enter all the prompted information needed for the generation of the PDF.

"
Class {
	#name : #OBGeneratePDFWindow,
	#superclass : #StandardWindow,
	#category : #'ObjectBrowser-PDFGeneration'
}

{ #category : #'instance creation' }
OBGeneratePDFWindow class >> newOnLesson: aLesson [ 
	| obj |
	obj := self new.
	obj model:(OBLessonToPDF newOnLesson:aLesson).
	^obj.
]

{ #category : #utils }
OBGeneratePDFWindow >> accept [
	(submorphs select:[ :m | m class == PluggableTextFieldMorph]) do:[ :m | m accept].
]

{ #category : #view }
OBGeneratePDFWindow >> buildAuthor:topStart height:height. [	
	self buildTextEntry: topStart withLabel: model authorLabel  set: #author:  get: #author height:height.
]

{ #category : #view }
OBGeneratePDFWindow >> buildButtons: top height: height [
	| b b2 |
	b := self
		newButtonFor: self
		action: #generate
		label: model generateLabel
		help: nil.
	self addMorph: b frame: (0.3 @ top corner: 0.6 @ (top + height)).

	b2 := self
		newButtonFor: self
		action: #cancel
		label: model cancelLabel
		help: nil.
	self addMorph: b2 frame: (0.6 @ top corner: 0.9 @ (top + height))
]

{ #category : #view }
OBGeneratePDFWindow >> buildCourse:topStart height:height. [	
	self buildTextEntry: topStart withLabel: model courseLabel  set: #course:  get: #course height:height.
]

{ #category : #view }
OBGeneratePDFWindow >> buildTeacher:topStart height:height. [	
	self buildTextEntry: topStart withLabel: model teacherLabel  set: #teacher:  get: #teacher height:height.
]

{ #category : #view }
OBGeneratePDFWindow >> buildTextEntry:topStart withLabel:aLabel set:aSetSelector get:aGetSelector height:height. [	
	self addMorph: (self newText: aLabel) frame: (0 @ topStart corner: 0.2 @ (topStart+height)).
	self
		addMorph:
			(self
				newTextEntryFor: self model
				getText: aGetSelector
				setText: aSetSelector
				getEnabled: nil
				help: nil)
		frame: (0.2 @ topStart corner: 1 @ (topStart + height))
]

{ #category : #'as yet unclassified ' }
OBGeneratePDFWindow >> cancel [
	self close.
]

{ #category : #view }
OBGeneratePDFWindow >> createView. [
	self title: self model title.
	
	self buildAuthor:0.0 height:0.23.
	self buildCourse:0.23 height:0.23.
	self buildTeacher:0.46 height:0.23.
	self buildButtons:0.69 height:0.23.	
]

{ #category : #'as yet unclassified ' }
OBGeneratePDFWindow >> generate [
	self accept.
	self model generate.
	self close.

]

{ #category : #view }
OBGeneratePDFWindow >> openInWorld [
	self createView.
	super openInWorld.
	self extent:312.0@130.0.

]
