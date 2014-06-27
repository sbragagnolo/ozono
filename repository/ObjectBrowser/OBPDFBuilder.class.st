Class {
	#name : #OBPDFBuilder,
	#superclass : #Object,
	#instVars : [
		'lessonToPDF',
		'doc',
		'page',
		'currentTop'
	],
	#classVars : [
		'debug'
	],
	#category : #'ObjectBrowser-PDFGeneration'
}

{ #category : #'create elements' }
OBPDFBuilder >> addBoxFor: element [
	self debug
		ifTrue: [ page add: (PDFRectElement from: element from dimension: element dimension) ]
]

{ #category : #'create elements' }
OBPDFBuilder >> addToPage: element [
	| height maxPos newFrom |
	height := (element dimension y as:#millimetre) value.
	maxPos := self currentTop + height.

	height > self usableHeight
		ifTrue: [ self error: 'The element ' , element asString , ' is bigger than a page' ].
			
	maxPos > self maxTop
		ifTrue: [ 
			self newPage.
			self addToPage: element ]
		ifFalse: [ 
			newFrom := element from + (0@self currentTop mm).
			element from: newFrom.
			self addBoxFor:element.
			page add: element ]
]

{ #category : #margins }
OBPDFBuilder >> bottomMargin [
	^35.
]

{ #category : #builder }
OBPDFBuilder >> buildDiagram [
	| imageStream image |
	self createHeading: 'Diagrama Objetos'.
	
	self vskip: 2 mm.
	
	imageStream := ReadWriteStream on: ByteArray new.
	PluginBasedJPEGReadWriter putForm: self lessonToPDF diagramForm onStream: imageStream.
	image := PDFJpegElement fromStream: imageStream.
	image dimension: (self scaleImage: image originalImageDimensions).
	image from: self leftMargin mm @ 0 mm.
	self addToPage: image
]

{ #category : #builder }
OBPDFBuilder >> buildInfo [
	self createHeading: 'Información Adicional'.
	self createLabel: 'Sistema Operativo:' translated withText: self model operatingSystem.
	self createLabel: 'Fecha y Hora:' translated withText: self model date asString.
	self createLabel: 'Pharo:' translated withText: self model pharoVersion.
	self createLabel: 'Ozono:' translated withText: self model ozonoVersion.
	self createLabel: 'Codigo Control:' translated withText: self model formattedControlCode.
	self createLabel: 'VM:' translated withText: self model vmVersion
]

{ #category : #builder }
OBPDFBuilder >> buildObjects [
	| visitor |
	self createHeading: 'Objetos'.
	visitor := OBPDFVisitor new builder:self; yourself.
	self model lesson accept:visitor.
]

{ #category : #builder }
OBPDFBuilder >> buildOn: aPDFDocument [ 
	self doc:aPDFDocument.
	self newPage.
	
	self buildInfo.
	self buildObjects.
	self buildDiagram.
]

{ #category : #styles }
OBPDFBuilder >> codeStyleSheet [
	| titleFont titleStyleSheet |
	titleFont := (PDFCourierFont new fontSize: 10 pt).
	titleStyleSheet := PDFStyleSheet new font: titleFont.
	titleStyleSheet alignment: PDFAlignment left middle.
	titleStyleSheet margin:0 mm.
	^titleStyleSheet.
]

{ #category : #'create elements' }
OBPDFBuilder >> createCode: text [
	(text subStrings: String crlf) do: [ :e | self createText: (self replaceTabs:e) withStyle: self codeStyleSheet ]
]

{ #category : #'header and footer' }
OBPDFBuilder >> createFooter [
	| from to |
	from := self leftMargin mm @ (self pageHeight - self bottomMargin + 2) mm.
	to := (self pageWidth - self rightMargin) mm @ (self pageHeight - self bottomMargin + 2) mm.
	page add: (PDFLineElement from: from to: to).

	page
		add:
			(PDFParagraphElement new
				text: self model teacher;
				from: self leftMargin mm @ (self pageHeight - self bottomMargin + 4) mm;
				style: self footerLeftStyleSheet;
				dimension: 15 mm @ 15 mm).

	page
		add:
			(PDFParagraphElement new
				text: self model formattedDate;
				from: (self pageWidth - self rightMargin - 15) mm @ (self pageHeight - self bottomMargin + 4) mm;
				style: self footerRightStyleSheet;
				dimension: 15 mm @ 15 mm).

	page
		add:
			(PDFParagraphElement new
				text: self pageNumber asString , '/' , '*#pages#*';
				from: (self pageWidth - self rightMargin - 15) mm @ (self pageHeight - self bottomMargin + 4) mm;
				style: self footerRightStyleSheet;
				dimension: 15 mm @ 15 mm)
]

{ #category : #'header and footer' }
OBPDFBuilder >> createHeader [
	| from to |
	from := self leftMargin mm @ (self topMargin - 2) mm.
	to := (self pageWidth - self rightMargin) mm @ (self topMargin - 2) mm.
	page add: (PDFLineElement from: from to: to).

	page
		add:
			(PDFParagraphElement new
				text: self model author;
				from: self leftMargin mm @ (self topMargin - 12) mm;
				style: self headerLeftStyleSheet;
				dimension: 15 mm @ 15 mm).

	page
		add:
			(PDFParagraphElement new
				text: self model course;
				from: (self leftMargin + (self usableWidth /2) ) mm @ (self topMargin - 12) mm;
				style: self headerLeftStyleSheet;
				dimension: 15 mm @ 15 mm).

	page
		add:
			(PDFParagraphElement new
				text: self model lesson title;
				from: (self pageWidth - self rightMargin - 40) mm @ (self topMargin - 12) mm;
				style: self headerRightStyleSheet;
				dimension: 15 mm @ 40 mm).
				
	self currentTop: self topMargin.
]

{ #category : #'create elements' }
OBPDFBuilder >> createHeading: text [
	^self createText: text withStyle: self headingStyleSheet.
]

{ #category : #'create elements' }
OBPDFBuilder >> createLabel: labelText withText: text [
	^ self createLabel: labelText withText: text labelRatio: 0.3
]

{ #category : #'create elements' }
OBPDFBuilder >> createLabel: labelText withText: text labelRatio: labelRatio [
	| valueRatio label value|
	valueRatio := 1 - labelRatio.
	label := PDFParagraphElement new
				styleSheet: self labelStyleSheet;
				dimension: (self usableWidth * labelRatio) mm @ 1000 mm;
				from: self leftMargin mm @ 0 mm;
				text: labelText; shrinkToContent; yourself.
				
	value := PDFParagraphElement new
				styleSheet: self valueStyleSheet;
				dimension: (self usableWidth * valueRatio) mm @ 1000 mm;
				from: (self leftMargin + (self usableWidth * labelRatio)) mm @ 0 mm;
				text: text; shrinkToContent; yourself.
	
	self
		addToPage:label.
		
	self
		addToPage:value.
				
	self updateTop: ((label dimension y as:#millimeters) value max:(value dimension y as:#millimeters) value) .
]

{ #category : #'create elements' }
OBPDFBuilder >> createSubHeading: text [
	^self createText: text withStyle: self headingStyleSheet.
]

{ #category : #'create elements' }
OBPDFBuilder >> createText: text withStyle: style [
	| element |
	element := (PDFParagraphElement new
				styleSheet: style;
				dimension: self usableWidth mm @ 0mm;
				from: self leftMargin mm @ 0 mm;
				text: text).
	element shrinkToContent.
	self addToPage: element.
	self updateTop: (element dimension y as:#millimeters)value.
]

{ #category : #accessing }
OBPDFBuilder >> currentTop [
	^currentTop.
]

{ #category : #accessing }
OBPDFBuilder >> currentTop:aValue [
	currentTop:=aValue.
]

{ #category : #accessing }
OBPDFBuilder >> debug [
	^ debug ifNil:[ false].
]

{ #category : #accessing }
OBPDFBuilder >> doc [
	^doc.
]

{ #category : #accessing }
OBPDFBuilder >> doc: aPDFDocument [ 
	doc := aPDFDocument.
]

{ #category : #styles }
OBPDFBuilder >> footerLeftStyleSheet [
	| styleSheet |
	styleSheet := PDFStyleSheet new font:PDFHelveticaFont new.
	styleSheet alignment: PDFAlignment left middle.
	styleSheet margin:0.
	^styleSheet.
]

{ #category : #styles }
OBPDFBuilder >> footerRightStyleSheet [
	| styleSheet |
	styleSheet := PDFStyleSheet new font:PDFHelveticaFont new.
	styleSheet alignment: PDFAlignment right middle.
	styleSheet filled:true.
	styleSheet fillColor: (PDFColor formatRGB:Color orange).
	styleSheet margin:0.	
	^styleSheet.
]

{ #category : #styles }
OBPDFBuilder >> headerLeftStyleSheet [
	| styleSheet |
	styleSheet := PDFStyleSheet new font:PDFHelveticaFont new.
	styleSheet alignment: PDFAlignment left middle.
	styleSheet margin:0.
	^styleSheet.
]

{ #category : #styles }
OBPDFBuilder >> headerRightStyleSheet [
	| styleSheet |
	styleSheet := PDFStyleSheet new font:PDFHelveticaFont new.
	styleSheet alignment: PDFAlignment right middle.
	styleSheet margin:0.
	^styleSheet.
]

{ #category : #styles }
OBPDFBuilder >> headingStyleSheet [
	| titleFont titleStyleSheet |
	titleFont := (PDFTimesFont new fontSize: 16 pt) bold italic.
	titleStyleSheet := PDFStyleSheet new font: titleFont.
	titleStyleSheet alignment: PDFAlignment left middle.
	titleStyleSheet margin:0 mm.
	^titleStyleSheet.
]

{ #category : #initialization }
OBPDFBuilder >> initialize [
	super initialize.
	currentTop := 0.
]

{ #category : #styles }
OBPDFBuilder >> labelStyleSheet [
	| titleFont titleStyleSheet |
	titleFont := (PDFTimesFont new fontSize: 10 pt) bold.
	titleStyleSheet := PDFStyleSheet new font: titleFont.
	titleStyleSheet alignment: PDFAlignment left middle.
	titleStyleSheet margin:0 mm.
	^titleStyleSheet.
]

{ #category : #margins }
OBPDFBuilder >> leftMargin [
	^30.
]

{ #category : #accessing }
OBPDFBuilder >> lessonToPDF [
	^ lessonToPDF
]

{ #category : #accessing }
OBPDFBuilder >> lessonToPDF: anObject [
	lessonToPDF := anObject
]

{ #category : #'calculated properties' }
OBPDFBuilder >> maxTop [
	^self pageHeight - self bottomMargin.
]

{ #category : #accessing }
OBPDFBuilder >> model [
	^lessonToPDF.
]

{ #category : #'create elements' }
OBPDFBuilder >> newPage [
	page := PDFPage new.
	doc add:page.
	self createHeader.
	self createFooter.
]

{ #category : #'calculated properties' }
OBPDFBuilder >> pageHeight [
	^(page format height convertTo: Unit mm) value floor.
]

{ #category : #'calculated properties' }
OBPDFBuilder >> pageNumber [
	^doc pages indexOf: page.
]

{ #category : #'calculated properties' }
OBPDFBuilder >> pageWidth [
	^(page format width convertTo: Unit mm) value floor.
]

{ #category : #convertion }
OBPDFBuilder >> replaceTabs: aString [
	| st |
	st := WriteStream on: String new.
	aString
		do: [ :c | 
			c = Character tab
				ifTrue: [ st nextPutAll: '    ' ]
				ifFalse: [ st nextPut: c ] ].
	^ st contents
]

{ #category : #margins }
OBPDFBuilder >> rightMargin [
	^30.
]

{ #category : #'calculated properties' }
OBPDFBuilder >> scaleImage:dimensions [
	| w h scaleH maxH maxW scaleW|
	w := (dimensions x as:#millimeters) value.
	h := (dimensions y as: #millimeters) value.
	maxH := 100.
	maxW := self usableWidth.
	scaleH := maxH / h.
	scaleW := maxW / w.	
	
	(scaleH > 1 and: [scaleW > 1]) 
		ifTrue:[^dimensions].
		
	scaleH < scaleW
		ifTrue:[ ^ dimensions * scaleH]
		ifFalse:[ ^ dimensions * scaleW]
]

{ #category : #accessing }
OBPDFBuilder >> toggleDebug [
	debug := self debug not.
]

{ #category : #margins }
OBPDFBuilder >> topMargin [
	^35.
]

{ #category : #accessing }
OBPDFBuilder >> updateTop:withHeight. [
	currentTop := currentTop + withHeight.
]

{ #category : #'calculated properties' }
OBPDFBuilder >> usableHeight [
	^self pageHeight - self topMargin - self bottomMargin.
]

{ #category : #'calculated properties' }
OBPDFBuilder >> usableWidth [
	^self pageWidth - self leftMargin - self rightMargin.
]

{ #category : #styles }
OBPDFBuilder >> valueStyleSheet [
	| titleFont titleStyleSheet |
	titleFont := (PDFTimesFont new fontSize: 12 pt).
	titleStyleSheet := PDFStyleSheet new font: titleFont.
	titleStyleSheet alignment: PDFAlignment left middle.
	titleStyleSheet margin:0 mm.
	^titleStyleSheet.
]

{ #category : #'create elements' }
OBPDFBuilder >> vskip:value. [
	self updateTop: (value as:#millimeters) value
]
