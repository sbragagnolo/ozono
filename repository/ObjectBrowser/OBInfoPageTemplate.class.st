Class {
	#name : #OBInfoPageTemplate,
	#superclass : #OBCommonPageTemplate,
	#category : #'ObjectBrowser-PDFGeneration'
}

{ #category : #'as yet unclassified' }
OBInfoPageTemplate >> createContent. [
	self createHeading: 'Información Adicional' withHeight:15 onTop: 0.
	self createLabel: 'Sistema Operativo:' translated withText: lessonToPDF operatingSystem withHeight: 15 onTop: 20.
	self createLabel: 'Fecha y Hora:' translated withText: lessonToPDF date asString withHeight: 15 onTop: 35.
	self createLabel: 'Pharo:'  translated withText: lessonToPDF pharoVersion withHeight: 15 onTop: 50.
	self createLabel: 'Ozono:'  translated withText: lessonToPDF ozonoVersion withHeight: 15 onTop: 65.
	self createLabel: 'Codigo Control:'  translated withText: lessonToPDF controlCode withHeight: 15 onTop: 80.
	self createLabel: 'VM:'  translated withText: lessonToPDF vmVersion withHeight: 80 onTop: 95.

]
